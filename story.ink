// Dan Nikiforov
// INK Project
// April 6 2026

VAR health = 3
VAR bullets = 2

VAR found_bullets_storage = false
VAR found_bullets_lab = false
VAR found_bullets_security = false

VAR found_gun = false
VAR keycard_a = false
VAR keycard_b = false
VAR power_on = false
VAR killed_specimen = false
VAR killed_stalker = false
VAR killed_nest = false

VAR locker_wounded = false
VAR nest_wounded = false
VAR hall_shape_shot = false
VAR hall_shape_dead = false
VAR hall_shape_gone = false
VAR killed_archive_creature = false
VAR archive_creature_revealed = false
VAR archive_creature_fled = false
VAR faceless_released = false
VAR faceless_gone = false
VAR killed_faceless = false

VAR found_mural = false
VAR found_small_passage = false
VAR heard_lullaby = false
VAR saw_subject_file = false
VAR heard_intercom_23 = false
VAR touched_root = false

VAR burned_clean = false

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

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Check the cabinet] -> cabinet
+ [Look under the bed] -> under_bed
+ [Step into the hallway] -> hall_a

=== cabinet ===
You open the cabinet.

Inside are old gauze rolls, empty pill bottles, and a black handgun sealed in a plastic evidence bag.

{found_gun == false:
~ found_gun = true
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
You step into the hallway.

A long medical corridor stretches in both directions under flickering lights.
Wheelchairs sit abandoned against the wall.

{ hall_shape_shot == false:
Far away, something thin and human-like moves slowly behind the frosted glass at the end of the corridor.
- else:
    { hall_shape_dead == true:
    At the far end, a collapsed thing lies half in a side alcove where it finally bled out.
    - else:
        { hall_shape_gone == true:
        A dark streak vanishes into a side alcove at the far end of the corridor.
        - else:
        A wet smear marks the wall where the distant shape fled after your shot.
        }
    }
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

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Go to Observation] -> observation
+ [Go to Testing] -> testing_hall
+ [Go to Security] -> security_door
* [Hide behind the overturned cart and listen] -> hide_hall
{hall_shape_shot == false:
+ [Use 1 bullet on the distant shape] -> shoot_hall_shape
}
{hall_shape_shot == true:
+ [Follow the trail into the side alcove] -> hall_trail
}
{player_id == "0012" and found_mural == false:
+ [Follow the faded painted handprints along the lower wall] -> mural_room
}
{player_id == "0012" and power_on == true and heard_lullaby == false:
+ [Follow the broken lullaby] -> lullaby_room
}
+ [Go back to patient room] -> patient_room

=== hide_hall ===
You crouch behind an overturned supply cart and stay still.

{hall_shape_shot == false:
The thing at the far end stops moving.

For a long moment, the corridor is silent.
Then the shape jerks its head toward some other noise deeper in the facility and vanishes from sight.
You are safe for now.
- else:
The corridor holds still except for the soft sound of something wet dragging far away.
Nothing comes for you.
}

-> hall_a

=== shoot_hall_shape ===
{found_gun == false:
You reach for a gun you do not have.
The mistake costs you a moment of courage.
-> hall_a
- else:
{bullets > 0:
~ bullets = bullets - 1
~ hall_shape_shot = true
You fire once.

The muzzle flash blinds you for half a second.
The shot echoes through the corridor like an alarm.

The shape convulses and disappears from view.
Instead, you hear movement everywhere.
Multiple things are now awake.

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> hall_a
- else:
The gun clicks dry.
You have no bullets to waste.
-> hall_a
}
}

=== hall_trail ===
{
- hall_shape_dead == true:
    You follow the black streak into a shallow side alcove.

    The thing you shot lies twisted beside a dented medicine cart.
    Part of its face is gone.
    One arm is still hooked around the wheel as if it tried to pull itself farther before dying.

    It is not getting back up.

    + [Return to the hallway] -> hall_a

- hall_shape_gone == true:
    You follow the streak into a shallow side alcove.

    Only blood, shed skin, and a bent medicine cart remain.
    Whatever dragged itself in here is gone now.

    + [Return to the hallway] -> hall_a

- else:
    You follow the streak into a shallow side alcove.

    The thing is still there.
    A thin, wet body is folded against a medicine cart, one arm hanging wrong.
    Its ribs twitch beneath stretched skin.
    It turns its head toward you in a series of small, broken movements.

    * [Finish it] -> hall_finish
    {player_id == "0023":
        * [Stand still and let it look at you] -> hall_attuned
    }
    + [Back away slowly] -> hall_a
}

=== hall_finish ===
{found_gun == false:
You have no gun.
The creature jerks toward you.
-> hall_shape_attack
- else:
{bullets > 0:
~ bullets = bullets - 1
~ hall_shape_dead = true
You fire into its skull at close range.

The body slams once against the cart, then goes loose.
The dragging sound ends for good.

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> hall_trail
- else:
The gun clicks empty.
The creature launches itself at you.
-> hall_shape_attack
}
}

=== hall_attuned ===
You do not move.

The thing shudders as it studies you.
For a second, its breathing falls into the same rhythm as your own.
Then it recoils, drags itself backward into a cracked wall panel, and vanishes into the dark.

~ hall_shape_gone = true

You are left staring at the empty alcove and the wet streak it left behind.
-> hall_trail

=== hall_shape_attack ===
The wounded creature hits you harder than something that damaged should be able to move.

Its teeth rake across your forearm before it twists away and disappears through a broken wall panel.

~ health = health - 1
~ hall_shape_gone = true

{health <= 0:
You crumple beside the medicine cart.
The last thing you hear is the sound of something dragging itself away through the wall.
-> END
- else:
HEALTH: {health}/3
You stagger back into the hallway.
-> hall_a
}

=== mural_room ===
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

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Look at the crayon drawings more closely] -> mural_drawings
{found_small_passage == false:
+ [Crawl through the low service hatch behind the cubbies] -> small_passage
}
+ [Return to the hallway] -> hall_a

