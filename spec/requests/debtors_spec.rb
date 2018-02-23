require 'rails_helper'

RSpec.describe "Debtors", type: :request do
  describe "GET /debtors" do
    it "works!" do
      get debtors_path
      expect(response).to have_http_status(200)
    end
  end
end
