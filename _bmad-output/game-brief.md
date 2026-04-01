---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8]
inputDocuments: []
documentCounts:
  brainstorming: 0
  research: 0
  notes: 0
workflowType: 'game-brief'
lastStep: 8
project_name: 'KiddoSandbox'
user_name: 'Broman'
date: '2026-04-01'
game_name: 'Double Twice'
---

# Game Brief: Double Twice

**Date:** 2026-04-01
**Author:** Broman
**Status:** Draft for GDD Development

---

## Executive Summary

**Double Twice** is a co-op bullet-hell boss-creator where sci-fi scientists create their own bosses — choosing modular body parts, attack patterns, and phases — then battle their creations together, unlocking new parts and patterns as they go.

**Target Audience:** A gamer dad and his young son (3-9), plus family and friends on the couch. 1-4 player co-op.

**Core Pillars:** Inclusive co-op, game feel/juice, create-then-conquer, accessibility without dumbing down.

**Key Differentiators:** You build what you fight. Graduated difficulty that grows with the player. Co-op that never punishes either player. Your kid is the dungeon master.

**Platform:** macOS, Linux, Windows, Steam Deck. KBM + controllers.

**Success Vision:** Wesley asks to play it again.

---

## Game Vision

### Core Concept

A co-op bullet-hell boss-creator where sci-fi scientists create their own bosses — choosing body parts, attack patterns, and phases — then battle their creations together, unlocking new parts and patterns as they go.

### Elevator Pitch

Double Twice is a co-op bullet-hell boss-creator where you and your kid are sci-fi scientists whose wild creations have gotten out of hand. Build a boss from modular parts — pick the head, body, arms, weapons, shades — then choose its attack patterns and phases. Enter the portal, fight through mini-creatures spawned from your boss's traits, and take on the big fight together. Beat your creation, earn rewards, and unlock new parts, patterns, and biomes to make even crazier bosses. It's Monster Hunter meets a dress-up game meets Enter the Gungeon, designed from the ground up for a parent and young child to play together. The co-op enhances the experience without ever punishing either player for the other's skill level.

### Vision Statement

Double Twice exists to be the game where Wesley builds the boss and then helps dad destroy it. You're sci-fi scientists — your crazy creations escape the lab, and it's up to you to take them down together. The creation *is* the game: dress up your monster with modular parts, choose its attack patterns, set its phases, then step into the portal and fight what you made. The mini-creatures you encounter along the way are spawned from your boss's traits — give it fire attacks, and its minions shoot fire too. Beat it, unlock new parts and harder patterns, and build your trophy case of defeated creations — Monster Hunter style. Beyond the in-game creator, the AI art pipeline lets Wesley say "I want a shark head" and see it show up as a new boss part. Building the game together is as much fun as playing it. Something he grows into — from age 4 to 9, maybe with his cousin jumping in too.

The game world is simple: a home base for building, upgrading, and admiring your trophy case, and the hunting grounds beyond the portal where you fight. Even if the direction shifts later, this lore and structure works from MVP (a handful of parts, one arena, a few attack patterns) all the way up to something massive. What matters first is the juice — does the combat feel satisfying? Does creating a boss feel fun? Does beating your own creation feel rewarding? Ideas and direction will emerge from getting that right.

---

## Target Market

### Primary Audience

Family and friends — specifically a gamer parent (30s, experienced) playing couch co-op with a young child (3-9 years old). Secondary players include older kids (nephews, cousins), spouse, and adult friends dropping in for couch sessions.

**Demographics:**
- Parent: Adult gamer with experience in roguelikes, bullet-hells, and action games. Wants systems with depth — meta progression, RNG modifiers, legendary weapons, character upgrades, skins, and meaningful challenge.
- Child: Ages 3-9. Good dexterity for movement but limited by hand size (no twin-stick), developing reading skills, and still learning advanced mechanics like dodge rolling. Needs the game to be fun and completable *without* mastering every system — unlike Gungeon, where skipping blanks and dodge rolls makes the game nearly unplayable.
- Extended: 1-4 player couch co-op for friends, nephews, family game nights.

