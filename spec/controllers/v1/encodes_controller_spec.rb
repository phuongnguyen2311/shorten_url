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
        expect(JSON.parse(response.body)['message']).to eq('Encode url success')
      end

      it 'should return has data shorten url' do
        expect(JSON.parse(response.body)['data']['short_url']).not_to be_empty
      end
    end

    context 'Concurrent requests' do
      it "does not create duplicate shorten link" do
        num_requests = 100
        threads = []
        num_requests.times do
          threads << Thread.new do
            action(path, params)
            expect(response).to be_successful
          end
        end
        threads.each(&:join)    
      end
    end
  end
end
