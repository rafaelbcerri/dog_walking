class RegistrationsController < Devise::RegistrationsController
  wrap_parameters :user, include: [:email, :password, :name]
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.role = Role.find_by_name(params['role']) if params['role']

    resource.save

    if resource.errors.empty?
      render json: resource, status: :created
    else
      render json: {
        error: resource.errors.messages
      }, status: :bad_request
    end
  end
end