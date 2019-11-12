# 1. Description
 this is a simple web application that converts currency rates from EUR to USD and from EUR to CHF (both ways) from currencylayer API. this app is composed from 2 views:
1. A view with a form includes the **value to convert**, **From** and **to** currencies. Submitting the form will show the result of the conversion but also it will **save the value, from , to and the result in the database**.
2. A view includes a table with all the history of currency conversions.
# 2. Setup
## Ruby & Bundler
To be able to do this challange make sure you have installed a recent version of ruby and bunlder.
https://www.ruby-lang.org/en/
https://bundler.io
## Install dependencies
To install required dependencies you just need to run `bundle install`
## Database server
Make sure to update database connection path in the file `config/environment.rb`.
# 3. Run the project
To run this starter project, simply execute `rackup` in your console
# 4. Run the tests
To run tests simply execute `rspec`  