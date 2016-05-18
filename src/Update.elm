module Update exposing (..)

import Transit
import Model exposing (..)
import Routes exposing (..)
import Location


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Location.pathUpdates PathUpdated
    , Transit.subscriptions PathTransition model
    ]


init : String -> (Model, Cmd Msg)
init path =
  mountRoute (Routes.decode path) initialModel


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SetPath path ->
      ( model, Location.setPath path )

    PathUpdated path ->
      let
        newRoute = Routes.decode path
      in
        Transit.start PathTransition (SetRoute newRoute) (50, 200) model

    PathTransition subMsg ->
      Transit.tick PathTransition subMsg model

    SetRoute route ->
      mountRoute route model


mountRoute : Route -> Model -> (Model, Cmd Msg)
mountRoute route oldModel =
  let
    model = { oldModel | route = route }
  in
    -- in a typical SPA, you might have to trigger tasks when landing on a page,
    -- like an HTTP request to load specific data
    case route of
      Home ->
        (model, Cmd.none)

      Page p ->
        ({ model | page = p }, Cmd.none)

      EmptyRoute ->
        (model, Cmd.none)
