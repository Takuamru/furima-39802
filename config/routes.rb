Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  # other routes...
end
