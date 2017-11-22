module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Task =
    { name : String, done : Bool }


type alias Model =
    { tasks : List Task }


model =
    { tasks =
        [ { name = "do foo", done = False }
        , { name = "do bar", done = False }
        , { name = "do baz", done = False }
        , { name = "do quux", done = False }
        ]
    }


type Msg
    = ChangeItUp


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeItUp ->
            model


renderItem : Task -> Html Msg
renderItem task =
    li [] [ text (task.name) ]


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ ul [] (List.map renderItem model.tasks)
            ]
        ]
