require "yaml/store"

$store = YAML::Store.new('place.yml')

def $store.get(code)
  transaction(true) do
    self['places'] ||= []
    self['places'].select{ |place| place if place["code"] == code }.sample
  end
end

def $store.get_all(all = false)
  transaction(true) do
    self['places'] ||= []

    if all
      self['places']
    else
      self['places'].reject { |place| place.has_value?("") }
    end
  end
end

def $store.update(new_place)
  transaction do
    $store['places'] ||= []
    $store['places'].delete_if { |place| place["code"] == new_place["code"] }
    $store['places'].push(new_place)
  end
end

def $store.delete(code)
  transaction do
    result = false
    $store['places'] ||= []
    $store['places'].delete_if do |place|
      if place["code"] == code
        result = true
        true
      else
        false
      end
    end

    result
  end
end
