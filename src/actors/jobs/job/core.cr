require "../../../sim/actor"
require "../../../sim/event"

class Job < Actor
  def initialize(id : Symbol = :server)
    super
  end

  def init(sim : Sim)
    super
  end

  def event_map(sim)
    super
  end
end
