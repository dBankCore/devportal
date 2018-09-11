---
title: Database API
position: 2
---

Subscription examples

~~~ javascript
dpay.api.setSubscribeCallback(callback, clearFilter, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Subscribe Callback"}

~~~ javascript
dpay.api.setPendingTransactionCallback(cb, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Pending Transaction Callback"}

~~~ javascript
dpay.api.setBlockAppliedCallback(cb, function(err, result) {
  console.log(err, result);
});
~~~
{: title="Set Block Applied Callback"}

~~~ javascript
dpay.api.cancelAllSubscriptions(function(err, result) {
  console.log(err, result);
});
~~~
{: title="Cancel All Subscriptions"}         
