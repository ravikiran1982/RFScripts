*** Settings ***
Documentation    All the page objects and keywords of Shop page
Library    SeleniumLibrary
Library    Collections
Library    Screenshot    on_pass = True

*** Variables ***
${elementLocated}    css:.nav-link.btn.btn-primary
${cardName}    Nokia Edge

*** Keywords ***
Wait until element is located
    Wait Until Element Is Visible    ${elementLocated}

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
    Capture Page Screenshot    ShopPage_my_screenshot1.png