# frozen_string_literal: true

class BaseDecorator < SimpleDelegator
  def initialize(model, context = {})
    super(model)
    context.each do |key, value|
      self.class.send(:attr_accessor, key)
      public_send("#{key}=", value)
    end
  end

  def model
    __getobj__
  end
end
