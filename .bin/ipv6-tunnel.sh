#!/bin/sh

LOCAL=CHANGE!!!                     # Client IPv4 address
ADDR=CHANGE!!!                      # Client IPv6 address
REMOTE=CHANGE!!!                    # Server IPv4 address

ip tunnel del he-ipv6 > /dev/null 2>&1

ip tunnel add he-ipv6 mode sit remote  local  ttl 255
ip link set he-ipv6 up

ip addr add  dev he-ipv6
ip route add ::/0 dev he-ipv6
