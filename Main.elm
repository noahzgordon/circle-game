module Main exposing (..)

import Svg
import Svg.Attributes exposing (..)
import Html.App


main =
    Html.App.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }


type alias Model =
    { player : Circle, enemies : List Circle }


initialModel : Model
initialModel =
    { player = player, enemies = enemies }


type Message
    = Noop


update : Message -> Model -> Model
update message model =
    model


view model =
    Svg.svg [ width "500", height "500" ] ([ player ] ++ enemies |> List.map drawCircle)


player : Circle
player =
    { size = 40, color = "blue", position = ( 250, 250 ) }


enemies : List Circle
enemies =
    [ { size = 20, color = "red", position = ( 50, 100 ) }
    , { size = 40, color = "red", position = ( 450, 450 ) }
    , { size = 40, color = "red", position = ( 450, 100 ) }
    , { size = 60, color = "red", position = ( 400, 250 ) }
    , { size = 60, color = "red", position = ( 300, 50 ) }
    , { size = 80, color = "red", position = ( 100, 250 ) }
    , { size = 90, color = "red", position = ( 100, 250 ) }
    , { size = 100, color = "red", position = ( 250, 400 ) }
    ]


type alias Circle =
    { size : Float
    , color : String
    , position : ( Float, Float )
    }


drawCircle : Circle -> Svg.Svg msg
drawCircle circle =
    let
        radius =
            circle.size / 2 |> toString

        ( x, y ) =
            circle.position

        translation =
            "translate(" ++ toString x ++ ", " ++ toString y ++ ")"
    in
        Svg.circle [ r radius, fill circle.color, transform translation ] []
