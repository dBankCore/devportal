---
title: 'RB: Get Post Comments'
position: 7
description: 'This example will output the reply details and totals for the post/comment passed as an argument to the script.'
layout: full
---              
<span class="fa-pull-left top-of-tutorial-repo-link"><span class="first-word">Full</span>, runnable src of [Get Post Comments](https://github.com/dpays/developer-docs-tutorials-rb/tree/master/tutorials/07_get_post_comments) can be downloaded as part of the [RB tutorials repository](https://github.com/dpays/developer-docs-tutorials-rb).</span>
<br>



### Script

First, we ask the blockchain for the replies on a post or comment.  Then, we grab the authors of those replies and list them, followed by the total comments count.

### To Run

First, set up your workstation using the steps provided in [Getting Started](https://developers.dpays.io/tutorials-ruby/getting_started).  Then you can create and execute the script (or clone from this repository):

```bash
git clone git@github.com:dpays/developer-docs-tutorials-rb.git
cd devportal-tutorials-rb/tutorials/07_get_post_comments
bundle install
ruby comments_list.rb https://dsite.io/dpay/@dsiteblog/dev-portal-update-new-dpay-developer-resources
```

### Example Output

```
Replies by:
	shahabshah
	mumin007
	bigblueleadsled
	reseller
	latikasha
	dannywill
	dsiteag
	sequentialvibe
	xplosive
	whatsup
	evolved08gsr
	steevc
	mightymicke
	marc0o
	akintunde
	oliverlai
	zufrizal
	bitcointravel
	vsf
	badribireuen
Total replies: 20
```

---
