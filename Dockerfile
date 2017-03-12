FROM ruby:2.3-onbuild
ENTRYPOINT ["bundle", "exec", "rackup -p 4000 --host 0.0.0.0"]