require 'rubygems'
require 'procon'

describe '#initialize' do
  before do
    @valid_attr = {:name => 'hoge', :hp => 1000}
  end
  context '初期値を与えると' do
    it '初期値が返る' do
      pro = Procon.new(@valid_attr[:name], @valid_attr[:hp])
      pro.name.should eq('hoge')
      pro.hp.should eq(1000)
    end
  end
  context '初期値を与えないと' do
    it 'nilが返る' do
      @valid_attr[:name] = nil
      @valid_attr[:hp] = nil
      pro = Procon.new(@valid_attr[:name], @valid_attr[:hp])
      pro.name.should eq(nil)
      pro.hp.should eq(nil)
    end
  end
end

describe '#infix_to_postfix' do
  describe '中置記法を後置記法に変換する' do
    context 'カッコが無い場合' do
      context 'オペランドが1つの場合' do
        it '"1 + 1"は、"11+"' do
          infix_array = %w{1 + 1}
          Procon.infix_to_postfix(infix_array).join.should eq('11+')
        end
        it '"3 - 2"は、"32-"' do
          infix_array = %w{3 - 2}
          Procon.infix_to_postfix(infix_array).join.should eq('32-')
        end
        it '"2 @ 3"は、"23@"' do
          infix_array = %w{2 @ 3}
          Procon.infix_to_postfix(infix_array).join.should eq('23@')
        end
      end
      context 'オペランドが2つの場合' do
        it '"1 + 3 - 2"は、"13+2-"' do
          infix_array = %w{1 + 3 - 2}
          Procon.infix_to_postfix(infix_array).join.should eq('13+2-')
        end
        it '"1 + 2 @ 3"は、"123@+"' do
          infix_array = %w{1 + 2 @ 3}
          debugger
          Procon.infix_to_postfix(infix_array).join.should eq('123@+')
        end
        it '"3 @ 4 @ 2"は、"34@2@"' do
          infix_array = %w{3 @ 4 @ 2}
          Procon.infix_to_postfix(infix_array).join.should eq('34@2@')
        end
      end
    end
    context 'カッコがある場合' do
      context 'カッコが1つの場合' do
        it '"f(2)"は、"2f"' do
          infix_array = %w{f ( 2 )}
          Procon.infix_to_postfix(infix_array).join.should eq('2f')
        end
        it '"g(2)"は、"2g"' do
          infix_array = %w{g ( 2 )}
          Procon.infix_to_postfix(infix_array).join.should eq('2g')
        end
        it '"(1 + 2) @ 3"は、"12+3@"]' do
          infix_array = %w{( 1 + 2 ) @ 3}
          Procon.infix_to_postfix(infix_array).join.should eq('12+3@')
        end
        it '"2 @ (1 + 3)"は、"213+@"' do
          infix_array = %w{2 @ ( 1 + 3 )}
          Procon.infix_to_postfix(infix_array).join.should eq('213+@')
        end
      end
      context 'カッコが複数の場合' do
        context 'カッコが独立している場合' do
          it '"(1 + 2) @ (3 + 4)"は、"12+34+@"' do
            infix_array = %w{( 1 + 2 ) @ ( 3 + 4 )}
            Procon.infix_to_postfix(infix_array).join.should eq('12+34+@')
          end
          it '"f(2) + g(2)"は、"2fg2+"' do
            infix_array = %w{f ( 2 ) + g ( 2 )}
            Procon.infix_to_postfix(infix_array).join.should eq('2f2g+')
          end
          it '"f(1@2) + g(2)"は、"12@fg2+"' do
            infix_array = %w{f ( 1 @ 2 ) + g ( 2 )}
            Procon.infix_to_postfix(infix_array).join.should eq('12@f2g+')
          end
        end
        context 'カッコが入れ子の場合' do
          it '"((1 + 2) @ 3) @ (4 + 5)"は、"12+3@45+@"' do
            infix_array = %w{( 1 + 2 ) @ 3 ) @ ( 4 + 5 )}
            Procon.infix_to_postfix(infix_array).join.should eq('12+3@45+@')
          end
          it '"f(f(1))"は、"1ff"' do
            infix_array = %w{f ( f ( 1 ) )}
            Procon.infix_to_postfix(infix_array).join.should eq('1ff')
          end
          it '"f(f(1)@g(1))"は、"1f1g@f"' do
            infix_array = %w{f ( f ( 1 ) @ g ( 1 ) )}
            Procon.infix_to_postfix(infix_array).join.should eq('1f1g@f')
          end
        end
      end
    end
  end
end


