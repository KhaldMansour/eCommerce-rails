class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :products

  # GET /products
  # GET /products.json
  def index
    current_user = User.find_by_id(session[:current_user_id])

    # @products = Product.all
    @products = Product.order(:name).page(params[:page]).per(10)
    # authorize! :manage, @products

  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])


  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    
  end

  # POST /products
  # POST /products.json
  def create
    # @current_user = User.find_by_id(session[:user_id])


    authorize! :manage, @product

    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save

        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :description, :category_id, :store_id,
                                    :brand_id, :price, :stock_quantity, {avatars: []})
  end
end
