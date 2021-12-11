require 'rails_helper'

RSpec.describe 'Sports API', type: :request do
  describe 'GET /sports' do
    before { get '/sports' }

    it 'returns sports list' do
      expect(json).not_to be_empty
      expect(json.size).to eq(4)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /sports/:sport_id' do
    before { get "/sports/#{sport_id}" }

    context 'when the record exists' do
      let(:sport_id) { 100 }

      it 'returns events list' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:sport_id) { 200 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Not found/)
      end
    end
  end

  describe 'GET /sports/:sport_id/events/:event_id' do
    before { get "/sports/#{sport_id}/events/#{event_id}" }

    context 'when the record exists' do
      let(:sport_id) { 100 }
      let(:event_id) { 1627357600 }

      it 'returns outcomes list' do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the sport does not exist' do
      let(:sport_id) { 200 }
      let(:event_id) { 1627317700 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Not found/)
      end
    end

    context 'when the event does not exist' do
      let(:sport_id) { 100 }
      let(:event_id) { 7777 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Not found/)
      end
    end
  end
end