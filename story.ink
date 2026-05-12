// Dan Nikiforov
// INK Project
// Started April 6 2026
// Draft 1 Due April 27 2026

VAR health = 3
VAR bullets = 0
VAR attention = 0

VAR found_bullets_storage = false
VAR found_bullets_lab = false
VAR found_bullets_security = false
VAR found_medkit = false
VAR has_medkit = false

VAR found_gun = false
VAR keycard_a = false
VAR keycard_b = false
VAR power_on = false
VAR killed_specimen = false
VAR killed_stalker = false
VAR killed_nest = false

VAR locker_wounded = false
VAR locker_revealed = false
VAR locker_jammed = false
VAR nest_wounded = false
VAR hall_shape_shot = false
VAR hall_shape_dead = false
VAR hall_shape_gone = false
VAR hall_swarm_awake = false
VAR hall_swarm_pending = false
VAR hall_swarm_kills = 0
VAR tried_empty_hall_shot = false
VAR killed_archive_creature = false
VAR archive_creature_revealed = false
VAR archive_creature_fled = false
VAR faceless_released = false
VAR faceless_gone = false
VAR faceless_trapped = false
VAR killed_faceless = false

VAR found_mural = false
VAR found_small_passage = false
VAR heard_lullaby = false
VAR found_lullaby_scrap = false
VAR saw_subject_file = false
VAR heard_intercom_23 = false
VAR touched_root = false
VAR knows_root = false
VAR knows_purge = false
VAR knows_perimeter = false
VAR observed_guard_routine = false
VAR reviewed_security_feeds = false
VAR blood_trail = false
VAR visited_patient_room = false
VAR visited_hall_a = false
VAR visited_mural_room = false
VAR visited_observation = false
VAR visited_lab3 = false
VAR visited_security_room = false
VAR visited_generator_hall = false
VAR visited_exit_processing = false
VAR visited_lullaby_room = false

VAR burned_clean = false
VAR saw_perimeter_shed = false
VAR saw_low_gap = false
VAR found_perimeter_evidence = false
VAR removed_wristband = false
VAR returned_after_escape = false
VAR tried_empty_nest_finish = false

VAR player_id = ""

Choose your player:
* [0001]
    ~ player_id = "0001"
    -> next
* [0012]
    ~ player_id = "0012"
    -> next
* [0023]
    ~ player_id = "0023"
    -> next

=== next ===

You wake up on a narrow bed beneath a flickering ceiling light.

The mattress is wrapped in cracked plastic.
A pale curtain sways gently from a draft.
You are wearing a hospital gown.

The room smells like antiseptic, wet concrete, and something rotten underneath both.

Somewhere beyond the walls, metal groans.
Then you hear it:
a scraping sound,
followed by a wet, uneven breathing noise.

On your wrist is a thin plastic band that says {player_id}.

{player_id == "0012":
The bed feels too tall when you slide toward its edge.
The plastic band nearly spins all the way around your wrist.
}

{player_id == "0023":
For one ugly moment, the scraping beyond the wall feels familiar,
like a sound remembered instead of heard.
}

* [Get off the bed] -> patient_room

=== patient_room ===
~ queue_hall_swarm_if_awake()
{
- visited_patient_room == true:
    You are back in the patient room.

    The fluorescent light still hums overhead.
    The sink, cabinet, and narrow bed all wait exactly where you left them.
- else:
    ~ visited_patient_room = true
    You stand slowly.

    The patient room is small and windowless.
    There is a sink with brown water stains, a metal cabinet, and a door hanging slightly open.
    The fluorescent light above you hums like it's struggling to stay alive.

    {player_id == "0012":
    The sink is mounted a little too high.
    Near the base of the far wall, scraps of paper suns and smiling faces still cling beneath old tape.
    }

    {player_id == "0023":
    A faint pressure builds behind your eyes when you look at the door,
    as if some part of you already knows the halls outside.
    }
}

{print_status()}

* [Check the cabinet] -> cabinet
* [Look under the bed] -> under_bed
+ [Step into the hallway] -> hall_a

=== cabinet ===
You open the cabinet.

Inside are old gauze rolls, empty pill bottles, and a black handgun sealed in a plastic evidence bag.

{found_gun == false:
~ found_gun = true
~ add_bullets(2)
You tear the bag open and take the gun.
It feels heavy, real, and slightly warm in your hand.
- else:
The evidence bag hangs in torn plastic strips where you left it.
}

You shut the cabinet quietly.

-> patient_room

=== under_bed ===
You kneel and look underneath the bed, it smells like mildew.

Only dust, stains, and some words scratched into the frame:

"THEY ARE NOT PEOPLE"
"EVERYONE IS DEAD"

You back away.
-> patient_room

=== hall_a ===
{
- visited_hall_a == true:
    You step back into the main hallway.

    The same wheelchairs sit abandoned against the wall beneath the flickering lights.
- else:
    ~ visited_hall_a = true
    You step into the hallway.

    A long medical corridor stretches in both directions under flickering lights.
    Wheelchairs sit abandoned against the wall.
}

{ hall_shape_shot == false:
Far away, a narrow human outline stands behind the frosted glass at the end of the corridor.
It stays still in the way a person would not.
- else:
    { hall_shape_dead == true:
    At the far end, a narrow body lies collapsed half inside a side alcove where it finally bled out.
    - else:
        { hall_shape_gone == true:
        A dark streak vanishes into a side alcove at the far end of the corridor.
        - else:
        A dark hand-shaped smear marks the wall where the distant shape fled after your shot.
        }
    }
}

{hall_swarm_awake == true:
    {
    - hall_swarm_kills == 0:
    Movement keeps stuttering between the patient doors now.
    Something takes position behind a wheelchair whenever you stop looking straight at it.
    - hall_swarm_kills == 1:
    One body lies slack near a wheelchair, but more shapes keep exchanging places from doorway to doorway.
    - else:
    Several of the things lie broken along the tiles now.
    The rest never hold the same positions twice.
    }
}

{blood_trail == true and attention >= 2:
Something behind one of the ward doors inhales when you pass.
You have started leaving enough of yourself behind for the building to follow.
}

{
- attention >= 3:
    Every small sound seems to travel farther than it should.
    The hall has started listening as a system.
- attention == 2:
    Somewhere beyond the patient doors, movement answers movement.
    The facility is no longer mistaking you for background noise.
- attention == 1:
    The shot's echo still seems trapped in the ceiling panels.
}

{hall_swarm_awake == true and hall_swarm_pending == true:
-> hall_swarm_encounter
}

A sign overhead reads:

WARD A
OBSERVATION
TESTING
SECURITY

{player_id == "0012" and power_on == true and heard_lullaby == false:
From somewhere deeper in the wall, a broken lullaby drifts through a ceiling speaker,
soft and wrong and almost familiar.
}

{print_status()}

+ {keycard_a == false} [Try the Security door] -> security_door
+ {keycard_a == true} [Go to Security] -> security_door
+ {hall_shape_shot == false and found_gun == true and bullets > 0} [Use 1 bullet on the distant shape] -> shoot_hall_shape
* {hall_shape_shot == false and found_gun == true and bullets <= 0 and tried_empty_hall_shot == false} [Try to fire at the distant shape] -> shoot_hall_shape
+ {hall_shape_shot == true} [Follow the trail into the side alcove] -> hall_trail
+ {player_id == "0012" and visited_mural_room == false} [Follow the faded painted handprints along the lower wall] -> mural_room
+ {player_id == "0012" and visited_mural_room == true} [Return to the room with the painted handprints] -> mural_room
+ {player_id == "0012" and power_on == true and heard_lullaby == false and visited_lullaby_room == false} [Follow the broken lullaby] -> lullaby_room
+ {player_id == "0012" and power_on == true and heard_lullaby == false and visited_lullaby_room == true} [Return to the room with the broken lullaby] -> lullaby_room
+ {player_id == "0012" and power_on == true and heard_lullaby == true and visited_lullaby_room == true} [Return to the silent sleep ward] -> lullaby_room
* {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> hall_a)
+ [Go to Observation] -> observation
+ [Go to Testing] -> testing_hall
* [Hide behind the overturned cart and listen] -> hide_hall
+ [Go back to patient room] -> patient_room

=== hide_hall ===
~ reduce_attention(1)

You crouch behind an overturned supply cart and stay still.

{hall_shape_shot == false:
The thing at the far end stops moving.

For a long moment, the corridor is silent.
Then the head tilts toward some other sound deeper in the facility and the outline slips out of sight.
You are safe for now.
- else:
    {hall_swarm_awake == true:
    The corridor does not go quiet.

    Bare feet tap tile out of sight.
    Something tests the top of the cart with two careful fingers, then moves on.
    After a long minute the motion thins back to scattered shapes and breath from too many throats.
    - else:
    The corridor holds still except for a faint scrape farther down, patient and irregular.
    Nothing comes for you.
    }
}

-> hall_a

=== shoot_hall_shape ===
{found_gun == false:
You reach for a gun you do not have.
The mistake costs you a moment of courage.
-> hall_a
- else:
{bullets > 0:
~ spend_bullet()
~ hall_shape_shot = true
~ wake_hall_swarm()
You fire once.

The muzzle flash blinds you for half a second.
The shot echoes through the corridor like an alarm.

The outline buckles out of sight behind the glass.
Instead, motion answers you from every direction.
Multiple things are now awake.

{print_ammo_status()}
-> hall_a
- else:
~ tried_empty_hall_shot = true
~ raise_attention(1)
The gun clicks dry.
The empty sound is smaller than a shot.
Somehow it travels farther.
-> hall_a
}
}

=== hall_swarm_encounter ===
~ hall_swarm_pending = false

{
- hall_swarm_kills == 0:
    The corridor answers your shot all at once.

    Shapes step out from half-open rooms on both sides.
    One moves along the ceiling with slow, deliberate placement while another crosses low behind a wheelchair without seeming to bend.
- hall_swarm_kills == 1:
    The hallway erupts again.

    Another shape drops from a doorway farther down and comes at you in a sideways run while something else keeps pace just out of sight.
- else:
    The hall has learned you.

    More shapes trade positions between the ward doors, fast, coordinated, difficult to count.
}

One of them stops pretending not to see you and comes straight in.

{print_status()}

+ [Shoot the nearest one and clear space] -> hall_swarm_shoot
+ [Cut between the wheelchairs and run] -> hall_swarm_run
+ [Drop behind the overturned cart and wait for a gap] -> hall_swarm_hide

=== hall_swarm_shoot ===
{found_gun == false:
You reach for a gun you do not have.
The first creature is already on you.
-> hall_swarm_attack
- else:
{bullets > 0:
~ spend_bullet()
~ hall_swarm_kills = hall_swarm_kills + 1
You fire at the nearest shape.

{hall_swarm_kills == 1:
It turns in the shot and collapses against the wall as if the idea of a spine left it all at once.
- else:
It drops beside one of the abandoned wheelchairs and keeps moving for a second after the rest of it has stopped.
}

The rest break pattern just long enough to give you breathing room.

{print_ammo_status()}
-> hall_a
- else:
The gun clicks dry.
Every moving thing in the hallway snaps toward the sound.
-> hall_swarm_attack
}
}

=== hall_swarm_run ===
~ raise_attention(1)

You break sideways and run.

