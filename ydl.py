#!/data/data/com.termux/files/usr/bin/env python3
import subprocess
import sys

def install_dependencies():
    """Installer yt-dlp si nécessaire"""
    try:
        import yt_dlp
    except ImportError:
        print("Installation de yt-dlp...")
        subprocess.run([sys.executable, "-m", "pip", "install", "yt-dlp"], check=True)

def download_video(url, output_dir="storage/downloads"):
    """Télécharger une vidéo simplement"""
    import yt_dlp

    ydl_opts = {
        'outtmpl': f'{output_dir}/%(title)s.%(ext)s',
        'format': 'best[ext=mp4]/best',
    }

    try:
        with yt_dlp.YoutubeDL(ydl_opts) as ydl:
            ydl.download([url])
        print("✅ Téléchargement terminé!")
    except Exception as e:
        print(f"❌ Erreur: {e}")

if __name__ == "__main__":
    install_dependencies()

    if len(sys.argv) > 1:
        url = sys.argv[1]
        download_video(url)
    else:
        url = input("🎬 Entrez l'URL de la vidéo: ")
        download_video(url)
        