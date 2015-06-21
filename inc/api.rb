require_relative 'pagevars'
module API
  def API.a()
    return "200 API online. Version: #{Pagevars.setVars("CIbuild")}"
  end
end
