# README

* Something about choosing Rails test over rspec
* Fixtures a weak, but work
* Tested with Postman and dev database

Things you may want to cover:

* Install ruby 3.3.0 via [homebrew](https://brew.sh/)
```
$ brew install rbenv ruby-build
$ rbenv init
$ rbenv install 3.3.0
```

* Setting up the application
```$ bundle install```

* Database creation
Download and install the [postgress app](https://postgresapp.com/) if you do not have postgres on your machine

* Database initialization
`bin/rails db:setup`
`bin/rails db:migrate`

`bin/rails db:seed`

* Running the test suite
`bin/rails test`

* Start server instructions
