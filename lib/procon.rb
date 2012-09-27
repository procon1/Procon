require 'robot'

class Procon

#FILES = "/home/atogo1/work/Procon/spec/file2/*"
FILES = "/home/awatanabe21/Procon1/spec/file2/*"

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
  def siyousyo
    specifications = Dir.glob("#{Procon::FILES}")
    file_count = specifications.count
    siyousyo = []
    for i in 1..file_count
      siyousyo << specifications.combination(i).to_a
    end
    siyousyo.flatten(1)
  end
end

p Procon.new.create_robots

