class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity


  def index
render json: Student.all, :include => [:instructor]
  end

  def show
student = Student.find(params[:id])
render json: student
  end

def create
  student = Student.create!(permitted_params)
  render json: student, status: :created
end

def update
student = Student.find(params[:id])
student.update!(permitted_params)

render json: student, status: 200
end

def destroy
student = Student.find(params[:id])
student.destroy
head :no_content
end



private

def permitted_params
params.permit(:name, :age, :major)
end


def record_not_found
render json: {error: "404 NOT FOUND"}
end

 def render_unprocessable_entity(exp)
  render json: {error: exp.record.errors}, status: 422
 end



end
