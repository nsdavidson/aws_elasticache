#
# Cookbook Name:: aws-elasticache
# Recipe:: default
#
# Copyright (C) 2014 Nolan Davidson
#
# All rights reserved - Do Not Redistribute
#

chef_gem "aws-sdk-core" do
  options("--pre")
  version "2.0.0.rc6"
end

require 'aws-sdk-core'