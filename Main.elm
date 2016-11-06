module Main exposing (..)

import Svg
import Svg.Attributes exposing (..)
import Html.App
import Keyboard


main =
    Html.App.program
        { init = initialModel
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    { player : Circle, enemies : List Circle }


initialModel : ( Model, Cmd Message )
initialModel =
    ( { player = player, enemies = enemies }, Cmd.none )


type Message
    = KeyPress Keyboard.KeyCode


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        KeyPress keyCode ->
            let
                player =
                    model.player

                newPlayer =
                    { player | position = updatePosition player.position keyCode }
            in
                ( { model | player = newPlayer }, Cmd.none )


updatePosition : ( Float, Float ) -> Keyboard.KeyCode -> ( Float, Float )
updatePosition ( x, y ) keyCode =
    case keyCode of
        -- w (up)
        119 ->
            ( x, y - 10 )

        -- a (left)
        97 ->
            ( x - 10, y )

        -- s (down)
        115 ->
            ( x, y + 10 )

        -- d (right)
        100 ->
            ( x + 10, y )

        _ ->
            ( x, y )


subscriptions : Model -> Sub Message
subscriptions model =
    Keyboard.presses KeyPress


view model =
    Svg.svg [ width "500", height "500" ] ([ model.player ] ++ model.enemies |> List.map drawCircle)


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
