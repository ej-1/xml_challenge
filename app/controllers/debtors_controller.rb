class DebtorsController < ApplicationController
  before_action :set_debtor, only: [:show]

  def index
    @debtors = Debtor.all # just doing this in challenge, otherwise use i.e. pagination.
  end

  def show
  end

  private

    def set_debtor
      @debtor = Debtor.find(params[:id])
    end

    def debtor_params
      params.fetch(:debtor, {})
    end
end
