# frozen_string_literal: true

class ApplicationController < ActionController::Base
    add_flash_types :danger
    include SessionHelper
  
    before_action :require_login
  
    private
  
    def require_login
      unless signed_in?
        flash[:danger] = 'Требуется логин'
        redirect_to root_path
      end
    end
  end
  