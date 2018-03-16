import Html exposing (..)
import Array exposing (..)
import List exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)

main : Program Never Model Msg
main =
  Html.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

type alias Row = Array.Array Int
type alias Board = Array.Array Row

type alias Point =
  { x : Int
  , y : Int
  }

type alias Rectangle =
  { origin : Point
  , size : Point
  }

type alias Model =
  { board : Board
  }

type Msg
  = Update Board

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Update board ->
      ({model | board = board} , Cmd.none)


view : Model -> Html Msg
view model =
  let
    height = 400
    width = 400
  in
    div []
      [ div [] [ Html.text "Look its a grid ^^" ]
      , svg [ viewBox "0 0 400 400", Svg.Attributes.width "100%"]
        (boardToRectangles model.board)
      ]

boardToView : Board -> Svg msg
boardToView board =
  rect [x "10", y "10", width "200", height "200", stroke "black", strokeWidth "0.1", fill "none" ]
  (boardToRectangles board)

rectangleToSvg : Rectangle -> Svg msg
rectangleToSvg rectangle =
  rect
    [ x (toString (rectangle.origin.x*50))
    , y (toString (rectangle.origin.y*50))
    , width (toString rectangle.size.x)
    , height (toString rectangle.size.y)
    , stroke "black", strokeWidth "0.1", fill "none" ]
    [
      Svg.text "9"
    ]

rectanglesToSvg: List Rectangle -> List (Svg msg)
rectanglesToSvg rectangles =
   List.map rectangleToSvg rectangles

boardToRectangles : Board -> List (Svg msg)
boardToRectangles board =
  let
    rows = range 0 3
    columns = range 0 3
  in
   rectanglesToSvg (concatMap buildRowRectangle rows)

rectangleBuilder: Point -> Int -> Int -> Rectangle
rectangleBuilder sizePoint row column =
  Rectangle (Point row column) sizePoint

buildRowRectangle : Int -> List Rectangle
buildRowRectangle index =
  let
    columns = range 0 3
    sizePoint = Point 50 50
    f = rectangleBuilder sizePoint index
  in
    List.map f columns


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

createRow: List Int -> Row
createRow items = Array.fromList(items)

createBoard: List Row -> Board
createBoard rows = Array.fromList(rows)

emptyRow : Row
emptyRow = createRow([0,0,0,0])

init : (Model, Cmd Msg)
init =
  (Model (createBoard
    [ emptyRow
    , emptyRow
    , emptyRow
    , emptyRow
    ]) , Cmd.none)
