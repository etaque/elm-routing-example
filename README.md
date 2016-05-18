# SPA routing with Elm 0.17

Install Elm 0.17 (see
[http://elm-lang.org/install](http://elm-lang.org/install)) and then:

```shell
npm install
npm start
```

That will compile Elm files and start a local server on [localhost:8000](http://localhost:8000).

## "router" is an obsolete notion

...at least for Elm 0.17, and I say that as the author of `elm-transit-router`, one of the three main routers for Elm 0.16.

What we need is route parsing: a way to transform the string representation of the path or hash to our app internal representation (`type`). For the rest, Elm is already efficient at the job, it's just a few `Msg` away!

In this example I added a fancy transition effect to illustrate my point: if you implement routing by yourself, you gain more power for specific behaviours.

Browser history handling is done with ports for now, but it will be easy to upgrade when the Elm bindings will be ready.