=== mural_drawings ===
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
You enter Observation.

One wall is made of thick glass, but the room beyond it is too dark to see clearly.
Old monitors display static.
A recorder on the desk is still blinking with power.

There is a side door marked ARCHIVE.
There is also a maintenance vent hanging partly open near the floor.

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Play the recorder] -> recorder
+ [Search the desk] -> obs_desk
+ [Open the ARCHIVE door] -> archive_room
+ [Crawl into the maintenance vent] -> vent_path
+ [Return to the hallway] -> hall_a

=== recorder ===
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
    Somewhere between the shelves, something breathes through a throat that does not work right.
- killed_archive_creature == true:
    A gray, twisted body lies crumpled between two cabinets where you dropped it.
- archive_creature_fled == true:
    A streak of black fluid disappears beneath the lowest cabinet.
    Whatever was here withdrew deeper into the archive.
}

{player_id == "0023" and saw_subject_file == false:
One drawer at chest height stands slightly open.
A white tab on the folder inside reads:
SUBJECT 23
}

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Search the general records] -> archive_files
{player_id == "0023" and saw_subject_file == false:
+ [Open the file marked SUBJECT 23] -> subject_file
}
+ [Move between the shelves] -> archive_creature
+ [Return to Observation] -> observation

=== archive_files ===
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

    A shape unfolds from the gap between two file cabinets.
    Its torso is narrow as wire, but its shoulders scrape both sides at once.
    One eye is sealed shut with scar tissue.
    The other stares at you without blinking.
    - else:
    The archive creature is still wedged between the cabinets, breathing in wet little clicks.
    }

    * [Shoot it] -> archive_shoot
    {player_id == "0023":
    * [Stand still and let it come close] -> archive_attuned
    }
    + [Back away] -> archive_room
}

