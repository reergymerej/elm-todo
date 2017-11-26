module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Task =
    { name : String
    , done : Bool
    , id : Int
    }


type alias Model =
    { tasks : List Task
    , nextTaskId : Int
    , text : String
    }


model =
    { tasks = []
    , nextTaskId = 0
    , text = ""
    }


type Msg
    = AddTask
    | ChangeText String
    | UpdateTaskCompletion Int Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTask ->
            { model
                | tasks =
                    List.append model.tasks
                        [ { name = model.text
                          , done = False
                          , id = model.nextTaskId
                          }
                        ]
                , nextTaskId = model.nextTaskId + 1
                , text = ""
            }

        ChangeText newValue ->
            { model | text = newValue }

        UpdateTaskCompletion taskId done ->
            let
                updateTask t =
                    if (t.id == taskId) then
                        { t | done = done }
                    else
                        t
            in
                { model
                    | tasks = List.map (updateTask) model.tasks
                }


unfinishedTaskStyle : Attribute msg
unfinishedTaskStyle =
    style []


finishedTaskStyle : Attribute msg
finishedTaskStyle =
    -- How do we generate a style sheet to use class names instead?
    style [ ( "text-decoration", "line-through" ) ]


getTaskStyle : Task -> Attribute msg
getTaskStyle task =
    if (task.done) then
        finishedTaskStyle
    else
        unfinishedTaskStyle


renderTask : Task -> Html Msg
renderTask task =
    div
        [ getTaskStyle task
        , onClick (UpdateTaskCompletion task.id (not task.done))
        ]
        [ text (task.name)
        ]


view : Model -> Html Msg
view model =
    div []
        [ div []
            (List.map renderTask model.tasks)
        , input
            [ type_ "text"
            , onInput ChangeText
            , value model.text
            ]
            []
        , button
            [ onClick AddTask
            , disabled (String.length model.text == 0)
            ]
            [ text ("add a task")
            ]
        ]
