# encoding: utf-8

require "rack/mock"

class Factory
  class << self
    def rack_env(environment = Hash.new)
      {"PATH_INFO" => "/blog/post/a-slug", "REQUEST_METHOD" => "GET"}.merge(environment)
    end

    def request
      Rango::Request.new(self.rack_env)
    end

    def controller
      controller = Rango::Controller.new
      controller.request
      controller.params
      return controller
    end
  end
end
