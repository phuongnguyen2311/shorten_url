# frozen_string_literal: true

module ResTemplate
  def template(code, message, content = {}, messages = [])
    response = { code: code, message: message, data: content }
    response[:messages] = messages if messages.present?

    response
  end

  def success(message, content = {})
    template(200, message, content)
  end

  def error(message, content = {})
    template(500, message, content)
  end

  def self.errors(messages, content = {})
    template(500, messages.first, content, messages)
  end
end
