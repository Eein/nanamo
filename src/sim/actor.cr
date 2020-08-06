require "./sim"

class Actor
  # Actor generation goes through a lifecycle
  property id : Symbol

  def initialize(id : Symbol = :default_actor)
    @id = id
    puts "Initializing Actor: :#{id}"
  end

  def init(sim : Sim)
    :not_implemented
  end

  def handle_event
  end
end
