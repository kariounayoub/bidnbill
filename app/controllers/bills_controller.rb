class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  def index
    @bills = policy_scope(Bill).order(created_at: :desc)
  end

  def show
    authorize @bill
  end

  def new
    @bill = Bill.new
     authorize @bill
  end

  def edit
    authorize @bill
  end

  def create
    @bill = Bill.new(bill_params)
    @bill.client = current_user
    authorize @bill
    if @bill.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    authorize @bill
    if @bill.update(bill_params)
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def destroy
    authorize @bill
    @bill.destroy
    redirect_to bills_url
  end

  private
    def set_bill
      @bill = Bill.find(params[:id])
    end

    def bill_params
      params.require(:bill).permit(:user_id, :category, :current_provider, :address, :price)
    end
end
