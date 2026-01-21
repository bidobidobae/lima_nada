  class Admin::SalariesController < ApplicationController
    before_action :authenticate_user!
    before_action -> { redirect_to root_path unless current_user.admin? }
    before_action :set_salary, only: [:show, :edit, :update, :destroy]

    def index
      if params[:month]
        begin
          @month = Date.strptime(params[:month], "%Y-%m") # input: "2025-06"
        rescue ArgumentError
          @month = Date.today.beginning_of_month
          flash.now[:alert] = "Format bulan tidak valid, menampilkan bulan ini."
        end
      else
        @month = Date.today.beginning_of_month
      end

      @salaries = Salary.includes(:user)
        .where(month: @month.month, year: @month.year)
        .order(year: :desc, month: :desc)
    end


    def new
      @salary = Salary.new
    end

    def create
      existing = Salary.find_by(user_id: salary_params[:user_id], month: salary_params[:month], year: salary_params[:year])
      if existing
        redirect_to admin_salary_path(existing), alert: "Gaji untuk user ini pada bulan tersebut sudah tersedia."
        return
      end

      @salary = Salary.new(salary_params)

      @salary.total_amount if @salary.per_attendance?

      if @salary.save
        redirect_to admin_salary_path(@salary), notice: "Gaji berhasil dibuat."
      else
        render :new, status: :unprocessable_entity
      end
    end


    def show; end

    def edit; end

    def update
      if @salary.update(salary_params)
        if @salary.per_attendance?
          @salary.total_amount
          @salary.save
        end
        redirect_to admin_salary_path(@salary), notice: "Gaji berhasil diperbarui."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @salary.destroy
      redirect_to admin_salaries_path, notice: "Gaji dihapus."
    end

    private

    def set_salary
      @salary = Salary.find(params[:id])
    end

    def salary_params
      params.require(:salary).permit(:user_id, :salary_type, :amount, :month, :year, :status)
    end
  end