=== archive_shoot ===
{found_gun == false:
You have no gun.
The creature jerks toward you.
-> archive_attack
- else:
{bullets > 0:
~ bullets = bullets - 1
~ killed_archive_creature = true
You fire once into the narrow aisle.

The report is deafening in the close room.
The creature slams into the cabinets, rattles them end to end, then collapses in a tangle of limbs and records.

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> archive_room
- else:
The gun clicks empty.
The creature launches itself down the aisle.
-> archive_attack
}
}

=== archive_attuned ===
You do not raise your hands.

The creature edges closer.
It leans in until the side of its face almost touches your wristband.
Then it recoils all at once, folding backward into the shadows beneath the shelves.

~ archive_creature_fled = true

The cabinets stop rattling.
The room goes still again.
-> archive_room

=== archive_attack ===
The creature crashes into you between the cabinets.

Cold fingers hook into your shoulder and drag down hard before you wrench free.

~ health = health - 1
~ archive_creature_fled = true

{health <= 0:
You fall into the open drawers.
The archive shuts around you in a storm of paper and clicking breath.
-> END
- else:
HEALTH: {health}/3
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
- killed_specimen == true:
    A reinforced door leads back into the main facility.
    The locker you opened earlier is hanging wide, and the thing you shot lies twisted in front of it.
- locker_wounded == true:
    A reinforced door leads back into the main facility.
    The locker door is bent outward, and dark fluid has dried across its vent slits.
    Something inside still twitches now and then.
- else:
    A reinforced door leads back into the main facility.
    Something knocks softly from inside one of the metal lockers.
}

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Search the supply crates] -> storage_crates
+ [Open the locker] -> locker_creature
+ [Leave through the reinforced door] -> generator_hall

=== storage_crates ===
You search the supply crates.

Under expired saline bags and cracked masks, you find a small box of handgun rounds.

{found_bullets_storage == false:
~ found_bullets_storage = true
~ bullets = bullets + 1
{bullets > 5:
~ bullets = 5
}
You take 1 bullet.
- else:
There is nothing left in the crate but dust and split cardboard.
}

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> storage

=== locker_creature ===
{
- killed_specimen == true:
    You look into the locker.

    The corpse is still folded in the same wrong shape, half in and half out.
    One long arm lies across the floor where it finally stopped moving.

    + [Back away] -> storage

- locker_wounded == true:
    You pull the locker wider.

    The same gray creature is crouched inside, one side of its face torn and slick with black blood.
    It twitches toward you, but slower now.

    + [Finish it] -> locker_finish
    + [Back away slowly] -> storage

- else:
    You open the locker.

    A collapsed figure spills out onto the floor.
    Its skin is gray and wet-looking, stretched tightly over a body that seems too long for its joints.
    Its jaw opens sideways.

    It twitches but has not fully noticed you yet.

    * [Shoot it] -> locker_shoot
    + [Back away slowly and leave it] -> storage
}

