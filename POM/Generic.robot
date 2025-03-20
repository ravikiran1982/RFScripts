*** Settings ***
Documentation    All the objects and keywords of Open browser, redirecting to URL, and closing the browser
Library    SeleniumLibrary
Library    Collections
Library    Screenshot    on_pass = True

*** Variables ***
${url}    https://rahulshettyacademy.com/loginpagePractise/
${browser_name}    Chrome

*** Keywords ***
Open the browser with rahul shetty academy url
#    1st way:
    Create Webdriver    ${browser_name}
    Go To    ${url}
#    2nd way:
#    Open Browser    ${url}    ${browser_name}

Open the browser with url
    Create Webdriver    ${browser_name}
    Go To    ${url}

Close Browser Session
    Close Browser