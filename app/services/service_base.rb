# frozen_string_literal: true

class ServiceBase
  include ActiveSupport::Concern
  extend ActiveModel::Callbacks

  BASE62 = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').freeze
  BASE = BASE62.length

  define_model_callbacks :execute, only: %I[before]

  before_execute :before

  class << self
    def execute!(*args, &block)
      new.execute!(*args, &block)
    end
  end

  def execute!(*_args)
    raise NotImplementedError
  end

  private

  def before; end

  def logger
    @logger ||= Logger.new(path_to_log_file)
  end

  def path_to_log_file
    Rails.root.join('log', "#{service_tmp_working_name}.log")
  end

  def service_tmp_working_name
    self.class.name.underscore.gsub('/', '-')
  end

  def with_error_logger(args: nil, start_log: false)
    logger.info({ class: self.class.name, args: args }.to_json) if start_log
    yield if block_given?
  rescue e
    log_error(e, args)
    raise e
  end

  def log_error(e, args = nil)
    if e
      logger.error(e.message)
      logger.error(e.backtrace.to_a.join("\n"))
    end
    logger.error({ args: args }.to_json)
  end
end
