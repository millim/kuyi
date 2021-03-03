Rails.application.routes.draw do
  root 'home#index'

  resources :home do
    get 'line_items', on: :member
  end

end
