*** Settings ***
#Test Setup    Open the browser with rahul shetty academy url
Test Setup    Open the browser with url
#Test Teardown    Close Browser Session
Library    ../customLibraries/Shop.py
Resource    ../POM/Generic.robot
Resource    ../POM/LoginPage.robot
Resource    ../POM/ShopPage.robot
Resource    ../POM/CheckoutPage.robot
Resource    ../POM/ConfirmationPage.robot

*** Variables ***
${ListOfProducts}    Blackberry    Nokia Edge

*** Test Cases ***
Validate Unsuccessful login
    [Tags]    SMOKE    REGRESSION
    LoginPage.Enter username, password, and click on Sign In button    ${username}    ${invalidPassword}
    LoginPage.Wait until element is located
    LoginPage.Validate error message is correct

End to end ecommerce Product validation
    [Tags]    REGRESSION
    LoginPage.Enter username, password, and click on Sign In button    ${username}    ${validPassword}
    ShopPage.Wait until element is located
    ShopPage.Validate card titles in the shopping page
    Add Items To Cart And Checkout    ${ListOfProducts}
    CheckoutPage.Validate items in Checkout page and proceed
    ConfirmationPage.Enter delivery location, select terms checkbox, and click purchase button
    ConfirmationPage.Validate success message

Validate All fields on the Login page
    [Tags]    SMOKE    REGRESSION
    LoginPage.Enter Username, Enter Password, Select Radio button, Handle pop-up, Select value from dropdown, Select checkbox    ${username}    ${validPassword}

# Note:
# If a keyword is available in multiple pages, best way to pick the correct page is to provide the page name at
# the beginning. This is the best practice.
# Example: "Wait until element is located" --> This is available in LoginPage and ShopPage.