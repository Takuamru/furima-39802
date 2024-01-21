Rails.application.routes.draw do
  devise_for :users
  
  #ログアウトリンクのメソッドがGETになってしまうための措置
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  #ログアウトリンクのメソッドがGETになってしまうための措置
  
  root "items#index"

  resources :items do
    resource :purchases, only: [:new, :create]
  end
end
