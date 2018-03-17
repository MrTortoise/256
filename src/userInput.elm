import Html exposing (..)
import Keyboard exposing (KeyCode)
import Set exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }

type alias Model =
    { pressedKeys : Set KeyCode
    }

type Msg
    = KeyChange Bool KeyCode

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        KeyChange pressed keyCode  ->
            (handleKeyChange pressed keyCode model, Cmd.none)

handleKeyChange : Bool -> KeyCode -> Model -> Model
handleKeyChange pressed keyCode model =
  let
    fn = if pressed then Set.insert else Set.remove
    pressedKeys = fn keyCode model.pressedKeys
  in
    { model | pressedKeys = pressedKeys }


view : Model -> Html Msg
view model =
    div []
        [ (Set.isEmpty model.pressedKeys)
          |> toString
          |> text
        ]

init : (Model, Cmd Msg)
init =
    (Model Set.empty  , Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    let
        keys = [ Keyboard.downs (KeyChange True)
               , Keyboard.ups (KeyChange False)
               ]
    in
    keys |> Sub.batch