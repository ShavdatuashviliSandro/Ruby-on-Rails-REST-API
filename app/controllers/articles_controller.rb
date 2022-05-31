class ArticlesController < ApplicationController
  def index
    articles = Article.recent
    paginated = paginator.call(
      articles,
      params: pagination_params,
      base_url: request.url
    )
    options = {meta: paginated.meta.to_h, links: paginated.links.to_h}
    render json: serializer.new(paginated.items), status: 200
  end

  def show
    article = Article.find(params[:id])
    render json: serializer.new(article)
  rescue ActiveRecord::RecordNotFound => e
    render json: {message: e.message, detail: 'some message here'}
  end

  def serializer
    ArticleSerializer
  end

  def paginator
    JSOM::Pagination::Paginator.new
  end

  def pagination_params
    params.permit![:page]
  end
end
