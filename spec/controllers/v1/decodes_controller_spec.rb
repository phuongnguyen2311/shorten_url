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

    context 'When url is blank' do
      params = {
        url: ''
      }
      before do
        action(path, params)
      end

      it 'should return code 500' do 
        expect(JSON.parse(response.body)['code']).to eq(500)
      end

      it 'should return message error' do
        expect(JSON.parse(response.body)['message']).to eq('url is required')
      end

      it 'should return empty data' do
        expect(JSON.parse(response.body)['data']).to eq({})
      end
    end

    context 'When url is valid' do
      before do
        action(path, params)
      end

      it 'should return code 200' do 
        expect(JSON.parse(response.body)['code']).to eq(200)
      end

      it 'should return message success' do
        expect(JSON.parse(response.body)['message']).to eq('Decode url success')
      end

      it 'should return has data original_url url' do
        expect(JSON.parse(response.body)['data']['original_url']).not_to be_empty
      end
    end

    context 'When url is wrong' do
      params = {
        url: 'http://localhost:4000/27Z2'
      }
      before do
        action(path, params)
      end

      it 'should return code 500' do 
        expect(JSON.parse(response.body)['code']).to eq(500)
      end

      it 'should return message error' do
        expect(JSON.parse(response.body)['message']).to eq('Decode url fail')
      end

      it 'should return original_url is empty' do
        expect(JSON.parse(response.body)['data']).to be_empty
      end
    end
  end
end
