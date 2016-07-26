# SPA routing with Elm 0.17

_note: this is obsolete since [elm-navigation](https://github.com/elm-lang/navigation) release_.


Install Elm 0.17 (see
[http://elm-lang.org/install](http://elm-lang.org/install)) and then:

```shell
npm install
npm start
```

That will compile Elm files and start a local server on [localhost:8000](http://localhost:8000).


## Do we need routers?

I don't think so anymore, at least since Elm 0.17 and port modules, and I say that as the author of `elm-transit-router`, one of the three main routers for Elm 0.16.

We need packages for route parsing: that is, a way to transform the string representation of the path or hash to our app internal model. There are a few packages for this already: [Bogdanp/elm-route](https://github.com/Bogdanp/elm-route) and [etaque/elm-route-parser](https://github.com/etaque/elm-route-parser) (disclaimer: I'm the author). [sporto/hop](https://github.com/sporto/hop) also has parsing tools but it isn't yet migrated to 0.17.

For the rest, Elm is already efficient at the job, it's just a few `Msg` away!

In this example I added a fancy transition effect to illustrate my point: if you implement routing by yourself, you gain more power for specific behaviours.

Note: browser history handling is done with ports for now, but it will be easy to upgrade when the Elm bindings will be ready.


## How it works

Browser location is the reference, so our app needs to subscribe to location changes, and push new locations to browser on navigation (and not the other way around). That's the job of `Location` port module here, with ports handled by JS in `index.html`. Can be path or hash, works the same.

`Route` module defines an enum type to store current route with params in the model.

Once we've subscribed to path updates, we parse them in `update` with the help of the route parser. Then our model is updated with new route and we can then react to this route update (see `mountRoute`).

Messages role being:

* `SetPath` means "please update browser location"
* `PathUpdated` means "browser notified us of a location update"
* `PathTransition` is the fancy transition animation tick
* `SetRoute` is the order to update route in model at the middle of the animation (can be combined with `PathUpdated` in the absence of animation).

The view match the current route to render the desired page. Plus, here we add style for transition animation.

## See also

 * [Bogdanp/elm-route app example](https://github.com/Bogdanp/elm-route/tree/master/examples/app)
