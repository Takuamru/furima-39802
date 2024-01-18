Rails.application.routes.draw do
  devise_for :users
  root "items#index"

  resources :items do
    # 必要に応じて、さらにネストされたルートやカスタムルートをここに追加
  end
end
