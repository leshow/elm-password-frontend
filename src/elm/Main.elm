module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)
import Http
import Task
import Json.Decode as Json exposing ((:=))
import String


-- APP


main : Program Never
main =
    Html.program { init = model, view = view, update = update, subscriptions = subs }


subs : Model -> Sub Msg
subs model =
    Sub.none



-- MODEL


type alias Model =
    { mnemonic : String, wordCount : Maybe Int }


model : ( Model, Cmd Msg )
model =
    { mnemonic = "", wordCount = Nothing } ! []



-- UPDATE


type Msg
    = NoOp
    | GetMnemonic
    | FetchSuccess String
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        GetMnemonic ->
            ( model, getMnemonic model )

        FetchSuccess pw ->
            ( { model | mnemonic = pw }, Cmd.none )

        FetchFail _ ->
            ( model, Cmd.none )


api : String
api =
    "http://localhost:3000/passphrase"


buildUrl : Maybe Int -> String
buildUrl words =
    case words of
        Just wc ->
            api ++ (toString wc)

        Nothing ->
            api


getMnemonic : Model -> Cmd Msg
getMnemonic model =
    let
        url =
            buildUrl model.wordCount
    in
        Task.perform FetchFail FetchSuccess (Http.get responseDecoder api)


responseDecoder : Json.Decoder String
responseDecoder =
    Json.at [ "passphrase" ] Json.string



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ header
        , hero model
        ]


header : Html Msg
header =
    nav [ class "navbar navbar-default" ]
        [ div [ class "container-fluid" ]
            [ div [ class "navbar-header" ]
                [ a [ class "navbar-brand", href "#" ]
                    [ text "Home"
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
                    , msgButton GetMnemonic
                    ]
                ]
            ]
        , passview model
        ]


passview : Model -> Html Msg
passview model =
    if ((String.length model.mnemonic) > 0) then
        div [ class "row" ]
            [ div [ class "col-xs-12" ]
                [ div [ class "jumbotron h1" ]
                    [ text (model.mnemonic)
                    ]
                ]
            ]
    else
        Html.text ""


msgButton : Msg -> Html Msg
msgButton msg =
    button [ class "btn btn-primary btn-lg", onClick msg ]
        [ span [ class "glyphicon glyphicon-star" ] []
        , span [] [ text "Generate password!" ]
        ]
