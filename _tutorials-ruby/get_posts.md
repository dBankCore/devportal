---
title: 'RB: Get Posts'
position: 4
description: 'Get Posts by Category'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Posts](https://github.com/dpays/developer-docs-tutorials-rb/tree/master/tutorials/04_get_posts) can be downloaded as part of the [RB tutorials repository](https://github.com/dpays/developer-docs-tutorials-rb).</span>
<br>


This example will output posts depending on which category is provided as the arguments.

### Script

Create a filed called `get_posts_by_category.rb`.

This script will pick a method to call based on the arguments passed.  The expected categories are:

* trending
* hot
* active
* created
* votes
* promoted
* children

We will base the name of the API method to execute on the provided argument.  Once we know which method to execute, we can build the query options.  The defaults for this script is `limit: 10` and `tag: ''`.

For each post we retrieve, we are going to build up a summary to display the interesting fields.  In this case, we're interested in:

* Creation Timestamp
* Title
* Author
* Net Votes
* Number of replies
* If it's promoted
* Number of words in the body
* Canonical URL

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.dpays.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
git clone git@github.com:dpays/developer-docs-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/04_get_posts
bundle install
ruby get_posts_by_category.rb trending 1 dpay
```

### Example Output

```
2018-05-24 06:38:33 UTC
  Post: New Phone App For dSite - Wow!
  By: happymoneyman
  Votes: 1087
  Replies: 332
  Promoted: 0.001 BBD
  Words: 190
  https://dsite.io/dsite/@happymoneyman/new-phone-app-for-dsite-wow
```

#### Error Handling

We're checking the result for `error` in case the remote node has an issue to raise.  Normally, it will be `nil`, but if it's populated, output `error.message` and exit.


---
