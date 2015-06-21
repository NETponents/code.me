module Dataconn
  def Dataconn.getUser(uname)
    userName = uname
    points = 1000
    imagePath = 'https://avatars3.githubusercontent.com/u/4678601?v=3&s=460'
    fullName = 'Code.me Mascot'
    geoLocation = 'United States'
    email = 'user@code.me'
    return "#{userName},#{points},#{imagePath},#{fullName},#{geoLocation},#{email}"
  end
end
