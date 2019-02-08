require 'rails_helper'
require 'faraday'

describe 'Blocking Users on Admin/Api routes' do

  context "/admin/api/v1/tutorial_sequencer/:tutorial_id" do
    it 'raises 404 routing if not admin' do
      # user = create(:user)
      tutorial = create(:tutorial)
      create(:video, tutorial: tutorial, position: 1)
      create(:video, tutorial: tutorial, position: 2)
      create(:video, tutorial: tutorial, position: 3)
      allow_any_instance_of(Admin::Api::V1::BaseController).to receive_message_chain(:current_user, :admin?) { false }

      VCR.use_cassette("http://localhost:3000/admin/api/v1/tutorial_sequencer/1") do
        conn = Faraday.new(url: "http://localhost:3000/admin/api/v1/") do |faraday|
          faraday.adapter  Faraday.default_adapter
        end
        response = conn.put "tutorial_sequencer/#{tutorial.id}"
        expect(response.status).to eq(404)
        expect(response.success?).to be_falsy
        response = response.to_hash
        expect(response[:reason_phrase]).to eq("Not Found")
      end
    end
    xit "does'nt raise error if current_admin", vcr: {record: :all } do
      tutorial = create(:tutorial)
      create(:video, tutorial: tutorial, position: 1)
      create(:video, tutorial: tutorial, position: 2)
      create(:video, tutorial: tutorial, position: 3)
      allow_any_instance_of(Admin::Api::V1::BaseController).to receive_message_chain(:current_user, :admin?) { true }

      VCR.use_cassette("http://localhost:3000/admin/api/v1/tutorial_sequencer/1") do
        conn = Faraday.new(url: "http://localhost:3000/admin/api/v1/") do |faraday|
          faraday.adapter  Faraday.default_adapter
        end
        response = conn.put "tutorial_sequencer/#{tutorial.id}"
        expect(response.status).to eq(404)
        response = response.to_hash
        expect(response[:reason_phrase]).to eq("Not Found")
      end
    end
  end
end
