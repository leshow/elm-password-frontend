module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)


-- APP


main : Program Never
main =
    Html.program { init = model, view = view, update = update, subscriptions = subs }


subs : Model -> Sub Msg
subs model =
    Sub.none



-- MODEL


type alias Model =
    Int


model : ( Model, Cmd Msg )
model =
    0 ! []



-- UPDATE


type Msg
    = NoOp
    | Increment


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Increment ->
            (model + 1) ! []


view : Model -> Html Msg
view model =
    div []
        [ header
        , hero model
        ]


header : Html Msg
header =
    nav
        [ class "navbar navbar-default" ]
        [ div
            [ class "container-fluid" ]
            [ div
                [ class "navbar-header" ]
                [ a
                    [ class "navbar-brand", href "#" ]
                    [ text
                        "Home"
                    ]
                ]
            ]
        ]


hero : Model -> Html Msg
hero model =
    div [ class "container", style [ ( "margin-top", "30px" ), ( "text-align", "center" ) ] ]
        [ div [ class "row" ]
            [ div [ class "col-xs-12" ]
                [ div [ class "jumbotron" ]
                    [ p [] [ text ("Elm/Rust Password Generator") ]
                    , msgButton Increment
                    ]
                ]
            ]
        ]


msgButton : Msg -> Html Msg
msgButton msg =
    button [ class "btn btn-primary btn-lg", onClick msg ]
        [ span [ class "glyphicon glyphicon-star" ] []
        , span [] [ text "Generate password!" ]
        ]
