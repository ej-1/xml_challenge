require "rails_helper"

RSpec.describe DebtorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/debtors").to route_to("debtors#index")
    end

    it "routes to #new" do
      expect(:get => "/debtors/new").to route_to("debtors#new")
    end

    it "routes to #show" do
      expect(:get => "/debtors/1").to route_to("debtors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/debtors/1/edit").to route_to("debtors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/debtors").to route_to("debtors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/debtors/1").to route_to("debtors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/debtors/1").to route_to("debtors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/debtors/1").to route_to("debtors#destroy", :id => "1")
    end

  end
end
