---
title: Demystifying Capsule Networks
date: 2017-11-10
author: Kendrick Tan
disqus: yes
---

----

_Assumed Knowledge: [Convolutional Neural Networks](https://ujjwalkarn.me/2016/08/11/intuitive-explanation-convnets/), [Variational Autoencoders](http://kvfrans.com/variational-autoencoders-explained/)_

----

## What are Capsule Networks and why do they exist?

The [Capsule Network](https://arxiv.org/abs/1710.09829) is a new type of neural network architecture conceptualized by [Geoffrey Hinton](http://www.cs.toronto.edu/~hinton/), the motivation behind Capsule Networks is to address some of the short comings of Convolutional Neural Networks (__ConvNets__), which are listed below:

#### Problem 1: ConvNets are Translation Invariance [<sub>[1]</sub>](https://aboveintelligent.com/ml-cnn-translation-equivariance-and-invariance-da12e8ab7049)

What does that even mean? Imagine that we had a model that predicts cats. You show it an image of a cat, it predicts that it's a cat. You show it the same image, _but rotated 90 degrees_, it still thinks that it's a cat.

<center><img src="https://i.imgur.com/NUQ90C3.png"/></center>
<h5 align="center">Figure 1.1: Translation Invariance</h5>

What we want to strive for is __translation equivariance__. Whereby you show it an image of a cat rotated 0 degrees, it predicts that it's a cat rotated ~0 degrees. You show it the same image rotated 90 degrees, it predicts that its a cat rotated ~90 degrees.

<center><img src="https://i.imgur.com/eChagPp.png"/></center>
<h5 align="center">Figure 1.2: Translation Equivariance</h5>

_Why is this a problem?_ ConvNets are unable to identify the position of one object relative to another, they can only identify if the object exists in a certain region, or not. This results in difficulty correctly identifying objects that have sub-objects that hold positional relationships relative to one another.

For example, a bunch of randomly assembled face parts will look like a face to a ConvNet, because all the key features are there:

<center><img src="https://i.imgur.com/0ZyaPt3.png"/></center>
<h5 align="center">Figure 1.3: Translation Invariance</h5>

If Capsule Networks do work as proposed, it should be able to identify that the face parts aren't in the correct position relative to one another, and label it correctly:

<center><img src="https://i.imgur.com/mLt9suH.png"/></center>
<h5 align="center">Figure 1.4: Translation Equivariance</h5>

#### Problem 2: ConvNets require a _lot_ of data to generalize [<sub>[2]</sub>](https://www.kth.se/social/files/588617ebf2765401cfcc478c/PHensmanDMasko_dkand15.pdf).

In order for the ConvNets to be translation invariance, it has to learn different filters for each different viewpoints, and in doing so it requires a __lot__ of data.

#### Problem 3: ConvNets are not a good representation of the human vision system

According to Hinton, when a visual stimulus is triggered, the brain has an inbuilt mechanism to _"route"_ low level visual data to parts of the brain where it belives can handle it best. Because ConvNets uses layers of filters to extract high level information from low level visual data, this routing mechanism is absent in it.

<center><img src="https://i.imgur.com/xmQmzB5.png"/></center>
<h5 align="center">Figure 1.5: Humans vs CNN</h5>

Moreover, the human vision system imposes coordinate frames on objects in order to represent them. For example:

<center><img src="https://i.imgur.com/W8peps6.png"/></center>
<h5 align="center">Figure 1.6: Imposing a coordinate frame</h5>

And if we wanted to compare the object in Figure 1.6 to say the letter 'R', most people would perform mental rotation on the object to a point of reference which they're familiar to before making the comparison.

<center><img src="https://thumbs.gfycat.com/PortlyGracefulBichonfrise-size_restricted.gif"/></center>
<h5 align="center">Figure 1.7: Mental Rotation</h5>

Again, because of the nature of ConvNets, these two features are absent in them.

## How do Capsule Networks solve these issues?

----

## References

1. [CNN: Translation Equivariance and Invariance](https://aboveintelligent.com/ml-cnn-translation-equivariance-and-invariance-da12e8ab7049)
2. [The Impact of Imbalanced Training Data for Convolutional Neural Networks](https://www.kth.se/social/files/588617ebf2765401cfcc478c/PHensmanDMasko_dkand15.pdf)