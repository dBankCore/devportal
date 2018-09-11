---
title: Using Jefferson as a Multiplexer
position: 1
description: Optimize your local applications with jefferson
exclude: true
layout: full
---

*By the end of this recipe you should know how to install `jefferson` on your local subnet to take advantage of its features.*

This recipe will take you through the process of setting up `jefferson` for a small infrastructure like a home network.

## Intro

What is a Multiplexer?  In this context, a multiplexer an appliance that accepts API requests from multiple applications running on the same subnet and passes them to an upstream node.  This means, for example, if you have two applications that request the same block from API, your local `jefferson` instance will make a single upstream request for the block and return it to both applications.

Deploying `jefferson` on your own local subnet will help improve efficiency because your local applications won't require SSL and `jefferson` can take care of gzipping requests that go out over the Internet.

<center>
  <img src="/images/tutorials-recipes/jefferson-multiplexer/network-diagram.png" alt="Network Diagram" />
</center>

## Steps

1. [**Setting Up Docker**](#setting-up-docker) In order to run `jefferson`, `docker` is recommended
1. [**Install `jefferson`**](#install-jefferson) Clone `jefferson` from the repository and build
1. [**Configure Your Apps**](#configure-your-apps) Point all of your applications to this node

#### 1. Setting Up Docker <a name="setting-up-docker"></a>

Although it's possible to set up `jefferson` to run natively without virtualization, `docker` is recommended.  Setting up `docker` depends on your operating system:

* [Docker for Linux](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
* [Docker for macOS](https://docs.docker.com/docker-for-mac/install/)
* [Docker for Windows](https://docs.docker.com/docker-for-windows/)

#### 2. Install `jefferson` <a name="install-jefferson"></a>

```bash
git clone https://github.com/dpays/jefferson.git
cd jefferson
```

Edit the file `DEV_config.json` and change all:

`https://dpayd.dpays.io`

... to ...

`https://api.dpays.io`

Also consider adding the [`retries`](/services/#retry) element to your `DEV_config.json`.

Then build and run:

```bash
docker build -t="$USER/jefferson:$(git rev-parse --abbrev-ref HEAD)" .
docker run -itp 9000:8080 "$USER/jefferson:$(git rev-parse --abbrev-ref HEAD)"
```

#### 3. Configure Your Apps <a name="configure-your-apps"></a>

Now, you can use your new `jefferson` node as if it's a full node running locally.  For example:

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_block", "params":[8675309], "id":1}' http://localhost:9000
```

In this case, `http://localhost:9000` will act like a full node.  In reality, it's passing all of its request to its upstream, `https://api.dpays.io`.

Once you've implemented your own `jefferson` node in this manner, you should notice an improvement in bandwidth utilization.  If you're internet provider implements packet shaping strategies, this will have a positive impact because you are no longer streaming the entire blockchain once for each application.

## Troubleshooting / Updating

#### Error: `invalid argument "/jefferson:master" for t=/jefferson:master: invalid reference format`

*Solution:*

You're probably trying to run on a raspberry pi.  Just replace `$USER` in the command with the current user.

---

If you would like to update `jefferson` to the latest version, here's a quick way:

```bash
git stash && git pull && git stash pop
```

If there are `git` errors due to structural changes to `DEV_config.json`, just start over from step 2 and reclone `jefferson` to a fresh location.  Otherwise, you should be able to rebuild and run.
