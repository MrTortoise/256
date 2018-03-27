
import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing(..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


type alias Model =
    {     }


type Msg
    = Msg1

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msg1 ->
            (model, Cmd.none)

view : Model -> Html Msg
view model =
  svg
  [ viewBox "-10 -10 110 110", Svg.Attributes.width "100%", Svg.Attributes.height "100%"]
  [
    rect [x "0", y "0", width "100", height "100", stroke "black", strokeWidth "0.1", strokeLinecap "round", fill "none" ][],
    rect [x "0", y "0", width "25", height "25", fill "#edaabc"][],
    Svg.text_ [x "1", y "22", textLength "23", preserveAspectRatio "xMaxyMax meet", lengthAdjust "spacingAndGlyphs", fontSize "30"][Svg.text "256"],
    Svg.text_ [x "26", y "22", textLength "23", preserveAspectRatio "xMaxyMax meet", lengthAdjust "spacingAndGlyphs", fontSize "30"][Svg.text "8"],
    Svg.text_ [x "51", y "22", textLength "23", preserveAspectRatio "xMaxyMax meet", lengthAdjust "spacingAndGlyphs", fontSize "30"][Svg.text "8"],
    Svg.text_ [x "76", y "22", textLength "23", preserveAspectRatio "xMaxyMax meet", lengthAdjust "spacingAndGlyphs", fontSize "30"][Svg.text "8"]
  ]



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init =
    (Model , Cmd.none)