**Gaming Preferences:**
Arcadey action games played on the couch — the same cadence as jamming on Zelda or Gungeon on a sick day home from school. Controller-based (8BitDo, Xbox/PowerA USB), not keyboard.

**Motivations:**
The parent wants engaging systems worth mastering. The child wants to feel involved, see cool bosses, shoot "blasters," and feel proud when they win. Both want to have fun *together* without the co-op working against them.

### Secondary Audience

Potentially other gamer parents in the same situation — but this is a personal project first. If the game grows, the core gameplay loop stands on its own. Assets and theming can be swapped later; the fun is engine-level.

### Market Context

This is not a commercial venture — it's a game built for a specific family. Market viability is not the driver.

**Similar Successful Games:**
Enter the Gungeon, Castle Crashers, Archvale, Nuclear Throne, AK-xolotl, Blazing Beaks, Vampire Survivors, Borderlands (loot system inspiration)

**Market Opportunity:**
None of these games nail family co-op for a parent with a young child. Gungeon comes closest but punishes both players for skill disparity, requires twin-stick and unintuitive button combos (click both sticks for blanks, RB for dodge roll), and scales difficulty without scaling accessibility. Castle Crashers has the right energy but lacks the bullet-hell loot depth. The gap: a game with adult-depth systems that a 3-year-old can meaningfully participate in.

**Content Approach:**
Violence is abstracted — "blasters" not guns, red dots and lasers not bullets, shadow monsters or imaginary creatures as enemies (no humans, no gore). Enemies fall away when defeated. Kid-friendly theming with room for Wesley to request custom enemies ("I want a shark!").

**Platform Targets:**
Cross-platform (macOS, Linux, Windows). Runs on Steam Deck (even unofficially). Supports both keyboard+mouse (WASD) and controllers (8BitDo, Xbox/PowerA via Bluetooth or USB). KBM is essential for development and testing auto-aim mechanics. 1-4 player couch co-op.

---

## Game Fundamentals

### Core Gameplay Pillars

1. **Inclusive co-op** — playing together makes it better, never worse. Either player can also enjoy solo.
2. **Game feel / juice** — combat, movement, and interactions feel satisfying from day one
3. **Create-then-conquer** — building the boss IS the game, not just a menu. Wesley can build for dad, build together, or fight together.
4. **Accessibility without dumbing down** — deep enough for dad, playable for a 3-year-old

**Pillar Priority:** When pillars conflict: Accessibility > Game Feel > Create-then-Conquer > Inclusive Co-op. If it doesn't feel good, nothing else matters. If a kid can't do it, it doesn't ship.

### Primary Mechanics

- **Create** — modular boss builder (head, body, arms, weapons, clothes, shades, attack patterns, phases)
- **Move** — walk, dodge roll
- **Shoot** — auto-aim option, various weapon types, loot with randomized modifiers
- **Collect** — passive items, active items, enhancements (within runs and as meta-progression)
- **Fight** — enter the arena, take on the boss you (or your kid) created
- **Unlock** — new boss parts, attack patterns, biomes, cosmetics from victories
- **Trophy case** — Monster Hunter-style collection of defeated creations

**Core Loop:** Build a boss → enter the arena → fight it → earn rewards → unlock new parts → build a harder boss

**Future Enhancements:** The arena can evolve into a procedurally generated open level with mini-events, mini-bosses guarding chests, hidden chests, scavengeable resources (ore, wood, a la Archvale/Monster Hunter), and more. The core loop stays the same — the world around it grows.

### Player Experience Goals

- **Pride** — Wesley feels proud beating the thing *he* built
- **Creative ownership** — "I made that!" both in-game boss creation and through the AI art pipeline
- **Togetherness** — side by side on the couch, building and fighting together
- **Discovery/excitement** — unlocking new parts, finding wild combinations, seeing what happens
- **Mastery** — for dad, deeper systems, harder patterns, better loot, satisfying challenge
- **Dungeon master energy** — Wesley can build a boss FOR dad to fight, then jump in to help if he wants

**Emotional Journey:** Build something silly/cool together → get hyped entering the portal → tension and action during the fight → triumph and rewards after victory → "let's make an even crazier one!"

---

## Scope and Constraints

### Target Platforms

