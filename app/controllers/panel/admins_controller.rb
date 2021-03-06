class Panel::AdminsController < ApplicationController
  before_filter :load_admin, :except=>[:index]

  
  def index
   
    if params[:approved] == "false"
      @admins = Admin.find_all_by_approved(false)
    else
      @admins = Admin.all
    end
  end

  def show
  end

  def get_role
  	role.try(:name)
  end


  def add_role
    role = Role.find_by_name params[:get_role]
    if role
      if @admin.roles.include?(role)
        flash[:error]= I18n.t("panel.roles.exists")
      else
    	 @admin.roles.push role
       flash[:success]= I18n.t("panel.roles.exists")
      end 
    end
    redisplay_roles
  end

  def delete_role
    @admin.roles.delete(Role.find params[:role])
    flash[:success]= I18n.t("panel.roles.exists")
    redisplay_roles
  end

  def set_approved
    @admin = Admin.find(params[:id])
    @admin.update_column :approved, params[:approved]
    render nothing: true
  end

  private

  def load_admin
    @admin = Admin.find params[:id]
  end

  def redisplay_roles
    respond_to do |format|
      format.html { redirect_to [:panel, @admin] }
      format.js { render :redisplay_roles }
    end
  end

  
end
