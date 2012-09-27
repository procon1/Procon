require 'parts'
class Robot
  INIT_LIFE = 1000000

  attr_accessor :id, :life, :offence, :deffence, :durability, :size, :buhin_ids

  # 親クラスから仕様書を複数受け取り、1つずつ(中身を)Partsクラスに投げる
  def create(specifications)
    parts = specifications.map do |specification|
      open("#{specification}") do |s|
        Parts.new(s)
      end
    end
    assign_attrs(parts)
  end

  def assign_attrs(parts)
    sum_atk = 0
    sum_of_squares_weight = 0
    sum_weight = 0
    size = 0
    deff = Array.new
    dur  = Array.new
    offence = 0
    deffence = 0
    # 部品値の計算
    parts.each do |p|
      sum_atk += p.atk
      sum_of_squares_weight += p.weight ** 2
      sum_weight += p.weight
      deff << p.deff
      dur  << p.dur
      size += p.size
    end
    offence = sum_atk - sum_of_squares_weight
    deffence = deff.min + 10 * sum_weight
    if create?(size, offence)
      self.id = 'hoge'
      self.life = INIT_LIFE
      self.offence = offence
      self.deffence = deffence
      self.durability = dur.min
      self.size = size
      self.buhin_ids = parts.map{|p| p.id}.join(',')
    end
    self
  end

  def create?(size, offence)
    size <= 100 && offence > 0
  end

end
