require '/home/amura/Desktop/practice/taxi_app/person.rb'
class User
  attr_accessor :from_location,:to_location,:travel_fair,:rides
   def initialize(name,age,id)
     @rides=[]
     @name=name
     @age=age
     @id=id
     @from_location=""
     @to_location=""
     @travel_fair=0
   end
end
