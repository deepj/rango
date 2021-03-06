# encoding: utf-8

module Rango
  class Router
    module Dispatcher
      class << self
        attr_accessor :router_adapter
        def included(klass)
          self.install_hook(klass)
        end

        def extended(object)
          self.install_hook(object.class)
        end

        def install_hook(klass)
          klass.send(:include, self.router_adapter)
        rescue TypeError
          raise TypeError, "You must set the Dispatcher.router_adapter first. For example Dispatcher.router_adapter = Rango::Router::RackRouter"
        end

        def route_to(env, app)
          Rango.logger.inspect("Routing request to #{app.inspect}")
          app.call(env)
        end
      end
    end
  end
end
