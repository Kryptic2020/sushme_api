# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 if User.count == 0
  User.create(username:"user1",email:"test@gmail.com",password:"123456",password_confirmation:"123456")
  User.create(username:"user2",email:"test2@gmail.com",password:"123456",password_confirmation:"123456")
end

if Category.count == 0
  Category.create(name:'Hot Roll')
  Category.create(name:'Temaki')
  Category.create(name:'Salad')
  Category.create(name:'Drinks')
  Category.create(name:'Desert')
  Category.create(name:'Others')
  Category.create(name:'Top Seller')
end

if Product.count == 0
  Product.create(title:'Cake', quantity:100, description:'Chocolate cake', price:150,status:'Available', category_id:1)
end

if Table.count == 0
  Table.create(reference:'Online-Takeaway')
  Table.create(reference:'2')
  Table.create(reference:'3')
  Table.create(reference:'4')
  Table.create(reference:'5')
end

if Status.count == 0
  Status.create(status:'Pending')
  Status.create(status:'Confirmed')
end