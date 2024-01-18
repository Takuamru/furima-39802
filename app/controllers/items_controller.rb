class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]


  def index
    @items = Item.all.order(created_at: :desc)  # 作成日時で並び替えた商品を取得
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user  # 現在のユーザーを@itemに割り当てる
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end
  

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to item_path(@item)
    end
  end  

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :shipping_fee_id, :shipping_area_id, :shipping_day_id, :image)
  end

  def redirect_if_not_owner
    redirect_to root_path unless current_user.id == @item.user_id
  end
end