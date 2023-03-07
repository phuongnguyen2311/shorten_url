# frozen_string_literal: true

require 'redis'
require 'connection_pool'

REDIS = ConnectionPool.new(size: 500) do
  Redis.new(
    host: Settings.redis.host,
    port: 6379,
    db: Settings.redis.db,
    driver: :hiredis
  )
end

class RedisCP
  class << self
    def redis
      REDIS
    end

    def run(method, opts = {})
      redis.with { |conn| conn.send(method, [opts[:key], opts[:val]].flatten) }
    end

    def get(key)
      redis.with { |conn| conn.get(key) }
    end

    def set(key, val, opts = {})
      redis.with { |conn| conn.set(key, val, opts) }
    end

    def keys(text)
      redis.with { |conn| conn.keys(text) }
    end

    def del(*key)
      redis.with { |conn| conn.del(*key) }
    end

    def mget(keys)
      redis.with { |conn| conn.mget(keys) }
    end

    def mapped_mset(keys)
      redis.with { |conn| conn.mapped_mset(keys) }
    end

    def exists(keys)
      redis.with { |conn| conn.exists(keys) }
    end
  end
end
