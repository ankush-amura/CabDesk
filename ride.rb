module RideModule
class Ride
  attr_accessor :source,:destination,:fare_collected,:kms_travelled,:time_taken,:status

   def initialize(source,destination,fare_collected,kms_travelled,time_taken)
      @source=source
      @destination=destination
      @fare_collected=fare_collected
      @kms_travelled=kms_travelled
      @time_taken=time_taken
      @status="cancellable"
   end

end
end
