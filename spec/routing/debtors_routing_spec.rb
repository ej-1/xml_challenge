require "rails_helper"

RSpec.describe DebtorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/debtors").to route_to("debtors#index")
    end

    it "routes to #show" do
      expect(:get => "/debtors/1").to route_to("debtors#show", :id => "1")
    end

  end
end
