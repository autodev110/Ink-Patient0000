---
name: ink-story-authoring
description: Use this skill when editing or generating Ink narrative files, especially for branching stories with stateful encounters, backtracking, and character-specific routes. Do not use it for non-Ink prose work.
---

# Ink Story Authoring Skill

## Purpose

This skill helps Codex edit Ink files safely and consistently for interactive narrative projects with revisitable rooms, branching routes, and persistent state.

## When to use

Use this skill when:
- editing `.ink` files
- adding or fixing choices, knots, or stitches
- debugging Ink conditional syntax
- introducing new encounters or persistent creature state
- reviewing backtracking, recursion, revisit logic, or ending branches
- extending a narrative without rewriting large portions of existing prose

Do not use this skill for:
- generic fiction brainstorming with no Ink deliverable
- non-Ink markdown docs
- engine-side C#, JS, or UI logic unless the task explicitly spans both layers

## Working method

1. Read the nearby knots before editing.
2. Identify whether the target knot is:
   - first-visit only
   - revisitable
   - a navigation hub
   - an encounter
   - an ending continuation knot
3. Map the relevant state transitions before changing prose.
4. Make the smallest safe change.
5. Re-check all inbound and outbound diverts.
6. Re-check revisit behavior after any new flag or branch.
7. Prefer preserving existing prose unless the user asked for narrative rewrite.

## Ink-specific rules

### Conditional syntax
If a block has more than one branch condition, use the full multi-branch form:

```ink
{
- cond_a:
    ...
- cond_b:
    ...
- else:
    ...
}
```

Do not use mixed conditional forms that commonly trigger compiler errors.

### Encounters
For revisitable encounters, preserve aftermath.
If the player injures or kills a creature, revisits must acknowledge that outcome.

Good revisit states include:
- wounded but alive
- dead body present
- fled, leaving traces
- gone, with environmental aftermath

### Choices
Default to:
- `*` for one-time or high-stakes actions
- `+` for repeatable navigation and safe inspection

If unsure, ask whether repeated use would be exploitable. If yes, prefer `*`.

### Pickups and resources
- Every unique pickup gets a dedicated flag.
- Clamp capped resources after mutation.
- On revisit, describe the empty / used state.

### Backtracking
When a room can be revisited, update:
- room header text
- available choices
- danger state
- pickup state

Do not assume a scene is single-pass unless the structure proves it.

## Preferred output style

When proposing or making changes:
- list the technical reason first
- then show the exact code change
- then mention any adjacent risk or follow-up if relevant

Keep recommendations concrete.

## Repo-specific reminders

This repo currently uses:
- player identities `0001`, `0012`, `0023`
- shared facility exploration
- persistent creature states
- multiple exterior continuation routes

Preserve those patterns unless explicitly asked to redesign them.
