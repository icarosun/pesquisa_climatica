class HomeController < ApplicationController
  def new 
  end

  def create
    codigo = Codigo.find_by(codigo: params[:codigo], utilizado: false)

    if codigo
      redirect_to "/formulario?codigo=#{codigo.codigo}"
    else
      redirect_to root_path, alert: "Código inválido ou já utilizado"
    end
  end
end
