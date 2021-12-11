# Sports Data Api

A Ruby on rails api to send request and send sports data. Includes:
* Sports data endpoints
* Proxied requests to avoid geo blocking
* Redis cache layer

## Requirements
* Ruby on rails installed locally
* Running local version of redis on default port
* An api key from [https://www.scraperapi.com/](https://www.scraperapi.com/) to run proxy requests

## Installation

create a config/application.yml file to store api key

```ruby
scraper_api_key: my_api_key
```

Install dependencies

```bash
bundle install
```
Start local development server

```bash
rails s
```
Run test suit

```bash
bundle exec rspec
```

## License
[MIT](https://choosealicense.com/licenses/mit/)