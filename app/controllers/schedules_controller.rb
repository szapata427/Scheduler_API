class SchedulesController < ApplicationController

    def index 
        @schedules = Schedule.all
        render json: {status:"Success", message: "All Schedules", data:@schedules}, status: :ok
    end

    def show
        @schedule = Schedule.find(params[:id])
        render json: @schedule
    end

    def create
        byebug
        @schedule = Schedule.create(schedule_params)
        if @schedule.save
            render json: {status:"Success", message: "Schedule Saved", data:@schedule}, status: :ok
        else
            render json: {status: "Error", message: 'Schedule not saved', data:schedule.errors}, status: :unprocessable_entity
        end
    end

    def destroy 
        @schedule = Schedule.find(params[:id])
        @schedule.destory
        render json: {message: "Schedule Deleted", json: @schedule}
    end

    private 
    def schedule_params
        params.require(:schedule).permit(:name)
    end
end
