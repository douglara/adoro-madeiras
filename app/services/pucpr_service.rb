class PucprService
  include HTTParty

  def get_notes(user)
    response = HTTParty.get('https://portal.pucpr.br/vda/pages/consultanotas/consultanotas.seam', headers: {"Cookie" => user.cookies} )
    parsed_data = Nokogiri::HTML.parse(response.body)
    {result: true, body: parsed_data.xpath('//*[@id="consultaNotasAlunoForm:idTableProgramasAprendizagemAluno"]').to_s }
  end

end