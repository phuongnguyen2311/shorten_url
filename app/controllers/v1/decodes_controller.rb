# frozen_string_literal: true

class V1::DecodesController < ApplicationController
  def create
    return render json: error('url is required') if params[:url].blank?
    data = DecodeService.new(params[:url]).execute!
    if data
      return render json: success(
        'Decode url success',
        original_url: data
      )
    end
    render json: error('Decode url fail')
  end
end
