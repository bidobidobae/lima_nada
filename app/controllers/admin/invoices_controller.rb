class Admin::InvoicesController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :set_invoice, only: %i[ show edit update destroy pdf ]
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create, :edit, :update, :destroy]

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1 or /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = current_user.invoices.build(invoice_params.except(:user_id))

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to admin_invoice_path(@invoice), notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to admin_invoice_path(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to admin_invoices_path, status: :see_other, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def pdf
    pdf = Prawn::Document.new
    pdf.text "Invoice Pembayaran", size: 20, style: :bold
    pdf.move_down 10
    pdf.text "Kode Invoice: #INV-#{@invoice.id.to_s.rjust(5,'0')}"
    pdf.text "Tanggal Dibuat: #{@invoice.created_at.to_date.strftime('%d %B %Y')}"
    pdf.move_down 20

    # Info Siswa
    pdf.text "Informasi Siswa", style: :bold
    pdf.move_down 5
    data = [
      ["Nama Siswa", @invoice.student.name],
      ["Nama Orangtua", @invoice.student.parent_name],
      ["Contact", @invoice.student.contact_person],
      ["Alamat", @invoice.student.address.presence || "-"]
    ]
    pdf.table(data, column_widths: [150, 350], cell_style: { borders: [] })
    pdf.move_down 20

    # Rincian Pertemuan
    pdf.text "Rincian Pertemuan", style: :bold
    pdf.move_down 5
    meetings = @invoice.meeting_dates.compact.map.with_index do |date, i|
      ["Pertemuan ke-#{i+1}", date.strftime('%d %B %Y')]
    end
    pdf.table(meetings, column_widths: [150, 350])

    pdf.move_down 20
    # Total
    pdf.text "Jumlah Tagihan: Rp. #{number_with_delimiter(@invoice.amount, delimiter: '.', separator: ',')}", style: :bold

    send_data pdf.render, filename: "invoice-#{@invoice.id}.pdf", type: "application/pdf", disposition: "inline"
  end

  private

    def check_admin
      unless current_user&.admin?
        redirect_to admin_invoices_path, alert: "Access denied!"
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:student_id, :meeting_date_1, :meeting_date_2, :meeting_date_3, :meeting_date_4, :amount, :status)
    end
end
