---
title: 'PY: Using Keys Securely'
position: 12
description: "Learn how dPay-Python library handles transaction signing with user's key and how to securely manage your private keys."
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Using Keys Securely](https://github.com/dpays/developer-docs-tutorials-py/tree/master/tutorials/12_using_keys_securely) can be downloaded as part of the [PY tutorials repository](https://github.com/dpays/developer-docs-tutorials-py).</span>
<br>



## Intro

dPay python library has 2 ways to handle your keys. One is from source code, another one is through command line interface called `dpaypy`. `dpaypy` cli is installed by default when you install dpay-python library on your machine.

## Steps

1.  [**App setup**](#app-setup) - Library install and import
1.  [**Key usage example**](#example-list) - Example showing how to import keys

#### 1. App setup <a name="app-setup"></a>

In this tutorial we are only using `dpay` package - dpay-python library.

```python
  # initialize DPay class
  from dpay import DPay

  # defining private keys inside source code is not secure way but possible
  s = DPay(keys=['<private_posting_key>', '<private_active_key>'])
```

Last line from above snippet shows how to define private keys for account that's going to transact using script.

#### 2. Key usage example <a name='example-list'></a>

After defining private keys inside DPay class, we can quickly sign any transaction and broadcast it to the network.

```python
  # above will allow accessing Commit methods such as
  # demo account sending 0.001 BEX to demo1 account

  s.commit.transfer('demo','0.001','BEX','memo text','demo1')
```

Above method works but it is not secure way of handling your keys because you have entered your keys within source code that you might leak accidentally. To avoid that, we can use CLI - command line interface `dpaypy`.

You can type following to learn more about `dpaypy` commands:

```python
  dpaypy -h
```

`dpaypy` lets you leverage your [BIP38](https://bitcoinpaperwallet.com/bip38-password-encrypted-wallets/) encrypted wallet to perform various actions on your accounts.

The first time you use dpaypy, you will be prompted to enter a password. This password will be used to encrypt the dpaypy wallet, which contains your private keys.

You can import your dPay username with following command:

`dpaypy importaccount username`

Next you can import individual private keys:

`dpaypy addkey <private_key>`

That's it, now that your keys are securely stored on your local machine, you can easily sign transaction from any of your Python scripts by using defined keys.

```python
  # if private keys are not defined
  # accessing Wallet methods are also possible and secure way
  s.wallet.get_active_key_for_account('demo')
```

Above line fetches private key for user `demo` from local machine and signs transaction.

`dpaypy` also allows you to sign and broadcast transactions from terminal. For example:

`dpaypy transfer --account <account_name> <recipient_name> 1 BEX memo`

would sign and broadcast transfer operation,

`dpaypy upvote --account <account_name> link`

would sing and broadcast vote operation, etc.

That's it!

### To Run the tutorial

1.  [review dev requirements](https://github.com/dpays/developer-docs-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/12_using_keys_securely`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see output in terminal/command prompt screen.

---
