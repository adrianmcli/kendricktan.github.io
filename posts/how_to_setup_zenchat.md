---
title: Tutorial - How to Setup ZENChat
date: 2017-08-28
author: Kendrick Tan
disqus: yes
---

# What is ZENChat?

<center> <img width=500 src="https://i.imgur.com/7Dc45pR.gif"/> </center>

ZENChat is a messaging application that ultilizes the ZEN blockchain to provide a fully secure, private, and anonymous way to send messages up to 340 bytes. It is also UTF-8 compatiable, meaning you can send emojis over the blockchain. 

This tutorial will help you get started in setting up ZENChat.

# Setting up zend for ZENChat

You can find `zen.conf` in the following locations:
```
- Windows < Vista: C:\Documents and Settings\Username\Application Data\Zen
- Windows >= Vista: C:\Users\Username\AppData\Roaming\Zencash
- Mac: ~/Library/Application Support/Zen
- Unix: ~/.zen
```

Currently, ZENChat works by perfoming RPC calls to zend. As such, `zen.conf` (the configuration file for zend) needs to contain the following:

```
# server=1 tells zend to accept RPC Calls
server=1
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
rpcport=8233
```

You will also need to setup a username and a <strong>strong</strong> password for the RPC server. Edit your `zen.conf` file again to include these lines:

```
rpcuser=MY_USERNAME_HERE
rpcpassword=MY_VERY_STRONG_PASSWORD_HERE_3276782193
```

# Getting ZENChat

The official and latest releases for ZENChat will can be found on github. You can grab them <a href="https://github.com/ZencashOfficial/ZENChat/releases">here</a>.

Download the files relevant to your operating system and extract them, there should be an executable within the folder. Run the executable, and you should be greeted with the following:

<center><img width=500 src="https://i.imgur.com/g1zx2Qs.png"/></center>

# Setting up ZENChat

The `host`, `port`, `username`, and `password` should be similiar to what was specified in the previous steps while setting up `zen.conf`.

If you're getting "connection failed" on step 2, double check and make sure your `zend` is running and all the settings provided are correct.

<center><img width=500 src="https://i.imgur.com/CqgvWXg.png"></center>

The next page determines which address will be used to send messages, and the handle/nickname given to the address (only visible by you and defaults to 'Me'). __It costs 0.00000001 ZEN to send a message, choose an address that has some funds. If you don't have any zen, get some at <a href="http://getzen.cash">http://getzen.cash</a>__.

<center><img width=500 src="https://i.imgur.com/HuwRRhM.png"></center>

Once thats done, you should be greeted with the following page:

<center><img width=500 src="https://i.imgur.com/B8AUxVi.png"></center>

If you would like to change any settings in the future, simply click the 'settings' button.

<center><img width=500 src="https://i.imgur.com/gUgCzqm.png"></center>

# Using ZENChat

To get started click the 'new chat' button.

<center><img width=500 src="https://i.imgur.com/hXQw35b.png"></center>

Enter in a secret phrase to generate your room. Anyone who has the same secret phrase can also join the chat. __Make sure the secret phrase is strong__.

<center><img width=500 src="https://i.imgur.com/0qKnaco.png"></center>

If you forgot your secret code and the chat is still there, you can click the ellipsis beside the chat name and get the secret code.

<center><img width=500 src="https://i.imgur.com/E95uHlo.png"></center>

There's also some additional features such as setting the nicknames of the participants in thet chat if you click on the 'chat info' button located on the top right.

<center><img width=500 src="https://i.imgur.com/C7iZrOV.png"></center>

<center><img width=500 src="https://i.imgur.com/CevVyhI.png"></center>

# Summary

This is only an alpha version of ZENChat, expect more functionality in the future :-) (such as file/image sharing!)