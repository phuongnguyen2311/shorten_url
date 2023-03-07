# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :find_url, only: %i[show shortened]
  def index
    @url = Url.new
  end

  def show
    redirect_to @url.sanitize_url
  end

  def create
    @url = Url.new shortened_url_params
    @url.sanitize
    if @url.new_url?
      @url.generate_short_url
      @url.sanitize
      if @url.save
        redirect_to "/shortened/#{@url.short_url}"
      else
        flash.now[:error] = 'Check the errors below'
        render :index
      end
    else
      flash.now[:notice] = 'A short link for this URL is existed!'
      redirect_to "/shortened/#{@url.find_duplicate.short_url}"
    end
  end

  def shortened
    @original_url = @url.sanitize_url
    @short_url = root_url.to_s + @url.short_url
  end

  private

  def find_url
    @url = Url.find_by_short_url params[:short_url]
  end

  def shortened_url_params
    params.require(:url).permit :original_url
  end
end