=== locker_finish ===
{found_gun == false:
You have no gun.
The creature unfolds itself toward you.
-> locker_attack
- else:
{bullets > 0:
~ bullets = bullets - 1
~ killed_specimen = true
~ locker_wounded = false
You fire directly into its head.

This time it only jerks once.
The locker door rings softly when its body hits the metal.

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
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
The creature unfolds itself toward you.
-> locker_attack
- else:
{bullets > 0:
~ bullets = bullets - 1
~ killed_specimen = true
~ locker_wounded = false
You fire directly into its head.
It spasms violently, slams against the lockers, then collapses still.

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> storage
- else:
The gun clicks empty.
The creature lunges.
-> locker_attack
}
}

=== locker_attack ===
The creature crashes into you in the narrow room.
Its fingers feel like surgical wire.

~ health = health - 1
~ locker_wounded = true

{health <= 0:
You scream once.
The storage room swallows the sound.
-> END
- else:
HEALTH: {health}/3
You shove it back and stumble through the reinforced door.
-> generator_hall
}

=== testing_hall ===
{power_on == true and faceless_released == false and killed_faceless == false and faceless_gone == false:
-> faceless_release
}

You enter the Testing wing.

Rows of glass chambers line the walls.
Most are shattered from the inside.

{
- killed_faceless == true:
    Broken glass litters the floor around the once-intact chamber.
    The pale faceless thing lies crumpled beside it, one hand still pressed against a shard.
- faceless_gone == true:
    The once-intact chamber now stands open and empty.
    Long smears run down the inside of the glass where something pulled itself out.
- else:
    Inside one intact chamber, something pale and faceless presses both hands against the glass and watches you without blinking.
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

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

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

A pale faceless thing spills across the floor on all fours, rises too quickly, and turns toward you.

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

* [Shoot it] -> faceless_shoot
* [Hide between the chambers] -> faceless_hide
* [Run for Lab 3] -> faceless_lab_run

=== faceless_shoot ===
{found_gun == false:
You have no gun.
The faceless thing rushes you soundlessly.
-> faceless_attack
- else:
{bullets > 0:
~ bullets = bullets - 1
~ killed_faceless = true
You fire into the center of its chest.

The thing folds in half the wrong way, hits the ground hard, and keeps moving for one blind second before it finally stops.

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> testing_hall
- else:
The gun clicks empty.
The faceless thing launches toward you.
-> faceless_attack
}
}

=== faceless_hide ===
You dive between two shattered chambers and flatten yourself against cold glass.

The faceless thing passes close enough that you hear its breathing inside its body.
Then it glides away down a dark side duct passage you did not notice before.

~ faceless_gone = true
-> testing_hall

=== faceless_lab_run ===
You turn and sprint for Lab 3.

The faceless thing catches your back with cold fingers as you reach the doorway, but the frame clips its shoulder and throws it off balance.

~ health = health - 1
~ faceless_gone = true

{health <= 0:
You fall into Lab 3 and never get back up.
-> END
- else:
HEALTH: {health}/3
You slam yourself through the doorway and do not stop until you hit the far desk.
-> lab3
}

=== faceless_attack ===
The pale creature collides with you and knocks the air out of your lungs.

Its smooth face presses against yours for one impossible second before you wrench free.

~ health = health - 1
~ faceless_gone = true

{health <= 0:
You collapse beneath broken glass and cold weight.
-> END
- else:
HEALTH: {health}/3
You stagger back down the hall as the creature slips away into darkness.
-> testing_hall
}

=== hide_testing ===
You slip between two cracked observation pods and wait.

A tall shape glides past the hall entrance.
It has no eyes that you can see, but its head turns slowly as if listening to the air.

After several seconds, it moves on.

You exhale.
-> testing_hall

=== lab3 ===
Lab 3 looks like it was abandoned during surgery.

Tools are laid out neatly beside restraints bolted into a reclining chair.
The overhead lamp still works, but it pulses weakly.
A terminal on the wall shows a repeated error message.
A corpse in a lab coat is folded beneath the desk.

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Search the corpse] -> corpse_lab
+ [Use the terminal] -> terminal_lab
+ [Return to Testing] -> testing_hall

=== corpse_lab ===
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
You tap the terminal keys.

The screen stabilizes just enough to display a file:

PROJECT MIMIC ROOT
SUBJECTS ARE NOT HOSTS.
SUBJECTS ARE BRANCHES.
PRIMARY MASS LOCATED NEAR EXIT PROCESSING.
INCINERATION REQUIRED.

You stare at the final line until the screen goes black again.
-> lab3

=== power_control ===
You enter Power Control.

The room is full of breaker panels and emergency battery units.
A backup generator sits in the corner with a manual start lever.

{
- killed_nest == true:
    Dark blood dries around the vent above the generator.
    Whatever nested there is dead now.
- nest_wounded == true:
    Something shifts weakly inside the vent above the generator.
    Dark fluid beads at the edge and drips onto the floor.
- else:
    Something has nested in the ceiling above the generator.

    You hear dripping.
    Then a string of saliva lands on the floor.
}

{
- killed_nest == true:
    + [Return to Testing] -> testing_hall
- nest_wounded == true:
    + [Shoot into the vent] -> finish_nest
    + [Retreat] -> testing_hall
- else:
    * [Start the generator quietly] -> start_generator_quiet
    * [Shoot the thing in the ceiling] -> shoot_ceiling
    + [Retreat] -> testing_hall
}
=== finish_nest ===
{found_gun == false:
You raise an empty hand toward the vent.
That is not going to help.
-> power_control
- else:
{bullets > 0:
~ bullets = bullets - 1
~ killed_nest = true
~ nest_wounded = false
You fire into the vent.

Something thrashes once above you, then slides halfway out and hangs still.

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> power_control
- else:
The gun clicks dry.
The thing in the vent scrapes farther back into the dark.
-> power_control
}
}

=== start_generator_quiet ===
You move slowly to the lever.

You start to pull it, but the machine shrieks to life with a metallic roar.

The thing above drops instantly.

-> ceiling_attack

=== shoot_ceiling ===
{found_gun == false:
You raise an empty hand.
Bad instinct.
-> ceiling_attack
- else:
{bullets > 0:
~ bullets = bullets - 1
~ power_on = true
~ killed_nest = true
~ nest_wounded = false
You fire into the ceiling nest.

A shriek explodes through the room.
The creature drops half-formed and thrashes on the ground until it stops moving.
You pull the backup lever.
Power returns to part of the facility.

{player_id == "0023" and heard_intercom_23 == false:
A speaker somewhere in the wall crackles to life.

"Branch Twenty-Three active."
Static swallows the next words before the system dies again.

~ heard_intercom_23 = true
}

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> testing_hall
- else:
The gun clicks empty.
The nest bursts open.
-> ceiling_attack
}
}

=== ceiling_attack ===
A slick, malformed creature drops onto you from above.

You manage to wrench free, but its claws rake across your shoulder and back.

~ health = health - 1
~ power_on = true
~ nest_wounded = true

{player_id == "0023" and heard_intercom_23 == false:
Emergency power hums back to life.
A hidden speaker spits one broken sentence into the room:

"Return Subject Twenty-Three to Processing."

~ heard_intercom_23 = true
}

{health <= 0:
You collapse beside the generator as the emergency lights hum back to life.
-> END
- else:
HEALTH: {health}/3
The power comes on as the creature retreats into the vents.
-> testing_hall
}

=== security_door ===
You reach Security.

A reinforced shutter blocks the entrance.
There is a card reader beside it.

{keycard_a == false:
You need better clearance.
-> hall_a
- else:
The reader flashes yellow.
CARD A ACCEPTED.
ADDITIONAL CLEARANCE REQUIRED.
{keycard_b == false:
Still locked.
-> hall_a
- else:
The shutter grinds open.
-> security_room
}
}

=== security_room ===
The Security room is dim and lined with dead monitors.
A few still work, each showing different corridors from around the facility.

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

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Check the wall locker] -> security_locker
+ [Check the desk safe] -> desk_safe
+ [Go to Exit Processing] -> exit_processing
+ [Return to hallway] -> hall_a

