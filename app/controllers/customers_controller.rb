class CustomersController < ApplicationController

  before_action do
    verify_user_is_a? :customer
  end
  before_action :set_professions, only: [:index]
  before_action :search_user, only: [:index]

  def index

  end

  private

  def set_professions
    @professions = Profession.all
  end

  def search_user
    return @workers = [] unless params[:search].present?
    @workers = User.search_by_profession(params[:search]).includes(:professions)
  end

end
