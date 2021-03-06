Rails.application.routes.draw do

  scope path_names: {edit: 'editar'} do
    scope path_names: {new: 'nova'} do

      resources :campanhas do
        resources :mensagens do
          member do
            get 'visualizada/:id_destinatario', action: 'visualizada', as: 'visualizada'
          end
        end
        member do
          post 'listas', action: :add_lista, as: :add_lista
          delete 'listas/:id_lista', action: :remove_lista, as: :remove_lista
        end
      end

      resources :listas, except: [:destroy] do
        member do
          post 'destinatarios', action: :add_destinatario, as: :add_destinatario
          delete 'destinatarios/:id_lista_destinatario', action: :remove_destinatario, as: :remove_destinatario
        end
      end
    end
    scope path_names: {new: 'novo'} do

      resources :destinatarios

      resources :usuarios

      resources :grupo_usuarios
    end
  end
  root 'index#index'

  get 'dados_pessoais' => 'index#dados_pessoais'

  post 'dados_pessoais' => 'index#salvar_dados_pessoais'

  get 'login' => 'index#login'

  post 'login' => 'index#logar'

  get 'logout', controller: 'index', action: 'logout', as: 'logout'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
