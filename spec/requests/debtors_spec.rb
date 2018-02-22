require 'rails_helper'

RSpec.describe "Debtors", type: :request do
  describe "GET /debtors" do
    it "works! (now write some real specs)" do
      get debtors_path
      expect(response).to have_http_status(200)
    end
  end
end
