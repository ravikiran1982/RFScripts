*** Settings ***
Test Setup    Open the browser with rahul shetty academy url
#Test Teardown    Close Browser Session
Library    ../customLibraries/Shop.py
Resource    ../POM/Generic.robot
Resource    ../POM/LoginPage.robot

*** Variables ***
${errorMessageDisplayed}    css:.alert-danger
${elementLocated}    css:.nav-link.btn.btn-primary
${cardName}    Nokia Edge
${ListOfProducts}    Blackberry    Nokia Edge

*** Test Cases ***
#Validate Unsuccessful login
#    Enter username, password, and click on Sign In button    ${username}    ${invalidPassword}
#    Wait until element is located    ${errorMessageDisplayed}
#    Validate error message is correct

Validate card titles displayed in the Shopping page
    Enter username, password, and click on Sign In button    ${username}    ${validPassword}
    Wait until element is located    ${elementLocated}
    Validate card titles in the shopping page
#    Select a card    ${cardName}
#    Helloworld
    Add Items To Cart And Checkout    ${ListOfProducts}

#Validate All fields on the Login page
#    Enter Username, Enter Password, Select Radio button, Handle pop-up, Select value from dropdown, Select checkbox    ${username}    ${validPassword}

*** Keywords ***
Enter username, password, and click on Sign In button
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    id:signInBtn

Wait until element is located
    [Arguments]    ${elementLocated}
    Wait Until Element Is Visible    ${elementLocated}

Validate error message is correct
#    1st way:
    ${actualResult} =    Get Text    ${errorMessageDisplayed}
    Should Be Equal As Strings    ${actualResult}    Incorrect username/password.
#    2nd way:
    Element Text Should Be    ${errorMessageDisplayed}    Incorrect username/password.

Validate card titles in the shopping page
    @{expectedList} =    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    @{elements} =    Get WebElements    css:.card-title
    @{actualList} =    Create List
    FOR    ${item}    IN    @{elements}
        Log    ${item.text}
        Append To List    ${actualList}    ${item.text}
    END
    Log    ${actualList}
    Lists Should Be Equal    ${expectedList}    ${actualList}

Select a card
    [Arguments]    ${cardName}
    @{elements} =    Get WebElements    css:.card-title
    ${index} =    Set Variable    1
    FOR    ${item}    IN    @{elements}
        Log    ${item.text}
        Exit For Loop If    '${cardName}' == '${item.text}'
        ${index} =    Evaluate    ${index} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button
    Capture Page Screenshot    testDemo6_my_screenshot.png

Enter Username, Enter Password, Select Radio button, Handle pop-up, Select value from dropdown, Select checkbox
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Select Radio Button    radio    user
    Wait Until Element Is Visible    css:.modal-content
    Click Button    id:okayBtn
    Wait Until Element Is Not Visible    css:.modal-content
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    id:terms
    Checkbox Should Be Selected    id:terms
    Capture Page Screenshot    testDemo6_my_screenshot1.png