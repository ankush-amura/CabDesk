require '/home/amura/Desktop/practice/taxi_app/person.rb'
require '/home/amura/Desktop/practice/taxi_app/Driver.rb'
require '/home/amura/Desktop/practice/taxi_app/user.rb'
require '/home/amura/Desktop/practice/taxi_app/ride.rb'
require '/home/amura/Desktop/practice/taxi_app/handling.rb'

class TaxiService
   include RideModule
   include ExceptionHandling
   @kms=0
   # creating a single driver that provides taxi service for all customers
   @@driver1=Driver.new("John",21,"PAN-KKBK2310")
   # locations define all the places for which the driver is available to service
   @@locations=["vennice","lazania","north-carolina","california"]
   # this method is responsible for initiating the taxi service from start
   puts "*****************************UBER CORPORATE************************************"


def start_taxi_service
     # we start from taking some personal details from the user
     puts "\nServing U With A Single Driver In The City....."
     puts "Car Type:  #{@@driver1.car_class }"
     puts "Car Fair : #{@@driver1.car_fair}"
     puts "*********************************Service Activated****************************"
     puts"We Require Some Personal Details To Move Furthur.. "
     take_user_details
     process_booking
end


 def take_user_details
   puts"Enter Your First Name: "
   name=gets.chomp
   begin
     raise NumberError.new if(name =~ /\d/)
   rescue => e
      while(name =~ /\d/) do
         puts "**********************Kindly Prevent Inserting Numbers in Your Name***************** "
         puts"Enter Your First Name again :"
         name=gets.chomp
      end
   end
   puts"Enter Your Age: "
   age=gets.chomp
   begin
     raise AlphaError.new if(age =~ /[a-zA-Z]/)
   rescue => e
     while(age =~ /[a-zA-Z]/) do
         puts "**********************Kindly Prevent Inserting Text in Your Age***************** "
         puts"Enter Your Age again :"
      age=gets.chomp
      end
   end
     puts"Enter Your Id Any: "
     id=gets.chomp
     puts "Thanks For Your Co-operation"
     puts"****************************Proceeding With Booking*****************************"
     # booking can start after the details have been entered Successfully
     @user1=User.new(name,age,id)
end


def process_booking
      puts " 1.Book Taxi \n 2.View My Rides \n 3.Cancel Ride \n 4.EXIT "
      selected=gets.chomp
      case selected
         when  "1"
            # booking need to be resumed when the person selects book taxi in choice
            book_taxi
         when "2"
            # rides should be viewed when the user selects to view the rides
            view_rides
         when "3"
            # the user can cancel ride if he has booked any currently
            cancel_ride
         when "4"
            return
         else
           puts "*************** Kindly Stay Within The Limits Of Choice Provided **************"
           process_booking
      end
end

def cancel_ride(ride=nil)
      # should return with displaying info if no rides are currently booked
      puts "********No Rides Booked Currently ******************" if(ride==nil)
      process_booking if(ride==nil)
      # should proceed with cancellation if any ride has been booked currently
      # displaying the current ride detail
      puts "********************** Entering Portal For Cacelling Ur Ride****************** "
      puts "Ur Current Ride details are: "
      puts "\n************** Ride 1 *********************"
      puts "Ur Pickup Location : #{ride.source}"
      puts "Ur Destination Location : #{ride.destination}"
      puts "Total Fair Of The Ride Was : #{ride.fare_collected}"
      puts "Total Kms Of The Ride Were : #{ride.kms_travelled}"
      puts "Total Time Taken For The Ride Was: #{ride.time_taken}"
      puts "************************************************\n"
      # prompt customer for confirm cancellation
      puts" 1. Confirm Cancellation \n 2.Return Back"
      response=gets.chomp
      case response
          when "1"
             puts">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Ride Successfully Cancelled<<<<<<<<<<<<<<<<<<<<<<<<"
             # return to process booking if no cancellation required
             process_booking
          when "2"
            # return back if no cancellation required
             return
          else
             puts "*************** Kindly Stay Within The Limits Of Choice Provided ******************"

      end
end


