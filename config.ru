#!/usr/bin/ruby

require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/namespace'
require 'json'
require 'web3'
require 'pry'
require 'coinone'

require 'sprockets'
require 'uglifier'
require 'sass'
require 'coffee-script'
require 'execjs'

require './app.rb'

run SinatraDapp.new

