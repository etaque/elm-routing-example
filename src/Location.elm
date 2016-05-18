port module Location exposing (..)

port setPath : String -> Cmd msg

port pathUpdates : (String -> msg) -> Sub msg
