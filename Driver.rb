require '/home/amura/Desktop/practice/taxi_app/person.rb'
class Driver < Person

 attr_accessor :num_pickups,:num_pickups_cancelled
 attr_accessor :total_fare_collected,:availability,:car_class,:car_fair,:current_location,:pickup_location

 def initialize(name,age,id)
    super(name,age,id)
     @total_fair_collected = 0
     @num_pickups_cancelled = 0
     @num_pickups = 0
     @availability = "vacant"
     @car_class = "Premium"
     @car_fair = 100
     @current_location = "lazania"
     @pickup_location = ""
    end

end
