class ProvidersController < ApplicationController
  respond_to :html

  expose(:provider, attributes: :provider_params)
  expose(:providers) { Provider.page(params[:page]) }

  def create
    flash[:notice] = 'Provider was successfully created.' if provider.save
    respond_with(provider)
  end

  def update
    flash[:notice] = 'Provider was successfully updated.' if provider.save
    respond_with(provider)
  end

  def destroy
    provider.destroy
    respond_with(provider)
  end

  private

  def provider_params
    params.require(:provider).permit(:industry, :name, :logo)
  end
end
