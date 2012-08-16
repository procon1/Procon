require 'rubygems'
require 'robot'

describe '#create' do
  context '部品が1つの場合' do
    context 'サイズが100以下の場合' do
      it 'ロボットが作成され、値が設定されること' do
        specifications = ["#{File.dirname(__FILE__)}/file/robot_parts1.txt"]
        robot = Robot.new.create(specifications)
        #robot.id.should eq('hoge')
        robot.life.should eq(1000000)
        #robot.offence.should eq()
        #robot.deffence.should eq()
        #robot.durability.should eq()
        robot.size.should eq(100)
      end
    end
    context 'サイズが100を超えている場合' do
      it 'ロボットは作成できない' do
        specifications = ["#{File.dirname(__FILE__)}/file/robot_parts2.txt"]
        robot = Robot.new.create(specifications)
        robot.id.should eq(nil)
        robot.life.should eq(nil)
        robot.offence.should eq(nil)
        robot.deffence.should eq(nil)
        robot.durability.should eq(nil)
        robot.size.should eq(nil)
      end
    end
  end
  context '部品が複数の場合' do
    context 'サイズが100以下の場合' do
      it 'ロボットが作成され、値が設定されること' do
      end
    end
    context 'サイズが100を超えている場合' do
      it 'ロボットは作成できない' do
      end
    end
  end
end
