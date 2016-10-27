module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material
import Material.Button as Button
import Material.Menu as Menu
import Material.Icon as Icon
import Material.Options exposing (css)


-- MODEL


type alias Model =
    { count : Int
    , mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }


model : Model
model =
    { count = 0
    , mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }



-- ACTION, UPDATE


type Msg
    = Increase
    | Reset
    | Mdl (Material.Msg Msg)



-- Boilerplate: Msg clause for internal Mdl messages.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )

        -- Boilerplate: Mdl action handler.
        Mdl msg' ->
            Material.update msg' model



-- VIEW


type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
    div []
        [ Menu.render Mdl
            [ 0 ]
            model.mdl
            [ Menu.ripple, Menu.bottomLeft ]
            [ Menu.item
                [ Menu.onSelect Increase ]
                [ text "English (US)" ]
            , Menu.item
                [ Menu.onSelect Reset ]
                [ text "français" ]
            ]
        , Button.render
            Mdl
            [ 0 ]
            model.mdl
            [ Button.fab
            , Button.colored
            , Button.ripple
            , Button.onClick Increase
            ]
            [ Icon.i "add" ]
        ]


main : Program Never
main =
    App.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }
