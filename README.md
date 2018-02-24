# test_app
Tiny framework for web testing with using of Page Object approach

#### Setup

* install ruby 2.5.0
* install gekodrivers for browsers you want to run tests on

##### How to use:

1. cd to application root folder: /.../test_app/

2. Run bundle install

3. Run:  ruby test_runner.rb 1.1
* where parameter 1.1 represents number of a feature file and number of a test case, separated by dot.

Note: you can change input data for test inside its own fixture file which has the same name as passed parameter (feature_number.test_case_number; ex. 1.1)
