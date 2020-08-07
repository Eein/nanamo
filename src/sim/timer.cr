require "./event"
require "./sim"

class Timer
  # Initialize a timer with 10m in ms
  property size : Int32 = 0
  property time : Int32 = 0
  property slots = Hash(Int32, Array(Event)).new

  def initialize(size : Int32 = 600000)
    @size = size
  end

  def handle_events(sim : Sim)
    return unless @slots.has_key?(@time)
    events = @slots[@time]
    events.each do |event|
      puts "---- handing #{event.name}"
      sim.send_event_to_actor(event)
    end
    # relying on rescues may be slower than checks
    # is likely also poor logging
  end

  def schedule(event : Event, time : Int32)
    @slots[time] ||= [] of Event
    @slots[time] << event
  end

  def tick
    @time += 1
  end

  # debug
  def count_slot
    begin
      @slots[@time].size
    rescue
      0
    end
  end

  def count_ticks
    count = 0
    @slots.each do |k, v|
      count = count + 1
    end
    count
  end
end
