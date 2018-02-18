# test_app
Tiny framework for web testing with using of Page Object approach

#### Setup

* installed ruby 2.5.0
* installed gekodrivers for browsers you want to run tests on

##### How to use:

1. cd to application root folder: /.../test_app/

2. Run bundle install

3. Run:   ruby test_runner.rb -f 1 -t 1 -b chrome -d search_freelancer_keyword
* -f: feature file (mandatory)
* -t: test case (mandatory)
* -b: browser (optional. Default: firefox)
* -d: data file (different setup data that is [not] needed for definite test)

