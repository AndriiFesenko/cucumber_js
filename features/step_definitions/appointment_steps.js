const { Given, When, Then, After } = require('@cucumber/cucumber');
const request = require('supertest');
const app = require('../../server/server.js');
const assert = require('assert');
const axios = require('axios');

let appointmentId;

// Step definition starts...
When('I request all appointments', async function () {
  response = await axios.get(`${this.api}/api/appointment`);
  this.response = response;
});

When('I create an appointment with valid data {string}', async function (date) {
  const appointmentDetail = {
    studentId: this.studentID,
    date: date
    };
  try {
    const response = await axios.post(`${this.api}/api/appointment`, appointmentDetail);
    this.response = response;
    appointmentId = this.response.data.id;
  } catch (error) {
    this.response = error.response;
  }
});

When('I create an appointment with past date {string}', async function (date) {
  const appointmentDetail = {
    studentId: this.studentID,
    date: date
    };
  try {
    const response = await axios.post(`${this.api}/api/appointment`, appointmentDetail);
    this.response = response;
  } catch (error) {
    this.response = error.response;
  }
});

When('I create an appointment with invalid data', async function (dataTable) {
  const appointmentDetailsArray = dataTable.hashes();
  try {
    const response = await axios.post(`${this.api}/api/appointment`, appointmentDetailsArray[0]);
    this.response = response;
  } catch (error) {
    this.response = error.response;
  }
});

When('I create an appointment with invalid date format {string}', async function (date) {
  const appointmentDetail = {
    studentId: this.studentID,
    date: date
};
  try {
    const response = await axios.post(`${this.api}/api/appointment`, appointmentDetail);
    this.response = response;
  } catch (error) {
    this.response = error.response;
  }
});

When('I request an appointment by id {string}', async function (id) {
  const response = await axios.get(`${this.api}/api/appointment/${id}`);
  this.response = response;
});

When('I delete an appointment by id', async function () {
  const response = await axios.delete(`${this.api}/api/appointment/${appointmentId}`);
  this.response = response;
});
// Step definition ends...

// Step validation starts...

Then('the response should contain appointments', function () {
  assert.ok(Array.isArray(this.response.data));
});

Then('the response should contain appointment data', function () {
  assert.ok(this.response.data.id);
  assert.ok(this.response.data.studentId);
  assert.ok(this.response.data.date);
});

Then('I receive object of appointments', function () {
  const appointments = this.response.data
  assert.strictEqual(typeof appointments, 'object', 'Expected response to be an object');
})

Then('the response should contain error message {string}', function (errorMessage) {
  let error;
  console.log(this.response.status);
  if (this.response.data.errors) {
    if (Array.isArray(this.response.data.errors)) {
      error = this.response.data.errors[0].msg; // handle if it is an array
    } else {
      error = this.response.data.errors.message; // handle if it is an object
    }
  } else {
    error = this.response.data.error;
  }
  assert.strictEqual(error, errorMessage);
});

Then('the response should contain appointment with id {string}', function (id) {
  assert.strictEqual(this.response.data.id, id);
});

// Step validation ends...