def book_taxi
      # prompt customer to select the source pickup location
      puts "Select Ur Start Location Of Travel "
      print_locations
      location=gets.chomp
      @user1.from_location=@@locations[location.to_i-1]
      puts "Your Pickup Location Taken Successfully"
      # prompt user for the destination location
      puts "Select Ur Destination Location"
      print_locations
      location=gets.chomp
      @user1.to_location=@@locations[location.to_i-1]
      # look if both the source and the destination are same
      # prompt user for error if both are same
      while @user1.from_location == @user1.to_location
          puts "*********Warning!!!! Both Destination and Pickup Can Not Be The Same*********"
          book_taxi
      end
      # finish with booking called after taking all the details fron the user
      finish_with_bookings
end

def drive_details
  # display customer with the current booking details
  # user can verify if any mistake in bookings
  puts "**************************** Ur Drive Details Are As Follows**********************"
  puts "PickUp Location: #{@user1.from_location}"
  puts "Ur Destination Location: #{@user1.to_location}"
  calc_kms
  puts "Total Km To Travel: #{@kms}"
  # fare calculated by having rate as 100 rs per KM
  puts "fare calculated: #{@kms*@@driver1.car_fair}"
  puts "Car Class Selected: #{@@driver1.car_class}"
  puts "Time For Travel: #{@kms*5} Taking 5min per km "
end

def calc_kms
  # now proceeding with the calculation for the kms and the fare
  index_start = @@locations.index(@user1.from_location)
  index_end = @@locations.index(@user1.to_location)
  # the index substraction provided us with how far the two locations are
  @kms=(index_end-index_start).abs * 2

end
def booking_processing
  @user1.travel_fair = @kms*@@driver1.car_fair
  @@driver1.pickup_location = @user1.from_location
  puts "***********************Your Ride is Confirmed********************************"
  @@driver1.availability="busy"
  driver_kms =(@@locations.index(@@driver1.current_location) - @@locations.index(@user1.from_location))*2
  driver_min=driver_kms*5
  puts "Driver will pick u up in: #{driver_min} minutes kindly wait " if(driver_min>0)
  puts "Driver Is Currently Present At Ur Location Please Come Near Taxi " if(driver_min==0)
  ride=Ride.new(@user1.from_location,@user1.to_location,@user1.travel_fair,@kms,(@kms*5))
  sleep(7)
  complete_ride(ride)
end

def complete_ride(ride)
  puts">>>>>>>>>>>>>>>>>>>>>>> Driver is near by ur location <<<<<<<<<<<<<<<<<<<<<<<<<<"
  puts"Ride Can Not Be Cancelled Now......"
  sleep(4)
  puts"Driver Has Reached Ur Location....."
  sleep(4)
  puts"Started Ride Successfully....."
  sleep(4)
  # push the ride into the users rides history if drive has once started
  @user1.rides.push(ride)
  puts "************************** The Ride Was Successfully Completed *************************"
  # validating the driver with all the details for the ride
end

def finish_with_bookings
     calc_kms
     puts"*********************************CheckOut Booking***********************************  "
     puts " 1.Confirm Ride \n 2.Cancel Current Ride"
     # confirm the ride if the user is satisfied with the ride and move furthur
     input=gets.chomp.to_i
     case input
        when 1
           booking_processing
           validate_driver
      when 2
          process_booking
    end
end


def validate_driver
  @@driver1.total_fare_collected = @user1.travel_fair + @@driver1.total_fare_collected.to_i
  @@driver1.num_pickups += 1
  @@driver1.availability="vecant"
  # moving now to the main choice menu back
  puts "Select Ur Choice From Menu Below  :    "
  process_booking

end


def print_locations
    @@locations.each_with_index do |item,index|
    puts  "#{index + 1}  #{item}"
    end

end

def view_rides
      # if there are no rided done in the history should be told to the user
      puts "****************** No Rides Completed In Ur History ********************" if(@user1.rides.count==0)
      # move back to the menu if there are no rides in the history
      process_booking if(@user1.rides.count==0)
      # proceed furthur and view all the rides to the customer
      puts "****************** Viewing Your Rides Below *******************************"
      @user1.rides.each_with_index do |item,index|
           puts "\n************** Ride #{index + 1} *********************"
           puts "Ur Pickup Location : #{item.source}"
           puts "Ur Destination Location : #{item.destination}"
           puts "Total Fair Of The Ride Was : #{item.fare_collected}"
           puts "Total Kms Of The Ride Were : #{item.kms_travelled}"
           puts "Total Time Taken For The Ride Was: #{item.time_taken}"
           puts "************************************************\n"
      end

      puts "******************Finished Viewing Your Rides *******************************"
      # moving back to the menu of choice for the customer
      process_booking
end


end
TaxiService.new.start_taxi_service
