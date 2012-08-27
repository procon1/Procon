require 'rubygems'
require 'formula'

describe '#convert_infix_notation' do
  describe '数式を中置記法に変換する' do
    context 'カッコが無い場合' do
      context 'オペランドが1つの場合' do
        it '"1+1"は、"1 + 1"' do
          formula = '1+1'
          Formula.convert_infix_notation(formula).should eq(%w{1 + 1})
        end
        it '"10+1"は、"10 + 1"' do
          formula = '10+1'
          Formula.convert_infix_notation(formula).should eq(%w{10 + 1})
        end
        it '"1+10"は、"1 + 10"' do
          formula = '1+10'
          Formula.convert_infix_notation(formula).should eq(%w{1 + 10})
        end
        context 'カッコがある場合' do
          context 'カッコが1つの場合' do
            it '"f(2)"は、"f ( 2 )"' do
              formula = 'f(2)'
              Formula.convert_infix_notation(formula).should eq(%w{f ( 2 )})
            end
            it '"(1+2)@3"は、"( 1 + 2 ) @ 3"' do
              formula = '(1+2)@3'
              Formula.convert_infix_notation(formula).should eq(%w{( 1 + 2 ) @ 3})
            end
          end
          context 'カッコが複数の場合' do
            context 'カッコが独立している場合' do
              it '"(1+2)@(3+4)"は、""' do
                formula = '(1+2)@(3+4)'
                Formula.convert_infix_notation(formula).should eq(%w{( 1 + 2 ) @ ( 3 + 4 )})
              end
            end
            context 'カッコが入れ子の場合' do
              it '"((1+2)@3)@(4+5)"は、"( ( 1 + 2 ) @ 3 ) @ ( 4 + 5 )"' do
                formula = '((1+2)@3)@(4+5)'
                Formula.convert_infix_notation(formula).should eq(%w{( ( 1 + 2 ) @ 3 ) @ ( 4 + 5 )})
              end
            end
          end
        end
      end
    end
  end
end

describe '#convert_reverse_polish_notation' do
  describe '中置記法を後置記法に変換する' do
    context 'カッコが無い場合' do
      context 'オペランドが1つの場合' do
        it '"1 + 1"は、"11+"' do
          infix_array = %w{1 + 1}
          Formula.convert_reverse_polish_notation(infix_array).join.should eq('11+')
        end
      end
      context 'オペランドが2つの場合' do
        it '"1 + 3 - 2"は、"13+2-"' do
          infix_array = %w{1 + 3 - 2}
          Formula.convert_reverse_polish_notation(infix_array).join.should eq('13+2-')
        end
        it '"1 + 2 @ 3"は、"123@+"' do
          infix_array = %w{1 + 2 @ 3}
          Formula.convert_reverse_polish_notation(infix_array).join.should eq('123@+')
        end
        it '"3 @ 4 @ 2"は、"34@2@"' do
          infix_array = %w{3 @ 4 @ 2}
          Formula.convert_reverse_polish_notation(infix_array).join.should eq('34@2@')
        end
      end
    end
    context 'カッコがある場合' do
      context 'カッコが1つの場合' do
        it '"f(2)"は、"2f"' do
          infix_array = %w{f ( 2 )}
          Formula.convert_reverse_polish_notation(infix_array).join.should eq('2f')
        end
        it '"g(2)"は、"2g"' do
          infix_array = %w{g ( 2 )}
          Formula.convert_reverse_polish_notation(infix_array).join.should eq('2g')
        end
        it '"(1 + 2) @ 3"は、"12+3@"' do
          infix_array = %w{( 1 + 2 ) @ 3}
          Formula.convert_reverse_polish_notation(infix_array).join.should eq('12+3@')
        end
        it '"2 @ (1 + 3)"は、"213+@"' do
          infix_array = %w{2 @ ( 1 + 3 )}
          Formula.convert_reverse_polish_notation(infix_array).join.should eq('213+@')
        end
      end
      context 'カッコが複数の場合' do
        context 'カッコが独立している場合' do
          it '"(1 + 2) @ (3 + 4)"は、"12+34+@"' do
            infix_array = %w{( 1 + 2 ) @ ( 3 + 4 )}
            Formula.convert_reverse_polish_notation(infix_array).join.should eq('12+34+@')
          end
          it '"f(2) + g(2)"は、"2fg2+"' do
            infix_array = %w{f ( 2 ) + g ( 2 )}
            Formula.convert_reverse_polish_notation(infix_array).join.should eq('2f2g+')
          end
          it '"f(1@2) + g(2)"は、"12@fg2+"' do
            infix_array = %w{f ( 1 @ 2 ) + g ( 2 )}
            Formula.convert_reverse_polish_notation(infix_array).join.should eq('12@f2g+')
          end
        end
        context 'カッコが入れ子の場合' do
          it '"((1 + 2) @ 3) @ (4 + 5)"は、"12+3@45+@"' do
            infix_array = %w{( 1 + 2 ) @ 3 ) @ ( 4 + 5 )}
            Formula.convert_reverse_polish_notation(infix_array).join.should eq('12+3@45+@')
          end
          it '"f(f(1))"は、"1ff"' do
            infix_array = %w{f ( f ( 1 ) )}
            Formula.convert_reverse_polish_notation(infix_array).join.should eq('1ff')
          end
          it '"f(f(1)@g(1))"は、"1f1g@f"' do
            infix_array = %w{f ( f ( 1 ) @ g ( 1 ) )}
            Formula.convert_reverse_polish_notation(infix_array).join.should eq('1f1g@f')
          end
        end
      end
    end
  end
