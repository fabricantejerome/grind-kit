class RegistrationsController < ApplicationController
	def new
		@user = User.new
	end

	def create
        @user = User.new(user_params)

        if @user.save
            redirect_to login_path, notice: "Successfully created account"
        else
            render :new, status: :unprocessable_entity
        end
    end

	private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :role, :branch, :store_name)
    end
end
