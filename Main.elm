import Svg
import Svg.Attributes exposing (..)

main = Svg.svg [ width "500", height "500" ] [ player ]

player = Svg.circle [ r "20", fill "blue", transform "translate(200 200)" ] []
