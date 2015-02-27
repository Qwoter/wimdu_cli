#!/usr/bin/env ruby 

class Place
  def initialize
    @status
  end

  def edit
  end

  class << self
    def list
    end

    def find(code)
    end
  end
end

class WimduCLI
  def hello(name)
    puts "Hello #{name}"
    puts "List"

    self.list
  end

  def list
    Place.list
    puts "asd"
  end

  def new
    place = Place.new
    place.continue
  end

  def show
  end

  def continue(code)
    place = Place.find(code)
    place.continue
  end
end

stream = $stdin
stream.each do |line|
  puts line
end
