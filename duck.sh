#!/bin/bash

# curl --basic -u "kingrachid2000@gmail.com:miragedz123" --silent https://ydns.io/api/v1/update/?host=miragedz.ydns.eu\&ip=$(curl --silent https://ydns.io/api/v1/ip)
echo url="https://www.duckdns.org/update?domains=miragedz&token=18c0e58f-5605-4475-a180-965097e89e42&ip=" | curl -k -o ~/.config/duckdns/duck.log -K -