=== security_locker ===
You open the wall locker.

Inside is a tactical belt, dried blood, and a small ammo pouch.

{found_bullets_security == false:
~ found_bullets_security = true
~ bullets = bullets + 1
{bullets > 5:
~ bullets = 5
}
You take 1 bullet.
- else:
Only the torn pouch remains.
}

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> security_room

=== desk_safe ===
The safe door is already cracked open.

Inside is one final loose round and a handwritten security memo.

{found_bullets_lab == false:
~ found_bullets_lab = true
~ bullets = bullets + 1
{bullets > 5:
~ bullets = 5
}
You take 1 bullet.
- else:
The safe is empty now except for the memo.
}

The memo says:
"If evacuation fails, trigger PURGE in the furnace room beyond Exit Processing."

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> security_room

=== generator_hall ===
You enter a service corridor beyond Storage.

Now that some power is back on, red emergency strips glow near the floor.
The corridor leads toward a rear Security access door, and another direction toward Exit Processing.

The walls here are covered in strange dark growths, like veins or roots beneath translucent skin.

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

+ [Follow the growths toward Exit Processing] -> exit_processing
+ [Go toward rear Security access] -> rear_security_access
* [Hide in the service recess] -> hide_service
+ [Go back to Storage] -> storage

=== rear_security_access ===
You move down the service corridor to a heavy rear Security door.

