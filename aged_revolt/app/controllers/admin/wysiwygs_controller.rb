class Admin::WysiwygsController < Admin::BaseController
  def index
  end
  
  def new
    if Wysiwyg.find_by_name(params[:name]) != nil
      redirect_to edit_admin_wysiwyg_path(Wysiwyg.find_by_name(params[:name]))
    else
      @wysiwyg = Wysiwyg.new(:name => params[:name])
    end
  end
  
  def show
    @img = Image.find(params[:hidden_field][:value])
    @img.destroy
    respond_to do |format|
      format.html { redirect_to admin_image_rotator_path }
    end
  end

  def edit
    @wysiwyg = Wysiwyg.find(params[:id])
  end
  
  def create
    @wysiwyg = Wysiwyg.new(params[:wysiwyg])
    if @wysiwyg.save
      redirect_to edit_admin_wysiwyg_path(@wysiwyg.id)
    else
      redirect_to admin_wysiwygs_path
    end
  end
  
  def update
    @wysiwyg = Wysiwyg.find(params[:id])
    
    if @wysiwyg.update_attributes(params[:wysiwyg])
      redirect_to edit_admin_wysiwyg_path(@wysiwyg.id)
    else
      redirect_to admin_wysiwygs_path
    end
  end
  
  #def image_rotator
  #  @images = Image.all.select{|i|i.viewable_type == "homepage"}
  #  @image = Image.new
  #end
  
  #def destroy_image(image)
  #  debugger
  #  @img = Image.find(image)
  #  @img.destroy
  #  respond_to do |format|
  #    format.html { redirect_to admin_image_rotator_path }
  #  end
  #end
  
  
end



