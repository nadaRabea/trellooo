Rails.application.routes.draw do
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    mount_devise_token_auth_for 'User', at: 'auth'  

    get 'users' => 'users#index' 

    resources :lists do
      member do
        post 'assign_member'
        post 'unassign_member'
      end
      resources :cards      
    end   
  end
end
