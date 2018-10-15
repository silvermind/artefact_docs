# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #  frame sidebar
  get 'sidebar', to: 'frames#sidebar'
  get 'home', to: 'frames#home'

  #  master frame
  root 'frames#main_index'
end
