---
title: dpayd Nodes
position: 2
exclude: true
---

Applications that interface directly with the dPay blockchain will need to connect to a `dpayd` node. Developers may choose to use one of the public API nodes that are available, or run their own instance of a node.

### Public Nodes

| URL                             | Owner          |
| ------------------------------- | -------------- |
| d.dsite.io                      | @dweb          |
| d.dpays.io                      | @dpay          |
| dpayd.dpays.io                  | @dpay          |
| d.dpays.io                      | @dpay          |
| dpay.mbex.link                  | @mbex          |
| dpaystan.link                   | @stan          |
| dpay.michaelx.link              | @michaelx      |
| dpay.nomoreheroes.link          | @nomoreheroes  |
| dpay.indominon.com         | @onceuponatime |
| freedomfirst.dpays.io           | @freedomfirst  |
| jefferson.dpays.io              | @jared         |
| jackson.dpays.io                | @nickeles      |
| dpay.tablecafe.link             | @tablecafe     |

### Private Nodes

The simplest way to get started is by deploying a pre-built dockerized container.

##### Dockerized p2p Node

_To run a p2p node (ca. 2GB of memory is required at the moment):_

##### Dockerized Full Node

_to run a node with all the data (e.g. for supporting a content website) that uses ca. 14GB of memory and growing:_

### Syncing blockchain

Normally syncing blockchain starts from very first, `0` genesis block. It might take long time to catch up with live network. Because it connectes to various p2p nodes in the dPay network and requests blocks from 0 to head block. It stores blocks in block log file and builds up the current state in the shared memory file. But there is a way to bootstrap syncing by using trusted `block_log` file. The block log is an external append only log of the blocks. It contains blocks that are only added to the log after they are irreversible because the log is append only.

Trusted block log file helps to download blocks faster. dPay DAO, provides public block log file which can be downloaded from [here](https://s3.amazonaws.com/dpay-dev-blockchainstate/block_log-latest) and there is also option from community witness `@stan` which can be downloaded from [here](https://dpaystan.link/get/blockchain/).

Both `block_log` files updated periodically, as of May 2018 uncompressed `block_log` file size ~110 GB. Docker container on `stable` branch of dPay source code has option to use `USE_PUBLIC_BLOCKLOG=1` to download latest block log and start dPay node with replay.

Block log should be place in `blockchain` directory below `data_dir` and node should be started with `--replay-blockchain` to ensure block log is valid and continue to sync from the point of snapshot. Replay uses the downloaded block log file to build up the shared memory file up to the highest block stored in that snapshot and then continues with sync up to the head block.

Replay helps to sync blockchain in much faster rate, but as blockchain grows in size replay might also take some time to verify blocks.

There is another [trick which might help](https://github.com/dpays/dpay/issues/2391) with faster sync/replay on smaller equipped servers:

```
while :
do
   dd if=blockchain/block_log iflag=nocache count=0
   sleep 60
done
```

Above bash script drops `block_log` from the OS cache, leaving more memory free for backing the blockchain database. It might also help while running live, but measurement would be needed to determine this.

##### Few other tricks that might help:

For Linux users, virtual memory writes dirty pages of the shared file out to disk more often than is optimal which results in dpayd being slowed down by redundant IO operations. These settings are recommended to optimize reindex time.

```
echo    75 | sudo tee /proc/sys/vm/dirty_background_ratio
echo  1000 | sudo tee /proc/sys/vm/dirty_expire_centisecs
echo    80 | sudo tee /proc/sys/vm/dirty_ratio
echo 30000 | sudo tee /proc/sys/vm/dirty_writeback_centisecs
```

Another settings that can be changed in `config.ini` is `flush` - it is to specify a target number of blocks to process before flushing the chain database to disk. This is needed on Linux machines and a value of 100000 is recommended. It is not needed on OS X, but can be used if desired.

``` bash
docker run \
    -d -p 2001:2001 -p 8090:8090 --name dpayd-default \
    dpay/dpay

docker logs -f dpayd-default  # follow along
```
``` bash
docker run \
    --env USE_WAY_TOO_MUCH_RAM=1 \
    -d -p 2001:2001 -p 8090:8090 --name dpayd-full \
    dpay/dpay

docker logs -f dpayd-full
```  