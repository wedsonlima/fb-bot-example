require 'rubygems'
require 'bundler'

Bundler.require

require 'dotenv'
Dotenv.load

require 'facebook/messenger'
require_relative 'bot'

run Facebook::Messenger::Server
