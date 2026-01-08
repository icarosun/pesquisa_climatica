require "test_helper"

class RespostaTest < ActiveSupport::TestCase
  let(:params) do
    ActionController::Parameters.new(
      codigo: "abc1234",
      respostas: {"1" => "1", "2" => "2", "3" => "3"},
      comentario_final: "ok",
    )
  end

  test "Create successfull response" do
    array_repostas = FormularioController.respostas_array
    resposta = Resposta.new(params).call
    expect(resposta).to_be_persisted
    expect(resposta.respostas).to_eq([1, 2, 3])
  end

  test "Reject response out of range" do
    params[:respostas]["1"] = "5"

    expect {
      Resposta.new(params).call
    }.to_raise_error("Resposta inválida")
  end
end
