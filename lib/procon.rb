class Procon
  attr_accessor :name
  attr_accessor :hp

  def initialize(name, hp)
    @name = name
    @hp   = hp
  end

  def self.infix_to_postfix(infix_array)
    plus_minus = ['+', '-']
    function = ['f', 'g']
    atmark = ['@']
    output = Array.new
    ope_stack = Array.new
    infix_array.each do |token|
      if token == '('
        # 左括弧が見つかったらスタックへ覚えておく
        ope_stack.push(token)
      elsif token == ')'
        # 右括弧が見つかったら、
        # 左括弧が見つかるまでスタックから取り出して出力
        while ope_stack.any? do
          ope = ope_stack.pop
          break if ope == '('
          output << ope
        end
      elsif function.include?(token)
        # fとgが見つかったら、
        # fとgが見つかるうちはスタックから取り出して出力してから、
        # スタックへ覚えておく
        while ope_stack.any? && function.include?(ope_stack.last) do
          ope = ope_stack.pop
          output << ope
        end
        ope_stack.push(token)
      elsif atmark.include?(token)
        # @が見つかったら、
        # @が見つかるうちはスタックから取り出して出力してから、
        # スタックへ覚えておく
        while ope_stack.any? && atmark.include?(ope_stack.last) do
          ope = ope_stack.pop
          output << ope
        end
        ope_stack.push(token)
      elsif plus_minus.include?(token)
        # ＋と－が見つかったら、
        # ＋と－と×と／が見つかるうちはスタックから取り出して出力してから、
        # スタックへ覚えておく
        while ope_stack.any? && (plus_minus + function + atmark).include?(ope_stack.last) do
          ope = ope_stack.pop
          output << ope
        end
        ope_stack.push(token)
      #elsif /(\-{0,1}\d+)/ =~ token
      elsif /\d+/ =~ token
        # 数値はそのまま出力
        output << token
      else
        printf "LINE#{__LINE__}: token error [#{token}] \n"
        raise "error #{token}"
      end
    end
    # スタックから全て取り出して出力
    while ope_stack.any? do
      output << ope_stack.pop
    end
    output
  end
end


#a_atk  = 50
#b_deff = 100
#
#def damage(atk, deff)
#  if deff >= atk
#    [atk - deff + 500, 1].max
#  else
#    3 * (atk - deff) + 500
#  end
#end
#
#def calc_attack(atk, weight)
#  atk - weight ** 2
#end
#
#def calc_deffence(deff, weight)
#  deff + 10 * weight
#end
#
#def calc_endurance(endurance)
#  endurance.min
#end
#
#p damage(a_atk, b_deff)
#p calc_attack(a_atk, b_deff)
#p calc_deffence(b_deff, 10)
#p calc_endurance([10, 20, 10, 30])
