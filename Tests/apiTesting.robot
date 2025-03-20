*** Settings ***
Library    Collections
Library    RequestsLibrary

*** Variables ***
${base_url}    https://rahulshettyacademy.com
${book_name}    RobotFramework
${aisle}    024
${book_id}


*** Test Cases ***
#Play around with dictionary
#    &{my_dict} =    Create Dictionary    name=Ravi    age=42    sex=Male
#    Log    ${my_dict}
#    Dictionary Should Contain Key    ${my_dict}    age
#    Log    ${my_dict}[name]
#    ${value} =    Get From Dictionary    ${my_dict}    age
#    Log    ${value}

API Testing using POST method - Add Book
    [Tags]    API
    &{req_body} =    Create Dictionary    name=${book_name}    isbn=RF    aisle=${aisle}    author=Ravi
    ${post_response} =    POST    url=${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    Log    ${post_response.json()}    # Here the response will be in dictionary
    Dictionary Should Contain Key    ${post_response.json()}    ID
    ${book_id} =    Get From Dictionary    ${post_response.json()}    ID
    Log    ${book_id}
    Log    ${post_response.json()}[Msg]
    Should Be Equal As Strings    ${post_response.json()}[Msg]    successfully added
    Status Should Be    200    ${post_response}
    Set Global Variable    ${book_id}

API Testing using GET method - Retrieve Book
    [Tags]    API
    ${get_response} =    GET    url=${base_url}/Library/GetBook.php    params=ID=${book_id}    expected_status=200
    Log    ${get_response.json()}    # Here the response will be in list
    Log    ${get_response.json()}[0][book_name]
    Should Be Equal As Strings    ${get_response.json()}[0][book_name]    ${book_name}

API Testing using POST method - Delete Book
    [Tags]    API
    &{del_req_body} =    Create Dictionary    ID=${book_id}
    ${del_response} =    POST    url=${base_url}/Library/DeleteBook.php    json=${del_req_body}    expected_status=200
    Log    ${del_response.json()}
    Log    ${del_response.json()}[msg]
    Should Be Equal As Strings    ${del_response.json()}[msg]    book is successfully deleted