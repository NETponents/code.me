module Levels
  def Levels.getLevelName(lnum)
    lnum = lnum.to_i
    if lnum == 0
      return 'Unknown'
    elsif lnum == 1
      return 'Hello World!'
    elsif lnum == 2
      return 'Modder'
    elsif lnum == 3
      return 'Coffee Intern'
    elsif lnum == 4
      return 'Tutorial Reader'
    elsif lnum == 5
      return 'Google-fu Master'
    elsif lnum == 6
      return 'CS101 Sensei'
    elsif lnum == 7
      return 'Commit Factory'
    else
      return 'Ultimate Coder'
    end
  end
  def Levels.getLevelFromPoints(points)
    points = points.to_i
    if points >= 0 and points < 100
      return 1
    elsif points >= 100 and points < 200
      return 2
    elsif points >= 200 and points < 400
      return 3
    elsif points >= 400 and points < 800
      return 4
    elsif points >= 800 and points < 1600
      return 5
    elsif points >= 1600 and points < 3200
      return 6
    elsif points >= 3200 and points < 6400
      return 7
    elsif points >= 6400
      return 8
    else
      return 0
    end
  end
end
