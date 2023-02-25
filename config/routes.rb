Rails.application.routes.draw do
  root 'photos#index'
  patch 'croppable/:id', to: 'photos#croppable', as: 'croppable'
  resources :photos
end
