# encoding: utf-8

module Rango
  class ORM
    class DataMapper
      class << self
        def models
          ObjectSpace.classes.map do |klass|
            klass.included(DataMapper::Resource)
          end
        end
      end
    end
  end
end
