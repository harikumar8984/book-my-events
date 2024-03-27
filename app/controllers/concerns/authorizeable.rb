module Authorizeable
  extend ActiveSupport::Concern

  included do
    before_action :authorize_user!, only: %i[edit update]
  end

  private

  def authorize_user!
    return if current_user == @event.user

    redirect_to events_path, alert: 'You are not authorized to perform this action.'
  end
end
