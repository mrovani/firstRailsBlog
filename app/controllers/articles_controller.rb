class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

def index
  @articles = Article.all
end


# SHOW ACTION FOR ARTICLE
  def show
    @article = Article.find(params[:id])
  end

# Added Article.new below otherwise @article would be nil in "view" and calling article.errors.any? in app/views/articles/new.html.erb would throw an error.
  def new
    @article = Article.new
  end

# Add an edit action to allow user to edit an article.
  def edit
    @article = Article.find(params[:id])
  end

# CREATE ACTION FOR ARTICLE
  def create
    # Create a new article in memory (RAM)
    @article = Article.new(article_params)
    # Saves it to the database making it permanent until deleted
    if @article.save
    # Redirects the article to "show" action for the @article
    redirect_to @article
    else
    render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

# ESTABLISHES A PRIVATE SESSION FOR PARAMETERS THAT CAN'T BE MODIFIED IN THE DOM

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
