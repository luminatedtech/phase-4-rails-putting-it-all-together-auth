class RecipesController < ApplicationController
    def index 
        user = User.find_by(id: session[:user_id])
            if user
             recipes = user.recipes
             render json: recipes, include: :user
             else 
             render json: {errors: ["Not authorized"]}, status: :unauthorized
         end 
    end 
    def create
        user = User.find_by(id: session[:user_id])
        if session[:user_id]
            recipe = user.recipes.create(recipe_params)
            if recipe.valid? && session[:user_id] = recipe.user.id
                render json: recipe, include: :user, status: :created
            elsif !recipe.valid?
                render json: {errors: ["Not a recipe"]}, status: :unprocessable_entity
            end 
        else 
            render json: {errors:["Not logged in"]}, status: :unauthorized
        end 
    end 
private
def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete, :user_id)
end 
end
