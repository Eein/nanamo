require "./timer"
require "./actor"
require "uuid"

class Sim
  property actors : Hash(Symbol, Actor)
  getter timer : Timer

  def initialize(timer_size : Int32 = 600000)
    @timer = Timer.new(timer_size)
    @actors = Hash(Symbol, Actor).new()
  end

  def add_actor(actor : Actor)
    raise "And actor already exists with the id: :#{actor.id}" if @actors.has_key?(actor.id)
    @actors[actor.id] = actor
    @actors[actor.id].init(self)
  end

  def handle_event(event : Event, actor : Actor)
    puts "handle an event"
  end
end