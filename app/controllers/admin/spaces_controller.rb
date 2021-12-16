class Admin::SpacesController < ApplicationController
  def index
    @space = Space.new
    @spaces = Space.all
  end

  def show
  end

  def edit
    @space = Space.find(params[:id])
  end

  def new
  end
  
  def create
    @space = Space.all
    @space = Space.new(space_params)
    @space.save
    redirect_to admin_spaces_path
  end
  
  
  def update
    @space = Space.find(params[:id])
    @space.update(space_params)
    redirect_to admin_spaces_path
  end

  private

  def space_params
    params.require(:space).permit(:name, :introduction )
  end
  
end
