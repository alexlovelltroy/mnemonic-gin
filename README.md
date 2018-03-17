# mnemonic-gin
## The basic code behind mnemonic-as-a-service.com

>There are only two hard things in Computer Science: cache invalidation and naming things.
>
>-- Phil Karlton

The nice folks at [mnx.io](http://mnx.io/) wrote a fun [blog post](http://mnx.io/blog/a-proper-server-naming-scheme/) about server naming schemes.

One of the pearls of wisdom is the recommendation to use Oren Tirosh’s [mnemonic encoding project](http://web.archive.org/web/20090918202746/http://tothink.com/mnemonic/wordlist.html) as a wordlist.

GENIUS!

Since I originally started playing with this wordlist, it has become my ```hello world``` example for dealing with new languages and frameworks.  I have examples in [flask](https://github.com/alexlovelltroy/mnemonic-as-a-service), [django](https://github.com/alexlovelltroy/django_mnemonic), nodejs, and lambda, that have all been behind menmonic-as-a-service.com at one time or another.

# Enter Golang, Docker and Kubernetes

Enough time has passed that I needed to play with a few more ideas.  The first is golang, so that's the language I've used here.  The second is Docker which is a natural fit for running Go binaries with repeatable environment variables.  It's certianly not necessary, but fun to learn.  I also have been working with kubernetes a lot recently and found the pod/service/deployment concept interesting enough to experiment there too.  Check out the Makefile for some GKE sugar that allowed me to do most of the development of this repo while on an airplane over the Pacific.  (No local docker builds on satellite internet)

# Rainbow Deploys

I'm not sold on this pattern yet, but found it compelling ehough to play with once I read about it. [Brandon Dimcheff's Blog](http://brandon.dimcheff.com/2018/02/rainbow-deploys-with-kubernetes/) explains the idea well.  I even cribbed some of his Makefile to get started.