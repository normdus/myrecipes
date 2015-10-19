class RecipesController < ApplicationController
  
  # all controller actions - must have specific controllers(recipe) object availble to use by the action
  
  #   index action 
  #   render views/recipes/index.html.erb  
  #   check routes(rake routes) - new route for recipes index is handled by:
  #   recipes GET    /recipes(.:format)          recipes#index
  def index
    # instance variable @recipe - Recipe(table) .find method to pass 
    # all rows from the table and passing to index view
    @recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
  end
  
  #   show action
  #   render views/recipes/show.html.erb  
  #   check routes(rake routes) - new route for recipes show is handled by:
  #   recipe GET    /recipes/:id(.:format)      recipes#show
  def show
    # instance variable @recipe - Recipe(table) .find method using 
    # params hash by id and passing to show view
    @recipe = Recipe.find(params[:id])
  end
  
  #   Note: *** The next two actions a tied together to complete NEW recipe ***
  
  #   render views/recipes/new.html.erb  (entry form)
  #   check routes(rake routes) - new route for recipes is handled by:
  #   new_recipe GET    /recipes/new(.:format)      recipes#new
  def new
    @recipe = Recipe.new
  end
  
  #   render views/recipes/create.html.erb  (submit entry form)
  #   check routes(rake routes) - create route for recipes is handled by:
  #   POST   /recipes(.:format)          recipes#create
  #   Strong Parameters: 
  def create
    @recipe = Recipe.new(recipe_params)
      @recipe.chef = Chef.find(2)
      
      if @recipe.save
        # shows a message when saved 
        flash[:success] = "Your recipe was created successfully!"
        # redirect - index page
        redirect_to recipes_path
      else
        render :new
      end
  end
  
  #   Note: *** The next two actions a tied together to complete EDIT recipe ***
  
  # render views/recipes/edit.html.erb  (edit form)
  #   check routes(rake routes) - edit route for recipes is handled by:
  #   edit_recipe GET    /recipes/:id/edit(.:format) recipes#edit
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
 
  # submit views/recipes/update.html.erb  (submit edit form)
  #   check routes(rake routes) - update route for recipes is handled by:
  #   new_recipe GET    /recipes/new(.:format)      recipes#new
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      #do something
      flash[:success] = "Your recipe was updated successfully"
      # redirect - show page - need the recipe object for the specific recipe
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  # like dislike system
  def like
    # instance variable = 
    @recipe = Recipe.find(params[:id])
    # set like to params like - url
    # hard code the chef until authentication created
    like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    # flash message
    if like.valid?
      flash[:success] = "Your selection was successful"
      # redirects to same page because this is available on index and show pages.
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      # redirects to same page because this is available on index and show pages.
      redirect_to :back
    end
  end
  
  # whitelist the fields: name, summary, description - strong parameters
  private

    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end

end