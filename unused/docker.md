---
title: Docker
position: 1
---

Just want to get up and running quickly? Try deploying a pre-built dockerized container. Both common binary types are included.

Just want to get up and running quickly?  Try deploying a pre-built
dockerized container.  Both common binary types are included.

#### Dockerized P2P Node

To run a p2p node (ca. 2GB of memory is required at the moment):

    docker run \
        -d -p 6620:6620 -p 1776:1776 --name dpayd-default \
        dpay/dpay

    docker logs -f dpayd-default  # follow along

#### Dockerized Full Node

To run a node with *all* the data (e.g. for supporting a content website)
that uses ca. 14GB of memory and growing:

    docker run \
        --env USE_WAY_TOO_MUCH_RAM=1 \
        -d -p 6620:6620 -p 1776:1776 --name dpayd-full \
        dpay/dpay

    docker logs -f dpayd-full

#### Seed Nodes

A list of some seed nodes to get you started can be found in
[doc/seednodes.txt](doc/seednodes.txt).

This same file is baked into the docker images and can be overridden by
setting `DPAYD_SEED_NODES` in the container environment at `docker run`
time to a whitespace delimited list of seed nodes (with port).