A shape slams off the wall beside you.
Another catches your sleeve as you wrench past the overturned cart.

-> hall_swarm_attack

=== hall_swarm_hide ===
~ reduce_attention(1)

You flatten behind the overturned cart and tuck your arms in tight.

Bare feet tap tile inches away.
Something leans over the cart and draws air through its teeth, then drifts on.
After a long half minute the corridor thins back to scattered movement.

-> hall_a

=== hall_swarm_attack ===
The nearest one reaches you in a burst of elbows and teeth.
Another scores across your shoulder before both of them break away toward the side rooms.

~ take_damage(1)

{health <= 0:
-> death_hall_swarm
- else:
{print_health_status()}
You kick free, stagger backward, and force enough distance to breathe again.
-> hall_a
}

=== hall_trail ===
{
- hall_shape_dead == true:
    You follow the black streak into a shallow side alcove.

    The body lies against a dented medicine cart.
    Part of its face is gone.
    One arm is still hooked around the wheel as if it tried to steady itself before dying.

    It is not getting back up.

    + [Return to the hallway] -> hall_a

- hall_shape_gone == true:
    You follow the streak into a shallow side alcove.

    Only blood, loosened skin, and a bent medicine cart remain.
    Whatever drew itself in here kept going.

    + [Return to the hallway] -> hall_a

- else:
    You follow the streak into a shallow side alcove.

    The thing is still there.
    A narrow body is propped against a medicine cart, as if it studied the posture and got close enough.
    One arm hangs at a bad angle.
    Its ribs lift in small, uneven counts.
    When it notices you, the head adjusts toward you a little at a time.

    {player_id == "0023":
        * [Stand still and let it look at you] -> hall_attuned
    }
    * [Finish it] -> hall_finish
    + [Back away slowly] -> hall_a
}

=== hall_finish ===
{found_gun == false:
You have no gun.
The creature jerks toward you.
-> hall_shape_attack
- else:
{bullets > 0:
~ spend_bullet()
~ hall_shape_dead = true
You fire into its skull at close range.

The body knocks once against the cart, then slackens.
The dragging sound ends.

{print_ammo_status()}
-> hall_trail
- else:
The gun clicks empty.
The creature launches itself at you.
-> hall_shape_attack
}
}

=== hall_attuned ===
You do not move.

The thing trembles as it studies you.
For a second, its breathing falls into the same rhythm as your own.
Then it eases itself backward into a cracked wall panel and vanishes into the dark.

~ hall_shape_gone = true

You are left staring at the empty alcove and the dark streak it left behind.
-> hall_trail

=== hall_shape_attack ===
The wounded thing closes the distance in one broken rush.

Its teeth score across your forearm before it slips through the broken wall panel and disappears.

~ take_damage(1)
~ hall_shape_gone = true

{health <= 0:
-> death_hall_shape
- else:
{print_health_status()}
You stagger back into the hallway.
-> hall_a
}

=== mural_room ===
~ queue_hall_swarm_if_awake()
{
- visited_mural_room == true:
    You duck back into the low mural room.

    The paper sun, tilted stars, and fence drawing feel more deliberate now than they did at first glance.
    {found_small_passage == true:
    The low service hatch behind the cubbies still hangs open where you forced it.
    }
- else:
    ~ visited_mural_room = true
    You follow the faded handprints into a side room with a low ceiling and a cracked half-door.

    This room is different from the others.
    The chairs are too low.
    The wall mural shows a bright paper sun, trees, a tall fence, and a dark shape in the sky above it.

    A mobile made of painted stars hangs crookedly over a reading mat gone gray with dust.

    {found_mural == false:
    ~ found_mural = true
    On one wall, someone drew the facility from outside in thick crayon lines.
    The fence is taller than anything else in the picture.
    }
}

{print_status()}

{found_small_passage == false:
+ [Crawl through the low service hatch behind the cubbies] -> small_passage
}
* [Look at the crayon drawings more closely] -> mural_drawings
+ [Return to the hallway] -> hall_a

=== mural_drawings ===
~ knows_perimeter = true

You crouch near the wall.

Most of the drawings are suns, stick trees, and boxy rooms.
But one of them shows a black shape above the building with a spinning line over it.
Another shows the front fence, and a single dot on the wrong side of it with a line through the head.

The paper is warped from old water damage.
Some of the corners look like they were gripped by very small hands.

-> mural_room

=== small_passage ===
You lower yourself into the service hatch.

It is so narrow you have to move one shoulder at a time.
Dust clings to your skin.
At one point you have to pause while something scratches softly on the other side of the metal for several long seconds.

Then the sound passes.

~ found_small_passage = true

The hatch lets you out behind a stack of broken supply bins in Storage.

-> storage

=== observation ===
~ queue_hall_swarm_if_awake()
{
- visited_observation == true:
    You return to Observation.

    The dark glass, dead monitors, and half-open vent look exactly as abandoned as before.
- else:
    ~ visited_observation = true
    You enter Observation.

    One wall is made of thick glass, but the room beyond it is too dark to see clearly.
    Old monitors display static.
    A recorder on the desk is still blinking with power.

    There is a side door marked ARCHIVE.
    There is also a maintenance vent hanging partly open near the floor.
}

{print_status()}

* [Play the recorder] -> recorder
* [Search the desk] -> obs_desk
* {player_id == "0001" and knows_perimeter == false} [Study the blacked-out facility map] -> witness_map
+ [Open the ARCHIVE door] -> archive_room
+ [Crawl into the maintenance vent] -> vent_path
+ [Return to the hallway] -> hall_a

=== recorder ===
~ knows_root = true

You press play.

A tired voice crackles through the speaker:

"Patient response is no longer neurological.
It is environmental.
They react to light, movement... possibly intention.
Do not engage unless termination is certain."

Then another voice cuts in urgently:

"If there's anyone still left in Ward A, tell them not to trust the exit signs, there was -"

The audio crackles and becomes inaudible, then it ends.
-> observation

=== witness_map ===
~ knows_perimeter = true

You flatten the map beneath your palms and look past the black marker.

Most of the facility is erased,
but the marker was laid down in a hurry.
Its edges skip over old fold lines.
Where the ink thins, you can still read fragments:

EXTERIOR ROAD
RUNOFF CONTROL
AIR RETRIEVAL
NO CIVILIAN DISCLOSURE

You do not understand the science here.
But you understand a coverup.

The exits were not hidden after everything went wrong.
They were hidden before.

-> observation

=== obs_desk ===
You search the desk drawers.

There are broken pens, files swollen with water damage, and a yellow access card.

{keycard_a == false:
~ keycard_a = true
You take ACCESS CARD A.
- else:
The drawer where the card was is hanging open.
}

There is also a map of the facility, but most of it has been blacked out with marker.
-> observation

=== archive_room ===
You push open the ARCHIVE door.

The room beyond is narrow and cold.
Rows of file cabinets stand between leaning shelves of boxed records.
At the far end, a glass specimen cylinder has cracked down one side and leaked across the floor.

{
- archive_creature_revealed == false and killed_archive_creature == false and archive_creature_fled == false:
    Somewhere between the shelves, something keeps trying to draw breath through a damaged throat.
- killed_archive_creature == true:
    A pale, wire-limbed body lies crumpled between two cabinets where you dropped it.
- archive_creature_fled == true:
    A thin black line disappears beneath the lowest cabinet.
    Whatever was here withdrew deeper into the archive.
}

{player_id == "0023" and saw_subject_file == false:
One drawer at chest height stands slightly open.
A white tab on the folder inside reads:
SUBJECT 23
}

{print_status()}

{player_id == "0023" and saw_subject_file == false:
+ [Open the file marked SUBJECT 23] -> subject_file
}
* [Search the general records] -> archive_files
+ [Move between the shelves] -> archive_creature
+ [Return to Observation] -> observation

=== archive_files ===
~ knows_perimeter = true

You slide open one of the heavy drawers.

Inside are intake forms, medication schedules, transfer orders, and blacked-out disciplinary reports.
Most of the pages are warped with age.

You catch fragments:
"annex closed"
"perimeter protocol updated"
"air retrieval only"

Then something shifts softly between the shelves behind you.

-> archive_room

=== subject_file ===
~ saw_subject_file = true
~ knows_root = true

You pull the file free.

The page inside is thin and stiff with age.

SUBJECT 23
BRANCH STABILITY ABOVE PROJECTED THRESHOLD
AMBULATORY AFTER SEPARATION EVENT
DO NOT CLASSIFY AS RECOVERED CIVILIAN
DO NOT ALLOW UNSCHEDULED SURFACE CONTACT

Lower on the page, someone wrote by hand:

"If it still speaks like a person, do not listen for too long."

Your fingers tighten around the paper before you force yourself to set it back.

-> archive_room

=== archive_creature ===
{
- killed_archive_creature == true:
    The corpse between the cabinets has stopped twitching.
    Its limbs are too long for the narrow aisle.
    + [Return to the archive entrance] -> archive_room

- archive_creature_fled == true:
    Only the sound of slow dripping remains between the shelves.
    Whatever watched you here is gone.
    + [Return to the archive entrance] -> archive_room

- else:
    {archive_creature_revealed == false:
    ~ archive_creature_revealed = true
    You step between the shelves.

    A shape eases itself out of the gap between two file cabinets, using the metal like rails.
    Its torso is narrow as wire, but its shoulders scrape both sides at once.
    One eye is sealed shut with scar tissue.
    The other fixes on you as if it has already sorted you.
    - else:
    The archive creature is still threaded between the cabinets, breathing in dry little clicks.
    }

    {player_id == "0023":
    * [Stand still and let it come close] -> archive_attuned
    }
    * [Shoot it] -> archive_shoot
    + [Back away] -> archive_room
}

=== archive_shoot ===
{found_gun == false:
You have no gun.
The creature jerks toward you.
-> archive_attack
- else:
{bullets > 0:
~ spend_bullet()
~ killed_archive_creature = true
You fire once into the narrow aisle.

The report is deafening in the close room.
The creature slams through the cabinets, rattling them end to end, then collapses in a spill of limbs and records.

{print_ammo_status()}
-> archive_room
- else:
The gun clicks empty.
The creature launches itself down the aisle.
-> archive_attack
}
}

=== archive_attuned ===
You do not raise your hands.

The creature approaches without hurry.
It tilts the good side of its face toward your wristband, as if reading it by touch.
Then it recoils all at once, folding backward into the shadows beneath the shelves.

~ archive_creature_fled = true

The cabinets stop rattling.
The room goes still again.
-> archive_room

=== archive_attack ===
The creature hits you between the cabinets before you can turn.

Cold fingers hook into your shoulder and pull downward with steady, deliberate force before you wrench free.

~ take_damage(1)
~ archive_creature_fled = true

{health <= 0:
-> death_archive
- else:
{print_health_status()}
You stumble out of the archive and slam the door half-shut behind you.
-> observation
}

=== vent_path ===
You crawl into the maintenance vent.

The metal is cold against your bare knees.
The darkness ahead feels packed and physical, like the vent has swallowed air and kept it.

Halfway through, you hear something dragging itself through another shaft nearby.

+ [Keep crawling quietly] -> vent_success
+ [Back out now] -> observation

=== vent_success ===
You move slowly and carefully.

The sound passes.
You emerge in a dim storage room lined with shelves and broken boxes.

-> storage

