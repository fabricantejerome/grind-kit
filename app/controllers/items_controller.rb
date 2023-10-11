class ItemsController < ApplicationController
	def add
		@item = Item.new
		@categories = Category.all
	end

	def create
		@item = Item.new(item_params)

        if @item.save
            redirect_to item_add_path, notice: "Successfully created item"
        else
            render :add, status: :unprocessable_entity
        end
	end

	private

	def item_params
		params.require(:item).permit(:name, :category_id, :description, :is_available, :sold_by, :price, :cost, :sku, :barcode, :is_track, :stock, :low_stock, :user_id)
	end
end
