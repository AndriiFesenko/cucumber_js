const fs = require('fs');
const path = require('path');
const reporter = require('cucumber-html-reporter');

const reportDir = './reports';
const htmlFile = path.join(reportDir, 'cucumber_report.html');
const jsonFile = path.join(reportDir, 'cucumber_report.json');

if (!fs.existsSync(reportDir)) {
  fs.mkdirSync(reportDir);
}

console.log(`Checking JSON file at: ${jsonFile}`);
if (fs.existsSync(jsonFile)) {
  console.log('JSON file found, generating report...');
  const options = {
    theme: 'bootstrap',
    jsonFile: jsonFile,
    output: htmlFile,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: true,
    metadata: {
      "App Version": "1.0.0",
      "Test Environment": "STAGING",
      "Browser": "Chrome  89.0.4389.82",
      "Platform": "Windows 10",
      "Parallel": "Scenarios",
      "Executed": "Remote"
    }
  };

  try {
    reporter.generate(options);
    console.log(`Report generated at: ${htmlFile}`);
  } catch (error) {
    console.error('Error generating report:', error);
  }
} else {
  console.error(`JSON report file not found: ${jsonFile}`);
}