=== storage ===
You step into Storage.

The room is cramped and full of medical waste bins, file boxes, and supply crates.

{
- locker_jammed == true:
    A reinforced door leads back into the main facility.
    The locker you trapped is pinned shut with a bent mop handle and a length of surgical tubing.
    Something taps from inside it now and then, but the door does not give.
- killed_specimen == true:
    A reinforced door leads back into the main facility.
    The locker you opened earlier is hanging wide, and what was inside lies spilled in front of it.
- locker_wounded == true:
    A reinforced door leads back into the main facility.
    The locker door is bent outward, and dark fluid has dried across its vent slits.
    Something inside keeps redistributing its weight.
- locker_revealed == true:
    A reinforced door leads back into the main facility.
    One locker now stands slightly ajar.
    Something inside has not decided whether to come out.
- else:
    A reinforced door leads back into the main facility.
    One locker answers the room with a soft tap from the inside.
}

{print_status()}

* {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> storage)
* [Search the supply crates] -> storage_crates
+ [Open the locker] -> locker_creature
+ [Leave through the reinforced door] -> generator_hall

=== storage_crates ===
You search the supply crates.

Under expired saline bags and cracked masks, you find a small box of handgun rounds.

{found_bullets_storage == false:
~ found_bullets_storage = true
~ add_bullets(1)
You take 1 bullet.
- else:
There is nothing left in the crate but dust and split cardboard.
}

{print_ammo_status()}
-> storage

=== locker_creature ===
{
- killed_specimen == true:
    You look into the locker.

    The corpse is still jammed half in and half out.
    One arm lies across the floor, too long for the compartment that held it.

    + [Back away] -> storage

- locker_jammed == true:
    You look at the trapped locker.

    The mop handle bows slightly every time the thing inside shifts,
    but the surgical tubing holds it against the frame.
    Whatever is inside has room to hate you and nothing else.

    + [Back away] -> storage

- locker_wounded == true:
    You pull the locker wider.

    The same gray creature is packed inside, one side of its face torn open and dark with blood.
    It adjusts toward you, but slower now.

    + [Finish it] -> locker_finish
    * [Kick the locker shut and wedge it closed] -> locker_jam
    + [Back away slowly] -> storage

- locker_revealed == true:
    You pull the same locker open again.

    The collapsed creature is still packed inside, watching from the dark gap between the door and frame.
    Its jaw works once on a hinge you do not trust.

    * [Shoot it] -> locker_shoot
    * [Kick the locker shut and wedge it closed] -> locker_jam
    + [Back away slowly and leave it] -> storage

- else:
    ~ locker_revealed = true
    You open the locker.

    A collapsed figure tips partway out onto the floor.
    Its limbs seem packed into the locker in the wrong order.
    Its mouth opens along one side first.

    It has not fully decided to unfold.

    * [Shoot it] -> locker_shoot
    * [Kick the locker shut and wedge it closed] -> locker_jam
    + [Back away slowly and leave it] -> storage
}

=== locker_jam ===
~ locker_jammed = true
~ locker_wounded = false
~ killed_specimen = false

You slam your shoulder into the locker door.

The creature folds backward with a wet snap and hits the rear wall of the compartment.
Before it can unfold again, you hook a bent mop handle through the latch and wrap surgical tubing twice around the frame.

The locker jumps once.
Then again.
Then settles into a steady, furious tapping.

You have not killed it.
You have made it the room's problem instead of yours.

-> storage

=== locker_finish ===
{found_gun == false:
You have no gun.
The creature unpacks itself toward you.
-> locker_attack
- else:
{bullets > 0:
~ spend_bullet()
~ killed_specimen = true
~ locker_wounded = false
You fire directly into its head.

This time it only answers once.
The locker door rings softly when its body hits the metal.

{print_ammo_status()}
-> storage
- else:
The gun clicks empty.
The creature lunges.
-> locker_attack
}
}

=== locker_shoot ===
{found_gun == false:
You have no gun.
The creature unpacks itself toward you.
-> locker_attack
- else:
{bullets > 0:
~ spend_bullet()
~ killed_specimen = true
~ locker_wounded = false
You fire directly into its head.
It convulses against the locker wall, then empties out onto the floor.

{print_ammo_status()}
-> storage
- else:
The gun clicks empty.
The creature lunges.
-> locker_attack
}
}

=== locker_attack ===
The creature hits you at chest height in the cramped room.
Its fingers close like loops of surgical wire.

~ take_damage(1)
~ locker_wounded = true

{health <= 0:
-> death_locker
- else:
{print_health_status()}
You shove it back and stumble through the reinforced door.
-> generator_hall
}

=== testing_hall ===
{power_on == true and faceless_released == false and killed_faceless == false and faceless_gone == false:
-> faceless_release
}

~ queue_hall_swarm_if_awake()

You enter the Testing wing.

Rows of glass chambers line the walls.
Most are shattered from the inside.

{
- killed_faceless == true:
    Broken glass litters the floor around the once-intact chamber.
    The faceless chamber thing lies crumpled beside it, one hand still pressed to a shard as if it stopped mid-motion.
- faceless_trapped == true:
    The once-intact chamber is open, but the thing from inside it is locked in a hardened shell of purge foam near the nozzles.
    The shell cracks quietly whenever it shifts.
- faceless_gone == true:
    The once-intact chamber now stands open and empty.
    Long hand-shaped streaks run down the inside of the glass where something taught itself how to leave.
- else:
    Inside one intact chamber, a pale figure rests both hands against the glass.
    Its face is smooth where features should begin.
    It watches you with perfect stillness.
}

At the end of the hall is LAB 3.
A side passage leads to POWER CONTROL.

{player_id == "0023" and power_on == true and heard_intercom_23 == false:
A ceiling speaker cracks to life above you.

"Branch Twenty-Three active."
A burst of static follows.
Then:
"Containment protocol pending."

~ heard_intercom_23 = true
}

{print_status()}

* {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> testing_hall)
+ [Go to Lab 3] -> lab3
+ [Go to Power Control] -> power_control
* [Hide between the chambers] -> hide_testing
+ [Return to main hallway] -> hall_a

=== faceless_release ===
~ faceless_released = true

You step into the Testing wing just as emergency power surges through the walls.

The intact chamber hisses.
Locks click open.
A line races across the glass.

Then the whole front panel bursts outward.

The chamber thing spills out on hands and feet, catches itself, and stands in one fast correction.
Its blank head tilts toward you as if checking whether you are where it expected.

{print_status()}

* [Shoot it] -> faceless_shoot
* [Trigger the chamber purge foam] -> faceless_foam
* [Hide between the chambers] -> faceless_hide
* [Run for Lab 3] -> faceless_lab_run

=== faceless_foam ===
You slam the yellow chamber override beside the broken frame.

The ceiling nozzles cough once, then vomit dense white suppression foam across the Testing wing.
The faceless thing takes two silent steps through it before the chemical mass hardens around its shoulders and arms.

It does not scream.
It only turns its blank head toward you from inside the foam shell,
still learning the shape of your escape while the shell locks it in place.

~ faceless_trapped = true
~ reduce_attention(1)

You slip past before the foam starts cracking.
-> testing_hall

=== faceless_shoot ===
{found_gun == false:
You have no gun.
The faceless thing closes the distance without making a sound.
-> faceless_attack
- else:
{bullets > 0:
~ spend_bullet()
~ killed_faceless = true
You fire into the center of its chest.

It buckles sharply at the middle, hits the floor, and still tries once to rise before the motion leaves it.

{print_ammo_status()}
-> testing_hall
- else:
The gun clicks empty.
The faceless thing launches toward you.
-> faceless_attack
}
}

=== faceless_hide ===
You dive between two shattered chambers and flatten yourself against cold glass.

The faceless thing passes close enough that you hear its breathing somewhere under the skin.
It does not look directly at you.
It only slows, head angled, as if listening through the rows of glass.
Then it slips away down a dark service passage you did not notice before.

~ faceless_gone = true
-> testing_hall

=== faceless_lab_run ===
~ raise_attention(1)

You turn and sprint for Lab 3.

As you reach the doorway, the faceless thing catches between your shoulders with cold, precise fingers.
The frame catches its shoulder and knocks it sideways before it can settle its grip.

~ take_damage(1)
~ faceless_gone = true

{health <= 0:
-> death_faceless_lab
- else:
{print_health_status()}
You slam yourself through the doorway and do not stop until you hit the far desk.
-> lab3
}

=== faceless_attack ===
~ raise_attention(1)

The faceless creature hits you in a single clean movement and knocks the air out of your lungs.

Its smooth face touches yours for one impossible second, like it is comparing shape to shape, before you wrench free.

~ take_damage(1)
~ faceless_gone = true

{health <= 0:
-> death_faceless_glass
- else:
{print_health_status()}
You stagger back down the hall as the creature slips away into darkness.
-> testing_hall
}

=== hide_testing ===
You slip between two cracked observation pods and wait.

{
- killed_faceless == true:
    Nothing moves between the chambers now except dust drifting through the emergency light.
    The dead thing near the broken glass does not rise.
- faceless_trapped == true:
    The purge-foam shell near the shattered chamber gives one slow crack.
    Whatever is inside shifts against it, then goes still again.
- faceless_gone == true:
    Somewhere down the dark service passage, a tall shape scrapes once against metal and keeps going away from you.
- else:
    A tall shape glides past the hall entrance.
    No eyes show on the front of its head.
    It turns slowly anyway, as if the glass around you is making enough noise.

    After several seconds, it moves on.
}

You exhale.
-> testing_hall

=== lab3 ===
{
- visited_lab3 == true:
    You step back into Lab 3.

    The restraints, the weak terminal glow, and the body under the desk feel even colder the second time.
- else:
    ~ visited_lab3 = true
    Lab 3 looks like it was abandoned during surgery.

    Tools are laid out neatly beside restraints bolted into a reclining chair.
    The overhead lamp still works, but it pulses weakly.
    A terminal on the wall shows a repeated error message.
    A corpse in a lab coat is folded beneath the desk.
}

{print_status()}

* [Search the corpse] -> corpse_lab
* [Use the terminal] -> terminal_lab
* {found_medkit == false} [Open the red trauma case on the wall] -> trauma_case
* {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> lab3)
+ [Return to Testing] -> testing_hall

=== corpse_lab ===
~ knows_purge = true

You search the lab coat.

Inside the coat pocket is a second access card and a folded note.

{keycard_b == false:
~ keycard_b = true
You take ACCESS CARD B.
- else:
The second pocket is turned inside out where you already searched it.
}

The note reads:
"If Nest is active, do not go to Exit Processing.
Burn the root or it will follow you outside."
-> lab3

=== terminal_lab ===
~ knows_root = true
~ knows_purge = true

You tap the terminal keys.

The screen stabilizes just enough to display a file:

PROJECT MIMIC ROOT
SUBJECTS ARE NOT HOSTS.
SUBJECTS ARE BRANCHES.
PRIMARY MASS LOCATED NEAR EXIT PROCESSING.
INCINERATION REQUIRED.

You stare at the final line until the screen goes black again.

The objective rearranges itself in your head.
Access cards were never the end.
The exit may not be enough.

-> lab3

=== trauma_case ===
~ found_medkit = true

The red case resists until you crack the seal with the heel of your hand.

