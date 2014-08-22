HotList::Application.routes.draw do
  resources :lists
  resources :items
  match '/next_items(/:id)', to: "home#next_items", via: :get
  root "home#index"
end
