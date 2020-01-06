Rails.application.routes.draw do
  resources :datasets do
    resources :datafiles
  end
end
