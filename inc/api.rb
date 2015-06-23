require_relative 'pagevars'
module API
  def API.a()
    return "200 API online. Version: #{Pagevars.setVars("CIbuild")}"
  end
  def API.aNotifications(uname)
    return "<info><item type=\"info\" title=\"#{uname}\">Notification API is online.</item></info>"
  end
end
