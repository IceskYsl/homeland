# coding: utf-8  
class HomeController < ApplicationController
  before_filter :require_no_user, :only => [:login, :login_create]
  before_filter :require_user, :only => :logout
  
  
  def index
    if !fragment_exist? "home/last_topics"
      @last_topics = Topic.recents.limit(10)
    end
    if !fragment_exist? "home/actived_topics"
      @actived_topics = Topic.last_actived.limit(10)
    end
  end
  
  def login
    @user_session = UserSession.new
  end
  
  def login_create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_back_or_default root_path
    else
      render :action => :login
    end
  end
  
  def logout
    current_user_session.destroy
    redirect_back_or_default root_path
  end
end
