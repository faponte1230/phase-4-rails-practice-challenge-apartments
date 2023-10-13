class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = find_lease
        lease.destroy
        head :no_content
    end
    
    private

    def find_lease
        Lease.find(params[:id])
    end

    def lease_params
        params.permit(:rent)
    end

end
