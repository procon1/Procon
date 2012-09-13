require 'robot'

class Procon
  def hoge
    robots = create_robots
    winner_robots = fight(robots)
  end

  def create_robots
    robots = []
    siyousyo.each do |a|
      r = Robot.new.create(a)
      robots << r if r.id 
    end
    robots
  end

  # 与えられた部品仕様書群を元にロボットの仕様書を作成
  # 戻り値：ロボット仕様書の配列
  # 　⇒１つの配列要素＝１ロボット分の仕様書
  #
  # TODO 要修正
  # 読み込むfileの格納フォルダのパス
  def siyousyo
    specifications = Dir.glob("/home/awatanabe21/Procon1/spec/file2/*")
    file_count = specifications.count
    siyousyo = []
    for i in 1..file_count
      siyousyo << specifications.combination(i).to_a
    end
    siyousyo.flatten(1)
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
