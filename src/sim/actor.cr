require "./sim"
require "./event"

class Actor
  # Actor generation goes through a lifecycle
  property id : Symbol
  property event_map : Hash(Symbol, Proc(Bool))

  def initialize(id : Symbol = :default_actor)
    @id = id
    puts "Initializing Actor: :#{id}"
    @event_map = Hash(Symbol, Proc(Bool)).new
  end

  def init(sim : Sim)
    @event_map = event_map(sim)
  end

  def event_map(sim)
    @event_map[:tick] = -> { puts "#{self.id} :: tick"; true }
    @event_map[:wait] = -> {
      puts "waiting"
      true
    }
    @event_map
  end

  def handle_event(event)
    puts "Event >> Actor :#{self.id} is handling :#{event.name}"
    raise "#{event.name} was not found on event_list, did you forget to define it?" unless @event_map.has_key?(event.name)
    @event_map[event.name].call
  end

  # Triggers and event directly
  # This is useful for direct side effects like server ticks
  def trigger(sim, name, target = EventTarget::Self)
    case target
    when EventTarget::All
      sim.actors.each do |sym, actor|
        actor.event_map[name].call
      end
    else
      @event_map[name].call
    end
    true
  end
end
