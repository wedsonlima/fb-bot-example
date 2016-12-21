require 'rubygems'
require 'bundler'
require 'sinatra/base'

Bundler.require

require 'dotenv'
Dotenv.load

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

require 'facebook/messenger'
require_relative 'bot'

run Facebook::Messenger::Server
run BotAdmin
