Rails.application.routes.draw do
  
  namespace :admin do
    resources :wysiwygs
  end
  
  match 'storeloc/', :to => "homepage#storeloc"
  match 'faq/', :to => "homepage#faq"
  match 'about/', :to => "homepage#about"
  match 'size_charts/', :to => "homepage#size_charts"
  match 'shipping/', :to => "homepage#shipping"
  
  root :to => 'homepage#index'
end
