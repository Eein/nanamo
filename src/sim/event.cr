enum EventType
  Wait
  Action
  OffGcd
  ServerTick
end

enum EventTarget
  All
  AllEnemies
  AllPlayers
  Enemy
  Player
  Self
end

class Event 
  def initialize(id : Symbol, type : EventType, target : EventTarget = EventTarget::Self)
    @type = type
    @target = target
  end

  def type
    @type
  end

  def target
    @target
  end
end
