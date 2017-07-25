import Regex exposing (regex, contains)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model = 
  { name : String
  , age : String
  , password : String
  , passwordAgain : String
  , submitted : Bool
  }

model : Model
model = 
  Model "" "" "" "" False

-- UPDATE
type Msg
  = Name String 
  | Age String
  | Password String
  | PasswordAgain String
  | Submit

update : Msg -> Model -> Model 
update msg model =
  case msg of 
    Name name ->
      { model | 
        name = name,
        submitted = False
      }

    Age age ->
      { model |
        age = age,
        submitted = False
      }

    Password password -> 
      { model | 
        password = password,
        submitted = False
      }

    PasswordAgain password ->
      { model | 
        passwordAgain = password, 
        submitted = False
      }

    Submit ->
      { model | submitted = True }


-- VIEW
view : Model -> Html Msg 
view model =
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name ] []
    , input [ type_ "text", placeholder "Age", onInput Age ] []
    , input [ type_ "password", placeholder "Password", onInput Password ] [] 
    , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] [] 
    , button [ onClick Submit ] [ text "Submit" ]
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model =
  let 
      (color, message) =
        if isValidAge model.age == False then 
          ("red", "You must supply a valid age")
          
        else if String.length model.password < 8 then
          ("red", "Password must be 8 characters long or more")

        else if contains (regex "[A-Z]+") model.password == False then
          ("red", "Passwords must contain at least one upper case letter")

        else if contains (regex "[a-z]+") model.password == False then
          ("red", "Passwords must contain at least one lower case letter")

        else if contains (regex "[0-9]+") model.password == False then
          ("red", "Passwords must contain at least one number")

        else if model.password /= model.passwordAgain then
          ("red", "Passwords do no match")

        else 
          ("green", "OK")
  in 
    if model.submitted then
      div [ style [("color", color)] ] [ text message ]
    else 
      div [] [] 

isValidAge age =
  case String.toInt age of 
    Err msg -> 
      False
    Ok age ->
      True
