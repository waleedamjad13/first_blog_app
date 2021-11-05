class ArticlesController < ApplicationController
    helper_method :current_user
    helper_method :logged_in?
    helper_method :require_user
    

    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def new
        @article = Article.new
    end

    def edit
    end


    def create
        @article = Article.new(article_params) #send data from new to other page
        @article.user = @current_user
        if @article.save #it will save that article
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article) #then show that saved article to show path
        else
            render 'new'
        end  
    end

    def update
        if @article.update(article_params)
            flash[:success] = "Article wass successfully updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def show
    end



    def destroy
        @article.destroy
        flash[:danger] = "Article was successfully deleted"
        redirect_to articles_path
    end



    private

        def article_params
            params.require(:article).permit(:title, :description)
        end

        def set_article
            @article = Article.find(params[:id])
        end
        
        def require_same_user
            if current_user != @article.user
                flash[:danger] = "You can edit or delete your own article"
                redirect_to root_path
            end
        end
    
end