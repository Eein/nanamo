require "../../../sim/actor"
require "../../../sim/event"

class Job < Actor
  property hp : Int32
  property hp_max : Int32
  property mp : Int32
  property mp_max : Int32

  def initialize(id : Symbol = :server)
    super
    @hp = 100
    @hp_max = 1000
    @mp = 1000
    @mp_max = 10000
  end

  def init(sim : Sim)
    super
  end

  def event_map(sim)
    @event_map = super
    @event_map[:tick] = -> {
      # schedule a new tick on the tick
      puts "#{self.id} :: tick"
      true
    }
    @event_map[:regen_tick] = -> {
      # schedule a new tick on the tick
      health_tick(sim)
      mana_tick(sim)
      true
    }
    @event_map
  end

  def health_tick(sim)
    # INVALID_FORMULA
    puts "#{self.id} :: health_tick"
    @hp = @hp + 10
  end

  def mana_tick(sim)
    # INVALID_FORMULA
    puts "#{self.id} :: mana_tick"
    @mp = @mp + 10
  end
end
