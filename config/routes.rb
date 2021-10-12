Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/patients', to: 'patients#index'
  get '/patients/:id', to: 'patients#show'
  post '/patients/new', to: 'patients#new'
  delete '/patients/:id', to: 'patients#delete'
  patch 'patients/:id', to: 'patients#update'
  
  get '/identifications/:id/id_image', to: 'identifications#get_id_image'
  post '/identifications/:id/upload', to: 'identifications#upload'
  get '/identifications', to: 'identifications#index'
  get '/identifications/:id', to: 'identifications#show'
  post '/identifications/new', to: 'identifications#new'
  delete '/identifications/:id', to: 'identifications#delete'
  patch '/identifications/:id', to: 'identifications#update'
end
