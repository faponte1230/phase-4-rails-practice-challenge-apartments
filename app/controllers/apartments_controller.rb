class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        apartments = Apartment.all
        render json: apartments
    end
    
    def show
        apartment = find_apt
        render json: apartment
    end

    def create
        apartment = Apartment.create!(apt_params)
        render json: apartment, status: :created
    end

    def update
        apartment = find_apt
        apartment.update(apt_params)
        render json: apartment
    end

    def destroy
        apartment = find_apt
        apartment.destroy
        head :no_content
    end

    private

    def find_apt
        Apartment.find(params[:id])
    end

    def apt_params
        params.permit(:number)
    end

    def render_not_found_response
        render json: {error: "Apartment not found"}, status: :not_found 
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity 
    end

end
