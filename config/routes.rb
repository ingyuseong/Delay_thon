Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'posts/:id/confirm' => 'posts#confirm', as: 'confirm'
  get 'posts/:id/confirm2' => 'posts#confirm2', as: 'confirm2'

  root "posts#index"
  post '/tinymce_assets' => 'tinymce_assets#create'
  get '/posts/:id/likes' => 'posts#likes', as: 'like'
  get 'search' => "posts#search", as: 'search'
end