Inside is a single trauma injector,
a packet of clotting gauze,
and a printed instruction card with most of the warnings blacked out.

The injector is military gray.
One dose.
No refill.

{health < 3:
* [Use the trauma injector now] -> use_trauma_now
* [Save it for later] -> save_trauma_injector
- else:
You are not hurt badly enough to waste it yet.
You slide the injector into the gown's torn pocket.
~ has_medkit = true
-> lab3
}

=== save_trauma_injector ===
~ has_medkit = true

You pocket the injector.

The plastic body is cold through the gown,
small enough to carry,
important enough to feel like weight.

-> lab3

=== use_trauma_now ===
~ heal(1)

You press the injector against your thigh and trigger it.

Cold pressure punches through muscle.
For one second your whole body tastes like copper.
Then the worst of the pain pulls back from the edge of panic.

{print_health_status()}
-> lab3

=== use_trauma_injector(-> return_to) ===
~ has_medkit = false
~ heal(1)

You pull the trauma injector from your pocket and press it against your thigh.

The dose burns cold.
Your hands stop shaking enough to be useful again.

{print_health_status()}
-> return_to

=== power_control ===
You enter Power Control.

The room is full of breaker panels and emergency battery units.
A backup generator sits in the corner with a manual start lever.

{
- killed_nest == true:
    Dark fluid has dried in thin trails beneath the vent above the generator.
    What nested there hangs partway out of the opening, emptied of tension.
- nest_wounded == true:
    Something keeps worrying at the metal from inside the vent above the generator.
    Dark fluid beads along the grille and drops at uneven intervals.
- else:
    Something has rooted itself into the vent above the generator.

    A pale thread lowers from the grille, trembles in the air, then draws back up out of sight.
}

{print_status()}

{
- killed_nest == true:
    * {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> power_control)
    + [Return to Testing] -> testing_hall
- nest_wounded == true:
    + {found_gun == true and bullets > 0} [Shoot into the vent] -> finish_nest
    * {found_gun == true and bullets <= 0 and tried_empty_nest_finish == false} [Try to shoot into the vent] -> finish_nest
    * {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> power_control)
    + [Retreat] -> testing_hall
- else:
    * {found_gun == true and bullets > 0} [Shoot the thing in the ceiling] -> shoot_ceiling
    * {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> power_control)
    * [Start the generator quietly] -> start_generator_quiet
    + [Retreat] -> testing_hall
}
=== finish_nest ===
{found_gun == false:
You raise an empty hand toward the vent.
That is not going to help.
-> power_control
- else:
{bullets > 0:
~ spend_bullet()
~ killed_nest = true
~ nest_wounded = false
You fire into the vent.

Something beats once against the metal above you, then slips halfway out and hangs there, unfinished and still.

{print_ammo_status()}
-> power_control
- else:
~ tried_empty_nest_finish = true
~ raise_attention(1)
The gun clicks dry.
The thing in the vent scrapes farther back into the dark.
-> power_control
}
}

=== start_generator_quiet ===
~ raise_attention(1)

You move slowly to the lever.

You start to pull it, but the machine shrieks to life with a metallic roar.

The thing in the vent lets go at once.

-> ceiling_attack

=== shoot_ceiling ===
{found_gun == false:
You raise an empty hand.
Bad instinct.
-> ceiling_attack
- else:
{bullets > 0:
~ spend_bullet()
~ power_on = true
~ killed_nest = true
~ nest_wounded = false
You fire into the ceiling nest.

A shriek explodes through the room.
The thing loses its hold and drops beside the generator in a loose, half-made heap.
It claws once for the wall, then stops.
You pull the backup lever.
Power returns to part of the facility.

{player_id == "0023" and heard_intercom_23 == false:
A speaker somewhere in the wall crackles to life.

"Branch Twenty-Three active."
Static swallows the next words before the system dies again.

~ heard_intercom_23 = true
}

{print_ammo_status()}
-> testing_hall
- else:
The gun clicks empty.
The nest bursts open.
-> ceiling_attack
}
}

=== ceiling_attack ===
A half-made thing drops onto you from the vent above.

It moves with brutal certainty in the space between ceiling and floor, all grasping limbs and sudden weight.
You wrench free, but its hooked limbs rake across your shoulder and back.

~ take_damage(1)
~ power_on = true
~ nest_wounded = true

{player_id == "0023" and heard_intercom_23 == false:
Emergency power hums back to life.
A hidden speaker spits one broken sentence into the room:

"Return Subject Twenty-Three to Processing."

~ heard_intercom_23 = true
}

{health <= 0:
-> death_backup_feed
- else:
{print_health_status()}
The power comes on as the creature retreats into the vents.
-> testing_hall
}

=== security_door ===
~ queue_hall_swarm_if_awake()

You reach Security.

A reinforced shutter blocks the entrance.
There is a card reader beside it.

{keycard_a == false:
The reader stays red.
You need ACCESS CARD A before this door will open.
+ [Return to the hallway] -> hall_a
- else:
The reader flashes yellow.
CARD A ACCEPTED.
ADDITIONAL CLEARANCE REQUIRED.
{keycard_b == false:
Still locked.
You need ACCESS CARD B as well.
+ [Return to the hallway] -> hall_a
- else:
The shutter grinds open.
-> security_room
}
}

=== security_room ===
~ queue_hall_swarm_if_awake()

{
- visited_security_room == true:
    You step back into Security.

    The dead monitors cast the same weak light over the safe, locker, and floor.
- else:
    ~ visited_security_room = true
    The Security room is dim and lined with dead monitors.
    A few still work, each showing different corridors from around the facility.
}

{ killed_stalker == true:
One monitor still shows EXIT PROCESSING.
The camera watches the fallen guard creature lying beside the root mass.
- else:
One monitor displays EXIT PROCESSING.
The door there is open.
Something large moves just off camera.
}

A desk safe sits under the monitor bank.
A wall locker is slightly open.

{print_status()}

* {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> security_room)
* [Check the wall locker] -> security_locker
* [Check the desk safe] -> desk_safe
* {reviewed_security_feeds == false} [Review the perimeter cameras] -> security_feeds
+ [Go to Exit Processing] -> exit_processing
+ [Return to hallway] -> hall_a

=== security_locker ===
You open the wall locker.

Inside is a tactical belt, dried blood, and a small ammo pouch.

{found_bullets_security == false:
~ found_bullets_security = true
~ add_bullets(1)
You take 1 bullet.
- else:
Only the torn pouch remains.
}

{print_ammo_status()}
-> security_room

=== desk_safe ===
~ knows_purge = true
~ knows_perimeter = true

The safe door is already cracked open.

Inside is one final loose round and a handwritten security memo.

{found_bullets_lab == false:
~ found_bullets_lab = true
~ add_bullets(1)
You take 1 bullet.
- else:
The safe is empty now except for the memo.
}

The memo says:
"If evacuation fails, trigger PURGE in the furnace room beyond Exit Processing."

{print_ammo_status()}
-> security_room

=== security_feeds ===
~ reviewed_security_feeds = true
~ knows_perimeter = true
~ knows_purge = true

You drag a rolling chair in front of the live monitors and force yourself to watch them carefully.

One exterior camera shows the service road,
the fence line,
and a painted landing mark for air retrieval.
Another shows the utility shed by the runoff controls.
The road was never meant to lead survivors anywhere.
It was meant to hold them where cameras could see.

On the Exit Processing feed, the guard creature repeats the same circuit again and again:
three steps,
pause,
turn,
correct.
It is not hunting like an animal.
It is running an old checkpoint routine with meat wrapped around it.

~ observed_guard_routine = true

{player_id == "0001":
The pattern is ugly, but it is a pattern.
You do not need to understand the experiment to understand a guard post.
}

{player_id == "0012":
The camera angle makes the decontamination arch look like a doorway in a drawing.
You mark the small space beneath its swing.
}

{player_id == "0023":
For a second, the creature on the monitor stops at the exact moment you expect it to.
Something in you recognizes the rhythm before you want it to.
}

-> security_room

=== generator_hall ===
{
- visited_generator_hall == true:
    You return to the service corridor beyond Storage.

    {power_on == true:
    The red emergency strips still glow near the floor, and the dark growths still web the walls.
    - else:
    The emergency strips along the floor are still dark, leaving the corridor mostly lit by weak spill light from Storage.
    The dark growths still web the walls.
    }
- else:
    ~ visited_generator_hall = true
    You enter a service corridor beyond Storage.

    {power_on == true:
    Now that some power is back on, red emergency strips glow near the floor.
    - else:
    The emergency strips along the floor are dead here, leaving most of the corridor in shadow.
    }
    The corridor leads toward a rear Security access door, and another direction toward Exit Processing.

    The walls here are covered in strange dark growths, like veins or roots beneath translucent skin.
}

{print_status()}

+ {keycard_a == false or keycard_b == false} [Try the rear Security access] -> rear_security_access
+ {keycard_a == true and keycard_b == true} [Go toward rear Security access] -> rear_security_access
* {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> generator_hall)
+ [Follow the growths toward Exit Processing] -> exit_processing
* [Hide in the service recess] -> hide_service
+ [Go back to Storage] -> storage

=== rear_security_access ===
You move down the service corridor to a heavy rear Security door.

A dual card reader is mounted beside it.
The red light above the frame stays solid.

{keycard_a == false or keycard_b == false:
The rear door needs the same clearance as the main one.
It does not open.
+ [Go back down the corridor] -> generator_hall
- else:
The light shifts green.
The lock disengages with a heavy clunk.
-> security_room
}

=== hide_service ===
You flatten yourself into a shallow maintenance recess.

Something passes down the corridor:
a tall figure moving with one side half a beat behind the other.
One leg trails stiffly.
Its head keeps adjusting in short, overcareful increments.
It pauses near you.

You do not move.

Eventually it continues on.

You remain unseen.
-> generator_hall

=== exit_processing ===
{
- visited_exit_processing == true:
    You enter Exit Processing again.

    The decontamination arches and shutter are unchanged, but the room feels more awake than before.
- else:
    ~ visited_exit_processing = true
    You enter Exit Processing.

    This room must once have been the final checkpoint before leaving the facility.
    Decontamination arches line the walls.
    A large rolling shutter at the far end leads outside.

    But the floor is covered in pulsating organic mass.
    The growths from the corridor all lead here.
    At the center, a heaving mass of tissue and white structural shapes has fused itself into the foundation.
}

{
- killed_stalker == true:
    The guard creature lies collapsed beside the pulsing mass.
    Beyond it, the path to the furnace control panel is open.
- else:
    One upright shape unhooks itself from the mass and takes its place between you and the control path.
}

{blood_trail == true and killed_stalker == false:
Its head angles toward the torn places in your gown.
The root does not need eyes to understand a trail.
}

{print_status()}

* {killed_stalker == false} [Hide and observe] -> observe_root
+ {killed_stalker == false} [Fight the guard creature] -> fight_guard
+ {killed_stalker == true} [Approach the control path] -> root_final
* {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> exit_processing)
+ [Run back] -> security_room

=== observe_root ===
~ observed_guard_routine = true
~ knows_purge = true
~ knows_root = true

You keep low behind an overturned decontamination cart.

You watch the room carefully.

The guard creature moves in clipped, deliberate circuits, like a checkpoint routine still running without staff.
Behind the root mass, you spot a furnace control panel set into the wall.
A label beneath it reads:
PURGE CHAMBER

