# frozen_string_literal: true

require 'rails_helper'

describe V1::DecodesController, type: :request do
  def action(path, params)
    post path, params: params
  end

  describe '#create', type: :request do
    let(:path) { '/v1/decode' }
    let(:params) do
      {
        url: 'http://localhost:4000/27Z2MQ0rjng'
      }
    end

    context 'URL exist' do
      before do
        action(path, params)
      end

      it 'should return origin url' do
        expect(JSON.parse(response.body)['data']['original_url']).to eq 'https://rubygems.org/gems/connection_pool/versions/2.2.1'
      end
    end
  end
end
