Title: Rare Pepes Generator
Date: 2017/05/24
Category: python, machine-learning, deep-learning
Summary: It's 2020 and the Pepe economy has crashed, luckily you can now generate them quite easily.

----

## [makerarepepes.me](https://makerarepepes.me)

Pepes, can't get enough of them, that's why I made a [website](https://makerarepepes.me) that turns rough sketches of pepes into a rare pepe (unique to your sketch!). 

<center> ![ ](https://i.imgur.com/O5MUs2h.png) </center>


The approach for this is very similar to how I did my [Bob Ross styled paintings](https://kendricktan.github.io/draw-like-bob-ross-with-pytorch.html), the only difference is the architecture of the network and the dataset. 

----

## Network

The network uses the [pix2pix](https://arxiv.org/abs/1611.07004) architecture, so if you would like further reading on it, I would highly recommend reading this [blog post by Christopher Hesse](https://affinelayer.com/pixsrv/).

TL;DR version would be that pix2pix is able to translate an image from `domain A` to `domain B`, in other words a rough pepe outline/sketch into a real pepe.

----

## Dataset

To translate a rough pepe sketch into a pepe, I needed some data. Luckily for me I found a decently sized [dataset of rare pepes](https://archive.org/details/PepeImgurAlbum). However, some of them were unusable as it contained too much unnecessary information:

<center> <div style="max-width: 300px"> ![ ](http://i3.kym-cdn.com/photos/images/original/001/047/653/4df.jpg) </div> </center>

So, I wrote a [script](https://github.com/kendricktan/rarepepes/blob/master/data/clean_dataset.py) that aids my in manually cleaning up that dataset. It displays the original input image on the left, and the image with [canny edge detection](http://docs.opencv.org/trunk/da/d22/tutorial_py_canny.html) applied on the right.

<center> <div style="max-width: 500px"> ![ ](https://i.imgur.com/Diq9iiX.png) </div> </center>

If its acceptable just press `Y` and it saves both of the image into a designated output folder, else press `N`.

----

### Check out the [github repo](https://github.com/kendricktan/rarepepes) for more info