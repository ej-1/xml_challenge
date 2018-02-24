Rails.application.routes.draw do
  get '/debtors/:id', to: 'debtors#show', as: 'debtor'
  get '/debtors', to: 'debtors#index', as: 'debtors'
end