If the root lives, the facility is not really escaped.
-> exit_processing

=== fight_guard ===
The guard creature notices you instantly.

Its chest parts along a narrow seam with the neatness of a door.

+ [Shoot it] -> shoot_guard
* {observed_guard_routine == true} [Move with its checkpoint pattern] -> guard_pattern
+ [Try to dodge past it] -> dodge_guard

=== guard_pattern ===
You do not try to outrun it.
You move on the rhythm you watched from behind the cart:
three steps,
pause,
let it correct,
then cut under the decontamination arch as it commits to the wrong angle.

The guard follows the routine more faithfully than the body can survive.
Its shoulder hooks beneath the arch.
The emergency frame clamps down with a hydraulic snap,
pinning it long enough for the root tendon in its chest to tear free.

The creature collapses in sections beside the mass,
still obeying a checkpoint that is no longer there.

~ killed_stalker = true
~ reduce_attention(1)

-> root_final

=== shoot_guard ===
{found_gun == false:
You have no gun.
The guard creature closes the gap before you can move.
-> guard_hit
- else:
{bullets > 0:
~ spend_bullet()
~ killed_stalker = true
You fire into the opening in its chest.
It recoils as if you struck something functional, then collapses beside the root in a hard rattle of limbs.

{print_ammo_status()}
-> root_final
- else:
The gun is empty.
-> guard_hit
}
}

=== dodge_guard ===
~ raise_attention(1)

You try to slip around it.

Its arm shoots across the gap with the efficiency of a closing gate and catches your side.

-> guard_hit

=== guard_hit ===
~ take_damage(1)

{health <= 0:
-> death_root_taken
- else:
{print_health_status()}
You stagger back across the room while the root shifts behind it in slow approval.
-> exit_processing
}

=== root_final ===
You stand in Exit Processing again.

The guard creature lies collapsed beside the pulsing mass.
The path to the control panel is open.
The shutter to the outside is only a short distance beyond it.

{knows_purge == true:
The furnace label matches every warning you have collected:
PURGE CHAMBER.
}

{knows_root == true:
You understand the cruel shape of the choice now.
Leaving is survival.
Burning it is prevention.
Staying until the burn completes is the only way to know it ends here.
}

{returned_after_escape == true:
You have already felt the night air once.
Coming back makes the control panel look less like a machine and more like a verdict.
}

{player_id == "0023" and touched_root == false:
* [Touch the root mass] -> root_communion
}
* {has_medkit == true and health < 3} [Use the saved trauma injector] -> use_trauma_injector(-> root_final)
+ [Open the shutter and escape now] -> ending_escape_bad
+ [Trigger the purge furnace, then run] -> ending_escape_mid
+ [Trigger the purge furnace and stay until it is done] -> true_ending
+ [Back away and return to Security] -> security_room

=== root_communion ===
~ touched_root = true

You step closer and place a hand against the outer layer of the root.

It is warm.
Not like flesh.
Warmer.
Like a deeper system pressing up through the floor.

The mass shudders.

For one second you are somewhere else:
a glass room,
white lights,
a voice saying "stable after separation,"
and another voice answering,
"Do not let it see the sky unless retrieval is ready."

Then the vision snaps away.

The root draws back from your hand as if identification is complete.

-> root_final

=== ending_escape_bad ===
You force open the shutter and stumble outside into cold night air.

For the first time, you see the world beyond the facility:
a fenced service road,
pine trees in the dark,
mist under floodlights.

You are out.

But behind you, deep inside the structure, the root still lives.
You hear one last heavy impact against the inside of the shutter.

{knows_root == true:
You know enough now to understand the sound.
It is not a monster throwing itself at a door.
It is a system testing the first obstacle between itself and the world.
}

-> outside_unburned

=== ending_escape_mid ===
{power_on == false:
The purge controls are dead.
You need facility power first.

+ [Return to the root chamber] -> root_final
+ [Go back and find a way to restore power] -> security_room
- else:
~ burned_clean = false

You slam the furnace control and run.

The facility shakes.
Smoke and sparks flood Exit Processing.
You dive beneath the rising shutter and spill out onto cracked concrete outside.

{returned_after_escape == true:
This time the outside does not feel like escape.
It feels like a question you still have not answered.
}

The night air hits your skin like ice.
Above you, the facility burns in sections, but not all of it.

Maybe enough died.
Maybe not.

{knows_purge == true:
The memo said trigger PURGE.
It never said the fire would forgive you for leaving early.
}

-> outside_burned
}

=== true_ending ===
{power_on == false:
The purge controls are dead.
You need facility power first.

+ [Return to the root chamber] -> root_final
+ [Go back and find a way to restore power] -> security_room
- else:
~ burned_clean = true

You stay at the controls and watch.

The furnace roars hotter.
The root mass shrieks with a thousand layered voices.
Faces emerge in the flesh, melting as fast as they form.

Only when the entire chamber is engulfed do you run.

You sprint through smoke and emergency light, throw yourself beneath the half-open shutter, and crash onto the pavement outside.

{returned_after_escape == true:
You know the cold before it hits you.
You chose to come back anyway.
}

Cold night air fills your lungs.
The facility behind you groans, then collapses inward in a storm of sparks and flame.

Beyond the fence, the road disappears into the dark woods.
But the thing below is dead.
Truly dead.

{knows_root == true:
For the first time since waking, the facility is only a building again.
A burning one.
A guilty one.
But no longer a living one.
}

-> outside_burned
}

=== outside_unburned ===
{
- player_id == "0001":
    -> outside_unburned_0001
- player_id == "0012":
    -> outside_unburned_0012
- else:
    -> outside_unburned_0023
}

=== bind_blood(-> return_to) ===
~ blood_trail = false
~ reduce_attention(1)

You stop long enough to make the bleeding less obvious.

There is not enough cloth to do it cleanly,
so you tear a strip from the gown,
press it hard against the worst place,
and knot it until the pain flashes white.

It will not heal you.
It will only make the trail harder to read.

{player_id == "0012":
The knot is clumsy in your small hands, but it holds.
}

{player_id == "0023":
For a second the blood on your fingers looks too dark under the floodlights.
Human enough.
That has to be enough.
}

-> return_to

=== outside_unburned_0001 ===
You stand outside the facility, breathing steam into the cold.

Floodlights wash the fence in pale yellow.
The pine woods beyond it look close enough to touch and impossibly far away.

{knows_perimeter == true:
The perimeter is not rescue infrastructure.
You understand that now.
It is the facility continuing outside the walls.
}

{saw_perimeter_shed == true:
The utility shed door still hangs partly open beside the service road.
- else:
A squat utility shed leans beside the service road.
}

{removed_wristband == true:
The skin beneath your wristband feels raw in the cold.
}

{blood_trail == true:
Cold air finds every torn place in your gown.
You are outside, but you are not hard to track.
}

Behind you, something hits the inside of the shutter again.

* {blood_trail == true} [Bind the bleeding before moving] -> bind_blood(-> outside_unburned_0001)
+ [Search the utility shed] -> perimeter_shed_0001
* [Stand in the open and wave toward the floodlights] -> death_searchlight_fixed
* [Stay near the shutter and listen] -> death_shutter_claimed
* [Try to climb the fence] -> sniper_death
+ [Go back inside and finish it] -> return_inside_0001

=== perimeter_shed_0001 ===
{
- saw_perimeter_shed == true:
    You return to the utility shed.

    The emergency phone hangs beside the wall where you left it.
    The runoff schematic is still pinned in place above the half-hidden hatch.
    {found_perimeter_evidence == true:
    The plastic incident folder is gone from the wall bracket because it is pressed under your arm.
    }
- else:
    ~ saw_perimeter_shed = true
    The shed door sticks before it gives.

    Inside: a rusted emergency phone, runoff schematics pinned to the wall, a wall bracket of sealed incident folders, and a maintenance hatch half hidden beneath a tarp.

    The map shows a drainage trench running beneath the outer fence toward the pines.
}

* {found_perimeter_evidence == false} [Pull down the incident file and radio sheet] -> shed_evidence_0001
* {removed_wristband == false} [Cut off the wristband with a rusted box cutter] -> remove_band_0001
* [Follow the runoff trench] -> ending_0001_runoff
* [Use the emergency phone] -> ending_0001_detained
+ [Return to the road] -> outside_unburned_0001

=== shed_evidence_0001 ===
~ found_perimeter_evidence = true

You tear the nearest folder from its wall bracket.

Inside are damp pages stamped:
SURFACE CONTACT PROTOCOL
NONCIVILIAN SURVIVOR HANDLING
PURGE AUTHORIZATION CHAIN

The radio sheet clipped to the back lists call signs, clearance phrases, and a short warning in red ink:

IF A SURVIVOR CAN DESCRIBE THE ROOT, ASSUME BREACH OF CONFIDENTIAL CONTAINMENT.

You fold the papers under your arm.
They are thin.
They feel heavier than the gun ever did.

-> perimeter_shed_0001

=== remove_band_0001 ===
~ removed_wristband = true

You take the rusted box cutter from a shelf and saw at the plastic band until it snaps.

For a second you expect an alarm.
Nothing sounds.

That somehow feels worse.

{found_perimeter_evidence == true:
You tuck the broken band into the incident folder, because even the number they gave you is evidence now.
- else:
You tuck the broken band into your gown, because even the number they gave you might matter later.
}

-> perimeter_shed_0001

=== ending_0001_runoff ===
You wrench up the hatch and drop into freezing runoff water.

The trench is narrow, dark, and lined with slime.
You crawl because there is no room to do anything else.

Above you, the fence hums.
Behind you, something in the facility hits metal hard enough to shake dirt loose into your hair.

{found_perimeter_evidence == true:
The incident folder is wrapped inside your gown.
Every few yards you check that it is still there.
}

{removed_wristband == true:
Above you, a speaker crackles once and says:
"Signal lost on exterior subject."
No one answers it.
}

At last the trench widens.
You drag yourself out into a drainage ditch beyond the perimeter and lie there in the wet pine needles, shaking and alive.

You never see the facility clearly again.
Only the glow of its floodlights through the trees, growing smaller as you keep walking.

{
- found_perimeter_evidence == true:
    By dawn, you know two things:
    you are out,
    and someone will spend the rest of their life wishing you had not carried those pages with you.
- else:
    By dawn, you know two things:
    you are out,
    and the road behind you is not a place anyone will admit exists.
}

ENDING: THROUGH THE RUNOFF
-> END

=== ending_0001_detained ===
You lift the emergency phone and force it to life.

Static crackles.
Then a calm male voice answers almost immediately, as if someone was waiting beside the line.

"State your clearance."

{found_perimeter_evidence == true:
You read the first clearance phrase from the radio sheet.

The silence afterward is immediate and total.

"Who gave you that sheet?"

"Your shed did," you say.
- else:
"I don't have one," you say. "I just got out."
}

Silence.
Then:
"Stay where you are. Hands visible."

A perimeter truck arrives before anything else can come out of the building.
They search you.
{removed_wristband == true:
They photograph the broken wristband after taking it from you.
- else:
They photograph the wristband while it is still attached to you.
}

