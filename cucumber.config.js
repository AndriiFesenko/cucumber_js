module.exports = {
  default: `--require features/support/setup.js --require features/support/world.js --require features/step_definitions/**/*.js --format json:./reports/cucumber_report.json`,
  active: `--require features/support/setup.js --require features/support/world.js --require features/step_definitions/**/*.js --tags @active --format json:./reports/cucumber_report.json`,
  exclude: `--require features/support/setup.js --require features/support/world.js --require features/step_definitions/**/*.js --tags ~@ignore --format json:./reports/cucumber_report.json`
};
