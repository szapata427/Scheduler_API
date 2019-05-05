class AppointmentsController < ApplicationController

    def index 
        @schedule = Schedule.find(params[:schedule_id])
        @all_appointments = @schedule.appointments.all
        render json: @all_appointments

    end

    def create
        @schedule = Schedule.find(params[:schedule_id])
        if appointment_params[:start_time] > appointment_params[:end_time]
            render json: {message: "start time is greater than end time, check your times ", data: appointment_params}
        else
            times_booked = []
            @all_appointments = @schedule.appointments.all
            @all_appointments.each do |app|
                times = (app.start_time..app.end_time).to_a
                times.each do |time|
                times_booked << time
                end 
            end
            byebug
                if times_booked.exclude? appointment_params[:start_time] and times_booked.exclude? appointment_params[:end_time]
                    @appointment = @schedule.appointments.create(appointment_params)
                    render json: {status:"Success", message: "Appointment has been created", data:@appointment}, status: :ok
                else
                    render json: {status:"Error", message: "Appointment slot is not available", data:@appointment}
                end
        
        end
        
    
    end

    def destroy 
        @schedule = Schedule.find(params[:schedule_id])
        byebug
        @appointment = @schedule.appointments.find(params[:id])
        @appointment.destroy
        
        render json: {status:"Success", message: "Appointment destoryed for schedule", data:@appointment}, status: :ok
       
    end

    private 
    def appointment_params
        params.require(:appointment).permit(:name, :start_time, :end_time, :schedule_id)
    end

end
