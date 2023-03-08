# frozen_string_literal: false

class V1::EncodesController < ApplicationController
  def create
    return render json: error('url is required') if params[:url].blank?
    data = EncodeService.new(params[:url]).execute!
    if data
      return render json: success(
        'Encode url success',
        short_url: short_url(data.short_url)
      )
    end
    render json: error('Encode url fail')
  end
end
