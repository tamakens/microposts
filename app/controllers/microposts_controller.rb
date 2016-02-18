class MicropostsController < ApplicationController
    before_action :logged_inuser, only:[:create]
    
    def create
        @microposts = current_user.microposts.build(microposts_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end
    
    private
    def microposts_params
        params.require(:micropost).permit(:content)
    end
end
