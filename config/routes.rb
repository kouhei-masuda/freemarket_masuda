Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
   }

  devise_scope :user do
    ## ↓登録方法の選択ページ
    get "users/select_registration", to: 'users/registrations#select', as: :select_registration
     ## ↓電話番号認証ページ
     get "users/confirm_phone", to: 'users/registrations#confirm_phone', as: :confirm_phone
     ## ↓addressの登録ページ
     get "users/regist_address", to: 'users/registrations#new_address', as: :new_regist_address
     ## ↓addressのcreate
     post "users/regist_address", to: 'users/registrations#create_address', as: :regist_address
     ## ↓cardの登録ページ
     get "users/regist_payment", to: 'users/registrations#new_payment', as: :new_regist_payment
     ## ↓登録完了ページ
     get "users/regist_completed", to: 'users/registrations#completed', as: :regist_completed
  end
  #root to: "items#index"

  

  resources :users, only: [:show] do
    collection do
      get "card"
      get "selling"
      get "selling_progress"
      get "sold"
      get "bought_progress"
      get "bought_past"
    end
  end

  resources :items  do
    member do
      get "purchase_confirmation"
      post "purchase"
    end
  end
  resources :categories, only: [:index, :show]
  resource :cards, only: [:new, :create, :show, :update, :destroy]

end
