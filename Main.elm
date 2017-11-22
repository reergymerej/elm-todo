module Main exposing (..)

import Html exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    String


model =
    "Hello"


type Msg
    = ChangeItUp


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeItUp ->
            "Howdy."


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]