A dual card reader is mounted beside it.
The red light above the frame stays solid.

{keycard_a == false or keycard_b == false:
The rear door needs the same clearance as the main one.
It does not open.
-> generator_hall
- else:
The light shifts green.
The lock disengages with a heavy clunk.
-> security_room
}

=== hide_service ===
You flatten yourself into a shallow maintenance recess.

Something passes down the corridor:
a tall, skeletal figure dragging one twisted leg.
Its head turns too far.
It pauses near you.

You do not move.

Eventually it continues on.

You remain unseen.
-> generator_hall

=== exit_processing ===
You enter Exit Processing.

This room must once have been the final checkpoint before leaving the facility.
Decontamination arches line the walls.
A large rolling shutter at the far end leads outside.

But the floor is covered in pulsating organic mass.
The growths from the corridor all lead here.
At the center is a heaving mound of flesh and bone fused into the foundation.

{
- killed_stalker == true:
    The guard creature lies collapsed beside the pulsing mass.
    Beyond it, the path to the furnace control panel is open.
- else:
    Something separates itself from the mass and stands upright.
}

HEALTH: {health}/3
AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}

{killed_stalker == false:
* [Hide and observe] -> observe_root
+ [Fight the guard creature] -> fight_guard
- else:
+ [Approach the control path] -> root_final
}
+ [Run back] -> security_room

=== observe_root ===
You keep low behind an overturned decontamination cart.

You watch the room carefully.

The guard creature patrols in short, twitching movements.
Behind the root mass, you spot a furnace control panel set into the wall.
A label beneath it reads:
PURGE CHAMBER

If the root lives, the facility is not really escaped.
-> exit_processing

=== fight_guard ===
The guard creature notices you instantly.

Its chest opens along a seam that should not exist.

+ [Shoot it] -> shoot_guard
+ [Try to dodge past it] -> dodge_guard

=== shoot_guard ===
{found_gun == false:
You have no gun.
The creature rushes you.
-> guard_hit
- else:
{bullets > 0:
~ bullets = bullets - 1
~ killed_stalker = true
You fire into the opening in its chest.
It jerks backward, spasms, and collapses in a heap of twitching limbs.

AMMO: {bullets}/5

{
- keycard_a == true and keycard_b == true:
    ACCESS CARDS: A, B
- keycard_a == true:
    ACCESS CARD A
- keycard_b == true:
    ACCESS CARD B
}
-> root_final
- else:
The gun is empty.
-> guard_hit
}
}

=== dodge_guard ===
You try to slip around it.

Its arm lashes out and catches your side like a hooked blade.

-> guard_hit

=== guard_hit ===
~ health = health - 1

{health <= 0:
The creature drags you into the living mass.
You do not come back out.
-> END
- else:
HEALTH: {health}/3
You stagger back across the room.
-> exit_processing
}

=== root_final ===
You stand in Exit Processing again.

The guard creature lies collapsed beside the pulsing mass.
The path to the control panel is open.
The shutter to the outside is only a short distance beyond it.

{player_id == "0023" and touched_root == false:
* [Touch the root mass] -> root_communion
}
+ [Open the shutter and escape now] -> ending_escape_bad
+ [Trigger the purge furnace] -> purge_choice
+ [Back away and return to Security] -> security_room

=== root_communion ===
~ touched_root = true

You step closer and place a hand against the outer layer of the root.

It is warm.
Not like flesh.
Warmer.
Like something deeper under the world pressing up through it.

