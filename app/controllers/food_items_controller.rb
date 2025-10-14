class FoodItemsController < ApplicationController
  before_action :set_food_item, only: [:show, :edit, :update, :destroy, :update_status]

  def index
    @food_items = FoodItem.includes(:food)

    # Filter by status
    if params[:status].present?
      @food_items = @food_items.where(status: params[:status])
    end

    # Filter by category
    if params[:category].present?
      @food_items = @food_items.joins(:food).where(foods: { category: params[:category] })
    end

    # Filter by expiry
    if params[:expiry_filter].present?
      today = Date.today
      case params[:expiry_filter]
      when 'expired'
        @food_items = @food_items.where('expiration_date < ?', today)
      when 'expiring_soon'
        @food_items = @food_items.where('expiration_date >= ? AND expiration_date <= ?', today, today + 3.days)
      when 'expiring_week'
        @food_items = @food_items.where('expiration_date >= ? AND expiration_date <= ?', today, today + 7.days)
      when 'fresh'
        @food_items = @food_items.where('expiration_date > ?', today + 7.days)
      end
    end

    # Sort
    case params[:sort]
    when 'expiration_date'
      @food_items = @food_items.order(:expiration_date)
    when 'name'
      @food_items = @food_items.order(:name)
    when 'purchase_date'
      @food_items = @food_items.order(purchase_date: :desc)
    else
      @food_items = @food_items.order(:expiration_date)
    end
  end

  def show
  end

  def new
    @food_item = FoodItem.new
  end

  def create
    # Find or create the Food record
    food = Food.find_or_create_by(name: params[:food_name]) do |f|
      f.category = params[:food_category]
    end

    # If food already exists but category was changed, update it
    if food.persisted? && params[:food_category].present?
      food.update(category: params[:food_category])
    end

    @food_item = FoodItem.new(food_item_params)
    @food_item.food = food

    # If no specific name provided, use the food name
    @food_item.name = params[:food_name] if @food_item.name.blank?

    if @food_item.save
      redirect_to @food_item, notice: 'Food item was successfully created.'
    else
      @food_name = params[:food_name]
      @food_category = params[:food_category]
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Find or create the Food record
    food = Food.find_or_create_by(name: params[:food_name]) do |f|
      f.category = params[:food_category]
    end

    # If food already exists but category was changed, update it
    if food.persisted? && params[:food_category].present?
      food.update(category: params[:food_category])
    end

    @food_item.food = food

    # If no specific name provided, use the food name
    food_item_params_hash = food_item_params.to_h
    food_item_params_hash[:name] = params[:food_name] if food_item_params_hash[:name].blank?

    if @food_item.update(food_item_params_hash)
      redirect_to @food_item, notice: 'Food item was successfully updated.'
    else
      @food_name = params[:food_name]
      @food_category = params[:food_category]
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @food_item.destroy
    redirect_to food_items_url, notice: 'Food item was successfully deleted.'
  end

  def update_status
    if @food_item.update(status: params[:status])
      respond_to do |format|
        format.html { redirect_to food_items_url, notice: 'Status was successfully updated.' }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to food_items_url, alert: 'Failed to update status.' }
        format.json { head :unprocessable_entity }
      end
    end
  end

  private

  def set_food_item
    @food_item = FoodItem.find(params[:id])
  end

  def food_item_params
    params.require(:food_item).permit(:food_id, :name, :quantity, :unit, :storage_location, :status, :expiration_date, :purchase_date, :cost, :notes)
  end
end
