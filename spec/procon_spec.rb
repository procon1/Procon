require 'rubygems'
require 'procon'

#describe '#initialize' do
#  before do
#    @valid_attr = {:name => 'hoge', :hp => 1000}
#  end
#  context '初期値を与えると' do
#    it '初期値が返る' do
#      pro = Procon.new(@valid_attr[:name], @valid_attr[:hp])
#      pro.name.should eq('hoge')
#      pro.hp.should eq(1000)
#    end
#  end
#  context '初期値を与えないと' do
#    it 'nilが返る' do
#      @valid_attr[:name] = nil
#      @valid_attr[:hp] = nil
#      pro = Procon.new(@valid_attr[:name], @valid_attr[:hp])
#      pro.name.should eq(nil)
#      pro.hp.should eq(nil)
#    end
#  end
#end

# 以下、動作確認用コード
# テストではない。。
describe '#siyousyo' do
  context 'あああ' do
    it "aaa" do
      a = Procon.new.siyousyo
      a.size.should_not == 1 
    end
  end

end
describe '#create_robots' do
  context 'あああ' do
    it "aaa" do
      a = Procon.new.create_robots
      a.size.should_not == 1 
    end
  end

end
