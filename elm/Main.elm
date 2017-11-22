module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


type alias Model =
    { message : String
    , taskDone : Bool
    }


model =
    { message = "Hello"
    , taskDone = False
    }


type Msg
    = ChangeItUp


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeItUp ->
            { model
                | message = "Howdy."
                , taskDone = not model.taskDone
            }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick ChangeItUp ] [ text "change" ]
        , div [] [ text (toString model) ]
        ]


main =
    Html.beginnerProgram { model = model, view = view, update = update }
