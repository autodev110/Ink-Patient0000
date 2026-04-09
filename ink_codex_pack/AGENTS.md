# AGENTS.md

## What this repo is

This repository contains Ink narrative projects. Treat it like an interactive fiction codebase, not a normal prose folder.

Primary goals, in order:
1. syntactically valid Ink
2. state-safe branching and backtracking
3. stable encounter / pickup persistence
4. small, scoped edits
5. narrative preservation unless the user explicitly asks for rewrites

The current project is a horror / survival Ink story with three selectable player identities (`0001`, `0012`, `0023`), shared facility exploration, persistent creature states, backtracking, and branching exterior endings.

## Default behavior for Codex

- Prefer the smallest correct change over a broad rewrite.
- Do not rewrite descriptive prose unless asked.
- Preserve knot names, variable names, and flow topology where possible.
- When you change flow, verify revisit behavior and state persistence.
- When you add a scene, decide whether it is first-visit only, repeatable, or revisit-aware.
- Call out technical risks directly and separately from narrative suggestions.

## Ink feature policy

Default allowed features:
- text
- choices
- sticky choices
- knots
- stitches
- diverts
- simple global variables
- temporary variables when clearly useful
- conditional blocks

Do not introduce advanced Ink features just because they exist.
Only add functions, lists, threads, tunnels, or external integration if they materially simplify the file.

## Syntax rules

### Knots and stitches
- Use `=== knot ===` for top-level story units.
- Use `= stitch` only when it clearly improves local organization.
- Do not create ambiguous names between knots and stitches.
- If adding includes, keep `INCLUDE` statements at the top of the file only.

### Conditional blocks
Use the single-condition form only for one condition plus optional else:

```ink
{ door_open:
The door is open.
- else:
The door is shut.
}
```

Use the full multi-branch form whenever there are 2 or more conditions:

```ink
{
- guard_dead:
    The guard lies still.
- guard_fled:
    A black trail disappears into the vent.
- else:
    The guard still blocks the path.
}
```

Do not write mixed-form conditionals like:

```ink
{ cond_a:
...
- cond_b:
...
}
```

If a block has more than one branch condition, convert it to the full multi-branch style.

### Choice rules
Use `*` for:
- one-time actions
- combat actions
- pickups
- irreversible decisions
- actions that should disappear after use

Use `+` for:
- navigation hubs
- re-checking non-consumptive environmental details
- repeatable exploration that does not trivialize danger

If a repeatable choice becomes a safety exploit, convert it to `*` or gate it behind state.

## State model rules

### Global variables
- Initialize globals at the top of the file.
- Keep names explicit and readable.
- Prefer descriptive booleans over vague flags.
- Do not create overlapping flags that can contradict each other.

### Persistent encounters
If a creature or threat can be revisited, the file must preserve its changed state.

Preferred state ideas:
- unseen
- revealed
- wounded
- dead
- fled / gone

On revisit:
- dead creatures should remain dead
- wounded creatures should show damage
- fled creatures should leave traces or changed absence
- pickups should not reappear unless intentionally renewable

### Resources
- Clamp capped resources immediately after mutation.
- Do not duplicate pickups.
- Keep max-value logic consistent everywhere.

## Backtracking and recursion rules

Backtracking is expected in this repo.

Whenever editing a revisitable knot, verify:
- first-visit text versus revisit text
- whether choices should persist
- whether state transitions still make sense
- whether the player can farm safety or items
- whether loops are intentional and stateful rather than accidental

Do not create loops that revisit the same knot with no new state, unless the loop is intentionally part of the story structure.

## Ending rules

Not every knot named like an ending is final.
Some “ending” knots transition into exterior continuation content.

Before changing an ending:
- verify whether it diverts to `END`
- verify whether prior state still matters afterward
- preserve player identity branching in post-ending routes

## Editing workflow

When asked to edit the Ink file:
1. identify whether the task is syntax, structure, persistence, branching, or narrative
2. make the smallest safe edit first
3. inspect adjacent states and revisits for the same class of bug
4. confirm no new duplicate pickups or reset encounters were introduced
5. summarize exact technical changes

## Validation checklist

Before considering a task done, check:
- all diverts target existing knots/stitches
- all multi-condition blocks use valid Ink syntax
- no encounter resets on revisit unless intended
- no pickup duplicates on revisit
- no sticky choice creates a farmable exploit
- no required content is skipped by an over-eager redirect
- no accidental infinite loop exists without state change
- player-specific branches still converge where intended

## Review documents

Also follow:
- `docs/ink-authoring-guide.md`
- `code_review.md`
- `.agents/skills/ink-story-authoring/SKILL.md`
