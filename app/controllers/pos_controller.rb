class PosController < ApplicationController
    def index
    end

    def transact
        @transaction_details = params[:transaction_details]

        @transaction_details.each do |item|
            item.delete(:name)
            item.permit!
        end

        if @transaction_details.empty?
            exit
        end

        @trans = Transaction.new(trans_params)

        if @trans.save
            @trans.transaction_details.create! (@transaction_details)
            render json: @trans.to_json
        end
    end

    def sales
        @transaction_details = TransactionDetail.all
    end

    private

    def trans_params
        params[:transaction][:user_id] = Current.user.id
        params.require(:transaction).permit(:total_amount, :cash, :change, :is_void, :user_id)
    end
end
