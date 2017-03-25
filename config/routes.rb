Rails.application.routes.draw do
  resources :cards, except: [:destroy]
  root 'static#home'
end
