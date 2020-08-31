require "../../sim/actor"
require "../../sim/event"

class Server < Actor
  def initialize(id : Symbol = :server)
    super
  end

  def init(sim : Sim)
    super
    # There needs to be some variance here
    puts "Scheduling initial server tick"
    event = Event.new(self.id, :server_tick)
    sim.timer.schedule(event, 0)
  end

  def event_map(sim)
    @event_map[:server_tick] = -> { trigger(sim, :tick, EventTarget::All) }
    @event_map[:tick] = -> {
      # schedule a new tick on the tick
      puts "Server is ticking";
      sim.timer.schedule(Event.new(self.id, :server_tick), sim.timer.time + 3)
      return true
    }
    @event_map
  end
end
