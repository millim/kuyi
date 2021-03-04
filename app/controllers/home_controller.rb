class HomeController < ApplicationController
  def index
    @contracts = Contract.all
    @invoices = Invoice.all
  end

  def new
    @contract = Contract.new
  end

  def show
    @renting_phases = Contract.find(params[:id]).renting_phases.order(:contract_index)
  end

  def line_items
    @line_items = Invoice.find(params[:id]).line_items
  end

  def auto_job
    if params[:select_date].present?
      Job.generate_invoice Date.parse(params[:select_date])
    end
    redirect_to home_index_path
  end

  def create
    @contract = Contract.new(contract_params)
    return render :new unless @contract.save

    redirect_to home_index_path
  end

  private


  def contract_params
    params.require(:contract).permit(:user_name, :price, :begin_date, :end_date, :cycle)
  end

end
