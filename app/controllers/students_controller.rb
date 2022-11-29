class StudentsController < ApplicationController

rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
    students = Student.all
    render json: students 
    end

    def create
    student = Student.create!(student_params)
    render json: student, status: :created
    end

    def update
    student = find
    student.update!(student_params)
    render json: student
    end

    def destroy
    student = find
    student.destroy
    head :no_content
    end
    
    private

    def find
        Student.find(params[:id])
    end

    def student_params
        params.permit (:name)
    end

    def render_unprocessable_entity_response (invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response
        render json: {error: "Id not found" }, status: :not_found
    end

end
