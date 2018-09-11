---
title: 'JS: Create Account'
position: 26
description: '_Create dPay account using dPayID as well as with client-side signing._'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Create Account](https://github.com/dpays/developer-docs-tutorials-js/tree/master/tutorials/26_create_account) can be downloaded as part of the [JS tutorials repository](https://github.com/dpays/developer-docs-tutorials-js).</span>
<br>



This tutorial runs on the main dPay blockchain. And accounts queried/searched are real accounts and creator account show have sufficient liquid balance to create new account.

## Intro

This tutorial will show few functions such as querying account by name and check if username is taken or available to register. We are using the `call` function provided by the `ddpays` library to pull account from the dPay blockchain. We then create proper private keys for new account. A simple HTML interface is used to enter payment of account creation fee and create account right inside tutorial.

## Steps

1.  [**App setup**](#app-setup) Setup `ddpays` to use the proper connection and network.
2.  [**Search account**](#search-account) Get account details after input has account name
3.  [**Generate private keys**](#generate-keys) Generate proper keys for new account
4.  [**Create account**](#create-account) Create account via Client-side or dPayID

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

After account name field is filled with some name, tutorial has Search button to search for account by name. HTML input forms can be found in the `index.html` file. The values are pulled from that screen with the below:

```javascript
    const accSearch = document.getElementById('username').value;
    let avail = 'Account is NOT available to register'
    if (accSearch.length>2) {
        const _account = await client.database.call('get_accounts', [[accSearch]]);
        console.log(`_account:`, _account, accSearch.length);

        if (_account.length==0) {
            avail = 'Account is available to register'
        }
    }
```

We will then do simple check if account is taken or not.

#### 3. Generate private keys <a name="generate-keys"></a>

After we know that account is available to register, we will fill form with password we wish for that account and enter creation fee. Note, that creation fees are deposited into new account, if VESTS is entered it will be powered up to new account.

```javascript
const username = document.getElementById('username').value;
const password = document.getElementById('password').value;

const ownerKey = ddpays.PrivateKey.fromLogin(username, password, 'owner');
const activeKey = ddpays.PrivateKey.fromLogin(username, password, 'active');
const postingKey = ddpays.PrivateKey.fromLogin(username, password, 'posting');
const memoKey = ddpays.PrivateKey.fromLogin(username, password, 'memo');

const ownerAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[ownerKey.createPublic(), 1]],
};
const activeAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[activeKey.createPublic(), 1]],
};
const postingAuth = {
    weight_threshold: 1,
    account_auths: [],
    key_auths: [[postingKey.createPublic(), 1]],
};
```

Above script shows, how to properly setup private keys of new account.

#### 4. Create account <a name="create-account"></a>

After following all steps properly, we can now submit transaction to create new account.

```javascript
const privateKey = ddpays.PrivateKey.fromString(
    document.getElementById('wif').value
);
const op = [
    'account_create',
    {
        creator: document.getElementById('account').value,
        new_account_name: username,
        owner: ownerAuth,
        active: activeAuth,
        posting: postingAuth,
        memo_key: memoKey,
        json_metadata: '',
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
```

Note in above creator's account name and active private keys are used for creation.

That's it!

### To run this tutorial

1.  clone this repo
1.  `cd tutorials/24_create_account`
1.  `npm i`
1.  `npm run dev-server` or `npm run start`
1.  After a few moments, the server should be running at [http://localhost:3000/](http://localhost:3000/)

---
