---
title: Peeking Into State Monads
date: 2018-06-20
author: Kendrick tan
disqus: yes
---

# Prelude
[State monads](https://hackage.haskell.org/package/mtl-2.2.2/docs/Control-Monad-State-Lazy.html), introduced to me during the [data61 functional programming course](https://github.com/data61/fp-course) is one of my most memorable encounter with a monad. This was mainly because things only started to clicked and made a _tiny_ bit of sense after a couple of weeks of frustration.

This article is my attempt to explain the underlying mechanics of the state monad.

# Introduction
State monads were created to represent _stateful computations_ in pure languages like Haskell. Stateful computations are computations which mutates the state of a non-local variable upon certain conditions.

<center>
    <img src="https://i.imgur.com/HMFQsOL.png"/>
    <h5>Pure vs stateful functions</h5>
</center>

In functional programming, we like having our cake and eating it too. That means we want a pure function that is capable of embedding arbitrary state. When I first started functional programming I often got around this by adding an additional parameter to represent the current 'state' the function was in. E.g.

```haskell
-- Keep track of odd numbers in string format from a list of integers
stringOdd :: String -> [Integral] -> String
stringOdd s []       = s
stringOdd s (x : xs) = countOdd (s ++ $ if odd x then (show x) else "") xs
```

But this creates a lot of redundency and we can abstract this messy structure using a more general format - state monads. The definition of a state monad is like so:

```haskell
newtype State s a = State (\s -> (a, s))
```

Keep in mind that `State s a` is just a more general form for `stringOdd`:

```haskell
stringOdd :: String   -> [Integral] -> String
-- replacement --
stringOdd :: b        ->  a         -> b
-- uncurried --
stringOdd :: b        -> (a,           b)
```