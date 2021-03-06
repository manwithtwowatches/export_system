class Panel::RolesController < ApplicationController

  def index
    @roles = Role.all
    @new_role = Role.new
  end

  def create
    Role.create params[:role]
    redisplay_roles
  end

  def destroy
    Role.find(params[:id]).destroy
    redisplay_roles
  end

  private

  def redisplay_roles
    respond_to do |format|
      format.html { redirect_to panel_roles_path }
      format.js {
        @roles = Role.all
        render :redisplay_roles
      }
    end
  end
end