{found_perimeter_evidence == true:
When the woman in the rear seat opens the incident folder, her expression changes.
Not fear exactly.
Recognition.

"Seal the road," she tells the driver. "No more radio traffic."

They do not ask what happened inside until the truck is already moving.
When they finally do, the recorder light is red.
- else:
They put you in the back without explaining where you are going.
}

It is not rescue.
But it is out.

{
- found_perimeter_evidence == true:
    ENDING: WITNESS REMOVED
- else:
    ENDING: HELD FOR DEBRIEF
}
-> END

=== return_inside_0001 ===
~ returned_after_escape = true

You turn and duck back under the half-raised shutter before it can slam all the way down.

The heat and stench hit you again immediately.
The dead guard creature still lies where it fell.
The root chamber waits for you.

-> root_final

=== outside_unburned_0012 ===
You stand outside in the freezing air.

The fence feels even taller out here.
Floodlights buzz above the service road.
The woods beyond them sway in the dark like they are waiting for something.

Behind you, the shutter jumps once from a heavy impact inside.

{found_mural == true:
You cannot stop thinking about the drawing:
the fence,
the dark shape in the sky,
and the small mark low near the edge of the wall.
}

{heard_lullaby == true:
For half a breath you think you hear the broken lullaby again through an exterior speaker.
Then the note bends into static.
}

{found_lullaby_scrap == true:
The folded paper map is soft in your hand.
It says the wall has a small place.
It says someone smaller than the fence can still be larger than the plan.
}

{blood_trail == true:
Blood dots the cold concrete behind you in small, bright marks.
The fence is not the only thing that can be followed.
}

* {blood_trail == true} [Bind the bleeding before moving] -> bind_blood(-> outside_unburned_0012)
+ [Follow the wall and look low along the fence line] -> low_gap_0012
* [Call out toward the floodlights] -> ending_0012_quarantine
* [Stay close to the shutter and listen] -> death_shutter_claimed
* [Try to climb the fence] -> sniper_death
+ [Go back inside and finish it] -> return_inside_0012

=== low_gap_0012 ===
{
- saw_low_gap == true:
    You return to the far corner of the perimeter wall.

    The bent conduit pipe and broken mesh still hide the same narrow opening.
- else:
    ~ saw_low_gap = true
    You move along the wall with one hand against the cold concrete.

    Near the far corner, behind a bent conduit pipe and a spill of dead weeds, you find it:
    a runoff opening half covered by broken mesh,
    small enough that an adult would never have looked twice.

    {found_small_passage == true:
    Your shoulders remember how to turn sideways before your mind catches up.
    }

    {found_mural == true:
    It is exactly where the crayon line in the mural said it would be.
    }
}

* [Crawl through] -> crawl_gap_0012
+ [Back away] -> outside_unburned_0012

=== crawl_gap_0012 ===
You flatten yourself and crawl into the opening.

Wet grit presses into your knees and elbows.
The pipe roof is so low your breath comes back warm against your face.

Above you, a searchlight rolls over the weeds.
Someone outside the fence says, "Check low. Smaller subject may use drainage."

For one terrible second, you stop moving.

* [Keep crawling toward the cold air] -> ending_0012_small_way
* [Freeze and wait for the voices to pass] -> ending_0012_quarantine

=== ending_0012_small_way ===
Somewhere behind you the shutter bangs again, then something screams inside the building in a voice too ruined to still be human.

You keep crawling.

At last you slide out into cold brush beyond the fence.
No spotlight finds you.
No one calls your number.
The trees take you in without a sound.

{found_mural == true:
When you look back once, the facility is the same shape as the crayon building on the wall.
This time, the small mark is on the right side of the fence.
}

ENDING: SMALL WAY OUT
-> END

=== ending_0012_quarantine ===
You raise both hands and call once into the dark.

For a few seconds nothing happens.
Then one floodlight turns.
Then another.

A voice from a mounted speaker cuts through the night:
"Remain visible. Do not approach the fence."

A two-person perimeter team reaches you in sealed masks and thermal cloaks.
One of them looks at the wristband and then at you for a little too long.

They wrap you in a gray blanket and lead you toward a waiting transport van instead of the woods.

{heard_lullaby == true:
Inside the van, one of the speakers clicks with static.
You brace for the song.
Nothing comes.
}

You are leaving.
You are not free.
But you are alive.

ENDING: QUARANTINED WITNESS
-> END

=== return_inside_0012 ===
~ returned_after_escape = true

You slip back beneath the shutter and into the heat and smoke.

The room feels even bigger now that you have seen the dark outside.
The dead guard creature lies in a twisted heap beside the root.

You make yourself keep moving.

-> root_final

=== outside_unburned_0023 ===
You step out onto the cracked service road.

The fence hums faintly in the floodlights.
Beyond it, the pines lean and sway together in the wind.

For a second the pressure behind your eyes returns.
Some part of you feels the root still moving below the floor.
Not calling yet.
Waiting.

{blood_trail == true:
Your blood marks the road in dark, separate drops.
Some buried part of you understands trails.
That makes this worse, not better.
}

* {blood_trail == true} [Bind the bleeding before moving] -> bind_blood(-> outside_unburned_0023)
* [Step into the floodlight and let them see you] -> ending_0023_retrieved_early
* [Tear off the wristband and wait near the road] -> ending_0023_false_early
+ [Follow the pressure along the fence line] -> ending_0023_rootmark
* [Stand still and let the pressure deepen] -> death_root_recalled
+ [Go back inside] -> return_inside_0023

=== ending_0023_retrieved_early ===
You step fully into the light.

It finds you too fast.
Not searching.
Recognizing.

A mounted speaker crackles above the road.

"Visual confirmation pending."
Then, after a pause:
"Visual confirmed. Subject Twenty-Three outside containment."

A black transport truck arrives instead of a rescue helicopter.
When the rear doors open, the people inside already know your number.

They do not ask if you are hurt.
They do not ask your name.

A restraint frame slides out from the truck floor.
Someone says "ambulatory" with the flat relief of a person confirming equipment survived transit.

You understand every word they say.
That does not change what they call you.

ENDING: RECOVERED ASSET
-> END

=== ending_0023_false_early ===
~ removed_wristband = true

You rip the band free and bury it beneath ash and gravel with the toe of your bare foot.

Then you wait in the edge of the light with your shoulders slumped and your eyes unfocused, like someone emptied out instead of escaped.

When the perimeter vehicle arrives, the woman who steps out does not greet you.
She studies your face.
Then your bare wrist.
Then the ruined building behind you.

"One civilian survivor," she says into her radio.
But she says it carefully.

{saw_subject_file == true:
You remember the file warning:
DO NOT CLASSIFY AS RECOVERED CIVILIAN.
}

They take you anyway,
but they use a blanket instead of restraints until the doors close.

ENDING: FALSE CIVILIAN
-> END

=== ending_0023_rootmark ===
You follow the fence instead of the road.

The farther you go, the stronger the pressure becomes.
Not pain.
Orientation.

Behind a transformer box half sunk in gravel, you find a service culvert with its grate already bent outward.
From inside comes warm air carrying the same mineral-organic smell as the root chamber below.

{touched_root == true:
For one second your palm burns again with remembered heat.
}

* [Crawl through the culvert and keep going] -> ending_0023_rootmark_escape
* [Let the pressure deepen until it tells you where to go] -> death_root_recalled
+ [Back away from it] -> outside_unburned_0023

=== ending_0023_rootmark_escape ===
You lower yourself into the culvert and move toward the dark.

It bends under the fence line and out toward the trees.
By the time you emerge, the facility is behind you, half hidden by earth and concrete and distance.

The pressure in your skull does not vanish.
It only thins.

{touched_root == true:
Your palm still knows the root is alive.
It knows the root knows you are outside.
}

Whatever tied you to the place is stretched now, not broken.
But stretched is enough.

ENDING: ROOTMARK ESCAPE
-> END

=== return_inside_0023 ===
~ returned_after_escape = true

You turn back toward the facility.

The shutter opening seems to widen for you a fraction before you duck through.
Inside, the root chamber waits with the dead guard sprawled beside it, as if it knew you would return.

-> root_final

=== death_hall_swarm ===
You lose your footing between the wheelchairs.

One of them hits you high.
Another takes your legs out from under you.
The corridor fills all at once with elbows, teeth, hospital fabric, and flickering fluorescent light.

You never see which mouth reaches your throat.
Only the ceiling stuttering white above you as the whole ward finally comes alive.

ENDING: HALL CONSUMED
-> END

=== death_hall_shape ===
You crumple beside the dented cart.

The wounded thing does not flee this time.
It catches your gown and works you toward the broken wall panel in short, efficient pulls.

By the time the sound stops, the alcove is empty again.
Only the cart is left vibrating beside the wall.

ENDING: INSIDE THE WALL
-> END

=== death_archive ===
You slam backward into the open drawers and cannot get your footing again.

Folders burst around you.
Paper sticks to your blood and skin.
The creature keeps working itself through the narrow aisle as if the archive made the space for it.

{
- player_id == "0023" and saw_subject_file == true:
    The drawer marked SUBJECT 23 hangs open beside your head as the cabinets begin to rattle shut.
- else:
    The cabinets begin to rattle shut one by one.
}

The room files you away in clicks and paper.

ENDING: FILED AWAY
-> END

=== death_locker ===
You hit the floor in front of the open locker and do not get back up.

The thing closes over you in a rush of wire-thin fingers and stale locker air.
Metal rings around your head as your shoulder strikes the steel again and again.

When the noise stops, Storage goes quiet.
The locker door swings once on its hinge, then settles.

ENDING: LOCKER FEED
-> END

=== death_faceless_lab ===
You make it through the Lab 3 doorway, but not far enough.

The faceless thing drops on you among the restraints and scattered tools.
The overhead lamp pulses weakly above its blank head, turning the whole room into a stop-start procedure.

The room that studied separation closes around you like it has resumed.

ENDING: LAB THRESHOLD
-> END

=== death_faceless_glass ===
You collapse beneath broken glass and cold weight.

The faceless thing pins you only long enough to take the air from your lungs.
Its smooth face presses against yours without eyes, mouth, or any sign it ever needed them.

When it finally lifts away, the shattered chamber stands open behind it.
Whatever was kept behind glass is loose, and the hall is quiet again in a way it should not be.

ENDING: GLASS RELEASE
-> END

=== death_backup_feed ===
You hit the floor beside the generator as the emergency lights blink awake.

The thing in the vent comes back down only long enough to finish feeding.
Blood spreads beneath the start lever while the room brightens around you in clean industrial white.

{
- player_id == "0023":
    Somewhere in the wall, the speaker keeps trying to return Subject Twenty-Three to Processing.
- else:
    The backup generator keeps running.
}

The power is back on.
You are not.

ENDING: BACKUP FEED
-> END

=== death_root_taken ===
The guard creature catches you before you clear the chamber.

Its grip closes like hooked steel.
The living mass opens beneath it, not with a mouth but with recognition.

Heat rolls over you.
Voices move through the root in layered fragments, as if many people are trying to remember one sentence at once.

{player_id == "0023":
For one impossible second, the voices answer the number on your wristband before they take the rest of you.
}

Then you are pulled inside.

ENDING: RETURNED TO ROOT
-> END

=== death_searchlight_fixed ===
You step into the open and wave both arms toward the floodlights.

For one hopeful second nothing happens.

Then every light locks onto you at once.
A voice barks from somewhere high above the fence:
"DOWN. NOW."

