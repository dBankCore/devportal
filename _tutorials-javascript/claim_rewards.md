---
title: 'JS: Claim Rewards'
position: 23
description: '_Learn how to claim rewards from unclaimed reward balance using dPayID as well as client signing method._'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Claim Rewards](https://github.com/dpays/developer-docs-tutorials-js/tree/master/tutorials/23_claim_rewards) can be downloaded as part of the [JS tutorials repository](https://github.com/dpays/developer-docs-tutorials-js).</span>
<br>



This tutorial runs on the main dPay blockchain. And accounts queried are real users with unclaimed balances.

## Intro

This tutorial will show few functions such as querying account by name and getting unclaimed rewards. We are using the `call` function provided by the `ddpays` library to pull accounts from the dPay blockchain. A simple HTML interface is used to capture the account and its unclaimed balance as well as allowing interactively claim rewards.

## Steps

1.  [**App setup**](#app-setup) Setup `ddpays` to use the proper connection and network.
2.  [**Search account**](#search-account) Get account details after input has account name
3.  [**Fill form**](#fill-form) Fill form with account reward balances
4.  [**Claim reward**](#claim-reward) Claim reward with dPayID or Client signing options

#### 1. App setup <a name="app-setup"></a>

Below we have `ddpays` pointing to the production network with the proper chainId, addressPrefix, and endpoint. There is a `public/app.js` file which holds the Javascript segment of this tutorial. In the first few lines we define the configured library and packages:

```javascript
const ddpays = require('ddpays');
let opts = {};
//connect to production server
opts.addressPrefix = 'STM';
opts.chainId =
    '38f14b346eb697ba04ae0f5adcfaa0a437ed3711197704aa256a14cb9b4a8f26';
//connect to server which is connected to the network/production
const client = new ddpays.Client('https://api.dpays.io');
```

#### 2. Search account <a name="search-account"></a>

After account name field is filled with some name, we do automatic search for account by name when input is focused out. HTML input forms can be found in the `index.html` file. The values are pulled from that screen with the below:

```javascript
    const accSearch = document.getElementById('username').value;
    const _accounts = await client.database.call('get_accounts', [[accSearch]]);
    console.log(`_accounts:`, _accounts);
```

#### 3. Fill form <a name="fill-form"></a>

After we fetched account data, we will fill form with reward balance and show current reward balance details.

```javascript
const name = _accounts[0].name;
const reward_dpay = _accounts[0].reward_dpay_balance.split(' ')[0];
const reward_bbd = _accounts[0].reward_bbd_balance.split(' ')[0];
const reward_sp = _accounts[0].reward_vesting_dpay.split(' ')[0];
const reward_vests = _accounts[0].reward_vesting_balance.split(' ')[0];
const unclaimed_balance = `Unclaimed balance for ${name}: ${reward_dpay} BEX, ${reward_bbd} BBD, ${reward_sp} SP = ${reward_vests} VESTS<br/>`;
document.getElementById('accList').innerHTML = unclaimed_balance;
document.getElementById('bex').value = reward_dpay;
document.getElementById('bbd').value = reward_bbd;
document.getElementById('bp').value = reward_vests;
```

#### 4. Claim reward <a name="claim-reward"></a>

We have 2 options on how to claim rewards. dPayID and Client signing options. We generate dPayID link to claim rewards, but you can also choose client signing option to claim rewards right inside tutorial.

In order to enable client signing, we will generate operation and also show Posting Private key (wif) field to sign transaction right there client side.
Below you can see example of operation and signing transaction, after successful operation broadcast result will be shown in user interface. It will be block number that transaction was included.

```javascript
window.submitTx = async () => {
    const privateKey = ddpays.PrivateKey.fromString(
        document.getElementById('wif').value
    );
    const op = [
        'claim_reward_balance',
        {
            account: document.getElementById('username').value,
            reward_dpay: document.getElementById('bex').value + ' BEX',
            reward_bbd: document.getElementById('bbd').value + ' BBD',
            reward_vests: document.getElementById('bp').value + ' VESTS',
        },
    ];
    client.broadcast.sendOperations([op], privateKey).then(
        function(result) {
            document.getElementById('result').style.display = 'block';
            document.getElementById(
                'result'
            ).innerHTML = `<br/><p>Included in block: ${
                result.block_num
            }</p><br/><br/>`;
        },
        function(error) {
            console.error(error);
        }
    );
};
```

That's it!

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/21_claim_rewards`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)

---
