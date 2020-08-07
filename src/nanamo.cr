require "./sim/event"
require "./sim/sim"
require "./actors/actors"
require "./actors/system/server"

sim = Sim.new(25)

server = Server.new

sim.add_actor(server)

while sim.timer.time <= sim.timer.size
  # Handle the current events the sim has on the current timer tick
  # On each event, we'll send the event to the actor list by its id on the event
  # Each actor will handle the execution of its events
  sim.handle_events

  # debug
  current_time = sim.timer.time
  slot_events = sim.timer.count_slot
  if slot_events > 0
    puts "[#{current_time}] : Events [#{slot_events}]"
  end

  sim.timer.tick
end
