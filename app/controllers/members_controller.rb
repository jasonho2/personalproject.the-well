class MembersController < ApplicationController
  protect_from_forgery with: :null_session # Allow external POSTs

  def create
    @member = Member.new(email: params[:email])
    if @member.save
      render json: { success: true }, status: :created
    else
      render json: { error: "Email already taken or invalid." }, status: :unprocessable_entity
    end
  end

  def index
    @members = Member.all
  end
end