You freeze instead.

The shot is precise enough to feel unreal.
It punches through you and drops you flat onto the frozen pavement before the echo reaches the trees.

The lights remain on you long after you stop moving.

ENDING: FIXED IN THE LIGHT
-> END

=== death_shutter_claimed ===
You stay too close to the half-open shutter.

At first it is only heat and smoke and the heavy pounding from somewhere inside.
Then something narrow pushes through the gap beneath the door, searching once before it finds your ankle.

You hit the road hard.
Your nails scrape sparks from the concrete as it reels you backward.

The last thing you see is the orange glow of the outside shrinking into a thin line under the shutter before it slams shut.

ENDING: CLAIMED BY WHAT REMAINED
-> END

=== death_root_recalled ===
You stop resisting the pressure.

It swells behind your eyes until the road, the fence, the trees, and the floodlights all feel secondary to a single certainty:
you are facing the wrong direction.

You turn back toward the facility without meaning to.
The shutter rises just enough.

Inside, something waiting in the smoke shifts like a body welcoming back a missing part.

ENDING: RECALLED
-> END

=== death_return_too_late ===
You duck back inside after the fire has already taken too much.

The corridor beyond the shutter is no longer a corridor.
It is smoke, falling metal, and the furnace roar traveling through concrete.

You make it three steps before the ceiling gives way.

The facility seals its own mouth over you.

ENDING: BURIED IN THE PURGE
-> END

=== sniper_death ===
You grab the fence and start to climb.

For one savage second you think you might actually clear it.
Cold wire bites into your palms.
The floodlights pin you in place.

Then a single rifle shot cracks through the night.

The impact tears through you and throws you backward off the wire.
You hit the ground hard beneath the floodlights while something inside the facility slams once more against the shutter.

No one comes to check if you are still moving.

ENDING: PERIMETER DENIED
-> END

=== outside_burned ===
{burned_clean == true:
The facility burns like it is collapsing from the inside out.
Every few seconds some deeper section gives way with a long metallic scream.
- else:
The facility burns in sections.
Part of it caves inward.
Part of it still stands, black against the fire.
}

You stand on the service road and look back.

Farther down the perimeter, one section of fence has buckled inward from the blast.
It is not much, but it is more than was there before.

Then a new sound cuts through the night.
Rotors.
Heavy, close, descending fast.

A helicopter appears over the trees and drops toward the service road.

{
- player_id == "0001":
    -> outside_burned_0001
- player_id == "0012":
    -> outside_burned_0012
- else:
    -> outside_burned_0023
}

=== outside_burned_0001 ===
The helicopter banks once, searchlight sweeping over the road and the burning building.

You have only a moment before it commits to a landing.

{knows_perimeter == true:
The landing pattern matches the security maps too neatly.
Whoever is coming knows exactly what the fence was built to keep quiet.
}

{burned_clean == true:
For the first time since waking up, nothing inside the facility answers the noise.
- else:
Deep in the broken structure, something still knocks once beneath the fire.
}

{found_perimeter_evidence == true:
The papers under your arm snap in the rotor wind.
}

{blood_trail == true:
The rotor wash pulls a dark line from your wounds across the pavement.
Even in all this smoke, the road is trying to keep evidence of you.
}

* {found_perimeter_evidence == false} [Search the road for something that proves what happened] -> burned_evidence_0001
* {blood_trail == true} [Bind the bleeding before moving] -> bind_blood(-> outside_burned_0001)
* {found_gun == true and bullets > 0} [Shoot out the nearest floodlight and run for the fence] -> ending_0001_blackout
* [Run for the damaged fence and the woods] -> ending_0001_woods
* [Wait for the helicopter] -> ending_0001_heli
* [Stay low beside the road until they commit elsewhere] -> ending_0001_low
* [Run back toward the collapsing shutter] -> death_return_too_late

=== burned_evidence_0001 ===
~ found_perimeter_evidence = true

You drop low and move along the broken edge of the road.

A perimeter case has burst open near the guardrail.
Most of its contents are scattered into the fire wash,
but one plastic sleeve is pinned beneath a chunk of concrete.

You pull it free.

Inside is an evacuation checklist,
a black-site call sheet,
and a signed order authorizing PURGE if the root reached surface level.

At the bottom, under a row of initials, someone wrote:
NO CIVILIAN DISCLOSURE PATH EXISTS.

You fold the sleeve against your chest and look up.
The helicopter is closer now.

-> outside_burned_0001

=== ending_0001_blackout ===
~ spend_bullet()

You raise the gun with both hands and fire at the nearest floodlight.

The bulb bursts white,
then black.
For one priceless second the fence breach, the ditch, and the first line of pines all belong to shadow.

The helicopter jerks its searchlight toward the muzzle flash.
You are already moving.

{found_perimeter_evidence == true:
The papers slap against your ribs under your arm.
You keep one hand over them as you run.
}

{removed_wristband == true:
No wristband pings from your arm when the perimeter speaker tries to re-acquire you.
}

{burned_clean == true:
Behind you, the facility gives one final inward roar.
Nothing under the concrete answers your shot.
- else:
Behind you, something inside the burning structure knocks once in response.
You do not wait to learn whether it heard you or recognized you.
}

You hit the damaged fence shoulder-first, roll through wet weeds, and vanish under the first low branches before the searchlight can stitch the road back together.

ENDING: BLACKOUT RUN
-> END

=== ending_0001_woods ===
You run for the darkest stretch of trees before the helicopter can settle.

Branches slash at your arms.
Behind you, the searchlight combs the road and the firelight throws the facility into broken shapes.

{blood_trail == true:
You cut through a drainage rut instead of the cleanest path.
Cold water takes the blood from your legs and carries the trail somewhere useless.
}

No one calls after you.

By the time the helicopter lands, you are through the damaged fence and deep enough in the woods that only the glow behind you remains.

{found_perimeter_evidence == true:
The plastic sleeve is still under your arm.
Later, when your hands stop shaking enough to unfold it, you realize the pages name people who believed the fence was enough.
}

ENDING: LOST IN THE PINES
-> END

=== ending_0001_heli ===
You stay where you are.

The helicopter lands hard on the service road.
A man in a dark field jacket steps out into the wash of firelight and rotor wind.

He looks at the burning facility first.

{
- removed_wristband == true:
Then at the raw place where the band used to be.
He notices the difference before he decides what to call it.
- else:
Then at the band on your wrist.
}

{burned_clean == true and found_perimeter_evidence == true:
You hold up the plastic sleeve before he can speak.

The man sees the purge authorization.
Then he sees the line at the bottom.

"How much did you see?" he asks.

"Enough," you say.

That is the first answer that makes anyone outside the building look afraid.

"Then keep walking," he says. "And when they ask, start at the beginning."
- else:
"If you can walk, walk. You're leaving. Now."
}

He does not wait for questions.
You climb aboard with the fire still reflecting in the helicopter glass.

{
- burned_clean == true and found_perimeter_evidence == true:
    The headset they put on you smells like smoke and metal.
    A recorder light blinks red near the rear bulkhead.
    Nobody calls you patient.
    Nobody calls you asset.
    For the first time, they call you witness.
- burned_clean == true:
    Whatever happens next is not simple rescue.
    But the thing under the building is gone, and the helicopter climbs away from it.
- else:
    Whatever happens next is not rescue exactly.
    But you are alive.
}

{
- burned_clean == true and found_perimeter_evidence == true:
    ENDING: THE ONLY ACCOUNT
- else:
    ENDING: EXTRACTED
}
-> END

=== ending_0001_low ===
You drop beside the broken edge of the road and wait.

The helicopter settles near the main service entrance instead of the breach.
The team that exits runs toward the building first, not you.

That is enough.

You slip through the warped section of fence and into the pines while every eye is turned toward the fire.

{found_perimeter_evidence == true:
By dawn, the facility is only smoke behind you,
and the plastic sleeve is folded flat beneath a stone near the first road sign you find.
You mark the place in your head before you keep moving.
- else:
By dawn, the facility is only smoke behind you.
}

ENDING: OUT OF RANGE
-> END

=== outside_burned_0012 ===
The helicopter lowers until its searchlight washes over the road, the fence, and the burning side of the building.

The sound is too loud to think through.

{burned_clean == true and heard_lullaby == true:
You wait for the broken song to come back through the outside speakers.
It does not.
}

{burned_clean == true and found_mural == true:
You suddenly know where the easiest part of the broken fence is before the light ever sweeps over it.
}

{blood_trail == true:
The cuff of your gown is wet and dark.
If you run now, you will leave a line behind you.
}

{
- burned_clean == true and found_mural == true and found_lullaby_scrap == true:
    * [Follow the drawing and the folded paper where they agree] -> ending_0012_maps_agree
- burned_clean == true and found_mural == true and heard_lullaby == true:
    * [Follow the picture-memory and the silence beyond it] -> ending_0012_no_number
- burned_clean == true and found_mural == true:
    * [Follow the picture-memory to the bent fence section] -> ending_0012_picture_way
- burned_clean == true and found_lullaby_scrap == true:
    * [Follow the folded paper map] -> ending_0012_paper_way
}
* {blood_trail == true} [Bind the bleeding before moving] -> bind_blood(-> outside_burned_0012)
* [Run into the woods and hide] -> ending_0012_woods
* [Wait for the helicopter] -> ending_0012_heli
* [Run back toward the collapsing shutter] -> death_return_too_late

=== ending_0012_woods ===
You run off the road and duck beneath a low spread of pine branches near the buckled stretch of fence.

Needles scrape your skin.
You stay low and watch through the gaps.

{found_small_passage == true:
You remember the service hatch behind the cubbies and make yourself small in the same way.
}

The helicopter settles near the service road.
A man in a dark jacket steps out and raises a handheld radio to his mouth.

"Perimeter secure. Facility is collapsing. I have one live survivor outside the burn zone. Small frame. No visible escort."

He listens for a reply you cannot hear.
Then he turns slowly, scanning the trees.

* [Stay hidden and let them think they missed you] -> ending_0012_hidden
* [Step out from the trees] -> ending_0012_reveal

=== ending_0012_hidden ===
You stay exactly where you are.

The rotor wash shakes the branches above you.
{blood_trail == true:
A dark drop falls from your sleeve onto a pale stone.
You cover it with your palm and press down until dirt sticks to your skin.
}
The man by the helicopter keeps scanning the tree line for another few seconds, then lowers the radio and boards again.

Soon the helicopter lifts away, carrying its light and noise with it.

When the road is dark again, you slip through the damaged fence section and keep moving without looking back.

{heard_lullaby == true:
For a long time you listen for the song.
Only trees answer.
}

ENDING: THEY MISSED YOU
-> END

=== ending_0012_reveal ===
You step out from the trees with your hands visible.

The man turns sharply, one hand already half-raised toward the side of his jacket.
Then he sees you clearly.

For a second, something in his face changes.
Not pity exactly.
Something closer to disbelief.

He lowers the radio.

"Easy. Stay where you are."

He looks at the wristband, then at the fire behind you.

"You're not staying here. Come on."

He leads you to the helicopter without touching you.
The building burns behind the fence until the door closes.

{burned_clean == true:
When the helicopter lifts, you see the roof collapse into itself.
Nothing reaches up after you.
}

ENDING: TAKEN ALIVE
-> END

