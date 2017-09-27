Rails.application.routes.draw do
  get '/arenas/quiz'
  get '/leaderboard/quiz', to: 'leaderboards#quiz'
  get '/leaderboard/category', to: 'leaderboards#category'
  get '/leaderboard/subcategory', to: 'leaderboards#subcategory'
  root 'welcome#index'
  get  '/about',    to: 'welcome#about'
  get  '/home',     to: 'welcome#index'
  get  '/help',     to: 'welcome#help'
  get  '/login',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  get  '/signup',   to: 'users#new'
  get  '/dashboard', to: 'dashboard#index'
  get "/auth/google_oauth2/callback", to: "sessions#create"
  get "/result", to: 'arenas#result'
  get "/play", to: 'arenas#quiz'
  post "/reset", to: 'answers#reset'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  resources :sessions
  resources :categories
  resources :subcategories
  resources :quizzes
  resources :questions
  resources :arenas
  resources :answers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#home'
end
