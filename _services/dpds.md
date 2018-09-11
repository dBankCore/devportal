---
title: DPDS
position: 5
---

**dpds** is a tool for easily querying the data of the dPay Blockchain.

While providing direct interfaces to several pluggable storage architectures that may be used for querying the blockchain, dpds may also be used as a lower level API upon which other applications can be built.

**Docker Hub**

```
docker run -d dpay/dpds
```

**Python 3**
```
pip3 install -e git+git@github.com:dpay/dpds.git#egg=dpds
```

**Examples**

Stream blocks 1 to 3450000 from our dev S3 bucket
```
dpds checkpoints get-blocks s3://dpay-dev-dpds-checkpoints/gzipped --start 1 --end 3450000
```

Stream blocks 8000000 to the last block from your local copy of our S3 bucket
```
dpds checkpoints get-blocks /home/ubuntu/checkpoints/gzipped --start 8000000
```

Stream all blocks from your local copy of our S3 bucket

```
dpds checkpoints get-blocks /home/ubuntu/checkpoints/gzipped
```

**Routes**

Coming soon.
