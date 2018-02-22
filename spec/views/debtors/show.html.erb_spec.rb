require 'rails_helper'

RSpec.describe "debtors/show", type: :view do
  before(:each) do
    @debtor = assign(:debtor, Debtor.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
