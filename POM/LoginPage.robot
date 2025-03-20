*** Settings ***
Documentation    All the page objects and keywords of Login page
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${username}    rahulshettyacademy
${invalidPassword}    1234567890
${validPassword}    learning
${errorMessageDisplayed}    css:.alert-danger

*** Keywords ***
Enter username, password, and click on Sign In button
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    id:signInBtn

Wait until element is located
    Wait Until Element Is Visible    ${errorMessageDisplayed}

Validate error message is correct
#    1st way:
    ${actualResult} =    Get Text    ${errorMessageDisplayed}
    Should Be Equal As Strings    ${actualResult}    Incorrect username/password.
#    2nd way:
    Element Text Should Be    ${errorMessageDisplayed}    Incorrect username/password.

Enter Username, Enter Password, Select Radio button, Handle pop-up, Select value from dropdown, Select checkbox
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Select Radio Button    radio    user
    Wait Until Element Is Visible    css:.modal-content
    Click Button    id:okayBtn
    Click Button    id:okayBtn
#    Wait Until Element Is Not Visible    css:.modal-content
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'modal-backdrop fade')]
    Wait Until Element Is Visible    xpath=//select[@class='form-control']
    Select From List By Value    xpath=//select[@class='form-control']    teach
    Select Checkbox    id:terms
    Checkbox Should Be Selected    id:terms