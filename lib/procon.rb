require 'robot'

class Procon
  def hoge
    robots = create_robots
    winner_robots = fight(robots)
  end

  def create_robots
    specifications = [Dir.glob("#{File.dirname(__FILE__)}/file/*")]
    # specificationsからいくつかを組み合わせた仕様書群をrobotクラスに投げる
    Robot.new.create(siyousyo)
  end

  def fight(robots)
  end

end

def damage(atk, deff)
  if deff >= atk
    [atk - deff + 500, 1].max
  else
    3 * (atk - deff) + 500
  end
end

def calc_attack(atk, weight)
  atk - weight ** 2
end

def calc_deffence(deff, weight)
  deff + 10 * weight
end

def calc_endurance(endurance)
  endurance.min
end

#
#p damage(a_atk, b_deff)
#p calc_attack(a_atk, b_deff)
#p calc_deffence(b_deff, 10)
#p calc_endurance([10, 20, 10, 30])
