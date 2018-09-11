---
title: Tutorials
position: 2
---

##### __dpay-py examples__
Install dpay-py:

~~~
$ sudo apt-get install libffi-dev libssl-dev python-dev python3-pip
$ pip3 install dpay
~~~

##### Auto Reply Bot
The most easy auto-reply bot can be coded with just a few lines of code:

##### Block Stream
This module allows to stream blocks and individual operations from the blockchain and run bots with a minimum of code.
This example code shows all comments starting at block 1893850.


##### Operation Stream
Example for operation Stream:


##### Decentralized Exchange
Example for decentralized exchange:

~~~ python
from dpay import DPay
import os
import json
dpay = DPay(wif="<posting-key-for-default-author>")
for c in dpay.stream_comments():
if "Anything you want" in c["body"]:
    print(c.reply(".. anything you want"))
~~~
{: title="Auto Reply Bot"}

~~~ python
from dpay.blockchain import Blockchain
from pprint import pprint

for a in blockchain.blocks()
    pprint(a)
~~~
{: title="Block Stream"}

~~~ python
from dpay.blockchain import Blockchain
from pprint import pprint

for a in blockchain.ops()
    pprint(a)
~~~
{: title="Opereation Stream"}

~~~ python
from pprint import pprint
from dpay import DPay
from dpay.dex import Dex

dpay = DPay()
dex = Dex(dpay)
pprint(dex.buy(10, "BBD", 100))
pprint(dex.sell(10, "BBD", 100))
pprint(dex.cancel("24432422"))
pprint(dex.returnTicker())
pprint(dex.return24Volume())
pprint(dex.returnOrderBook(2))
pprint(dex.ws.get_order_book(10, api="market_history"))
pprint(dex.returnTradeHistory())
pprint(dex.returnMarketHistoryBuckets())
pprint(dex.returnMarketHistory(300))
pprint(dex.get_lowest_ask())
pprint(dex.get_higest_bid())
pprint(dex.transfer(10, "BBD", "jared", "nomoreheroes"))
~~~
{: title="Decentralized Exchange"}
