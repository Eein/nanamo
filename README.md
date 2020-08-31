# nanamo

TODO: Write a description here

## TODO
- [x] Handle Events
- [x] Schedule Events
- [x] Server Ticks
- [~] Regen Server Ticks
- [ ] Jobs
- [ ] Actions
- [ ] Damage
- [ ] Buffs
- [ ] Debuffs

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here


## Events
schedule vs handle vs trigger

`Schedule` schedules an event in the future
`Handle` handles an event on the stack (calling trigger behind the schenes)
`Trigger` triggers an event immediately as a side effect of some process. This is for things that are prominently server validated such as on-tick procs, on-tick damage, and other immediate server behaviour. *It it not recommended to use this as this will bypass any network/brain latency checks when they are implemented*

### Actions

Actions are assumed to be hitting the action client buffer.
Actions are split into several event building characteristics:

`init` - Allows for validations for the ability/action, in case of level/job/defaults; then initializes them to the actor for creation.
`ready` - Determines if the event can be used - useful for combos or other actions/abilities that depend on some buff/debuff/condition to be available. These will raise an error if a priority list provides an impossible action.
`execute` - Schedules the damage to the enemy actor and reporter
`impact` - Schedules the damage to the enemy actor and reporter

Todo:
`cost` - allows modifying resource costs based on buffs/etc
`consume_resource` - allows modifying resource consumption of buffs/alt resources
`potency_modifier` - allows modifying the potency of the base value - good for combos
`cast` - Same as execute but calculates cast time by haste characteristics
`composite_potency_multiplier` - Allows runetime potency modification based on buffs
`composite_aoe_potency_multiplier` - How do we handle these?
`composite_aoe_potency_dropoff_multiplier` - How do we handle these?


#### Melee

Melee events are modeled around animation if necessary
For example dragoon jump ability has a huge windup, and delays damage, with a secondary animation phase. For this worst case example the following would be handled:

1. Schedule next possible available gcd
 - if animation length > gcd, use animation lag length
 - else use gcd length

2. Schedule `impact` event for the time damage calculation is made
 - delta of impact is manually set separately from the animation time, as the event can fire off on a separate event.

This scenario may look like:
```
[ ANIMATION FRAMES =============================== ] gcd reschedule event
[ == 2.5s animation == [Impact event] ============ ] gcd reschedule event
```

The animation itself isn't modeled apart from the lock on the gcd being able to be activated.

## Questions
- [ ] At what point does lag affect being about to double-weave? And do abilities incur animation lag
- [ ] what is the maximum allowable buffs/debuffs on a target (mostly for enemies, but i want to validate jobs cannot exceed these as well.
- [ ] Which buffs are non-unique on the buff table - how do we handle collisions (astro/scholar shields come to mind)
- [ ] Do abilities snapshot stats? For example dragoon jumps and receives a damage buff mid flight - will their execution retain the new stat bonus?

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/nanamo-crystal/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [your-name-here](https://github.com/your-github-user) - creator and maintainer
