---
title: dPay-Python
position: 4
---

dPay-Python is a command line tool to interact with the dPay network.  dPay-Python is
written in Python and highly customizable for building dPay tools and performing
wallet operations.

**dPay-Python** - [https://github.com/dpays/dpay-python](https://github.com/dpays/dpay-python)

Install with pip3:
<br/>
```
sudo apt-get install libffi-dev libssl-dev python-dev python3-pip
pip3 install dpay
```

Manual installation:

```
git clone https://github.com/dpays/dpay-python/
cd dpay-python
python3 setup.py install --user
```

Upgrade

```
pip3 install dpay --user --upgrade
```

Additional dependencies

dpayapi.dpayasyncclient:

- asyncio==3.4.3
- pyyaml==3.11
- Documentation

Thanks to readthedocs.io, the documentation can be viewed on python.dpays.io

Documentation is written with the help of sphinx and can be compile to html with:

~~~
cd docs
make html
~~~
