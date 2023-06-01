class UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id 
            render json: user, status: :created
        else 
            render json: {errors: ["Not a valid user"] }, status: :unprocessable_entity
        end 
    end 
    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: :created
        else 
            render json: {errors: ["Not logged in"]}, status: :unauthorized
        end 
    end 

private
def user_params
    params.permit(:username, :bio, :image_url, :password, :password_confirmation)
end 
end

