# frozen_string_literal: true

class V1::DecodesController < ApplicationController
  def create
    data = DecodeService.new(params[:url]).execute!
    if data
      return render json: success(
        'Decode url sucess',
        original_url: data
      )
    end
    render json: error('Decode url fail')
  end
end
