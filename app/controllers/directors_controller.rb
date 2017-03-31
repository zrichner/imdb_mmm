class DirectorsController < ApplicationController
  def index
    @directors = Director.all

    render("directors/index.html.erb")
  end

  def show
    @director = Director.find(params[:id])

    render("directors/show.html.erb")
  end

  def new
    @director = Director.new

    render("directors/new.html.erb")
  end

  def create
    @director = Director.new

    @director.names = params[:names]
    @director.image = params[:image]
    @director.movie_id = params[:movie_id]

    save_status = @director.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/directors/new", "/create_director"
        redirect_to("/directors")
      else
        redirect_back(:fallback_location => "/", :notice => "Director created successfully.")
      end
    else
      render("directors/new.html.erb")
    end
  end

  def edit
    @director = Director.find(params[:id])

    render("directors/edit.html.erb")
  end

  def update
    @director = Director.find(params[:id])

    @director.names = params[:names]
    @director.image = params[:image]
    @director.movie_id = params[:movie_id]

    save_status = @director.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/directors/#{@director.id}/edit", "/update_director"
        redirect_to("/directors/#{@director.id}", :notice => "Director updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Director updated successfully.")
      end
    else
      render("directors/edit.html.erb")
    end
  end

  def destroy
    @director = Director.find(params[:id])

    @director.destroy

    if URI(request.referer).path == "/directors/#{@director.id}"
      redirect_to("/", :notice => "Director deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Director deleted.")
    end
  end
end
