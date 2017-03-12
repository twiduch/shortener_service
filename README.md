#Shortener Service

##How to run
Install all gems

    bundle install

Run localy

    bundle exec rackup -s webrick -p 4000

Or using docker

    docker build -t farm .
    docker run -d -p 4000:4000 farm

Navigate to:

    http://localhost:4000/front

For redirection to shortened url use:

    http://localhost:4000/:shortened_url

To verify tests, please use:

    rspec spec


##Description
This is simple (very simple!) url shortener leveraging Sinatra framework. You can post url as JSON and receive both: short_url and url as a response

If you send the same url for a second time, the original (from the first call) short_url will be returned. That may or may be not a desired behaviour.

In current implementation URLs are stored in memory. That means all will be lost with a server restart, and you cannot use multi-processes servers.
