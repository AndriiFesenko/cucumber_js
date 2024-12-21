Feature: Debts
    as a user
    I want to be able to create, update and delete debts
    So that I can track the debts

    Scenario: Create debt for a specific student
    Given The API is running
    #precondition
      #Creating a new student
      When I create a new student with the following details:
      | name    | age | sex   | fearFactor    |
      | Andrii  | 28  | Male  | 1             |
      Then the response status code should be 201
    #executing the test  
    When I create a debt for the student with the amount 1000
    Then the response status code should be 201
    And The debt should be created with the amount 1000
    And Id is assigned to the debt
    And The monthly percent of the newly created debt must be 0

    Scenario: Create debt for unexisting
    Given The API is running
    When I create a debt for the student that does not exist "unknown" with the amount 1000
    Then the response status code should be 404
    And the response should contain error message "Student not found"
