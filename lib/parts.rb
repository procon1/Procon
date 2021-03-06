require 'formula'
class Parts

  attr_accessor :id, :atk, :deff, :dur, :weight, :size

  # 仕様書1つの中身をRobotクラスから受け取り、それを解釈して返す
  def initialize(specification)
    array = specification.map {|s| Formula.calc(s.chomp)}
    self.id     = array[0]
    self.atk    = array[1]
    self.deff   = array[2]
    self.dur    = array[3]
    self.weight = array[4]
    self.size   = array[5]
    self
  end

end
