*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Library    DataDriver    file=resources/data.csv    encoding=utf_8    dialect=excel
Test Template    Validate Unsuccessful login

*** Variables ***
${url}    https://rahulshettyacademy.com/loginpagePractise/
${errorMessageDisplayed}    css:.alert-danger

*** Test Cases ***
Login with user ${username} and password ${password}    abc    123
# Notes:
# The above statement will be helpful in 2 ways:
# 1. When test case name is  not provided in csv file (only username and data is given), RF will execute with
# that data set using the above test case name (Login with user ...)
# 2. When the data file path (mentioned in Settings section) is incorrect, RF will execute using the default data
# mentioned after the test case name (abc, 123)

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