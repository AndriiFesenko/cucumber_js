Feature: Students
  As a user
  I want to be able to create students
  So that I can track their data afterwards

  Scenario: Create a student
    Given The API is running
    When I create a new student with the following details:
    | name  | age | sex   | fearFactor    |
    | Greg  | 25  | Male  | 1             |
    Then the response status code should be 201
    And The parameter 'name' should be equal to 'Greg'
    And The parameter 'sex' is type of string

  Scenario: Get students
    Given The API is running
    When I request all students
    Then the response status code should be 200
    Then I receive object of students

  Scenario: Get a specific student by id
    Given The API is running
    When I request a specific student by its ID 's2'
    Then the response status code should be 200
    Then The parameter 'id' should be equal to 's2'

  Scenario: Create a student with age 0
    Given The API is running
    When I create a new student with invalid age and the following details:
      | name  | age | sex   | fearFactor    |
      | Test  | 0   | Male  | 1             |
    Then the response status code should be 400
    And the response should contain error message "invalid student age"
  
  Scenario: Create a student with age -1
    Given The API is running
    When I create a new student with invalid age and the following details:
      | name  | age | sex   | fearFactor    |
      | Test  | -1   | Male  | 1             |
    Then the response status code should be 400
    And the response should contain error message "invalid student age"
  
  Scenario: Create a student with invalid fearFactor
    Given The API is running
    When I create a new student with invalid age and the following details:
      | name  | age | sex   | fearFactor    |
      | Test  | 25  | Male  | 6             |
    Then the response status code should be 400
    And the response should contain error message "invalid fearFactor"
  
  Scenario: Create a student with invalid fearFactor
  Given The API is running
  When I create a new student with invalid age and the following details:
    | name  | age | sex   | fearFactor     |
    | Test  | 25  | Male  | -1             |
  Then the response status code should be 400
  And the response should contain error message "invalid fearFactor"

  Scenario: Create 16 students and verify the ID of the 16th
    Given The API is running
    When I create 16 students
    Then I verify the ID of the last student 16
  
  
  
  
  #Scenario: Create appointment with collector

  #Scenario: Request all possible appointments

