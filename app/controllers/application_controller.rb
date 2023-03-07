# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ResTemplate
  skip_before_action :verify_authenticity_token

  def short_url(code)
    root_url.to_s + code
  end
end
