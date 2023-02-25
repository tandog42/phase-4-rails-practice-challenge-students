class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index 
    render json: Instructor.all
  end

  def show
    ins = Instructor.find(params[:id])
    render json: ins, status: 200
  end

  def create
    ins = Instructor.create!(permitted_params)
    render json: ins, status: :created
  end

  def update
ins = Instructor.find(params[:id])

ins.update!(permitted_params)
render json: ins, status: 200

  end

  def destroy
ins = Instructor.find(params[:id])
ins.destroy
head :no_content
  end




  private

def permitted_params
params.permit(:name)
end

def render_unprocessable_entity(exp)
render json: {error: exp.record.errors}, status: 422
end


  def render_not_found
render json: {error: "Not Found" }, status: 404
  end
end
