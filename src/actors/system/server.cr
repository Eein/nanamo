require "../../sim/actor"
require "../../sim/event"

class Server < Actor
  property tick_count : (Int32 | Int8)

  def initialize(id : Symbol = :server)
    super
    @tick_count = 0
  end

  def init(sim : Sim)
    super
    # There needs to be some variance here
    puts "Scheduling initial server tick"
    event = Event.new(self.id, :server_tick)
    sim.timer.schedule(event, 0)
  end

  def event_map(sim)
    @event_map = super
    @event_map[:server_tick] = -> {
      trigger(sim, :tick, EventTarget::All)
      if @tick_count == 0
        trigger(sim, :regen_tick, EventTarget::All)
      end
      raise "Tick count out of bounds" if @tick_count < 0 || @tick_count > 2
      # Increment tick counter
      @tick_count = @tick_count == 2 ? 0 : (@tick_count + 1)
      true
    }
    @event_map[:regen_tick] = -> { true }
    @event_map[:tick] = -> {
      # schedule a new tick on the tick
      puts "#{self.id} :: tick"
      sim.timer.schedule(Event.new(self.id, :server_tick), sim.timer.time + 1)
      return true
    }
    @event_map
  end
end
