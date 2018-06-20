---
title: Peeking Into State Monads
date: 2018-06-20
author: Kendrick tan
disqus: yes
---

# Prelude
[State monads](https://hackage.haskell.org/package/mtl-2.2.2/docs/Control-Monad-State-Lazy.html), introduced to me during the [data61 functional programming course](https://github.com/data61/fp-course) is one of my most  memorable monad encounter. This was because things only clicked and started to make sense after a couple of weeks of frustration.

This article is my attempt to reimplement the state monad in `Python`, as well as explain the underlying mechanics of the state monad.

# Introduction
State monads were created to perform _stateful computations_ in pure languages like Haskell. Stateful computations are computations which mutates the state of a non-local variable upon certain conditions.

<insert photos on pure/stateful functions>

A common way to embed state in pure functions passing in an additional parameter that represents the current `state` of the program. E.g.

```haskell
f :: a -> b

-- becomes

f' :: curState -> a -> b
```