#!/bin/bash

# Replace 'wlp2s0' with your interface name (`ip link`)
IF="enp4s0"


RX_PREV=0
TX_PREV=0


while true; do
RX_CUR=$(cat /sys/class/net/$IF/statistics/rx_bytes)
TX_CUR=$(cat /sys/class/net/$IF/statistics/tx_bytes)
RX=$(( (RX_CUR - RX_PREV) / 1024 ))
TX=$(( (TX_CUR - TX_PREV) / 1024 ))
RX_PREV=$RX_CUR
TX_PREV=$TX_CUR
echo "⬆ ${TX} KB/s ⬇ ${RX} KB/s"
sleep 1
done
