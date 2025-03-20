*** Settings ***
Test Setup    Open the browser with rahul shetty academy url
Resource    ../POM/Generic.robot

*** Variables ***
${email}

*** Test Cases ***
Validate Parent/child window functionality
    [Tags]    SMOKE
    Click the link in parent window to open child window
    Validate the user is switched to child window
    Grab "email" from the child window
    Switch to parent window and enter "email" in username field

*** Keywords ***
Click the link in parent window to open child window
#    Click Link    css:.blinkingText
    Click Link    xpath://a[contains(text(),'Free Access to InterviewQues/ResumeAssistance/Material')]
    Sleep    5

Validate the user is switched to child window
    Switch Window    NEW
    Element Text Should Be    xpath://h1[normalize-space()='Documents request']    DOCUMENTS REQUEST

Grab "email" from the child window
    ${email} =    Get Text    css:a[href='mailto:mentor@rahulshettyacademy.com']
    Log    ${email}
    Set Global Variable    ${email}

Switch to parent window and enter "email" in username field
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username    ${email}
    Capture Page Screenshot    testDemo3_my_screenshot.png