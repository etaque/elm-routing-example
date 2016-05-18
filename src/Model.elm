module Model exposing (..)

import Transit
import Routes


type alias Model = Transit.WithTransition
  { route : Routes.Route
  , page : Int
  }


initialModel : Model
initialModel =
  { transition = Transit.empty
  , route = Routes.Home
  , page = 0
  }


type Msg
  = SetPath String
  | PathUpdated String
  | PathTransition (Transit.Msg Msg)
  | SetRoute Routes.Route

