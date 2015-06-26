require_relative 'pagevars'
module API
  def API.a()
    return "200 API online. Version: #{Pagevars.setVars("CIbuild")}"
  end
  def API.aNotifications(uname)
    return "[ { 'title' : '#{uname}', 'msg' : 'Notification API is online.', 'type' : 'info' } ]"
  end
end
