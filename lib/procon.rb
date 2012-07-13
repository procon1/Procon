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
        ope_stack.push(token)
      elsif token == ')'
        while ope_stack.any? do
          ope = ope_stack.pop
          if ope == '('
            ope = ope_stack.pop
            (ope == 'f' || ope == 'g') ? output << ope : ope_stack << ope
            break
          end
          output << ope
        end
      elsif function.include?(token)
        output << pop_operation(ope_stack, function)
        ope_stack.push(token)
      elsif atmark.include?(token)
        output << pop_operation(ope_stack, atmark)
        ope_stack.push(token)
      elsif plus_minus.include?(token)
        output << pop_operation(ope_stack, (plus_minus + function + atmark))
        ope_stack.push(token)
      elsif /\d+/ =~ token
        output << token
      else
        printf "LINE#{__LINE__}: token error [#{token}] \n"
        raise "error #{token}"
      end
    end

    while ope_stack.any? do output << ope_stack.pop end
    output
  end

  def self.pop_operation(ope_stack, operations)
    ret = []
    while ope_stack.any? && operations.include?(ope_stack.last) do ret << ope_stack.pop end
    ret
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
