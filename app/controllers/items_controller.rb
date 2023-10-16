class ItemsController < ApplicationController
	def index
		@items = Item.all
	end

	def add
		@item = Item.new
		@categories = Category.all
	end

	def create
		@item = Item.new(item_params)
        @categories = Category.all

        if @item.save
            redirect_to items_path, notice: "Successfully created item"
        else
            render :add, status: :unprocessable_entity
        end
	end

	def edit
        @item = Item.find(params[:id])

		@categories = Category.all
    end

	def update
        @item = Item.find(params[:id])
        @categories = Category.all

        if @item.update(item_params)
            redirect_to items_path, notice: "Item was successfully updated."
        else
            render :add, status: :unprocessable_entity
        end
    end

	def destroy
        @item = Item.find(params[:id])

        @item.destroy

        redirect_to items_path, notice: "Successfully deleted item"
    end

	private

	def item_params
		params.require(:item).permit(:name, :category_id, :description, :is_available, :sold_by, :price, :cost, :sku, :barcode, :is_track, :stock, :low_stock, :user_id)
	end
end
