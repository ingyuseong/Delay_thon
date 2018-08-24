Rails.application.routes.draw do
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  post '/tinymce_assets' => 'tinymce_assets#create'
  get '/posts/:id/likes' => 'posts#likes', as: 'like'
  get 'search' => "posts#search", as: 'search'
end
