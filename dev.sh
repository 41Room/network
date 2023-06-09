#!/bin/bash
# geth 초기화
if [ -d "./data_testnet/geth" ]
then echo "Directory ./data_testnet/geth exists."
else
    echo "Directory ./data_testnet/geth does not exists."
    geth --datadir ./data_testnet init ./data_testnet/genesis.json
fi
# 백그라운드 여부 파악용 변수
background_run=""

# 백그라운드 여부 파악
if [ "$1" == "-b" ]; then 
    background_run="&"
fi

# 활성 포트 체크
if lsof -Pi :8545 -sTCP:LISTEN -t >/dev/null ; then echo "Port 8545 is already in use."
else
    geth \
    --networkid 4777 \
    --datadir ./data_testnet \
    --http \
    --http.addr "0.0.0.0" \
    --http.port 8545 \
    --http.corsdomain "*" \
    --port 30303 \
    --http.corsdomain "*" \
    --http.vhosts=* \
    --http.api "eth, net, web3, personal, miner, admin, debug, txpool, shh, db" \
    --miner.etherbase "0x80c85d9b325b49f03629efb37d970eb47ef1ebae" \
    --allow-insecure-unlock \
    --verbosity 3 \
    console 2>> "./data_testnet/geth.log" \
    $background_run
fi