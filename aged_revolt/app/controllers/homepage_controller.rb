class HomepageController < Spree::BaseController
  
  resource_controller
  helper :taxons
  helper :products
  
  def index
    render :layout => "spree_application"
  end
  
  def storeloc
  end
  
  def faq
  end
  
  def about
  end

  def size_charts
  end
  
  def shipping
  end

  def contact
  end

end
