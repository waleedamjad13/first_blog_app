class SessionsController < ApplicationController

    def new

    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "You have successfully Logged In"
            redirect_to user_path(user)
        else
            flash.now[:danger] = "There is something wrong with your provided information"
            render 'new'
        end
        
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You have successfully looged in"
        redirect_to root_path
    end
end