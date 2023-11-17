class ListsController < ApplicationController
  # Action pour afficher toutes les listes
  def index
    @lists = List.all
  end

  # Action pour afficher le formulaire de création d'une nouvelle liste
  def new
    @movies = Movie.all
    @list = List.new
  end

  # Action pour créer une nouvelle liste
  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to lists_path, notice: 'Liste créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Action pour afficher les détails d'une liste spécifique
  def show
    @list = List.find(params[:id])
    @movies = @list.movies
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path, status: :see_other
  end


  private

  # Méthode privée pour définir les paramètres autorisés lors de la création d'une liste
  def list_params
    params.require(:list).permit(:name, movie_ids: [])
  end
end
