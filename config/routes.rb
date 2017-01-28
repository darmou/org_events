Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  namespace :api, :defaults => { :format => :json } do
    namespace :v1 do
      resources :organizations
      resources :events,   controller: 'events' do
        collection do
          post :create
          get :index
          #get :events_for_organization
          #get :groups_for_cards
        end
      end
    end
  end

end
