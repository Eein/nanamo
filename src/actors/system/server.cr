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
    event = Event.new(self.id, EventType::ServerTick, EventTarget::All)
    sim.timer.schedule(event, 0)
  end

  def ability_list
    action = new_ability_list
    action[:server_tick] = ServerTick.new
  end

end


class ServerTick
end

class Action
end