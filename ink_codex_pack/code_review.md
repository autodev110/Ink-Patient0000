# code_review.md

Review Ink changes against this checklist.

## Syntax and compile safety
- Are all knots and diverts valid and spelled correctly?
- Are all multi-condition blocks written in valid full-branch form?
- Did the change introduce ambiguous knot/stitch naming?
- Are includes still only at the top of the file?

## State safety
- Does every revisitable encounter preserve damage / death / absence correctly?
- Can any pickup now be collected more than once by mistake?
- Did any new flag create a contradictory state combination?
- Are resource caps still enforced everywhere they should be?

## Flow safety
- Did any early divert skip required room text or choices?
- Did any branch become unreachable?
- Did any new loop become infinite without a meaningful state change?
- Does backtracking still land in a coherent room state?

## Choice safety
- Should each changed choice be `*` or `+`?
- Can the player now spam a safety action, hide action, or lore action in a way that breaks tension or logic?
- Are combat options removed or changed after the creature is dead / fled / wounded?

## Project-specific checks
- Does the change preserve the three player identities (`0001`, `0012`, `0023`)?
- Does `0023` still feel tied to facility lore?
- Do exterior continuation routes still branch correctly after the purge / non-purge split?
- If the player goes back into the facility after an exterior beat, does the file preserve interior state correctly?

## Review output format
When reviewing, report in this order:
1. critical breakage
2. state / backtracking risks
3. choice persistence issues
4. optional cleanup ideas

Separate "must fix" from "nice to have".
