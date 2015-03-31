class CompaniesController < ApplicationController
  respond_to :html

  expose(:company, attributes: :company_params)
  expose(:companies) { Company.page(params[:page]) }

  def create
    flash[:notice] = 'Company was successfully created.' if company.save
    Service.find_or_create_by(company_id: company.id, provider_id: params[:company][:provider_id])
    respond_with(company)
  end

  def update
    flash[:notice] = 'Company was successfully updated.' if company.save
    Service.find_or_create_by(company_id: company.id, provider_id: params[:company][:provider_id])
    respond_with(company)
  end

  def destroy
    company.destroy
    respond_with(company)
  end

  private

  def company_params
    params.require(:company).permit(:belongs_to, :name, :address, :phone_number, :provider_id, :lat, :lng)
  end
end
