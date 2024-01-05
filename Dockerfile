FROM ruby:3.1.2

# Set environment variables
ENV RAILS_ROOT /app

# Set the working directory inside the container
WORKDIR $RAILS_ROOT

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the Rails application into the container
COPY . .

# Expose ports
EXPOSE 3000

# Start the Rails application
CMD ["rails", "server", "-b", "0.0.0.0"]