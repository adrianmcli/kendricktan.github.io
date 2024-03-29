---
title: Draw Like Bob Ross (With Pytorch!)
date: 2017-04-05
author: Kendrick Tan
disqus: yes
---

*I've been playing around with [autoencoders](http://ufldl.stanford.edu/tutorial/unsupervised/Autoencoders/), and have been fully fascinated with the idea of using one in a cool, fun project, and so [__drawlikebobross__](https://github.com/kendricktan/drawlikebobross) was born.*

---

# What is drawlikebobross?

[__drawlikebobross__](https://github.com/kendricktan/drawlikebobross) aims to turn a patched color photo into a Bob Ross styled photo, like so:

<center> ![ ](https://i.imgur.com/9rdXfdM.png) </center>

Basically turning rough color patches into an image that _(hopefully)_ looks like it could be drawn from Bob Ross. 

It also includes a nice little web app for you to test things out :-)

---

# How we do what we do

### Scrapping Data

Before we start diving into anything, we first need data. Fortunately, a quick google search on *"Bob Ross Datasets"* results in this website: [twoinchbrush](http://www.twoinchbrush.com/).

Whats so great about this website is that it lists all its Bob Ross images in a nice, scrapable format:

	http://www.twoinchbrush.com/images/painting1.png
	http://www.twoinchbrush.com/images/painting2.png
	http://www.twoinchbrush.com/images/painting3.png
	http://www.twoinchbrush.com/images/paintingN.png
	
A quick and easy [shell script](https://github.com/kendricktan/drawlikebobross/blob/master/scrapper.sh) finishes the job.

### Preprocessing Data

As our challenge here is to convert color patches into Bob Ross styled drawings, I've decided to use [mean shift filtering](https://spin.atomicobject.com/2015/05/26/mean-shift-clustering/) to smoothen the images in order to resemble color patches as inputs, and the original image as the output:

<center>![](https://i.imgur.com/IdbIQGt.png)</center>

To minimize the training time, I've preprocessed the bulk of images into smoothen images and stored them in a [h5 format](http://www.h5py.org/). This allows me to rapidly test different neural network architectures without having to preprocessed the data during training time, which is a huge time saver.

### Neural Network Architecture

The network architecture I'm using is called an _Adversarial Autoencoder_, or _aae_ for short. You can read more about them [here](http://hjweide.github.io/adversarial-autoencoders), original paper [here](https://arxiv.org/abs/1511.05644)

TL;DR: _"The idea I find most fascinating in this paper is the concept of mapping the encoder’s output distribution q(z|x) to an arbitrary prior distribution p(z) using adversarial training (rather than variational inference)." - Hendrik J. Weideman_

<center>__AAE Figure__

![](http://www.inference.vc/content/images/2016/01/Screen-Shot-2016-01-08-at-14-48-25.png)
</center>

### Feeding Data Into Our Model + Pytorch

So we want color patches coming in, and Bob Ross styled images coming out, the process should now look like:

<center>![](https://i.imgur.com/hyWoQ18.png)</center>

I've chosen to use [pytorch](http://pytorch.org) to implement the model in because I've been using it tons in my [work](http://popgun.ai), as it has a super pleasant and consistent API (_looking at you tensorflow_), and I just feel like my productivity has increase tenfolds.

The [model pipeline](https://github.com/kendricktan/drawlikebobross/tree/master/aae) has also been abstracted into 4 components:

* __models.py__: Architecture of the Neural Network
* __loader.py__: Dataloader 
* __trainer.py__: The training procedure for the Network
* __train.py__: Run this file to initiate training

This way, if I wanted to say change the architecture of the network, all I need to do is edit __models.py__ and __trainer.py__, and we're good to go!

### Training

Now the longer we train, the better the network gets at Bob Rossifying our color patches:

<center>![](https://thumbs.gfycat.com/DefenselessEminentKookaburra-size_restricted.gif)</center>

Since I'm using a thinkpad t460s with a shitty GPU, I rented a g2 on AWS and chucked the model there for around a day or so. (Got to around 2.5k epochs).

---

# Final thoughts

I had a ton of fun making this lil project, if machine learning interests you, I would highly recommend doing a small weekend project like so.

Also, did I mention that the project has a web UI to interact with the model? ;-)

![](https://i.imgur.com/FWTPNJY.png)
