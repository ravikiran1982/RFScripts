*** Settings ***
Documentation    All the page objects and keywords of Checkout page
Library    SeleniumLibrary
Library    Collections
Library    ../customLibraries/Shop.py

*** Variables ***
${ListOfProducts}    Blackberry    Nokia Edge

*** Keywords ***
Validate items in Checkout page and proceed
    @{expectedList}    Create List    Nokia Edge    Blackberry
    @{actualList}    Create List
    ${element1} =    Get Text    xpath://a[normalize-space()='Nokia Edge']
    ${element2} =    Get Text    xpath://a[normalize-space()='Blackberry']
    Append To List    ${actualList}    ${element1}
    Append To List    ${actualList}    ${element2}
    Log    ${actualList}
    Log    ${expectedList}
    Lists Should Be Equal    ${expectedList}    ${actualList}
    Click Button    css:.btn-success