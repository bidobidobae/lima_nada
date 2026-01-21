class AttendancesController < ApplicationController
  before_action :set_student
  before_action :set_attendance

  def edit
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@attendance, partial: "attendances/form", locals: { attendance: @attendance, student: @student }) }
      format.html { render :edit }

    end
  end

  def update
    if @attendance.update(attendance_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@attendance, partial: "attendances/attendance", locals: { attendance: @attendance, student: @student }) }
        format.html { redirect_to student_path(@student), notice: "Attendance updated successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@attendance, partial: "attendances/form", locals: { attendance: @attendance, student: @student }) }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end

  def set_attendance
    @attendance = @student.attendances.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:status, :user_id)
  end
end

