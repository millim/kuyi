Rails.application.routes.draw do
  root 'home#index'

  resources :home do
    post 'auto_job', on: :collection
    get 'line_items', on: :member
  end

end