**Primary:** macOS (development machine), Linux, Windows
**Secondary:** Steam Deck (unofficial, but should just work)

Input: Keyboard+mouse (WASD, essential for dev/testing auto-aim) and controllers (8BitDo, Xbox/PowerA via Bluetooth or USB). 1-4 player couch co-op.

### Budget Considerations

Cheap hobby project. ~$30 in Gemini API credits for art generation gets to prototype. No paid tools, engines, or asset packs — Godot is free, art is AI-generated via Nano Banana, sprite sheets assembled via custom Sprite Sheet Gen skill. Total cost is time + API credits.

### Team Resources

- **Solo dev:** Broman — intermediate programmer, learning Godot
- **AI tooling:** Claude Code for development, Nano Banana for art generation, Sprite Sheet Gen for animation assembly
- **Creative director:** Wesley (age 3.5, unofficial but very opinionated)
- **Skill gaps:** Game dev experience (learning), art (mitigated by AI pipeline), audio/music (TBD)

### Technical Constraints

- **Engine:** Godot 4.5
- **Art pipeline:** Nano Banana → Sprite Sheet Gen → Godot. Requires a clearly defined art bible (pixel resolution, color palette, perspective, outline style, animation frame counts) to ensure visual coherence across all AI-generated assets. The sprite-sheet-gen skill is a starting point and can be updated or replaced — the art bible is the source of truth, the skill is just a tool.
- **Art coherence is critical:** No mixing 8x8 sprites with 16x16 bushes, no betraying the color scheme. MVP must look and feel solid and coherent even as a prototype. Palette, resolution, and style must be defined before asset generation begins.
- **Modular design:** Boss parts, skins, and animations should be built with modularity in mind from the start — even if MVP ships with minimal variants, the system should support adding more without rework.
- **Accessibility:** Auto-aim option, simple controls (no twin-stick), very little reading (short labels + controller button icons), no heavy dialogue.

### Scope Realities

This is a learning project. Scope is intentionally small:
- **Pre-MVP:** Simple menu for boss creation (head, torso, legs — 3 parts to start, one phase per boss), one arena, core bullet-hell combat, 1-2 player co-op. The menu is throwaway scaffolding to test the core question: "is building and fighting your own boss fun?"
- **MVP goal:** Once the system is proven, invest in the diegetic lab experience — walk around your home base, interact with the boss-building machine in-world, see your creation on the monitor.
- **Future vision:** Diegetic lab with upgrades, resource harvesting from defeated bosses (farm ghost heads → unlock ectoplasm biome), boss parts as crafting materials for player abilities (passives, actives), more body part categories, multi-phase bosses, procedurally generated hunting grounds.
- The game is designed to be expandable — new parts, patterns, biomes, and systems layer on over time without rearchitecting
- Juice and game feel are the priority over content volume
- "Good enough to make Wesley want to keep playing" is the bar

---

## Reference Framework

### Inspiration Games

**Enter the Gungeon**
- Taking: Bullet-hell combat feel, weapon variety, boss personality (Gatling Gull shirt rip energy), ghost mechanic for dead co-op player (keeps the kid involved while dad clutches), revive at end of each boss in boss rush, dodge roll with i-frames (RB/B button mapping), the snowball effect of finding cool item combinations, twin-stick controls (but not mandatory)
- Not taking: Co-op punishment systems (losing heart container if partner gets hit by boss, mandatory revive chests that steal item drops), camera tug-of-war, jank weapon rewards for getting hit, boss rush dropping useless loot (keys, "chest mimic necklace" in a mode with almost no chests), scaling boss HP without scaling accessibility, difficulty that makes dodge roll mandatory from the start

**Borderlands**
- Taking: Randomized loot modifiers on weapons (fire rate +50%, legendary tiers), the dopamine of farming for better gear, the "one more run" loot chase, snowballing power fantasy
- Not taking: Open world scope, FPS genre, reading-heavy quest systems, online multiplayer focus

**Castle Crashers**
- Taking: The energy and vibe, fun boss fights with personality, couch co-op feel, cute collectible animals, accessible action that kids love, melee weapons as an option
- Not taking: Linear level progression

