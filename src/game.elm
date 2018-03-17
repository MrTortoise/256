module Game exposing (..)

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
