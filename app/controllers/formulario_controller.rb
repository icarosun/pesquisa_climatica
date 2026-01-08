class FormularioController < ApplicationController
  def new
    @codigo = params[:codigo]
  end
end
