Rails.application.routes.draw do
  get '/debtors/:id', to: 'debtors#show', as: 'debtor_path'
  get '/debtors', to: 'debtors#index', as: 'debtors_path'
end