end

describe '#calc_reverse_polish_notation' do
  describe '後置記法を計算する' do
    context 'カッコが無い場合' do
      context 'オペランドが1つの場合' do
        it '"1 + 1"は、"2"' do
          reverse_polish_array = %w{1 1 +}
          Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(2)
        end
      end
      context 'オペランドが2つの場合' do
        it '"1 + 3 - 2"は、"2"' do
          reverse_polish_array = %w{1 3 + 2 -}
          Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(2)
        end
        it '"1 + 2 @ 3"は、"11"' do
          reverse_polish_array = %w{1 2 3 @ +}
          Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(11)
        end
        it '"3 @ 4 @ 2"は、"32"' do
          reverse_polish_array = %w{3 4 @ 2 @}
          Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(32)
        end
      end
    end
    context 'カッコがある場合' do
      context 'カッコが1つの場合' do
        it '"f(2)"は、"4"' do
          reverse_polish_array = %w{2 f}
          Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(4)
        end
        it '"g(2)"は、"1"' do
          reverse_polish_array = %w{2 g}
          Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(1)
        end
        it '"(1 + 2) @ 3"は、"12"' do
          reverse_polish_array = %w{1 2 + 3 @}
          Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(12)
        end
        it '"2 @ (1 + 3)"は、"12"' do
          reverse_polish_array = %w{2 1 3 + @}
          Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(12)
        end
      end
      context 'カッコが複数の場合' do
        context 'カッコが独立している場合' do
          it '"(1 + 2) @ (3 + 4)"は、"20"' do
            reverse_polish_array = %w{1 2 + 3 4 + @}
            Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(20)
          end
          it '"f(2) + g(2)"は、"5"' do
            reverse_polish_array = %w{2 f 2 g +}
            Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(5)
          end
          it '"f(1@2) + g(2)"は、"13"' do
            reverse_polish_array = %w{1 2 @ f 2 g +}
            Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(13)
          end
        end
        context 'カッコが入れ子の場合' do
          it '"((1 + 2) @ 3) @ (4 + 5)"は、"42"' do
            reverse_polish_array = %w{1 2 + 3 @ 4 5 + @}
            Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(42)
          end
          it '"f(f(1))"は、"4"' do
            reverse_polish_array = %w{1 f f}
            Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(4)
          end
          it '"f(f(1)@g(1))"は、"8"' do
            reverse_polish_array = %w{1 f 1 g @ f}
            Formula.calc_reverse_polish_notation(reverse_polish_array).should eq(8)
          end
        end
      end
    end
  end
end
