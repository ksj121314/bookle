# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

categories = ["문학","역사","사회과학","교육","취미"]

categories.each do |category|
  0.upto(1) do |i|
    b = Book.new
    b.user_id = 1
    b.category = category
    b.title = "#{category}책#{i} 이름"
    b.price = 10000 + i
    b.publicdate = 20150500 + i
    b.out = "판매중"
    b.content = "#{category}책#{i} 설명"
    b.save
  end
end
