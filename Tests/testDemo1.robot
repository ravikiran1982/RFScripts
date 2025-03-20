*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary

*** Variables ***
${url}    https://rahulshettyacademy.com/loginpagePractise/
${errorMessageDisplayed}    css:.alert-danger

*** Test Cases ***
Validate Unsuccessful login
    [Tags]    SMOKE
    Open the browser with rahul shetty academy url
    Enter username, password, and click on Sign In button
    Wait until error message is displayed
    Validate error message is correct

*** Keywords ***
Open the browser with rahul shetty academy url
    Create Webdriver    Chrome
    Go To    ${url}

Enter username, password, and click on Sign In button
    Input Text    id:username    rahulshettyacademy
    Input Password    id:password    1234567890
    Click Button    id:signInBtn

Wait until error message is displayed
    Wait Until Element Is Visible    ${errorMessageDisplayed}

Validate error message is correct
#    1st way:
    ${actualResult} =    Get Text    ${errorMessageDisplayed}
    Should Be Equal As Strings    ${actualResult}    Incorrect username/password.
#    2nd way:
    Element Text Should Be    ${errorMessageDisplayed}    Incorrect username/password.