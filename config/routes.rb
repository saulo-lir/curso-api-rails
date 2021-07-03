Rails.application.routes.draw do
  resources :kinds
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Separando as versões dos controllers em v1 e v2

  # Para acessar essa rota: http://localhost:3000/contacts?version=1
  scope module: 'v1' do
    resources :contacts, :constraints => lambda { |request| request.params[:version] == '1'} do
    end
  end

  # Para acessar essa rota: http://localhost:3000/contacts?version=2
  scope module: 'v2' do
    resources :contacts, :constraints => lambda { |request| request.params[:version] == '2'} do
    end
  end
end