**Monster Hunter**
- Taking: Trophy case of defeated creatures, hunt-prep-fight loop (base → portal → boss), harvesting boss parts as resources for progression/upgrades
- Not taking: Complex crafting systems, massive scope, online multiplayer focus, steep learning curve

**Archvale**
- Taking: Bullet-hell + RPG feel, scavengeable resources (ore, wood — future feature), accessible combat
- Not taking: Full world/overworld scope (for now)

**Vampire Survivors**
- Taking: Open field + enemies spawning as early prototype feel, auto-aim/auto-shoot accessibility mode as inspiration for kid-friendly input options
- Not taking: Passive gameplay as the core loop (Double Twice is active combat), overwhelming enemy count as the primary mechanic

**Nuclear Throne / AK-xolotl / Blazing Beaks**
- Taking: Top-down bullet-hell combat reference, weapon variety, tight action feel
- Not taking: Blazing Beaks' co-op item pool that assumes both players are competent (useless items like "give co-op player your keys"), punitive difficulty that doesn't scale for mixed-skill co-op

**Mega Man** (beat the boss, get its power)
- Taking: Defeat a boss, gain its abilities/traits as your own powers
- Not taking: Linear stage structure, precision platforming

### Key Differentiators (Design Principles)

1. **You build what you fight** — the boss creator is the game, not a side feature. No other bullet-hell lets you design the boss, then fight it. Your kid is the dungeon master.
2. **Graduated difficulty by design** — dodge rolls and advanced mechanics exist but aren't required at lower levels. You can build approachable bosses and ramp up. The challenge grows with the player, not ahead of them.
3. **Accessibility as a spectrum** — auto-aim percentage (a la Blazing Beaks), optional auto-shoot, twin-stick available but not mandatory. The same game works for a 3-year-old and an experienced gamer sitting next to each other.
4. **Co-op that never punishes** — no shared punishment, no useless co-op items, no loot pool pollution. Ghost mechanic keeps dead player involved. The stronger player is never penalized for the weaker player's performance.
5. **Snowball potential** — cool item/weapon combinations that create emergent power fantasies, building toward roguelike/boss-rush modes where random boss generation and within-run progression create replayability.

**Unique Value Proposition:** The only bullet-hell where your kid builds the boss, you fight it together, and the difficulty is something you grow into — not something that gatekeeps the fun.

---

## Content Framework

### World and Setting

Dexter's Laboratory meets Rick and Morty portal vibes. A home base lab where sci-fi scientists build creatures, and a portal to the hunting grounds where you fight them. Charming and doesn't take itself seriously — Gungeon's aesthetic energy. Lore-light for now; world-building expands if the POC works.

### Narrative Approach

Minimal — pure gameplay. Maybe fun flavor text on items and boss parts, but no cutscenes, dialogue trees, or story-driven content. The narrative is emergent: "we built a shark-headed thing with laser arms and we beat it together."

**Story Delivery:** Through gameplay and item/boss descriptions. Nothing that requires reading comprehension beyond short labels.

### Content Volume

Intentionally small for pre-MVP/MVP:
- 5 head variants, 5 torso variants, 5 leg variants (interchangeable, likely to be wiped and reworked as modularity expands)
- 1 arena/biome
- Core combat with a handful of weapon types
- A few passive and active items
- Everything is designed to be swapped and expanded — nothing is precious at this stage

---

## Art and Audio Direction

### Visual Style

Chibi pixel art — oversized heads, compact bodies, ~64x64 per character. Warm, muted palette with enough personality for glasses, beards, lab coats, and outfit variants. Style anchor: the existing scientist character sprite (lab coat version).

**Key Principles:**
- Color contrast between characters and backgrounds is critical — accessible and readable in a bullet-hell
- Artistic cohesion even in prototype — intentional placeholder art, not programmer art
- All assets generated via Nano Banana with strict prompt guidelines referencing the art bible (resolution, palette, perspective, outline style, frame counts)
- Modular design: outfit/skin swaps should work on the same base model (proven with trenchcoat → lab coat variant)

**Art Bible (to be defined):** Pixel resolution, color palette, perspective, outline style, animation frame counts. Every Nano Banana prompt references this to maintain cohesion. The Sprite Sheet Gen skill implements it but is not the source of truth.

