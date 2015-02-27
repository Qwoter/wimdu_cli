require "lib/store"

class Place
  attr_accessor :params

  ATTRIBUTES = ['Title', 'title',
     'Property Type', 'property_type',
     'Address', 'address',
     'Nightly Rate', 'nightly_rate',
     'Max Guests', 'max_guests',
     'Email', 'email',
     'Phone Number', 'phone_number']

  def initialize(empty_record = true)
    if empty_record
      code = (('A'..'Z').to_a + (0..9).to_a).shuffle[0,8].join
      @params ||= { 'code' => code,
                    'title' => '',
                    'property_type' => '',
                    'address' => '',
                    'nightly_rate' => '',
                    'max_guests' => '',
                    'email' => '',
                    'phone_number' => '' }

      puts "Starting with new property #{code}."

      self.continue
    else
      @params = {}
    end
  end

  def update
    $store.update(@params)
  end

  def show
    ATTRIBUTES.each_slice(2) do |description, element|
      puts "#{description}: #{@params[element]}"
    end
  end

  def edit
    #TODO edit Place almost the same as continue
  end

  def continue
    ATTRIBUTES.each_slice(2) do |description, element|
      if @params[element].empty?
        print "#{description}: "
        input = STDIN.gets
        #TODO check for errors

        @params[element] = input
        self.update
      else
        puts "#{description}: #{@params[element]}"

        next
      end
    end
  end

  class << self
    def list(all = false)
      places = $store.get_all(all)

      if places.empty?
        puts "No properties found."
      else
        offer = places.size == 1 ? "offer" : "offers"
        puts "Found #{places.size} #{offer}."
        places.each { |place| puts "#{place['code']}: #{place['title']}" }
      end
    end

    def find(code)
      place = Place.new(false)
      place.params = $store.get(code)
      place
    end

    def delete(code)
      if $store.delete(code)
        puts "Successfully deleted place with code: #{code}"
      else
        puts "Couldn't delete place with code: #{code}"
      end
    end
  end
end
