Feature: Appointments API
    as a user
    I want to be able to create, update and delete appointments
    So that I can track the appointments

  Scenario: Get all appointments
    Given The API is running
    When I request all appointments
    Then the response status code should be 200
    And the response should contain appointments

  Scenario: Create a new appointment
    Given The API is running
    #precondition
      #Creating a new student
      When I create a new student with the following details:
      | name    | age | sex   | fearFactor    |
      | Andrii  | 28  | Male  | 1             |
      Then the response status code should be 201
    #executing the test
    When I create an appointment with valid data "2025-10-20 10:00:00"
    Then the response status code should be 201
    And the response should contain appointment data

 Scenario: Create an appointment with past date
    Given The API is running
    #precondition
      #Creating a new student
      When I create a new student with the following details:
      | name    | age | sex   | fearFactor    |
      | Andrii  | 28  | Male  | 1             |
      Then the response status code should be 201
    #executing the test
    When I create an appointment with past date "2023-05-20 10:00:00"
    Then the response status code should be 400
    And the response should contain error message "Appointment date cannot be in the past"

Scenario: Create an appointment with invalid student ID
    Given The API is running
    When I create an appointment with invalid data
      | date                | studentId |
      | 2024-10-20 10:00:00 | unknown   |
    Then the response status code should be 400
    And the response should contain error message "Student not found"

Scenario: Create an appointment with invalid date format
    Given The API is running
    #precondition
      #Creating a new student
      When I create a new student with the following details:
      | name    | age | sex   | fearFactor    |
      | Andrii  | 28  | Male  | 1             |
      Then the response status code should be 201
    #executing the test
    When I create an appointment with invalid date format "2025/05/20 10:00:00"
    Then the response status code should be 400
    And the response should contain error message "Date must be in YYYY-MM-DD HH:mm:ss format"

  Scenario: Get appointment by id
    Given The API is running
    When I request an appointment by id "ap1"
    Then the response status code should be 200
    And the response should contain appointment with id "ap1"

  Scenario: Delete an appointment by id
    Given The API is running
    #precondition
      #Creating a new student
      When I create a new student with the following details:
      | name    | age | sex   | fearFactor    |
      | Andrii  | 28  | Male  | 1             |
      Then the response status code should be 201
      #Creating appointment
      When I create an appointment with valid data "2025-10-20 10:00:00"
      Then the response status code should be 201
    #executing test
    When I delete an appointment by id
    Then the response status code should be 204
