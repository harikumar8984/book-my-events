# frozen_string_literal: true

module Decorateable
  extend ActiveSupport::Concern

  def decorate
    @decorate ||= "#{self.class.name}Decorator".safe_constantize.new(self)
  end

  def method_missing(method_name, *args, &)
    if method_name.in?(decorate.class.instance_methods - Object.instance_methods)
      decorate.send(method_name, *args, &)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = true)
    method_name.to_s.in?(decorate.class.instance_methods - Object.instance_methods) || super
  end
end
