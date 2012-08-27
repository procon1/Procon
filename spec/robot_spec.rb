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
        robot.offence.should eq(100)
        robot.deffence.should eq(130)
        robot.durability.should eq(40)
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
    context '攻撃力が0未満の場合' do
      it 'ロボットは作成できない' do
        specifications = ["#{File.dirname(__FILE__)}/file/robot_parts3.txt"]
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
        specifications = ["#{File.dirname(__FILE__)}/file/robot_parts4.txt", "#{File.dirname(__FILE__)}/file/robot_parts5.txt"]
        robot = Robot.new.create(specifications)
        #robot.id.should eq('hoge')
        robot.life.should eq(1000000)
        robot.offence.should eq(1800)
        robot.deffence.should eq(210)
        robot.durability.should eq(10)
        robot.size.should eq(30)
      end
    end
    context 'サイズが100を超えている場合' do
      it 'ロボットは作成できない' do
        specifications = ["#{File.dirname(__FILE__)}/file/robot_parts6.txt", "#{File.dirname(__FILE__)}/file/robot_parts7.txt"]
        robot = Robot.new.create(specifications)
        robot.id.should eq(nil)
        robot.life.should eq(nil)
        robot.offence.should eq(nil)
        robot.deffence.should eq(nil)
        robot.durability.should eq(nil)
        robot.size.should eq(nil)
      end
    end
    context '攻撃力が0未満の場合' do
      it 'ロボットは作成できない' do
        specifications = ["#{File.dirname(__FILE__)}/file/robot_parts8.txt", "#{File.dirname(__FILE__)}/file/robot_parts9.txt"]
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
end
