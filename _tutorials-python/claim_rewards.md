---
title: 'PY: Claim Rewards'
position: 23
description: 'How to claim rewards using Python.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Claim Rewards](https://github.com/dpays/developer-docs-tutorials-py/tree/master/tutorials/23_claim_rewards) can be downloaded as part of the [PY tutorials repository](https://github.com/dpays/developer-docs-tutorials-py).</span>
<br>



In this tutorial we show you how to check the BEX, BBD and BEX POWER rewards balances of an account on the **dPay** blockchain, and how to claim either a portion or all of the rewards for an account using the `commit` class found within the [dpay-python](https://github.com/dpays/dpay-python) library.

## Intro

The dPay python library has a built-in function to transmit transactions to the blockchain. We are using the `claim_reward_balance` method found within the `commit` class in the library. Before we transmit a claim, we use the `get_account` function to check the current rewards balance of the account to see what is available to claim. The `claim` method has 4 parameters:

1.  _reward dpay_ - The amount of BEX to claim
1.  _reward bbd_ - The amount of BBD to claim
1.  _reward vests_ - The amount of VESTS (BEX POWER) to claim
1.  _account_ - The source account for the claim

## Steps

1.  [**App setup**](#setup) - Library install and import. Connection to testnet
1.  [**User information and dPay node**](#userinfo) - Input user information and connection to dPay node
1.  [**Check reward balance**](#balance) - Check current rewards balances of user account
1.  [**Claim commit**](#commit) - Input amount of rewards to claim and commit to blockchain
1.  [**Balance update**](#update) - Check new rewards balances after completed claim

#### 1. App setup <a name="setup"></a>

In this tutorial we use 2 packages:

- `dpay` - dpay-python library and interaction with Blockchain
- `pick` - helps select the query type interactively

We import the libraries and connect to the `testnet`.

```python
import dpaybase
import dpay
from pick import pick
from dpay.amount import Amount

dpaybase.chains.known_chains['DPAY'] = {
    'chain_id': '38f14b346eb697ba04ae0f5adcfaa0a437ed3711197704aa256a14cb9b4a8f26',
    'prefix': 'DWB', 'bex_symbol': 'BEX', 'bbd_symbol': 'BBD', 'vests_symbol': 'VESTS'
}
```

Because this tutorial alters the blockchain we connect to a testnet so we don't create spam on the production server.

#### 2. User information and dPay node <a name="userinfo"></a>

We require the `private active key` of the user in order for the claim to be committed to the blockchain. This is why we are using a testnet. The values are supplied via the terminal/console before we initialize the `dpay` class. There are some demo accounts available but we encourage you to create your own accounts on this testnet and create balances you can claim; it's good practice.

```python
#capture user information
username = input('Enter username: ') #demo account: cdemo
wif = input('Enter private ACTIVE key: ') #demo account: 5KaNM84WWSqzwKzY82fXPaUW43idbLnPqf5SfjGxLfw6eV2kAP3

#connect node
client = dpay.DPay(nodes=['https://testnet.dpays.io'],keys=[wif])
```

#### 3. Check reward balance <a name="balance"></a>

In order to get a clear picture of the available rewards that can be claimed, we send a query to the blockchain using the `get_account` function. From the result we can gather the rewards balances.

```python
#get account reward balances
userinfo = client.get_account(username)

reward_dpay = userinfo['reward_dpay_balance']
reward_bbd = userinfo['reward_bbd_balance']
reward_sp = userinfo['reward_vesting_dpay']
reward_vests = userinfo['reward_vesting_balance']

print('Reward Balances:' + '\n' +
    'BEX: ' + reward_dpay + '\n' +
    'BBD: ' + reward_bbd + '\n' +
    'BEX POWER: ' + reward_bp + '\n' +
    'VESTS: ' + reward_vests
    )

input('\n' + 'Press enter to continue to claim selection')
```

The result of the query is displayed in the console/terminal.

#### 4. Claim commit <a name="commit"></a>

An option is provided to either claim all rewards at once or to specify specific amounts to be claimed for each individual reward balance. If you are using one of dPay's demo accounts, please leave some rewards for others to claim!

```python
#choice of claim
title = 'Please choose claim type: '
options = ['ALL', 'SELECTED', 'CANCEL']
option, index = pick(options, title)
```

When the option to claim all rewards is selected, the claim parameters are automatically assigned from the `get_accounts` query. We also check that there are in fact outstanding rewards balances before we commit the claim.

```python
#commit claim based on selection
if option == 'ALL':
    if Amount(reward_dpay).amount + Amount(reward_bbd).amount + Amount(reward_vests).amount == 0:
        print('\n' + 'No rewards to claim')
        exit()
    else:
        client.claim_reward_balance(reward_dpay, reward_bbd, reward_vests, username)
        print('\n' + 'All reward balances have been claimed. New reward balances are:' + '\n')
else:
    if option == 'CANCEL':
        print('\n' + 'Operation cancelled')
        exit()
    else:
        claim_dpay = input('\n' + 'Please enter the amount of BEX to claim: ') + ' BEX'
        claim_bbd = input('Please enter the amount of BBD to claim: ') + ' BBD'
        claim_vests = input('Please enter the amount of VESTS to claim: ') + ' VESTS'
        if Amount(claim_dpay).amount + Amount(claim_bbd).amount + Amount(claim_vests).amount == 0:
            print('\n' + 'Zero values entered, no claim to submit')
            exit()
        else:
            if claim_dpay > reward_dpay or claim_bbd > reward_bbd or claim_vests > reward_vests:
                print('\n' + 'Requested claim value higher than available rewards')
                exit()
            else:
                client.claim_reward_balance(claim_dpay, claim_bbd, claim_vests, username)
                print('\n' + 'Claim has been processed. New reward balances are:' + '\n')

```

When doing only a selected claim of available rewards, the values are captured in the console/terminal. The inputs cannot be negative, must be less than or equal to the available reward and at least ONE of the inputs needs to be greater than zero for the claim to be able to transmit. The result of the selected option is printed on the UI.

#### 5. Balance update <a name="update"></a>

As a final check we run the account query again to get updated values for the available rewards balances.

```python
#get updated account reward balances
userinfo = client.get_account(username)

reward_dpay = userinfo['reward_dpay_balance']
reward_bbd = userinfo['reward_bbd_balance']
reward_sp = userinfo['reward_vesting_dpay']
reward_vests = userinfo['reward_vesting_balance']

print('BEX: ' + reward_dpay + '\n' +
    'BBD: ' + reward_bbd + '\n' +
    'BEX POWER: ' + reward_sp + '\n' +
    'VESTS: ' + reward_vests
    )
```

We encourage users to play around with different values and data types to fully understand how this process works. You can also check the balances and transaction history on the [testnet portal](http://condenser.dpays.io/).

### To Run the tutorial

1.  [review dev requirements](https://github.com/dpays/developer-docs-tutorials-py/tree/master/tutorials/00_getting_started#dev-requirements)
1.  clone this repo
1.  `cd tutorials/23_claim_rewards`
1.  `pip install -r requirements.txt`
1.  `python index.py`
1.  After a few moments, you should see a prompt for input in terminal screen.

---
