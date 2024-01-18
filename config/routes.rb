Rails.application.routes.draw do
  devise_for :users
  root "items#index"

  resources :items, only: [:index, :new, :create, :show, :edit, :update] do
    # 必要に応じて、さらにネストされたルートやカスタムルートをここに追加
  end
end
