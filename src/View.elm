module View exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Json
import TransitStyle
import Model exposing (..)
import Routes exposing (..)


view : Model -> Html Msg
view model =
  div
    [ ]
    [ h1 [] [ text "Elm TransitRouter example" ]
    , div [ class "menu" ]
        [ a (clickTo <| Routes.encode Home) [ text "Home" ]
        , a (clickTo <| Routes.encode (Page 1)) [ text "Page 1" ]
        , a (clickTo <| Routes.encode (Page 2)) [ text "Page 2" ]
        ]
    , div
        [ class "content"
        , style (TransitStyle.fadeSlide 200 model.transition)
        ]
        [ text <| case model.route of
            Home ->
              "This is home"
            Page _ ->
              "This is page " ++ toString model.page
            EmptyRoute ->
              ""
        ]
    ]


-- inner click helper

clickTo : String -> List (Attribute Msg)
clickTo path =
  [ href path
  , onWithOptions
      "click"
      { stopPropagation = True, preventDefault = True }
      (Json.map (\_ -> SetPath path) Json.value)
  ]