The mass shudders.

For one second you are somewhere else:
a glass room,
white lights,
a voice saying "stable after separation,"
and another voice answering,
"Do not let it see the sky unless retrieval is ready."

Then the vision snaps away.

The root withdraws from your hand as if recognizing you.

-> root_final

=== purge_choice ===
{power_on == false:
The purge controls are dead.
You need facility power first.

+ [Return to the root chamber] -> root_final
+ [Go back and find a way to restore power] -> security_room
- else:
You slam your palm onto the furnace control.
Warning alarms begin to pulse red across the room.

The root mass starts convulsing violently.
A side furnace hatch opens and the chamber begins to ignite.

* [Stay long enough to make sure it burns] -> true_ending
* [Run immediately for the shutter] -> ending_escape_mid
}

=== ending_escape_bad ===
You force open the shutter and stumble outside into cold night air.

For the first time, you see the world beyond the facility:
a fenced service road,
pine trees in the dark,
mist under floodlights.

You are out.

But behind you, deep inside the structure, the root still lives.
You hear one last wet impact against the inside of the shutter.

-> outside_unburned

=== ending_escape_mid ===
~ burned_clean = false

You run as the furnace ignites behind you.

The facility shakes.
Smoke and sparks flood Exit Processing.
You dive beneath the rising shutter and spill out onto cracked concrete outside.

The night air hits your skin like ice.
Above you, the facility burns in sections, but not all of it.

Maybe enough died.
Maybe not.

-> outside_burned

=== true_ending ===
~ burned_clean = true

You stay at the controls and watch.

The furnace roars hotter.
The root mass shrieks with a thousand layered voices.
Faces emerge in the flesh, melting as fast as they form.

Only when the entire chamber is engulfed do you run.

You sprint through smoke and emergency light, throw yourself beneath the half-open shutter, and crash onto the pavement outside.

Cold night air fills your lungs.
The facility behind you groans, then collapses inward in a storm of sparks and flame.

Beyond the fence, the road disappears into the dark woods.
But the thing below is dead.
Truly dead.

-> outside_burned

=== outside_unburned ===
{
- player_id == "0001":
    -> outside_unburned_0001
- player_id == "0012":
    -> outside_unburned_0012
- else:
    -> outside_unburned_0023
}

=== outside_unburned_0001 ===
You stand outside the facility, breathing steam into the cold.

Floodlights wash the fence in pale yellow.
The pine woods beyond it look close enough to touch and impossibly far away.

Behind you, something hits the inside of the shutter again.

+ [Run toward the woods] -> woods_blocked_0001
* [Try to climb the fence] -> sniper_death
+ [Go back inside and finish it] -> return_inside_0001

=== woods_blocked_0001 ===
You run toward the tree line.

The fence cuts across the whole perimeter, taller than it looked from the shutter.
Razor wire glints at the top.
There is no easy way through it.

Behind you, the facility groans wetly in the dark.

+ [Go back to the service road] -> outside_unburned_0001
* [Try to climb the fence anyway] -> sniper_death

=== return_inside_0001 ===
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

+ [Run toward the woods] -> woods_blocked_0012
* [Try to climb the fence] -> sniper_death
+ [Go back inside and finish it] -> return_inside_0012

=== woods_blocked_0012 ===
You hurry toward the pine line.

The fence rises in front of you all at once, all wire and steel and wet metal.
It is much taller up close than it looked from the building.

A warning light blinks somewhere high above you.

+ [Back away from the fence] -> outside_unburned_0012
* [Try to climb it anyway] -> sniper_death

=== return_inside_0012 ===
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

+ [Move toward the woods] -> woods_blocked_0023
* [Try to climb the fence] -> sniper_death
+ [Go back inside] -> return_inside_0023

=== woods_blocked_0023 ===
You move toward the fence line.

The farther you get from the shutter, the stronger the pressure in your skull becomes.
Not pain.
Recognition.

The woods beyond the fence seem too still.
As if they are listening.

