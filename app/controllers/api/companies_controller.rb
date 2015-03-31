class Api::CompaniesController < ApplicationController

	def index
    @companies = Company.all.includes(:user)
  end

end