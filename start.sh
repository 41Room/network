#!/bin/bash
# geth 초기화
if [ -d "./data_testnet/geth" ];
then echo "Directory ./data_testnet/geth exists."
else
    echo "Directory ./data_testnet/geth does not exists."
    geth --datadir ./data_testnet init ./data_testnet/genesis.json
fi

# 활성 포트 체크
if lsof -Pi :8545 -sTCP:LISTEN -t >/dev/null ; then echo "Port 8545 is already in use."
else
    echo "Port 8545 is not in use."

    echo "Start Network..."

    nohup geth \
    --networkid 5674 \
    --datadir ./data_testnet \
    --http \
    --http.addr "0.0.0.0" \
    --http.port 8545 \
    --port 30303 \
    --http.corsdomain "*" \
    --http.api "eth, net, web3, personal, miner, admin, debug, txpool" \
    --allow-insecure-unlock \
    --nat=none &
    

    echo "Network Running on Port 8545"
fi

