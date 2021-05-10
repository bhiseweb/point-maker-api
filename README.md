# README

Things you may want to cover:

## Ruby version
* 2.7.1

## Rails version
* 6.1.3.1

## Setup And Installation

* `git clone https://github.com/anshu-dev/point-maker-api.git` 
* `cd point-maker-web`
* `bundle install`


## Database configuration
* Modify `config/database.yml` with your postgresql setting.
* Postgis is used as adapter for geo points.
* Run `rails db:create`
* Run `rails db:migrate`

## Running On Development

* `rails s`
* Visit your app at (http://localhost:3000/api/v1/points).

## Heroku URL
* https://aqueous-meadow-88620.herokuapp.com/api/v1/points
