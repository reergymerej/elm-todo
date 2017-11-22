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
    { tasks = [] }


type Msg
    = AddTask


getNextTaskName : List Task -> String
getNextTaskName tasks =
    "task #" ++ toString (List.length tasks + 1)


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTask ->
            { model
                | tasks =
                    List.append model.tasks
                        [ { name = (getNextTaskName model.tasks)
                          , done = False
                          }
                        ]
            }


renderItem : Task -> Html Msg
renderItem task =
    li [] [ text (task.name) ]


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ ul [] (List.map renderItem model.tasks)
            ]
        , button [ onClick AddTask ]
            [ text ("add a task")
            ]
        ]
