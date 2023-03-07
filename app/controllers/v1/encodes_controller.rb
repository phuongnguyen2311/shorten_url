# frozen_string_literal: false

class V1::EncodesController < ApplicationController
  def create
    data = EncodeService.new(params[:url]).execute!
    if data
      return render json: success(
        'Encode url sucess',
        short_url: short_url(data.short_url)
      )
    end
    render json: error('Encode url fail')
  end
end
