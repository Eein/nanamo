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
  property type : EventType
  property target : EventTarget
  def initialize(id : Symbol, type : EventType, target : EventTarget = EventTarget::Self)
    @type = type
    @target = target
  end
end
