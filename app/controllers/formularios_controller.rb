class FormulariosController < ApplicationController
  def new
    @codigo = params[:codigo]
    @perguntas = Pergunta.todas
  end

  def create
    respostas = params[:respostas]&.transform_values(&:to_i)
    codigo = params[:codigo]

    resposta = Resposta.new(
      codigo: codigo,
      respostas: respostas,
      comentario_final: params[:comentario_final]
    )

    if resposta.save
      Codigo.where(codigo: codigo).first.update(utilizado: true)
      redirect_to root_path, notice: "Pesquisa enviada com sucesso!"
    else
      redirect_to formulario_path(codigo: codigo),
                  alert: resposta.errors.full_messages.first
    end
  end

end
