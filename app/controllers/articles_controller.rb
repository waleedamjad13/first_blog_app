class ArticlesController < ApplicationController

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(title: params[:article][:title], description: params[:article][:description]) #send data from new to other page
        if @article.save #it will save that article
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article) #then show that saved article to show path
        else
            render 'new'
        end  
    end

    def edit
        @article = Article.find(params[:id])
    end

    def show
        @article =  Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:success] = "Article wass successfully updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy!
        flash[:danger] = "Article was successfully deleted"
        redirect_to articles_path(@article)
    end

    private
    
        def article_params
            params.require(:article).permit(:title, :description)
        end
end