class PosController < ApplicationController
    def index
    end

    def transact
        @trans1 = params[:transaction]
        @trans1[:user_id] = Current.user.id
        @transaction_details = params[:transaction_details]

        @transaction_details.each do |item|
            item.delete(:name)
            item.permit!
        end

        @trans1.permit!
        
        if @transaction_details.empty?
            exit
        end

        @trans = Transaction.new(@trans1)

        if @trans.save
            @trans.transaction_details.create! (@transaction_details)
            render json: @trans.to_json
        end
    end

    def sales
        @transaction_details = TransactionDetail.all
    end
end
