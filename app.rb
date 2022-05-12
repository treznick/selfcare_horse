# frozen_string_literal: true

require 'sinatra'
require 'sinatra/subdomain'
require 'active_support/all'

SUBDOMAINS = %w(five.minute)

SELF_CARE = {
  "five.minute" => [
    "Touching plants is good for you. Go weed the garden",
    "Throw a ball with your dog",
    "Pet your cat",
    "Practice piano",
    "Write in your journal",
    "Call a friend",
    "Stretch",
    "Breathe Mindfully"
  ]
}

DURATIONS = {
  "five.minute" => "five minutes"
}

subdomain do
  get '/' do
    if SUBDOMAINS.include?(subdomain)
      erb :index, locals: locals(subdomain)
    else
      halt 404
    end
  end
end

def get_self_care_for_subdomain(key)
  SELF_CARE[key].sample
end

def humanize_subdomain(key)
  key.tr(".", " ").titleize
end

def duration_subdomain(key)
  DURATIONS[key]
end

def locals(key)
  {
    self_care: get_self_care_for_subdomain(key),
    humanized_subdomain: humanize_subdomain(key),
    duration: duration_subdomain(key)
  }
end
