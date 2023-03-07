# frozen_string_literal: false

require 'rails_helper'

describe V1::EncodesController, type: :request do
  def action(path, params)
    post path, params: params
  end

  describe '#create', type: :request do
    let(:path) { '/v1/encode' }
    let(:params) do
      {
        url: 'https://rubygems.org/gems/connection_pool/versions/2.2.1'
      }
    end

    context 'URL exist' do
      before do
        action(path, params)
      end

      it 'should return shorten url' do
        expect(JSON.parse(response.body)['data']['short_url']).not_to be_empty
      end
    end
  end
end
