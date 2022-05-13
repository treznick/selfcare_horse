# frozen_string_literal: true

require 'sinatra'
require 'sinatra/subdomain'
require 'active_support/all'

class SubDomain
  attr_reader :name, :humanized_duration, :self_care
  def initialize(name:, humanized_duration:, self_care:)
    @name = name
    @humanized_duration = humanized_duration
    @self_care = self_care
  end

  def humanized
    name.tr(".", " ").titleize
  end

  def sample_self_care
    self_care.sample
  end
end

SUBDOMAINS = {
  "five.minute" => SubDomain.new(name: "five.minute",
                                 humanized_duration: "five minutes", 
                                 self_care: [
                                   "Touching plants is good for you. Go weed the garden",
                                   "Throw a ball with your dog",
                                   "Pet your cat",
                                   "Practice piano",
                                   "Write in your journal",
                                   "Call a friend",
                                   "Stretch",
                                   "Breathe Mindfully",
                                   "Take a five minute walk",
                                   "Drink some water",
                                 ]
                                ),
  "ten.minute" => SubDomain.new(name: "ten.minute",
                                 humanized_duration: "ten minutes", 
                                 self_care: [
                                   "Touching plants is good for you. Go weed the garden",
                                   "Throw a ball with your dog",
                                   "Pet your cat",
                                   "Practice piano",
                                   "Write in your journal",
                                   "Call a friend",
                                   "Stretch",
                                   "Breathe Mindfully",
                                   "Take a five minute walk",
                                   "Drink some water",
                                   "Sketch something fun",
                                   ""
                                 ]
                                )
 }

subdomain do
  get '/' do
    if SUBDOMAINS.keys.include?(subdomain)
      erb :index, locals: locals(SUBDOMAINS[subdomain])
    else
      halt 404
    end
  end
end

def locals(sub_domain)
  {
    self_care: sub_domain.sample_self_care,
    humanized_subdomain: sub_domain.humanized,
    humanized_duration: sub_domain.humanized_duration
  }
end
