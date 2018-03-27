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
    , x : Int
    , y : Int
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
    (x, y) = parseDirection pressedKeys model
  in
    { model | pressedKeys = pressedKeys, x = x, y = y }

parseDirection : Set KeyCode -> Model -> (Int, Int)
parseDirection keyCodes model =
  let
    left = Set.member 37 model.pressedKeys
    up = Set.member  38 model.pressedKeys
    right = Set.member 39 model.pressedKeys
    down = Set.member 40 model.pressedKeys
  in
    (model.x, model.y)
    |> handleUp  up
    |> handleDown down
    |> handleLeft left
    |> handleRight right


handleUp:Bool -> (Int, Int) ->  (Int, Int)
handleUp  apply (x,y)=
  case apply of
    True -> (x,y+1)
    False -> (x,y)

handleDown: Bool ->  (Int, Int) -> (Int, Int)
handleDown apply (x,y)  =
  case apply of
    True -> (x,y-1)
    False -> (x,y)

handleLeft:  Bool ->(Int, Int) -> (Int, Int)
handleLeft apply (x,y)  =
  case apply of
    True -> (x-1,y)
    False -> (x,y)

handleRight: Bool ->(Int, Int) ->  (Int, Int)
handleRight apply (x,y)  =
  case apply of
    True -> (x+1,y)
    False -> (x,y)

view : Model -> Html Msg
view model =
  let
      keyString =
         Set.map toString model.pressedKeys
        |> Set.foldr String.append ""
  in
      div []
          [
            text keyString, text (toString model.x), text (toString model.y)
          ]

init : (Model, Cmd Msg)
init =
    (Model Set.empty 0 0  , Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    let
        keys = [ Keyboard.downs (KeyChange True)
               , Keyboard.ups (KeyChange False)
               ]
    in
    keys |> Sub.batch


