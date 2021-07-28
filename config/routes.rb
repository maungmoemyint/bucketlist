Rails.application.routes.draw do
  root to: 'home#index'

  get 'home/index'

  get 'styles/atoms'

  get 'styles/molecules'

  get 'styles/organisms'

  get 'ideas/index'

  get 'styleguide', to: 'styles#atoms'

  get 'complete/style/guide', to: 'styles#atoms'

  get 'ideas/new'

  post 'ideas/create'

  get '/ideas/:id/edit', to: 'ideas#edit', as: 'edit_idea'

  patch '/ideas/:id', to: 'ideas#update', as: 'idea'

  get 'account/ideas'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