=== ending_0012_heli ===
You stay in the open as the helicopter lands.

The man who steps out into the rotor wash looks at the building first, then at you.
His eyes catch on the wristband immediately.

He crouches slightly so he is not towering over you.

"You walked out of that?"

He glances back at the collapsing fire, then lowers the radio in his hand.

"Alright. You're coming with me. Don't look back."

You go with him toward the helicopter while sparks drift up behind the fence like fireflies.

{heard_lullaby == true:
Inside the helicopter, a medic offers you a headset.
You put it on slowly.
There is only rotor noise inside it.
No lullaby.
}

ENDING: LIFTED OUT
-> END

=== ending_0012_picture_way ===
You move before the searchlight fully settles.

Not toward the deepest woods.
Toward the spot your mind already marked from the mural room:
the low, awkward break where bent steel and ruined mesh leave just enough room.

You slide through it sideways and tumble into wet brush on the far side.
By the time the helicopter light reaches the gap, you are already below the rise of the ground and crawling through black pine roots.

No one calls your number.
No one follows.

ENDING: THE DRAWING WAS RIGHT
-> END

=== ending_0012_paper_way ===
You do not have the mural in your memory.
You have something better:
a route folded small enough to survive under a bed.

The paper map shakes in your hand as the helicopter light sweeps over the road.
You count the fence posts drawn in blunt pencil,
then count the real ones,
then run before the numbers can become fear.

The break in the mesh is exactly where the fold said it would be.
You slide through wet steel and cold weeds with the paper clenched between your teeth.

Behind you, someone shouts for a subject number.
You keep crawling until the only answer is branches scraping the sky.

ENDING: PAPER HOUSE ROUTE
-> END

=== ending_0012_maps_agree ===
You move before the searchlight fully settles.

The mural gave you the shape of the wall.
The folded paper gave you the count of the posts.
The silence after the lullaby tells you the old system is no longer calling your number.

For once, the clues do not compete.
They line up.

You run low along the fence until the real world matches both maps:
bent steel,
dead weeds,
a place meant to be overlooked by anyone too tall to need it.

You slide through on your side.
The paper tears at one fold.
You keep the larger half clenched in your fist and crawl until the helicopter light sweeps over empty road behind you.

At the tree line, you look back only once.
The facility is burning.
The fence is still standing.
But the small place in the plan was real.

ENDING: WHERE THE MAPS AGREE
-> END

=== ending_0012_no_number ===
You move before the searchlight fully settles.

Not toward the road.
Not toward the voices.
Toward the low, awkward break your mind already knows.

The mural had the fence,
the dark shape,
and the small mark low near the edge of the wall.
It did not have the song.

That part is new.

You wait one breath at the bent steel.
The outside speakers crackle.
Nothing plays.

You slide through the gap and tumble into wet brush on the far side.
Roots catch your gown.
Cold mud gets under your fingernails.

Behind you, the helicopter light sweeps across the wrong place.
Someone calls for a subject number.
No one answers.

When morning begins to pale between the trees, you are still walking.
You do not know where the road goes.
But no wall is holding you.
No speaker is singing.
No one is calling your number.

ENDING: NO ONE CALLS YOUR NUMBER
-> END

=== outside_burned_0023 ===
The helicopter descends lower than it should.

Its searchlight sweeps across the road once, then snaps back onto you too quickly.
Not searching.
Finding.

{burned_clean == true and touched_root == true:
For the first time since waking, the pressure behind your eyes weakens instead of deepening.
- else:
The pressure behind your eyes returns.
}

{saw_subject_file == true:
The file's warning waits in your memory with the patience of a locked door:
DO NOT CLASSIFY AS RECOVERED CIVILIAN.
}

{blood_trail == true:
Blood spots the road between your feet.
The helicopter light finds each mark a half-second after it finds you.
}

{burned_clean == true and touched_root == true:
* [Wait until the pressure is completely gone, then move] -> ending_0023_severed
}
* {blood_trail == true} [Bind the bleeding before moving] -> bind_blood(-> outside_burned_0023)
* [Step into the searchlight] -> ending_0023_light
* [Run into the woods] -> ending_0023_woods
* [Tear off or cover the wristband and wait] -> ending_0023_false
* [Run back toward the collapsing shutter] -> death_return_too_late

=== ending_0023_light ===
You step fully into the light.

The helicopter lands hard.
The man who exits is already speaking into his radio before he reaches you.

"Confirm visual. Subject Twenty-Three is ambulatory."

That makes him look up at you for the first time.

He studies your face, then the wristband, then the fire behind the fence.

"You were not supposed to survive this intact."

He gestures toward the helicopter.

"Hands where I can see them. You're coming with us."

There is no pretense of rescue.
Only retrieval.

The helicopter has a frame bolted to the floor.
It has straps at the wrists, chest, ankles, and throat.

When they lock you into it, one of them says:
"Responsive but compliant."

You turn the words over inside your head.
Responsive.
Compliant.
Neither one means alive.

ENDING: RECOVERED ASSET
-> END

=== ending_0023_woods ===
You turn and run for the trees before the helicopter can settle.

The pressure in your skull pulses in time with the rotors and something older beneath them.
You do not look back.

By the time the searchlight sweeps across the fence again, you are already through the damaged section and inside the dark between the pines.

{touched_root == true:
Your palm still feels warm where it touched the root.
}
{ saw_subject_file == true:
You already know what they planned to call you if they ever found you again.
}

{burned_clean == true:
The pressure flickers behind your eyes and fails to become a command.
}

Whatever you are, you are no longer inside their walls.

ENDING: THE BRANCH ESCAPES
-> END

=== ending_0023_false ===
~ removed_wristband = true

You rip off the wristband and grind it into the ash and gravel under your heel.

Then you pull the gown tighter and wait near the firelight as if you belong to no one.

The helicopter lands.
The same dark-jacketed man steps out and scans you once from a distance.

He stops just short of speaking.

His eyes move to your bare wrist.
Then to your face.
Then back again.

For one second you think he knows.

{blood_trail == true:
Then his eyes catch on the blood instead.
Injured survivor is an easier box than impossible specimen,
and for one dangerous second you let him choose the easier one.
}

{touched_root == true:
Something behind your eyes seems to answer the look he gives you.
}
{ saw_subject_file == true:
You remember the line from the file:
DO NOT CLASSIFY AS RECOVERED CIVILIAN
}

At last he speaks into the radio without taking his eyes off you.

"One survivor. Identity uncertain."

He motions you forward.

You walk to the helicopter with the fire at your back and the feeling that you have almost fooled them.

Almost.

ENDING: FALSE SURVIVOR
-> END

=== ending_0023_severed ===
You do not move at first.

You stand in the firelight and wait for the old pressure to return.
For the pull.
For the recognition.
For the buried thing under the world to remember you.

It does not.

Little by little the feeling drains away until your skull is only your skull again, and your hand is only your hand.

The helicopter light sweeps wide toward the facility.
For once, it does not snap back to you.

Whatever the branch was tied to is gone now.
If they come looking, they will be looking for something that no longer exists.

* [Walk into the trees before anyone can name you] -> ending_0023_severed_free
* [Step into the edge of the light and say what you are not] -> ending_0023_not_root

=== ending_0023_severed_free ===
You turn and slip through the broken fence alone.

No pressure rises to correct you.
No hidden system opens a path.
No buried voice pulls at the back of your eyes.

The pines close around you one branch at a time.

You walk until the fire is only a stain behind the trees.
You walk until the searchlight is gone.
You walk because you choose the next step,
and then the next,
and then the next after that.

ENDING: SEVERED
-> END

=== ending_0023_not_root ===
You step into the edge of the searchlight.

Rifles lift.
The helicopter speaker cracks open.

"Subject Twenty-Three, remain where you are."

The words should hook into something.
They do not.

You look at the burning facility.
Then at the people waiting to decide what you are.

"I am not the root," you say.

Your voice is raw.
Human.
Yours.

For a moment nobody moves.
No protocol fits the silence.

Then you step backward out of the light and into the trees.
This time, nothing inside you turns back.

ENDING: I AM NOT THE ROOT
-> END

=== lullaby_room ===
~ queue_hall_swarm_if_awake()

{
- heard_lullaby == true:
    You return to the half-open sleep ward.

    The speaker is dead now.
    The low beds sit in rows beneath the painted moon, and the wall gap behind the nearest frame is open and empty.

    {found_lullaby_scrap == false:
    A folded paper shape lies where the thing had been rocking before the song stopped.
    }
- visited_lullaby_room == true:
    You return to the half-open sleep ward.

    The speaker is still trapped in the same warped few notes.
    Something thin remains tucked beneath the nearest bed frame, rocking in time.
- else:
    ~ visited_lullaby_room = true

    You follow the melody to a half-open side room.

    A small speaker in the corner keeps trying to play the same lullaby from a warped internal loop.
    The room itself looks like a sleep ward that was shut in a hurry:
    low beds,
    folded blankets,
    a painted moon on one wall.

    Something thin crouches beneath the nearest bed frame.

    It does not rush you.
    It only rocks slightly in time with the broken melody.
}

* {heard_lullaby == false} [Stand still and listen until the song stops] -> lullaby_listen
* {heard_lullaby == true and found_lullaby_scrap == false} [Take the folded paper shape] -> lullaby_scrap
+ [Back away quietly] -> hall_a

=== lullaby_listen ===
~ heard_lullaby = true

You stay still.

The melody skips, repeats, then finally dies in a burst of static.
The thing beneath the bed stops rocking.

After a long second, it crawls soundlessly into the wall gap behind the bed and disappears.

Only the room remains.

You are alone again.
-> hall_a

=== lullaby_scrap ===
~ found_lullaby_scrap = true
~ knows_perimeter = true

You pick up the folded paper shape.

It is not a toy.
It is a map folded into a little house:
sleep ward,
hall,
fence,
tree line.

Someone drew the outside as a row of black vertical strokes.
Someone else later crossed out every stroke except one low place near the service road.

The paper is soft at the folds,
as if it has been opened and closed by small hands until the route became a prayer.

-> lullaby_room

=== function print_status ===
HEALTH: {health}/3
AMMO: {bullets}/5
NOISE: {attention}/3
{print_access_cards()}

=== function print_health_status ===
HEALTH: {health}/3

=== function print_ammo_status ===
AMMO: {bullets}/5
{print_access_cards()}

=== function print_access_cards ===
{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

=== function add_bullets(amount) ===
~ bullets = MIN(bullets + amount, 5)

=== function spend_bullet ===
~ bullets = bullets - 1
~ raise_attention(1)

=== function take_damage(amount) ===
~ health = health - amount
~ blood_trail = true
~ raise_attention(1)

=== function heal(amount) ===
~ health = MIN(health + amount, 3)

=== function raise_attention(amount) ===
~ attention = MIN(attention + amount, 3)
{attention >= 2 and hall_swarm_awake == false:
    ~ hall_swarm_awake = true
    ~ hall_swarm_pending = true
}

=== function reduce_attention(amount) ===
~ attention = MAX(attention - amount, 0)

=== function wake_hall_swarm ===
~ hall_swarm_awake = true
~ hall_swarm_pending = true
~ attention = MAX(attention, 2)

=== function queue_hall_swarm_if_awake ===
{hall_swarm_awake == true:
    ~ hall_swarm_pending = true
}
