class DecodeService < ServiceBase
  def initialize(url)
    @code = url.split('/').last
  end

  def execute!
    url = RedisCP.get(code)
    return url if url

    url = Url.find_by(short_url: code)
    return url.original_url if url

    false
  end

  private

  attr_reader :code
end
