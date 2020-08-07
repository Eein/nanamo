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
  property id : Symbol
  property name : Symbol
  def initialize(id : Symbol, name : Symbol)
    @id = id
    @name = name
  end
end
