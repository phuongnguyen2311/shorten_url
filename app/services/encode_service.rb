# frozen_string_literal: false

class EncodeService < ServiceBase
  def initialize(url)
    @url = url
  end

  def execute!
    code = generate_code
    old_url = Url.find_by(short_url: code)
    return old_url if old_url

    data_url = Url.new(original_url: url, short_url: code)
    data_url.sanitize
    if data_url.save
      RedisCP.set(code, url)
      return data_url
    end
    false
  end

  private

  attr_reader :url

  def generate_code
    id = url.hash.abs
    code = ''

    return BASE62[0] if id == 0

    while id > 0
      code << BASE62[id % BASE]
      id /= BASE
    end
    code.reverse
  end
end
