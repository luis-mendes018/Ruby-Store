class CategoriesController < ApplicationController
  layout "admin"
  def index
    @pagy, @categories = pagy(:offset, Category.order(:name))
  end

 def index
   categories = Category.order(:name)

   if params[:name].present?
     categories = categories.where("name ILIKE ?", "%#{params[:name]}%")
   end
   @pagy, @categories = pagy(:offset, categories)
 end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "Categoria criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
   @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
   @category = Category.find(params[:id])

   if @category.update(category_params)
     redirect_to category_path(@category), notice: "Categoria atualizada com sucesso."
   else
     render :edit, status: :unprocessable_entity
   end
  end

def destroy
  @category = Category.find(params[:id])

  @category.destroy

  redirect_to categories_path, notice: "Categoria excluída com sucesso."
end

  private

  def category_params
    params.expect(category: [ :name ])
  end
end
