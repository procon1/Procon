class Formula

  def self.convert_infix_notation(formula)
    ret = []
    temp = ""
    formula.split(//)

    formula.each do |f|
      if f =~ /\d/
        temp = temp + f
      else
        ret.push(temp)
        ret.push(f)
        temp = ""
      end
    end
    if temp != ""
      ret.push(temp)
    end
    ret
  end

  def self.convert_reverse_polish_notation(infix)
    plus_minus = ['+', '-']
    function = ['f', 'g']
    atmark = ['@']
    output = Array.new
    ope_stack = Array.new
    infix.each do |token|
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
    output.flatten
  end

  def self.pop_operation(ope_stack, operations)
    ret = []
    while ope_stack.any? && operations.include?(ope_stack.last) do ret << ope_stack.pop end
    ret
  end

  def self.calc_reverse_polish_notation(reverse_polish)
    stack = Array.new
    reverse_polish.each do |token|
      case token
      when '+'
        stack.push(stack.pop + stack.pop)
      when '-' 
        stack.push(-(stack.pop - stack.pop))
      when '@'
        stack.push((stack.pop + stack.pop) * 2)
      when 'f'
        stack.push(stack.pop * 2)
      when 'g'
        stack.push(stack.pop / 2)
      else
        stack.push(token.to_i)
      end
    end
    stack.pop
  end

  def self.calc(formula)
    infix = convert_infix_notation(formula)
    reverse_polish = convert_reverse_polish_notation(infix)
    calc_reverse_polish_notation(reverse_polish)
  end
end
