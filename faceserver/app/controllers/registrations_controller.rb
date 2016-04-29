class RegistrationsController < Devise::RegistrationsController
  private

  # Overwriting the sign_out redirect path method

  def after_sign_up_path_for(user)
    p = Profile.create(:user =>user)
    edit_profile_path p
    # byebug
  end
end