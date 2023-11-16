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
      render :new
    end
  end

  # Action pour afficher les détails d'une liste spécifique
  def show
    @list = List.find(params[:id])
  end

  private

  # Méthode privée pour définir les paramètres autorisés lors de la création d'une liste
  def list_params
    params.require(:list).permit(:name)
  end
end
