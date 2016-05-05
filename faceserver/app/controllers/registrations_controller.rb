class RegistrationsController < DeviseTokenAuth::RegistrationsController

  def create
    # byebug
    super do |resource|
      Profile.create(:user =>resource)
    end
  end
end