+ [Go back to the service road] -> outside_unburned_0023
* [Try to climb the fence anyway] -> sniper_death
+ [Go back inside] -> return_inside_0023

=== return_inside_0023 ===
You turn back toward the facility.

The shutter opening seems to widen for you a fraction before you duck through.
Inside, the root chamber waits with the dead guard sprawled beside it, as if it knew you would return.

-> root_final

=== sniper_death ===
You grab the fence and start to climb.

For one savage second you think you might actually clear it.

Then a single rifle shot cracks through the night.

The impact tears through you and throws you backward off the wire.
You hit the ground hard beneath the floodlights and do not get up again.

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

* [Run into the woods] -> ending_0001_woods
* [Wait for the helicopter] -> ending_0001_heli

=== ending_0001_woods ===
You run for the darkest stretch of trees before the helicopter can settle.

Branches slash at your arms.
Behind you, the searchlight combs the road and the firelight throws the facility into broken shapes.

No one calls after you.

By the time the helicopter lands, you are through the damaged fence and deep enough in the woods that only the glow behind you remains.

ENDING: LOST IN THE PINES
-> END

=== ending_0001_heli ===
You stay where you are.

The helicopter lands hard on the service road.
A man in a dark field jacket steps out into the wash of firelight and rotor wind.

He looks at the burning facility first.
Then at the band on your wrist.

"If you can walk, walk. You're leaving. Now."

He does not wait for questions.
You climb aboard with the fire still reflecting in the helicopter glass.

Whatever happens next is not rescue exactly.
But you are alive.

ENDING: EXTRACTED
-> END

=== outside_burned_0012 ===
The helicopter lowers until its searchlight washes over the road, the fence, and the burning side of the building.

The sound is too loud to think through.

* [Run into the woods and hide] -> ending_0012_woods
* [Wait for the helicopter] -> ending_0012_heli

=== ending_0012_woods ===
You run off the road and duck beneath a low spread of pine branches near the buckled stretch of fence.

Needles scrape your skin.
You stay low and watch through the gaps.

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
The man by the helicopter keeps scanning the tree line for another few seconds, then lowers the radio and boards again.

Soon the helicopter lifts away, carrying its light and noise with it.

When the road is dark again, you slip through the damaged fence section and keep moving without looking back.

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

ENDING: LIFTED OUT
-> END

=== outside_burned_0023 ===
The helicopter descends lower than it should.

Its searchlight sweeps across the road once, then snaps back onto you too quickly.
Not searching.
Finding.

The pressure behind your eyes returns.

* [Step into the searchlight] -> ending_0023_light
* [Run into the woods] -> ending_0023_woods
* [Tear off or cover the wristband and wait] -> ending_0023_false

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

Whatever you are, you are no longer inside their walls.

ENDING: THE BRANCH ESCAPES
-> END

=== ending_0023_false ===
You rip off the wristband and grind it into the ash and gravel under your heel.

Then you pull the gown tighter and wait near the firelight as if you belong to no one.

The helicopter lands.
The same dark-jacketed man steps out and scans you once from a distance.

He stops just short of speaking.

His eyes move to your bare wrist.
Then to your face.
Then back again.

For one second you think he knows.

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

=== lullaby_room ===
~ heard_lullaby = true

You follow the melody to a half-open side room.

A small speaker in the corner keeps trying to play the same lullaby from a warped internal loop.
The room itself looks like a sleep ward that was shut in a hurry:
low beds,
folded blankets,
a painted moon on one wall.

Something thin crouches beneath the nearest bed frame.

It does not rush you.
It only rocks slightly in time with the broken melody.

* [Stand still and listen until the song stops] -> lullaby_listen
* [Back away quietly] -> hall_a

=== lullaby_listen ===
You stay still.

The melody skips, repeats, then finally dies in a burst of static.
The thing beneath the bed stops rocking.

After a long second, it crawls soundlessly into the wall gap behind the bed and disappears.

Only the room remains.

You are alone again.
-> hall_a
