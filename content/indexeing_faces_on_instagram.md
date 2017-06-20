Title: Indexing Faces on Instagram
Date: 2017/06/18
Category: python, machine-learning, deep-learning, pytorch
Summary: Scrap, preprocess, and index facial data obtained from Instagram

---
I just wanted to build something cool using machine learning on a bunch of public images. But after showing it to a couple of my *"friends"* they thought it was too creepy and Instagram might sue me for breaking their [platform policy](https://www.instagram.com/about/legal/terms/api/) and I should stop doing it.

So, I did what most sane people would do - write a blog post detailing how I did it, and [open source](https://github.com/kendricktan/iffse) it.

__Whats the worst that could happen?__ ( ͡° ͜ʖ ͡°) > [IFFSE -Instagram Facial Feature Search Engine](https://iffse.kndrck.co) <

---

# What did you do?
Err.. that's a good question. I basically told a computer to download a bunch of images containing faces from Instagram, and sort them according to similarity.

Essentially building a database of indexed faces ( ͡°( ͡° ͜ʖ( ͡° ͜ʖ ͡°)ʖ ͡°) ͡°).

# So how did you do it?

Before we start off doing anything machine learning-y we need a bunch of data, a bunch of #selfies to train our model on. Hmmm, sounds like we need to drop by and pay [Instagram.com](https://www.instagram.com) a visit ( ͡°╭͜ʖ╮͡° ).

### Loaning Images from Instagram

I've decided to use the word 'loan' instead of scrap, as scrapping has such negative connotations with it. Anyway, I wanted a way to be able to loan images Instagram without providing them with any of my keys. After playing around with the web app for a couple of minutes, I discover the [tags endpoint](https://www.instagram.com/explore/tags/selfie/), which gives like infinite images without authentication.

<center>
    <img src="https://thumbs.gfycat.com/YellowishPositiveBeagle-size_restricted.gif">
    <h6>#selfies. Note the 'Sign Up' Button</h6>
</center>

Perfect! Now to just automate the process of loaning images from Instagram into our server.


### Reverse Engineering the tags endpoint

I noticed that everytime I scroll to the bottom of the page, this particular request pops up:

<center>
    <img width=75% src="https://i.imgur.com/Lc1Qpim.png">
    <h6>graphql endpoint: https://www.instagram.com/graphql/query/?query_id=17882293912014529&tag_name=selfie&first=6&after=J0HWUYXkgAAAF0HWUYXigAAAFiYA</h6>
</center>

Looks like an API call, I wonder what could that hold?

<center>
    <iframe height=300 src="https://pastebin.com/embed_iframe/NS2kB9dr" style="border:none;width:75%"></iframe>
    <h6>JSON dump of the graphql endpoint</h6>
</center>

Woah nifty! The URL to the images are easily accesible and it looks like the only variables we need to change are the `query_id` and `after`. `after` looks suspiciously similar to `end_cursor` obtained from the graphql query endpoint, I wonder if it would make a difference if I changed the `after` variable in our query to be `J0HWUYaEwAAAF0HWUYaAwAAAFlIA`, making our GET request url now: `https://www.instagram.com/graphql/query/?query_id=17882293912014529&tag_name=selfie&first=6&after=J0HWUYaEwAAAF0HWUYaAwAAAFlIA`. Querying it gives us:

<center>
    <img width=75% src="https://i.imgur.com/ic6sY24.png">
    <h6>Bingo, we're now able to continously query for new data</h6>
</center>

What about `query_id`? At first I thought it was some constant as I couldn't find it anywhere and kinda just hardcoded it into my queries and it worked for a while until I started getting timeout errors ♪~ ᕕ(ᐛ)ᕗ . In the end, I found out that the `query_id` is generated from the file `en_US_Commons.js`, which is included during your inital request to Instagram.

So, the journey of automating our loaning of images from Instagram currently looks like:

1. GET `instagram.com/explore/tags/<TAG>`
2. Find `display_url`(s), `query_id` and `end_cursor` from step 1.
3. Query graphql endpoint using the variables obtained from last step.
4. Store `display_url`(s) and get new `end_cursor` from step 3.
5. Repeat step 3 - 5 until you run out of memory or happy.

So far so good, I wrote a [multithreaded scrapper](https://github.com/kendricktan/iffse/blob/master/scrapper.py), chucked it onto a C4 instance on AWS, and left it overnight.

<center>
    <img width=75% src="https://i.imgur.com/vZE6CKH.png">
    <h6>Working all 36 of my cores (ᵔᴥᵔ)</h6>
</center>

<center>
    <img width=75% src="https://i.imgur.com/jge7rKh.png">
    <h6>Indexes around 6-8 images a second</h6>
</center>

The next morning I woke up and decided to check its progress, and got around 200k images. Sounds good right? ༼ʘ̚ل͜ʘ̚༽ Not really, Instagram gets ~35 million images per day, thats only __0.2%__ of the images they get __per day__. But whatevs, 200k is enough for me, I think. (ღ˘⌣˘ღ)


# Preprocessing our images

We now have our images, problem is they aren't normalized.

<center>
    <img width=30% src="https://i.imgur.com/qCaGYGe.jpg">
    <h6>random ig girl</h6>
</center>

See how the above face is tilted to the right? Thats baaaad. We can't have feed it into the black machine learning box that way ب_ب. So I uh, did a bit of googling and found out about this cool library called [dlib](https://pypi.python.org/pypi/dlib) that does what I want it to do. It is able to find the 68 landmarks of the face with some magic, and using that I can transform the original image to an aligned face.

<center>
    <img width=30% src="//cdn-images-1.medium.com/max/800/1*AbEg31EgkbXSQehuNJBlWg.png">
    <h6>68 facial landmaks</h6>
</center>

Dlib's super easy to use, just from looking at the [example code](http://dlib.net/face_landmark_detection.py.html), I was able to plot my own 68 facial landmarks too!

<center>
    <img width=30% src="https://i.imgur.com/tSbx3yn.png">
    <h6>68 facial landmaks on random ig girl</h6>
</center>

With a little bit more [magic](https://github.com/kendricktan/iffse/blob/master/iffse/utils/cv/faces.py#L80), I was able to align the face, voila! ◔̯◔

<center>
    <img width=30% src="https://i.imgur.com/kRF34rv.png">
    <h6>ig girl with aligned face</h6>
</center>

# 'Building' our Machine Learning model

Remember how I said we needed alot of data to train __our__ model? I lied. I tried to get the [MS Celeb 1M](https://www.microsoft.com/en-us/research/project/ms-celeb-1m-challenge-recognizing-one-million-celebrities-real-world/) dataset. But do you really think Microsoft is really going to hand over the dataset to some kid who says he's going to use it to index faces on instagram and be non-creepy? (´・ω・)っ由

In the end, I decided to just use a pretrained model from [OpenFace](https://github.com/cmusatyalab/openface/blob/master/models/get-models.sh). Problem is, these cool kids are using `Torch`, and I'm using `PyTorch`. Whats the difference? There's a `Py` infront of `PyTorch`, having a longer name must mean its newer and better. And communicating between `Lua` (what `Torch` is built on) and `Python` (what `PyTorch` is built on) induces a large overhead and is a huge hassle.

Using my 1337 googling skills, I found a [OpenFacePytorch implementation online from some korean guy who works at intel](https://github.com/thnkim/OpenFacePytorch). I cloned the repository and low and behold! It works! Thank you Pete Tae-hoon Kim!

<center>
    <img width=75% src="https://i.imgur.com/1EsTMrW.png">
    <h6>OpenFace in PyTorch!</h6>
</center>

The architecture used by OpenFace is based on [FaceNet](https://arxiv.org/abs/1503.03832):

<center>
    <img width=50% src="https://i.imgur.com/7IiugMo.png">
    <h6>FaceNet Architecture</h6>
</center>

An analogy I like to use to explain the intuition behind FaceNet is to imagine it as a coin sorting machine. The coin sorting machine can measure the coins' size and weight, and will sort coins of similar size and weight into one pile. FaceNet is doing exactly the same thing, except it's measuring the high level abstract features of the images (position of mouth, eyes, nose), and not low level concrete features (skin color, hair color, etc)

<center>
    <img width=50% src="//machinelearningmastery.com/wp-content/uploads/2014/04/plot_mean_shift_1.png">
    <h6>Clustering in 2D, FaceNet does it in 128D</h6>
</center>

Because of the Triplet Loss, it can be assumed that faces with similar features will have a similar embedding. Now I'm not going to explain CNN's here, but if you would like the intuition, here's a [good post](https://ujjwalkarn.me/2016/08/11/intuitive-explanation-convnets/). 

After our preprocessed image passes the Deep Architecture and the L2 regularization (in pic), the abstract features (e.g. position of nose, eyes) are fed into a Feed Forward Network (embeddings), and it is the activations of the Feed Forward Network (embeddings) that we are after: a 128 dim vector.

Once we index all our loaned preprocessed images with their respective 128 dimensional vector, we can start using [K-nearest neighbours](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm) to search for similar faces. For this I used [Spotify's Annoy](https://github.com/spotify/annoy).

# What's Next?

TBH, not much. I wrote a couple endpoints and spun up a [sanic server](https://github.com/channelcat/sanic), hosted my files, and decided to call it a day.

Just hope the FBI doesn't come knocking on my door. (>人<)

# TL;DR:

Steps to index faces:

1. Load images from Instagram
2. Preprocess and normalize loaded images
3. Pass image through a blackbox and index image with blackbox outputs
4. Use an algorithm like KNN to find images with similar indexes

<center>
    <img src="//media.giphy.com/media/upg0i1m4DLe5q/giphy.gif">
</center>

Again, you can check the live project here - [https://iffse.kndrck.co/](https://iffse.kndrck.co/)

---

UPDATE 1: So... the first server got hugged to death at 4am in the morning. Thank you...? I've spin up a general instance (instead of a micro) to handle the load.

UPDATE 2: Day 2, server ran out of storage space, also added new sharable features :)

---