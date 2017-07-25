import Html exposing (..)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Random

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL
type alias Model = 
  { firstDieFace : Int
  , secondDieFace : Int
  }

-- UPDATE
type Msg 
  = Roll
  | NewFaces (Int, Int)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of 
    Roll ->
      ( model
      , Random.generate NewFaces (Random.pair (Random.int 1 6) (Random.int 1 6))
      )
    NewFaces (first, second) ->
      (Model first second, Cmd.none)

-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ drawDie model.firstDieFace
    , drawDie model.secondDieFace
    , h3 [] [ Html.text (String.concat [ "Your score is: ", (toString (model.firstDieFace + model.secondDieFace))]) ]
    , button [ onClick Roll ] [ Html.text "Roll" ]
    ]

drawDie : Int -> Html msg
drawDie dieValue =
  let 
      svgWidth = 120
      svgHeight = 120
      svgAttrs = [ width (toString svgWidth), height (toString svgHeight), viewBox "0 0 120 120" ]
      face = rect [ x "10", y "10", width "100", height "100", ry "10", rx "10", fill "red" ] []
      makeCircle x y =
        circle [ cx (toString x), cy (toString y), r "10", fill "white" ] []
      calcCircles dieValue =
        case dieValue of
          1 ->
            [ makeCircle (svgWidth / 2) (svgHeight / 2) ]
          2 ->
            [ makeCircle (svgWidth / 2) (svgHeight / 4) 
            , makeCircle (svgWidth / 2) ( 3 * (svgHeight / 4))
            ]
          3 ->
            [ makeCircle (svgWidth / 2) (svgHeight / 4) 
            , makeCircle (svgWidth / 2) ( svgHeight / 2)
            , makeCircle (svgWidth / 2) ( 3 * (svgHeight / 4))
            ]
          4 ->
            [ makeCircle (svgWidth / 4) (svgHeight / 4) 
            , makeCircle (svgWidth / 4) (3 * (svgHeight / 4)) 
            , makeCircle (3 * (svgWidth / 4)) ( svgHeight / 4)
            , makeCircle (3 * (svgWidth / 4)) (3 * ( svgHeight / 4))
            ]
          5 ->
            [ makeCircle (svgWidth / 4) (svgHeight / 4) 
            , makeCircle (svgWidth / 4) (3 * (svgHeight / 4)) 
            , makeCircle (svgWidth / 2) ( svgHeight / 2)
            , makeCircle (3 * (svgWidth / 4)) ( svgHeight / 4)
            , makeCircle (3 * (svgWidth / 4)) (3 * ( svgHeight / 4))
            ]
          6 ->
            [ makeCircle (svgWidth / 4) (svgHeight / 4) 
            , makeCircle (svgWidth / 4) ( svgHeight / 2)
            , makeCircle (svgWidth / 4) ( 3 * (svgHeight / 4))
            , makeCircle (3 * (svgWidth / 4)) (svgHeight / 4) 
            , makeCircle (3 * (svgWidth / 4)) ( svgHeight / 2)
            , makeCircle (3 * (svgWidth / 4)) ( 3 * (svgHeight / 4))
            ]
          _ ->
            [ makeCircle (svgWidth / 2) (svgHeight / 2) ]

  in
      svg
        svgAttrs
        (List.append [ face ] (calcCircles dieValue))

getDieImg : Int -> Html msg
getDieImg dieValue =
 let imgSrc = "img/dieX.png" in
     img [ src (String.split "X" imgSrc 
                  |> String.join (toString dieValue)) ] []

-- INIT
init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
