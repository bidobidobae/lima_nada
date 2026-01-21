class Admin::BookkeepingsController < ApplicationController
  before_action :set_bookkeeping, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :require_admin

  def require_admin
    redirect_to root_path, alert: "Not authorized" unless current_user.admin?
  end

  # GET /bookkeepings or /bookkeepings.json
  def index
    if params[:month]
      begin
        @month = Date.strptime(params[:month], "%Y-%m") # aman untuk input seperti "2025-06"
      rescue ArgumentError
        @month = Date.today.beginning_of_month
        flash.now[:alert] = "Format bulan tidak valid, menampilkan bulan ini."
      end
    else
      @month = Date.today.beginning_of_month
    end

    @bookkeepings = Bookkeeping.where(date: @month.all_month).order(date: :desc)
  end

  # GET /bookkeepings/1 or /bookkeepings/1.json
  def show
  end

  # GET /bookkeepings/new
  def new
    @bookkeeping = Bookkeeping.new
  end

  # GET /bookkeepings/1/edit
  def edit
  end

  # POST /bookkeepings or /bookkeepings.json
  def create
    @bookkeeping = Bookkeeping.new(bookkeeping_params)
    @bookkeeping.user = current_user
    if @bookkeeping.save
      redirect_to admin_bookkeeping_path(@bookkeeping), notice: 'Data saved'
    else
      render :new
    end
  end

  # PATCH/PUT /bookkeepings/1 or /bookkeepings/1.json
  def update
    respond_to do |format|
      if @bookkeeping.update(bookkeeping_params)
        format.html { redirect_to admin_bookkeeping_path(@bookkeeping), notice: "Bookkeeping was successfully updated." }
        format.json { render :show, status: :ok, location: @bookkeeping }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bookkeeping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookkeepings/1 or /bookkeepings/1.json
  def destroy
    @bookkeeping.destroy!

    respond_to do |format|
      format.html { redirect_to admin_bookkeepings_path, status: :see_other, notice: "Bookkeeping was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookkeeping
      @bookkeeping = Bookkeeping.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bookkeeping_params
      params.require(:bookkeeping).permit(:date, :amount, :status, :category, :description, :user_id, :salary_id, :invoice_id)
    end
end
