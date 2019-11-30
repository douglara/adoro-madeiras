class PucprService
  include HTTParty

  def get_notes(user)
    begin
      response = HTTParty.get('https://portal.pucpr.br/vda/pages/consultanotas/consultanotas.seam', headers: {"Cookie" => user.cookies} )
      parsed_data = Nokogiri::HTML.parse(response.body)
      result = parsed_data.xpath('//*[@id="consultaNotasAlunoForm:idTableProgramasAprendizagemAluno"]').to_s
      if (result != "")
        return {result: true, body: result }
      else
        return {result: false }
      end 
    rescue => exception
      return {result: false }
    end
  end

end