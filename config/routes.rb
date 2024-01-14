Rails.application.routes.draw do
  devise_for :users
  root "items#index"  # ルートパスをitemsコントローラーのindexアクションに設定

  resources :items, only: [:index, :new, :create, :show] do
    # 必要に応じて、さらにネストされたルートやカスタムルートをここに追加
  end
end
