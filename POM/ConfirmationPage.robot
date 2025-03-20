*** Settings ***
Documentation    All the page objects and keywords of Confirmation page
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${country}    India

*** Keywords ***
Enter delivery location, select terms checkbox, and click purchase button
    Input Text    id:country    ${country}
    Sleep    5
    Wait Until Element Is Visible    xpath://a[text()='${country}']
    Click Element    xpath://a[text()='${country}']
    Click Element    xpath://label[@for='checkbox2']
    Click Button    xpath://input[@value='Purchase']

Validate success message
    Page Should Contain    Success! Thank you! Your order will be delivered in next few weeks :-).