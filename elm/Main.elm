module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Task =
    { name : String, done : Bool }


type alias Model =
    { tasks : List Task
    , text : String
    }


model =
    { tasks = []
    , text = ""
    }


type Msg
    = AddTask
    | ChangeText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddTask ->
            { model
                | tasks =
                    List.append model.tasks
                        [ { name = model.text
                          , done = False
                          }
                        ]
                , text = ""
            }

        ChangeText newValue ->
            { model | text = newValue }


renderItem : Task -> Html Msg
renderItem task =
    li [] [ text (task.name) ]


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ ul [] (List.map renderItem model.tasks)
            ]
        , button
            [ onClick AddTask
            , disabled (String.length model.text == 0)
            ]
            [ text ("add a task")
            ]
        , input [ type_ "text", onInput ChangeText, value model.text ] []
        ]
