# frozen_string_literal: true

module Drivers
  module Source
    class Factory
      def self.build(context, app, options = {})
        engine = detect_engine(app, context.node, options)
        raise StandardError, 'There is no supported Source driver for given configuration.' if engine.blank?
        engine.new(context, app, options)
      end

      def self.detect_engine(app, node, _options)
        Drivers::Source::Base.descendants.detect do |source_driver|
          t = source_driver.driver_type
          source_driver.allowed_engines.include?(
            app['app_source'].try(:[], 'type') || node['deploy'][app['shortname']][t].try(:[], 'type')
          )
        end
      end
    end
  end
end
