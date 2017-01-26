module Main exposing (..)

import Svg
import Svg.Attributes exposing (..)
import Html
import Keyboard
import List.Extra as List


main =
    Html.program
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

                biggerNewPlayer =
                    { newPlayer | size = player.size + 20 }

                collidingCircle =
                    List.find (collidesWith newPlayer) model.enemies
            in
                case collidingCircle of
                    Just circle ->
                        if newPlayer.size > circle.size then
                            ( { model | player = biggerNewPlayer, enemies = List.filter ((/=) circle) model.enemies }, Cmd.none )
                        else
                            ( model, Cmd.none )

                    Nothing ->
                        ( { model | player = newPlayer }, Cmd.none )


collidesWith : Circle -> Circle -> Bool
collidesWith c1 c2 =
    let
        leftBound c =
            (Tuple.first c.position) - (c.size / 2)

        rightBound c =
            (Tuple.first c.position) + (c.size / 2)

        bottomBound c =
            (Tuple.second c.position) + (c.size / 2)

        topBound c =
            (Tuple.second c.position) - (c.size / 2)

        horizontalCollision =
            (rightBound c1 > leftBound c2 && leftBound c1 < rightBound c2)
                || (rightBound c2 > leftBound c1 && leftBound c2 < rightBound c1)

        verticalCollision =
            (bottomBound c1 > topBound c2 && topBound c1 < bottomBound c2)
                || (bottomBound c2 > topBound c1 && topBound c2 < bottomBound c1)
    in
        horizontalCollision && verticalCollision


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
    , { size = 60, color = "red", position = ( 450, 100 ) }
    , { size = 60, color = "red", position = ( 400, 250 ) }
    , { size = 100, color = "red", position = ( 300, 50 ) }
    , { size = 120, color = "red", position = ( 100, 250 ) }
    , { size = 120, color = "red", position = ( 100, 250 ) }
    , { size = 140, color = "red", position = ( 250, 400 ) }
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
