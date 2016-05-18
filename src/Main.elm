module Main exposing (..)

import Html.App as Html
import Update exposing (init, update, subscriptions)
import View exposing (view)


main =
  Html.programWithFlags
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }
