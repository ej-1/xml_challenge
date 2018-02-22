Rails.application.routes.draw do
  get '/debtors/:id', to: 'debtors#show', as: 'debtors_path'
  get '/debtors', to: 'debtors#index', as: 'debtor_path'
end
