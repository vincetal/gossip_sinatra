require 'bundler'
Bundler.require

$:.unshift File.expand_path('./../lib', __FILE__)
require 'app/template_classe_app'
require 'views/template_classe_view'
