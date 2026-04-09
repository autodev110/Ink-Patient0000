# Ink Authoring Guide

This file defines repository-specific authoring standards for Ink.

## Primary philosophy

Write Ink that is:
- easy to compile
- easy to debug
- easy to backtrack through
- easy to extend without breaking old branches
- readable by someone who is not an Ink expert

This repo prefers clarity over cleverness.

## How to structure scenes

### One main responsibility per knot
A knot should usually represent one of these:
- room entry / room hub
- encounter
- pickup / discovery
- transition
- ending continuation

If a knot starts mixing too many jobs, split helper logic into a nearby knot or stitch.

### Revisit-safe room headers
If the player can return to a room, the room should describe the current state on entry.
Examples:
- corpse still present
- broken locker still open
- empty crate
- chamber shattered
- facility burning
- creature fled and left traces

Do not always reprint the exact first-visit description.

## Choice guidance

### Once-only choices (`*`)
Use for:
- attacks
- picking up an item
- committing to a path
- “do it now” survival actions
- revelations that should happen once

### Sticky choices (`+`)
Use for:
- returning to hubs
- re-reading non-consumptive lore
- optional exploration
- navigation menus

Avoid sticky choices for actions that let the player neutralize danger forever by repetition.

## Conditional guidance

### Single-condition form
Good for one condition plus optional else:

```ink
{ keycard_a:
The reader glows green.
- else:
The door stays locked.
}
```

### Multi-branch form
Use this for 2+ condition branches:

```ink
{
- creature_dead:
    The body is still here.
- creature_wounded:
    It drags itself when it moves.
- else:
    It is unhurt and blocking the path.
}
```

Never mix those forms inside the same block.

## State design

### Preferred naming
Use explicit names like:
- `found_gun`
- `killed_specimen`
- `archive_creature_fled`
- `heard_intercom_23`

Avoid:
- `done1`
- `flagB`
- `x_state`

### Encounter persistence
For any encounter that can be revisited, decide the state model before writing prose.
At minimum decide whether it can be:
- unseen
- wounded
- dead
- gone

Then write text and options for each relevant state.

### Pickups
Every non-repeatable pickup should have its own flag.
On revisit, the environment should acknowledge the pickup is gone.

### Ammo and caps
Clamp immediately after mutation.
Preferred style:

```ink
~ bullets = MIN(bullets + 1, 5)
```

If the file already uses explicit clamp blocks consistently, match the local style instead of mixing both approaches randomly.

## Backtracking checklist for every new scene

When adding a knot, answer:
1. Can the player return here?
2. If yes, what changes on return?
3. If combat happened here, what remains?
4. If an item was here, can it be taken twice?
5. Should the same choices still appear?
6. Does the scene still make sense after adjacent events change?

## Player-identity handling

This repo currently uses three player identities:
- `0001`: baseline survivor
- `0012`: smaller, quieter subject with childlike environmental implication
- `0023`: subject with deeper facility ties

Use player-specific variation sparingly:
- intro text
- 1–3 special scenes
- special perception / lore
- ending continuation variation

Do not fork the full campaign unless explicitly asked.

## Ending continuation guidance

The story uses two major exterior continuation routes:
- escaped without fully burning the root
- escaped after purge / fire sequence

When editing those routes:
- preserve the perimeter / sniper logic
- preserve helicopter logic
- keep player-specific payoff distinct
- do not lose earlier identity flags that should still matter outside

## Common failure modes

Watch for:
- multi-condition syntax errors
- accidental room bypass by early divert
- revisitable rooms that forget their state
- combat choices that remain available after the target is dead
- duplicate rewards on revisit
- loops with no state change
- broken convergence after adding exclusive character content

## Preferred refactor style

If a knot gets too messy:
- move state-specific prose into helper knots
- keep the hub readable
- avoid deeply nested conditionals in a navigation knot

Refactor for clarity, not abstraction.
