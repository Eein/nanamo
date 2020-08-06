require "./sim/event"
require "./sim/sim"
require "./actors/actors"
require "./actors/system/server"

sim = Sim.new(25)
event = Event.new(:server, EventType::Wait, EventTarget::All)

server = Server.new
sim.add_actor(server)

sim.timer.schedule(event, 15)
sim.timer.schedule(event, 1)

while sim.timer.time <= sim.timer.size
  sim.timer.handle_events

  # debug
  current_time = sim.timer.time
  slot_events = sim.timer.count_slot
  if slot_events > 0
    puts "[#{current_time}] : Events [#{slot_events}]"
  end

  sim.timer.tick
end
