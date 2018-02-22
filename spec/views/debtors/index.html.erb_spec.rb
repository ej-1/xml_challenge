require 'rails_helper'

RSpec.describe "debtors/index", type: :view do
  before(:each) do
    assign(:debtors, [
      Debtor.create!(),
      Debtor.create!()
    ])
  end

  it "renders a list of debtors" do
    render
  end
end
