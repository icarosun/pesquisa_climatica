class HomeController < ApplicationController
  def new 
  end

  def create
    codigo_param = params[:codigo].to_s.strip

    if codigo_param.blank?
      redirect_to root_path, alert: "Informe um código válido"
      return
    end

    codigo = Codigo.where(codigo: codigo_param, utilizado: false).first

    if codigo
      puts "Variável código: #{codigo.inspect}"
      redirect_to new_formulario_path(codigo: codigo.codigo)
    else
      puts "Variável código: #{codigo.inspect}"
      redirect_to root_path, alert: "Código inválido ou já utilizado"
    end
  end
end
