# frozen_string_literal: true

class Url < ApplicationRecord
  UNIQUE_ID_LENGTH = 6
  ORIGINAL_VALID_FORMAT = %r{\A(?:(?:http|https)://)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:/[-a-zA-Z0-9@,!:%_\+.~#?&//=]*)?\z}.freeze

  validates :original_url, presence: true, on: :create
  validates :original_url, format: { with: ORIGINAL_VALID_FORMAT }, if: :validate_original_url?
  # before_create :generate_short_url
  # before_create :sanitize

  def validate_original_url?
    original_url.present?
  end

  def generate_short_url
    url = [*('a'..'z'), *('A'..'Z'), *('0'..'9')].sample(UNIQUE_ID_LENGTH).join
    old_url = Url.where(short_url: url).last
    if old_url.present?
      generate_short_url
    else
      self.short_url = url
    end
  end

  def find_duplicate
    Url.find_by_sanitize_url sanitize_url
  end

  def new_url?
    find_duplicate.nil?
  end

  def sanitize
    original_url.strip!
    self.sanitize_url = original_url.downcase.gsub(%r{(https?://|(www\.))}, '')
    self.sanitize_url = "#{Settings.shorten.protocol}#{sanitize_url}"
  end
end