**References:** Enter the Gungeon (charming cohesive pixel art), Castle Crashers (bold personality in simple characters)

### Audio Style

- **Music:** Generated via Suno AI when ready. TBD on genre — likely chiptune or synth to match pixel aesthetic.
- **SFX:** Satisfying blaster sounds, impact feedback, boss roars. Suno AI or free SFX libraries. Priority is game juice — every action should feel good to hear.
- **Voice acting:** None. Grunts/sound bites at most.

### Production Approach

All art through AI pipeline (Nano Banana → Sprite Sheet Gen → Godot). All audio through Suno AI. Solo dev with Claude Code for programming. Assets are intentionally replaceable — build for cohesion now, swap for quality later.

---

## Risk Assessment

### Key Risks

1. **Scope creep** — The idea is exciting and expandable. Risk of adding systems before the core loop is fun. *Mitigation:* Pre-MVP is boss menu + one arena + combat. Nothing else until that's fun.
2. **Art cohesion from AI generation** — Nano Banana can produce inconsistent styles between prompts. *Mitigation:* Define art bible before generating assets. Use the existing character sprite as style anchor. Strict prompts.
3. **Modular boss system complexity** — Even 3 parts × 5 variants = design/animation challenges for how they combine visually. *Mitigation:* Start with simple combinations, validate the system works before expanding.

### Technical Challenges

- Modular sprite composition (combining head/torso/legs into one coherent boss at runtime)
- Boss attack pattern system that's data-driven and expandable
- Co-op camera that doesn't fight players
- Auto-aim system with configurable percentage
- Controller support across platforms (macOS, Linux, Windows, Steam Deck)

### Mitigation Strategies

- Keep MVP brutally small — prove the fun first
- Art bible before assets
- Playtest with Wesley early and often — he's the real QA
- Nothing is irreversible at this stage — assets, systems, and scope can all be reworked

---

## Success Criteria

### MVP Definition

**Pre-MVP (Proof of Concept):**
- Simple menu to select boss parts (head, torso, legs — 5 variants each)
- One arena
- Core bullet-hell combat (move, shoot, dodge roll)
- 1-2 player co-op
- Auto-aim option
- One weapon to start
- Boss has one phase with a few attack patterns
- No meta-progression — just "build it, fight it, repeat"

**MVP (if POC is fun):**
- Diegetic lab (home base)
- Portal to hunting grounds
- Loot drops (weapons with randomized modifiers)
- Passive and active items
- Trophy case
- Ghost mechanic for dead co-op player
- Basic unlock progression (beat bosses → unlock new parts/patterns)

### Success Metrics

- Wesley asks to play it again
- The core loop (build boss → fight boss) is fun before any meta-progression exists
- Game feel is satisfying — shooting, rolling, movement all feel good
- Co-op works without frustration for either player
- Broman is learning Godot and having fun building it

### Launch Goals

This is a personal project — there is no "launch." Success is playing it on the couch together. If it ever grows beyond that, goals can be revisited.

---

## Next Steps

### Immediate Actions

1. Define art bible (lock down pixel resolution, color palette, perspective, outline style, animation frame counts)
2. Prototype core combat (movement, shooting, dodge roll in a single arena)
3. Build simple boss creation menu (head/torso/legs selector)
4. Get a modular boss rendering on screen and moving
5. Playtest with Wesley

### Research Needs

- How to compose modular sprites at runtime in Godot 4.5
- Boss attack pattern system architecture (data-driven, expandable)
- Co-op camera solutions in Godot
- Auto-aim implementation approaches
- Controller input mapping in Godot (multi-controller support)

### Open Questions

- What pixel resolution works best for the chibi style at game scale? (64x64 character vs world tile size)
- How do modular boss parts animate together? (Separate AnimatedSprite2D nodes? Single composed sprite sheet?)
- What does "good game feel" mean specifically for this game? (Screen shake? Hit pause? Knockback? Particle effects?)
- How does difficulty scaling work mechanically? (Boss HP? Attack speed? Pattern complexity? Number of projectiles?)

---

_This Game Brief serves as the foundational input for Game Design Document (GDD) creation._

_Next Steps: Use the `/gds-create-gdd` command to create detailed game design documentation._
