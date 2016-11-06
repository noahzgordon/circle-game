import Svg
import Svg.Attributes exposing (..)

main = Svg.svg [ width "500", height "500" ] ([ player ] ++ enemies)

player = Svg.circle [ r "20", fill "blue", transform "translate(250 250)" ] []

enemies =
  [ Svg.circle [ r "10", fill "red", transform "translate(50, 100)" ] []
  , Svg.circle [ r "20", fill "red", transform "translate(450, 450)" ] []
  , Svg.circle [ r "20", fill "red", transform "translate(450, 100)" ] []
  , Svg.circle [ r "30", fill "red", transform "translate(400, 250)" ] []
  , Svg.circle [ r "30", fill "red", transform "translate(300, 50)" ] []
  , Svg.circle [ r "40", fill "red", transform "translate(100, 250)" ] []
  , Svg.circle [ r "40", fill "red", transform "translate(100, 250)" ] []
  , Svg.circle [ r "50", fill "red", transform "translate(250, 400)" ] []
  ]
