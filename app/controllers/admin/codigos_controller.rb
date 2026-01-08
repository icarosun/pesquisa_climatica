class Admin::CodigosController < ApplicationController
  before_action :authorize_admin!

  def index
    @codigos = Codigo.order_by(created_at: :desc)
  end

  def create 
    quantidade = params[:quantidade].to_i
    quantidade = 1 if quantidade <= 0

    Codigo.gerar(quantidade)

    redirect_to admin_codigos_path(token: params[:token]), notice: "Códgios gerados com sucesso"
  end

  private

  def authorize_admin!
    token = params[:token] || request.headers["X-ADMIN-TOKEN"]

    unless token.present? && token == ENV["ADMIN_TOKEN"]
      render plain: "Não autorizado", status: :unauthorized
    end
  end
end
