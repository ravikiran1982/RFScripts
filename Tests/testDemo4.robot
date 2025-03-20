*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Test Template    Validate Unsuccessful login

*** Variables ***
${url}    https://rahulshettyacademy.com/loginpagePractise/
${errorMessageDisplayed}    css:.alert-danger

*** Test Cases ***          username                password
Invalid username            ravi                    learning
Invalid password            rahulshettyacademy      123456
Special characters          ravi@#                  learning

*** Keywords ***
Validate Unsuccessful login
    [Arguments]    ${username}    ${password}
    Open the browser with rahul shetty academy url
    Enter username, password, and click on Sign In button    ${username}    ${password}
    Wait until error message is displayed
    Validate error message is correct

Open the browser with rahul shetty academy url
    Create Webdriver    Chrome
    Go To    ${url}

Enter username, password, and click on Sign In button
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    id:signInBtn

Wait until error message is displayed
    Wait Until Element Is Visible    ${errorMessageDisplayed}

Validate error message is correct
#    1st way:
#    ${actualResult} =    Get Text    ${errorMessageDisplayed}
#    Should Be Equal As Strings    ${actualResult}    Incorrect username/password.
#    2nd way:
    Element Text Should Be    ${errorMessageDisplayed}    Incorrect username/password.