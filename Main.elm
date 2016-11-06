import Svg
import Svg.Attributes exposing (..)

main = Svg.svg [] [ player ]

player = Svg.circle [ r "20", fill "blue", transform "translate(200 200)" ] []
