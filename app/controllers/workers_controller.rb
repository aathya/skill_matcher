class WorkersController < ApplicationController

  before_action do
    verify_user_is_a? :worker
  end
  before_action :set_profession_names, only: [:index]
  before_action :set_profession, only: [:create]
  before_action :set_worker_profession, only: [:destroy]

  def index
    @worker_professions = current_user.worker_professions.includes(:profession)
  end

  def create
    @worker_profession = current_user.worker_professions.create(profession: @profession)
    set_profession_names
  end

  def destroy
    @worker_profession.destroy
    set_profession_names
  end
  
  private

  def set_profession
    @profession = Profession.search_by_name(params[:profession_name])
    create_new_profession unless @profession.present?
  end

  def create_new_profession
    @profession = Profession.create(name: params[:profession_name])
  end

  def set_worker_profession
    @worker_profession = current_user.worker_professions.find_by(id: params[:id])
  end

  def set_profession_names
    @profession_names = Profession.where.not(id: current_user.worker_professions.pluck(:profession_id)).pluck(:name)
  end
end
