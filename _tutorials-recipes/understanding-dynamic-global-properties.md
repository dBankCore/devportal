---
title: Understanding Dynamic Global Properties
position: 1
description: Maintains global state information
exclude: true
layout: full
---

### Intro

Dynamic Global Properties represents a set of values that are calculated during normal chain operations and reflect the current values of global blockchain properties.

[The API](#example-method-call) returns an object containing information that changes every block interval such as the head block number, the total vesting fund, etc.

### Sections

* Fields
  * [head_block_number](#head_block_number)
  * [head_block_id](#head_block_id)
  * [time](#time)
  * [current_witness](#current_witness)
  * [total_pow](#total_pow)
  * [num_pow_witnesses](#num_pow_witnesses)
  * [virtual_supply](#virtual_supply)
  * [current_supply](#current_supply)
  * [current_bbd_supply](#current_bbd_supply)
  * [total_vesting_fund_dpay](#total_vesting_fund_dpay)
  * [total_vesting_shares](#total_vesting_shares)
  * [total_reward_fund_dpay](#total_reward_fund_dpay)
  * [total_reward_shares2](#total_reward_shares2)
  * [bbd_interest_rate](#bbd_interest_rate)
  * [maximum_block_size](#maximum_block_size)
  * [current_aslot](#current_aslot)
  * [recent_slots_filled](#recent_slots_filled)
  * [last_irreversible_block_num](#last_irreversible_block_num)
  * [vote_power_reserve_rate](#vote_power_reserve_rate)
  * [average_block_size](#average_block_size)
  * [current_reserve_ratio](#current_reserve_ratio)
  * [max_virtual_bandwidth](#max_virtual_bandwidth)
* [Not Covered](#not-covered)
* [Example Method Call](#example-method-call)
* [Example Output](#example-output)

### `head_block_number`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Block height at the head of the blockchain.  This represents the latest block produced by witnesses.

* example: `24155032`

### `head_block_id`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Used to implement TaPoS (Transaction as Proof of Stake).  The first 4 bytes (8 hex digits) of the block ID represents the block number.  E.g., `01709398` in hex is `24155032` in decimal.

* example: `0170939865fa4e3aa7fca8f8df35d23333fe0bee`
* see: [RIPEMD-160 hashes](https://en.wikipedia.org/wiki/RIPEMD#RIPEMD-160_hashes)

### `time`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Point in time (UTC) that the block was included in the chain.

Used to synchronize events like Hard Fork activation.

When attempting to calculate the validity of a transaction we need to lookup a past block and check its block hash and the time it occurred so we can calculate whether the current transaction is valid and at what time it should expire.

For new transactions, expirations originate from this time.

* example: `2018-07-14T01:19:51`

### `current_witness`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Account name of the current witness.

* example: `blocktrades`

### `total_pow` <span class="warn deprecated">Deprecated</span><a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The total POW accumulated, aka the sum of `num_pow_witness` at the time new POW is added.

* example: `514415`

### `num_pow_witnesses` <span class="warn deprecated">Deprecated</span><a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>


The current count of how many pending POW witnesses there are, determines the difficulty of doing pow.

* example: `172`

### `virtual_supply`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The virtual supply is the supply of all BEX + all BBD if all BBD were converted to BEX at the current median price.

* example: `283290592.652 BEX`

### `current_supply`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

BEX currently in existence.

* example: `271546371.129 BEX`

### `confidential_supply`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Total asset held in confidential balances.

* example: `0.000 BEX`

### `current_bbd_supply`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

BBD currently in existence.

* example: `15478883.968 BBD`

### `confidential_bbd_supply`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Total asset held in confidential balances.

* example: `0.000 BBD`

### `total_vesting_fund_dpay` <span class="warn deprecated">Deprecated</span><a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

*Now deprecated way to get BEX that is invested in BEX POWER (powered up).*

Use [`condenser_api.get_reward_fund`](/apidefinitions/#condenser_api.get_reward_fund) instead.

* example: `192713261.007 BEX`

### `total_vesting_shares`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

VESTS that are invested in BEX POWER (powered up).

* example: `390950506702.452773 VESTS`

### `total_reward_fund_dpay`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

BEX available in the reward pool.

* example: `0.000 BEX`

### `total_reward_shares2` <span class="warn deprecated">Deprecated</span> <a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

*Now deprecated way to get the number of shares in the pool.*

Use [`condenser_api.get_reward_fund`](/apidefinitions/#condenser_api.get_reward_fund) instead.

* example: `0`

### `bbd_interest_rate`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

This property defines the interest rate that BBD deposits receive.

* example: `0`

### `maximum_block_size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Maximum block size is decided by the set of active witnesses which change every round.  Each witness posts what they think the maximum size should be as part of their witness properties, the median size is chosen to be the maximum block size for the round.

**Note:** the minimum value for `maximum_block_size` is defined by the protocol to prevent the network from getting stuck by witnesses attempting to set this too low.

* example: `65536`

### `current_aslot`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The current absolute slot number.  Equal to the total number of slots since genesis.  Also equal to the total number of missed slots plus `head_block_number`.

* example: `24231997`

### `recent_slots_filled`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Used to compute witness participation.

* example: `340282366920938463463374607431768211455`

### `last_irreversible_block_num`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The latest block number that has been confirmed by two thirds of all block producers and is thus irreversible.

* example: `24155017`

### `vote_power_reserve_rate`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The number of votes regenerated per day.  Any user voting slower than this rate will be "wasting" voting power through spillover; any user voting faster than this rate will have their votes reduced.

* example: `10`

### `average_block_size`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Average block size is updated every block to be: `average_block_size = (99 * average_block_size + new_block_size) / 100`.  This property is used to update the `current_reserve_ratio` to maintain approximately *  50% or less utilization of network capacity.

* example: `9309`

### `current_reserve_ratio`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Any time `average_block_size <= 50% maximum_block_size` this value grows by 1 until it reaches `DPAY_MAX_RESERVE_RATIO`.  Any time `average_block_size` is greater than 50% it falls by 1%.  Upward adjustments happen once per round, downward adjustments happen every block.

* example: `200000000`

### `max_virtual_bandwidth`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

The maximum bandwidth the blockchain can support is `max_bandwidth = maximum_block_size * DPAY_BANDWIDTH_AVERAGE_WINDOW_SECONDS / DPAY_BLOCK_INTERVAL`; The maximum virtual bandwidth is: `max_bandwidth * current_reserve_ratio`

* example: `264241152000000000000`

### `Not Covered`<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

Fields not covered in this recipe are:

* `confidential_supply`
* `confidential_bbd_supply`
* `pending_rewarded_vesting_shares`
* `pending_rewarded_vesting_dpay`
* `bbd_print_rate`
* `participation_count`

### Example Method Call<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

To retrieve the current results for [`condenser_api.get_dynamic_global_properties`](https://developers.dpays.io/apidefinitions/#condenser_api.get_dynamic_global_properties), we can retrieve the current state information using `curl`:

```bash
curl -s --data '{"jsonrpc":"2.0", "method":"condenser_api.get_dynamic_global_properties", "params":[], "id":1}' https://api.dpays.io
```

### Example Output<a style="float: right" href="#sections"><i class="fas fa-chevron-up fa-sm" /></a>

```json
{
   "id":1,
   "jsonrpc":"2.0",
   "result":{
      "head_block_number":24238248,
      "head_block_id":"0171d8a833dc369abd034b0c67d8725f96df9e5b",
      "time":"2018-07-16T22:41:24",
      "current_witness":"jared",
      "total_pow":514415,
      "num_pow_witnesses":172,
      "virtual_supply":"283434761.199 BEX",
      "current_supply":"271729171.190 BEX",
      "confidential_supply":"0.000 BEX",
      "current_bbd_supply":"15498201.173 BBD",
      "confidential_bbd_supply":"0.000 BBD",
      "total_vesting_fund_dpay":"192913644.627 BEX",
      "total_vesting_shares":"391296886352.617261 VESTS",
      "total_reward_fund_dpay":"0.000 BEX",
      "total_reward_shares2":"0",
      "pending_rewarded_vesting_shares":"379159224.860656 VESTS",
      "pending_rewarded_vesting_dpay":"185294.019 BEX",
      "bbd_interest_rate":0,
      "bbd_print_rate":2933,
      "maximum_block_size":65536,
      "current_aslot":24315228,
      "recent_slots_filled":"340282366920938463463374607431768211400",
      "participation_count":128,
      "last_irreversible_block_num":24238230,
      "vote_power_reserve_rate":10,
      "average_block_size":10950,
      "current_reserve_ratio":200000000,
      "max_virtual_bandwidth":"264241152000000000000"
   }
}
```
