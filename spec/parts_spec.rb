require 'rubygems'
require 'parts'

describe '#initialize' do
  it '値が設定されること' do
    open("#{File.dirname(__FILE__)}/file/specification1.txt") do |specification|
      parts = Parts.new(specification)
      parts.id.should     eq(2)
      parts.atk.should    eq(2)
      parts.deff.should   eq(11)
      parts.dur.should    eq(12)
      parts.weight.should eq(12)
      parts.size.should   eq(42)
    end
  end
end
