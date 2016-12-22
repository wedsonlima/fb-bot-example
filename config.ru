require 'rubygems'
require 'sinatra/base'

require 'bundler'
Bundler.require

require 'dotenv'
Dotenv.load

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

require 'facebook/messenger'
require_relative 'bot'

run Facebook::Messenger::Server
