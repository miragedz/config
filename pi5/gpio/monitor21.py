#!/usr/bin/env python3
"""
gpio_button_monitor.py

Monitor GPIO21 on /dev/gpiochip0 (Raspberry Pi 5, Raspberry Pi OS "Trixie")
using libgpiod v2 Python bindings and invoke ./switch.sh ON/OFF whenever the
button is pressed or released.

Requires:
    sudo apt install python3-gpiod      # libgpiod >= 2.0 (default on Trixie)

Wiring assumption (default):
    GPIO21 -- button -- GND   (active-low, internal pull-up enabled)
    Pressed  -> line reads LOW  -> falling edge -> switch.sh ON
    Released -> line reads HIGH -> rising edge  -> switch.sh OFF
Use --active-high if your button instead pulls the line HIGH when pressed.
"""

from __future__ import annotations

import argparse
import subprocess
import sys
from datetime import timedelta
from pathlib import Path

import gpiod
from gpiod.line import Bias, Edge

DEFAULT_CHIP = "/dev/gpiochip0"
DEFAULT_LINE_OFFSET = 21
DEFAULT_SCRIPT = Path(__file__).resolve().parent / "switch.sh"


def run_switch(script_path: Path, state: str) -> None:
    """Invoke switch.sh <state>, logging failures without killing the monitor loop."""
    try:
        subprocess.run(["/bin/bash", str(script_path), state], check=True)
    except subprocess.CalledProcessError as exc:
        print(f"[ERROR] {script_path.name} {state} exited with code {exc.returncode}", file=sys.stderr)
    except FileNotFoundError:
        print(f"[ERROR] script not found: {script_path}", file=sys.stderr)


def handle_event(event: gpiod.EdgeEvent, script_path: Path, active_low: bool) -> None:
    """Dispatch an edge event to switch.sh ON/OFF using a match/case (switch-style) block."""
    match event.event_type:
        case gpiod.EdgeEvent.Type.FALLING_EDGE:
            state = "ON" if active_low else "OFF"
            print(f"[EVENT] Falling edge on line {event.line_offset} -> {state}")
            run_switch(script_path, state)
        case gpiod.EdgeEvent.Type.RISING_EDGE:
            state = "OFF" if active_low else "ON"
            print(f"[EVENT] Rising edge on line {event.line_offset} -> {state}")
            run_switch(script_path, state)
        case _:
            print(f"[WARN] Unhandled edge event type: {event.event_type}", file=sys.stderr)


def monitor(
    chip_path: str,
    line_offset: int,
    script_path: Path,
    active_low: bool,
    debounce_us: int,
) -> None:
    bias = Bias.PULL_UP if active_low else Bias.PULL_DOWN

    with gpiod.request_lines(
        chip_path,
        consumer="gpio-button-monitor",
        config={
            line_offset: gpiod.LineSettings(
                edge_detection=Edge.BOTH,
                bias=bias,
                debounce_period=timedelta(microseconds=debounce_us),
            )
        },
    ) as request:
        print(
            f"Monitoring GPIO{line_offset} on {chip_path} "
            f"({'active-low' if active_low else 'active-high'}, "
            f"debounce={debounce_us}us) -- Ctrl+C to stop"
        )
        try:
            while True:
                # Blocks until an edge event is available.
                for event in request.read_edge_events():
                    handle_event(event, script_path, active_low)
        except KeyboardInterrupt:
            print("\nStopped.")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Monitor a GPIO line on a Raspberry Pi 5 (gpiochip0) and run "
            "switch.sh ON/OFF when a button is pressed/released."
        )
    )
    parser.add_argument(
        "--chip",
        default=DEFAULT_CHIP,
        help=f"GPIO chip device (default: {DEFAULT_CHIP})",
    )
    parser.add_argument(
        "--line",
        type=int,
        default=DEFAULT_LINE_OFFSET,
        help=f"GPIO line offset to monitor (default: {DEFAULT_LINE_OFFSET})",
    )
    parser.add_argument(
        "--script",
        type=Path,
        default=DEFAULT_SCRIPT,
        help=f"Path to switch.sh (default: {DEFAULT_SCRIPT})",
    )
    parser.add_argument(
        "--active-high",
        dest="active_low",
        action="store_false",
        help="Button pulls the line HIGH when pressed (default is active-low).",
    )
    parser.add_argument(
        "--debounce-us",
        type=int,
        default=10_000,
        help="Debounce period in microseconds (default: 10000 = 10ms).",
    )
    parser.set_defaults(active_low=True)
    return parser.parse_args()


def main() -> None:
    args = parse_args()

    if not args.script.exists():
        print(f"[ERROR] switch.sh not found at {args.script}", file=sys.stderr)
        sys.exit(1)

    monitor(
        chip_path=args.chip,
        line_offset=args.line,
        script_path=args.script,
        active_low=args.active_low,
        debounce_us=args.debounce_us,
    )


if __name__ == "__main__":
    main()
