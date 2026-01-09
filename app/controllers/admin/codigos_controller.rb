require 'csv'

class Admin::CodigosController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @codigos = Codigo.order_by(created_at: :desc)
  end

  def create 
    quantidade = params[:quantidade].to_i
    quantidade = 1 if quantidade <= 0

    Codigo.gerar(quantidade)

    redirect_to admin_codigos_path(token: params[:token]), notice: "Códigos gerados com sucesso"
  end

  def export_respostas
    @respostas = Resposta.all.order(created_at: :asc)

    if @respostas.empty?
      redirect_to admin_codigos_path, alert: "Não há respostas para exportar."
      return
    end

    csv_data = CSV.generate(headers: true) do |csv|
      perguntas_total = @respostas.first.respostas.size
      cabecalho = (1..perguntas_total).map { |i| "Q#{i.to_s.rjust(2, '0')}" }
      cabecalho += ["Comentário Final", "Criado em"]

      csv << cabecalho

      @respostas.each do |r| 
        linha = r.respostas.map(&:to_i)
        linha += [r.comentario_final, r.created_at.strftime("%d/%m/%y %H:%M")]
        csv << linha
      end
    end

    send_data csv_data, 
      filename: "respostas -#{Time.zone.now.strftime('%Y%m%d%H%M%S')}.csv",
      type: "text/csv"
  end
end
