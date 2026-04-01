---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
inputDocuments:
  - game-brief.md
documentCounts:
  briefs: 1
  research: 0
  brainstorming: 0
  projectDocs: 0
workflowType: 'gdd'
lastStep: 14
project_name: 'KiddoSandbox'
user_name: 'Broman'
date: '2026-04-01'
game_type: 'roguelike'
game_name: 'Double Twice'
---

# Double Twice - Game Design Document

**Author:** Broman
**Game Type:** Roguelike (bullet-hell boss-creator)
**Target Platform(s):** macOS, Linux, Windows, Steam Deck

---

## Executive Summary

### Game Name

Double Twice

### Core Concept

Double Twice is a co-op bullet-hell boss-creator where players are sci-fi scientists whose wild creations have escaped the lab. The core experience is uniquely player-driven: you build a boss from modular parts — choosing its head, torso, legs, attack patterns, and phases — then step through a portal to fight what you've made. The mini-creatures you encounter along the way are spawned from your boss's traits, making every run feel like a consequence of your own creativity.

Designed from the ground up for a parent and young child to play together on the couch, Double Twice embraces skill disparity as a feature. Auto-aim, graduated difficulty, and a ghost mechanic for downed players ensure that a 3-year-old and an experienced gamer can both have fun — without the stronger player ever being punished for having a weaker partner. Your kid can be the dungeon master, building the boss for dad to fight, then jumping in to help.

The game grows through a Monster Hunter-inspired loop: defeat bosses, harvest their parts, unlock new modular pieces and attack patterns, and build increasingly wild creations. A trophy case tracks your victories. Weapons drop with Borderlands-style randomized modifiers. Passive and active items stack for emergent power fantasies. The vision stays open — whether it evolves into a full roguelike, a boss rush mode, or something else entirely, the fun lives in the game feel first.

**Future crafting system:** Harvested monster parts run through a "processor" to create "goop" — a universal crafting resource used to forge weapons from blueprints found in chests or dropped by bosses. Weapons have rarity tiers (common/uncommon/rare/epic/legendary) with RNG chances for modifiers at matching rarity levels — status effects, increased mag size, fire rate boosts, or passive abilities. **MVP starts simpler:** 3-4 distinct weapon types with unique behaviors, no modifiers yet.

### Game Type

**Type:** Roguelike (bullet-hell boss-creator)
**Framework:** This GDD uses the roguelike template with type-specific sections for run structure, procedural generation, permadeath/progression, item systems, character selection, and difficulty modifiers — adapted for the unique boss-creator core loop.

---

## Target Platform(s)

### Primary Platform

PC — macOS (development machine), Linux, Windows. Godot 4.5 exports to all three natively.

### Platform Considerations

- **Steam Deck:** Should run unofficially without additional work since it's a Linux build.
- **Performance:** Pixel art bullet-hell at 60fps on all targets. No demanding GPU requirements.
- **No console certification needed** — personal project.

### Control Scheme

- **Controllers (primary):** 8BitDo, Xbox/PowerA via Bluetooth or USB. 1-4 controllers for couch co-op.
  - Left stick: move | Right stick: aim (optional twin-stick) | RT: shoot | RB/B: dodge roll | A: interact
- **Keyboard+Mouse (secondary):** WASD movement, mouse aim, click to shoot. Essential for dev/testing auto-aim.
- **Auto-aim:** Configurable percentage per player (0-100%). At 100%, aiming is fully automatic.
- **Optional auto-shoot:** For youngest players.

---

## Target Audience

### Demographics

Primary: gamer dad (30s, experienced) + young son (3.5, growing into it). Extended: nephews (5 and 8), spouse, adult friends. 1-4 player couch co-op.

### Gaming Experience

Mixed by design. Dad wants systems depth. Son wants cool bosses and "blasters." Game works for both simultaneously without compromise.

### Genre Familiarity

None required. Dad knows Gungeon/Borderlands/Castle Crashers intimately. Son knows which character he likes and what looks cool.

### Session Length

15-45 minute couch sessions — build a boss, fight it, maybe build another.

### Player Motivations

- **Dad:** Engaging systems, satisfying game feel, quality time
- **Son:** Cool bosses, creative ownership, feeling proud, being involved
- **Both:** Togetherness, laughing at silly creations, victory celebrations

---

## Goals and Context

### Project Goals

1. **Learning goal:** Learn Godot 4.5 game development through building a real, playable game
2. **Creative goal:** Create a co-op bullet-hell that solves the family co-op problems in existing games (Gungeon, Blazing Beaks, Castle Crashers)
3. **Experience goal:** Build something Wesley wants to play again and again — and wants to help create
4. **Technical goal:** Establish a modular boss-creation system and AI art pipeline (Nano Banana → Sprite Sheet Gen → Godot) that supports ongoing content creation

### Background and Rationale

Existing co-op bullet-hells and roguelikes fail families with young children. Enter the Gungeon punishes the skilled player when the co-op partner gets hit (lost heart containers, mandatory revive chests, camera tug-of-war). Blazing Beaks pollutes the item pool with co-op items that assume equal skill. Castle Crashers has the right energy but lacks bullet-hell loot depth. No game in this space is designed for a parent and a 3-year-old to enjoy together without compromise.

Double Twice fills this gap — not as a commercial product, but as a passion project built by a dad for his family. The modular boss-creator gives it a unique identity: your kid designs the challenge, then you face it together. The AI art pipeline means Wesley can say "I want a shark" and see it appear in the game. Building it together is as much the point as playing it.

### Unique Selling Points (USPs)

1. **You build what you fight** — the boss creator is the game, not a side feature
2. **Graduated difficulty** — advanced mechanics exist but aren't required at lower levels
3. **Accessibility as a spectrum** — auto-aim percentage, optional auto-shoot, twin-stick optional
4. **Co-op that never punishes** — no shared punishment, ghost mechanic keeps dead player involved
5. **Snowball potential** — item/weapon combinations create emergent power fantasies

---

## Core Gameplay

### Game Pillars

1. **Inclusive co-op** — playing together makes it better, never worse. Either player can also enjoy solo.
2. **Game feel / juice** — combat, movement, and interactions feel satisfying from day one.
3. **Create-then-conquer** — building the boss IS the game. Wesley can build for dad, build together, or fight together.
4. **Accessibility without dumbing down** — deep enough for dad, playable for a 3-year-old.

**Pillar Priority:** When pillars conflict: Accessibility > Game Feel > Create-then-Conquer > Inclusive Co-op. If it doesn't feel good, nothing else matters. If a kid can't do it, it doesn't ship.

### Core Gameplay Loop

**Build → Hunt → Fight → Harvest → Unlock → Build Harder**

1. **Build** — In the lab (menu for pre-MVP, diegetic lab later), select modular boss parts: head, torso, legs. Choose attack patterns and phases.
2. **Enter** — Step through the portal into the hunting grounds.
3. **Hunt** (future) — Fight through mini-creatures spawned from your boss's traits to reach the arena.
4. **Fight** — Bullet-hell boss battle. Dodge, shoot, use items, cooperate.
5. **Harvest** — Defeat the boss, collect parts, weapons, items, and rewards.
6. **Unlock** — New boss parts, attack patterns, biomes, weapons, and cosmetics become available.
7. **Repeat** — Build a harder boss with new parts. Trophy case grows.

**Loop Timing:** 10-20 minutes per boss encounter (pre-MVP: 3-5 minutes). Full session: 2-3 bosses.

**Loop Variation:** Every boss is player-designed, so no two fights are the same. Randomized loot and item drops add further variety. Boss trait combinations create emergent behaviors in mini-creatures.

### Win/Loss Conditions

#### Victory Conditions

- **Per encounter:** Defeat the boss you created. Boss HP reaches zero.
- **Meta victory:** Fill the trophy case, unlock all parts, build and defeat increasingly difficult creations.
- **No "final" win state** — this is an ongoing creative sandbox with escalating challenge.

#### Failure Conditions

- **Both players' HP reaches zero** during a boss fight.
- **Ghost mechanic:** When one player dies, they become a ghost that can deploy weak blanks/assists (a la Gungeon). They revive after the boss is defeated.
- **No permadeath for meta-progression** — you keep all unlocked parts and weapons between attempts.

#### Failure Recovery

- Lose a boss fight → return to lab with nothing gained (but nothing lost either)
- Ghost player revives at end of boss fight if partner wins
- No punishment for failure beyond not earning rewards — try again with the same or different boss

---

## Game Mechanics

### Primary Mechanics

#### Movement
- **Walk:** 8-directional movement, responsive and snappy
- **Dodge Roll:** i-frame invincibility roll (RB/B button). Not required at lower difficulties but essential for harder bosses. Should feel satisfying — good animation, screen feedback, audio punch.

#### Combat
- **Shoot:** Fire equipped weapon. Auto-aim configurable per player (0-100%). Optional auto-shoot for youngest players.
- **Twin-stick aiming:** Available but not mandatory. Right stick aims, left trigger/RT shoots.
- **Melee weapons:** Future option — Castle Crashers-inspired close-range combat as an alternative playstyle.

#### Boss Creation
- **Part selection:** Choose head, torso, legs from unlocked variants (5 each at MVP)
- **Attack pattern assignment:** Select from unlocked attack patterns per phase
- **Phase configuration:** Set number of phases and patterns per phase (1 phase at pre-MVP)
- **Preview:** See your creation before entering the portal

#### Items & Equipment
- **Weapons:** 3-4 distinct weapon types at MVP, each with unique behavior (e.g., rapid-fire blaster, shotgun spread, charged laser, bouncing projectile)
- **Passive items:** Stackable enhancements with fun/silly effects
- **Active items:** Usable abilities on cooldown or charges (shield, grenade, decoy, etc.)

#### Progression
- **Within-run:** Pick up weapons and items during the fight
- **Meta-progression:** Unlock new boss parts, attack patterns, weapons, and biomes by defeating bosses
- **Trophy case:** Monster Hunter-style collection of defeated creations

### Controls and Input

#### Controller (Primary)
| Input | Action |
|-------|--------|
| Left Stick | Move (8-directional) |
| Right Stick | Aim (optional — auto-aim available) |
| RT / R2 | Shoot |
| RB / B | Dodge Roll |
| A | Interact / Confirm |
| X | Use Active Item |
| Y | Swap Weapon |
| Start | Pause / Menu |
| D-Pad | Navigate menus / Boss creator |

#### Keyboard+Mouse (Secondary)
| Input | Action |
|-------|--------|
| WASD | Move |
| Mouse | Aim |
| Left Click | Shoot |
| Space | Dodge Roll |
| E | Interact |
| Q | Use Active Item |
| Tab | Swap Weapon |
| Esc | Pause |

---

## Roguelike Specific Elements

### Run Structure

Each "run" in Double Twice is a single boss encounter: build → enter portal → fight → return to lab.

**Pre-MVP run:** Select boss from menu → enter arena → fight boss → return to lab.
**MVP run:** Build boss in lab → enter portal → (future: fight through mini-creatures) → boss arena → collect rewards → return to lab.

- **Run length:** 5-15 minutes per encounter
- **Starting conditions:** Player starts with their equipped weapon and any persistent upgrades. Items found during combat are per-run.
- **Difficulty scaling:** Determined by the boss you build — harder parts and patterns = harder fight = better rewards.
- **Victory condition:** Boss HP reaches zero.

### Procedural Generation

**Pre-MVP:** No procedural generation. Boss is player-designed, arena is static.

**MVP:** Boss behavior is "procedurally" driven by player choices — attack patterns, phases, and trait-spawned mini-creatures create emergent variety.

**Future:**
- Procedurally generated hunting grounds between portal and boss arena
- Mini-events, mini-bosses guarding chests, hidden chests
- Scavengeable resources (ore, wood — Archvale-inspired)
- Biome variation based on boss traits (ghost head → ectoplasm biome)

### Permadeath and Progression

**No traditional permadeath.** This is a kid-friendly game — losing a boss fight means you go back to the lab and try again.

**What persists between runs:**
- All unlocked boss parts, attack patterns, and biomes
- Weapon collection (best weapons saved from runs — future feature)
- Trophy case of defeated bosses
- Player upgrades and abilities
- Unlocked cosmetics and skins

**Meta-progression systems:**
- Defeat bosses → earn boss parts as resources
- Boss parts → unlock new modular pieces, attack patterns, biomes
- Future: Boss parts → processor → "goop" → craft weapons from blueprints
- Future: Farm specific boss types for specific resources (ghost heads → ectoplasm biome unlock)

### Item and Upgrade System

**MVP Item Types:**
- **Weapons (3-4 types):** Each with distinct behavior — rapid-fire, shotgun spread, charged laser, bouncing projectile
- **Passive items:** Stackable buffs (move speed, fire rate, extra HP, etc.)
- **Active items:** Cooldown abilities (shield, dash bomb, decoy, heal)

**Future Item Systems:**
- **Rarity tiers:** Common / Uncommon / Rare / Epic / Legendary
- **Weapon modifiers:** RNG chance for modifiers matching rarity — status effects, mag size, fire rate, passives
- **Item synergies:** Certain combinations create emergent power fantasies (snowball effect)
- **Blueprints:** Found in chests or dropped by bosses, used with goop to craft weapons
- **No curse/risk mechanics** — this is a feel-good game, not a punishment simulator

### Character Selection

**MVP Characters:**
- **Dad (Broman):** Scientist in lab coat. Balanced stats. The "default" character.
- **Son (Wesley):** Kid scientist. Potentially slightly different abilities or a companion pet.

**Future Characters:**
- Mom
- Family dog
- Nephews/cousins
- Unlockable characters with unique abilities or playstyles
- Cosmetic skins and outfit variants (lab coat → trenchcoat → etc.)

**Character differences are cosmetic at MVP** — gameplay balance between characters is a future consideration. No character should be strictly better or worse, especially since the young player shouldn't be disadvantaged by character choice.

### Difficulty Modifiers

**Core philosophy:** Difficulty is player-controlled through boss creation, not forced by the game.

**MVP difficulty:**
- Easier bosses: simpler parts, fewer/slower attack patterns, one phase
- Harder bosses: complex parts, faster/denser patterns, multiple phases
- Player controls difficulty by what they build

**Future challenge systems:**
- Difficulty tiers on boss parts (1-star easy, 3-star hard)
- Better rewards for harder bosses
- Boss rush mode: fight a gauntlet of randomly generated bosses
- Challenge modifiers: optional mutators ("no dodge roll," "double projectiles") for experienced players
- Achievement conditions tied to specific boss configurations

---

## Progression and Balance

### Player Progression

**Short-term (within a session):**
- Pick up weapons and items during boss fights
- Get better at dodging specific attack patterns
- Learn boss behaviors based on the parts you chose

**Medium-term (across sessions):**
- Unlock new boss parts, attack patterns, and biomes
- Build up trophy case
- Accumulate weapons and items in persistent collection
- Discover item synergies and effective combinations

**Long-term (ongoing):**
- Master harder boss configurations
- Unlock all parts and patterns
- Complete trophy case
- Future: Boss rush leaderboards, challenge runs

### Difficulty Curve

The difficulty curve is **player-driven**, not designer-imposed:

1. **Early game:** Simple parts available, one phase, slow attack patterns. Wesley can build and beat these.
2. **Mid game:** More complex parts, faster patterns, 2-3 phases. Dad starts needing dodge rolls.
3. **Late game:** Dense bullet patterns, multiple phases with escalating difficulty, rare parts that create truly challenging bosses.
4. **The curve is opt-in:** Players choose their difficulty by what they build. A 3-year-old never encounters a difficulty wall.

### Economy and Resources

**MVP economy:** Minimal. Beat a boss → unlock new parts. No currencies.

**Future economy:**
- **Boss parts:** Harvested from defeated bosses. Different bosses drop different parts.
- **Goop:** Processed from boss parts. Universal crafting currency.
- **Blueprints:** Found in chests or boss drops. Combined with goop to craft weapons.
- **No premium currency, no MTX** — this is a personal project.

---

## Level Design Framework

### Level Types

**Pre-MVP:** Single static arena. Flat ground, no obstacles. Pure boss fight.

**MVP:**
1. **Home Base (Lab):** Hub area for boss creation, trophy case, weapon storage, upgrades. Pre-MVP: simple menu. MVP: diegetic Dexter's Lab-style environment.
2. **Boss Arena:** The fighting space. Simple for MVP — open area with the boss.

**Future:**
3. **Hunting Grounds:** Procedurally generated area between portal and boss. Mini-creatures, mini-events, chests, resources.
4. **Biome variants:** Visual/mechanical themes tied to boss traits (ectoplasm biome, fire biome, etc.)

### Level Progression

No linear level progression — the player chooses what to fight by building it. The "progression" is the expanding roster of available parts and the increasing complexity of bosses you can create.

---

## Art and Audio Direction

### Art Style

**Style:** Chibi pixel art — oversized heads, compact bodies, ~64x64 per character sprite.
**Palette:** Warm, muted tones with enough personality for glasses, beards, lab coats. Style anchor: existing scientist character sprite (lab coat version).
**Perspective:** Top-down for gameplay.

**Key Principles:**
- Color contrast between characters and backgrounds — critical for bullet-hell readability
- Artistic cohesion even in prototype — intentional placeholder art, not programmer art
- All assets generated via Nano Banana with strict prompt guidelines referencing the art bible
- Modular design: outfit/skin swaps on same base model (proven with trenchcoat → lab coat)

**Art Bible (to be defined before asset generation):**
- Pixel resolution per asset type
- Color palette (exact hex values)
- Outline style and thickness
- Animation frame counts per action (idle, walk, roll, shoot, death, etc.)
- Projectile and effect sizes
- UI element style

**Inspiration:** Enter the Gungeon (charming cohesive pixel art), Castle Crashers (bold personality in simple characters)

### Audio and Music

- **Music:** Generated via Suno AI. Likely chiptune or synth to match pixel aesthetic. Per-biome themes future.
- **SFX:** Satisfying blaster sounds, impact feedback, boss roars, dodge roll whoosh, item pickup chimes. Priority is juice — every action should feel good to hear.
- **Voice acting:** None. Grunts/sound bites at most.
- **Production:** All audio through Suno AI or free SFX libraries.

---

## Technical Specifications

### Performance Requirements

- **Frame rate:** 60fps target on all platforms
- **Resolution:** Support common resolutions (1080p, 1440p, 4K scaling for pixel art)
- **Load times:** Near-instant for arena transitions (small scope)
- **Memory:** Minimal — pixel art assets are tiny

### Platform-Specific Details

| Platform | Details |
|----------|---------|
| **macOS** | Development machine. Bluetooth controller support. Primary testing platform. |
| **Linux** | Native Godot export. Steam Deck target (unofficial). |
| **Windows** | Native Godot export. Broadest controller compatibility. |
| **Steam Deck** | Linux build, should work out of the box. Controller-first by design. |

### Asset Requirements

**Character sprites:**
- Player characters: ~64x64, chibi pixel art
- Animations needed: idle, walk (4-dir or 8-dir), dodge roll, shoot, death, item pickup
- Modular boss parts: head/torso/legs at consistent scale, must compose cleanly at runtime

**Environment:**
- Arena tileset (MVP: one biome)
- Lab/home base tiles
- Portal effect

**UI:**
- Boss creation interface elements
- HUD (HP, weapon, active item, ammo)
- Controller button icons (Xbox-style) for prompts
- Short text labels ("Play", "Start", "Shop")

**Effects:**
- Projectile sprites (player + enemy variants)
- Hit effects, death effects
- Dodge roll trail
- Screen shake, hit pause parameters

---

## Development Epics

### Epic Structure

**Epic 0: Project Setup**
- Godot 4.5 project structure
- Input system (controller + KBM, multi-controller support)
- Basic scene management

**Epic 1: Core Combat (Pre-MVP)**
- Player movement (8-dir, dodge roll with i-frames)
- Shooting system (basic projectile, auto-aim)
- Single weapon implementation
- Basic enemy (static target for testing)
- Game feel pass: screen shake, hit pause, knockback, particles

**Epic 2: Boss System (Pre-MVP)**
- Modular boss data structure (head/torso/legs)
- Boss creation menu (simple UI selector)
- Boss rendering (compose parts into single entity)
- Single attack pattern implementation
- Boss HP and defeat

**Epic 3: Boss Combat (Pre-MVP)**
- 3-4 attack patterns with projectile behaviors
- Boss phase system (single phase for pre-MVP)
- Trait-based mini-creature spawning (basic version)
- Arena scene

**Epic 4: Co-op (Pre-MVP)**
- 2-player local co-op
- Split/shared camera solution
- Ghost mechanic for dead player
- Player revive on boss defeat
- Auto-aim per-player configuration

**Epic 5: Weapons & Items (MVP)**
- 3-4 distinct weapon types with unique behaviors
- Weapon pickup/swap system
- Basic passive items (2-3)
- Basic active items (1-2)

**Epic 6: Meta-Progression (MVP)**
- Trophy case
- Boss part unlocks
- Persistent weapon collection
- Save/load system

**Epic 7: Home Base (MVP)**
- Diegetic lab environment
- Boss creation machine (in-world interaction)
- Portal to hunting grounds
- Trophy display

**Epic 8: Art & Polish (MVP)**
- Art bible definition
- Character sprite generation (Nano Banana pipeline)
- Boss part sprite generation
- Environment art
- UI polish
- SFX and music (Suno AI)

---

## Success Metrics

### Technical Metrics

- 60fps on all target platforms
- No crashes during boss fights
- Controller hot-plug works reliably
- Multi-controller co-op connects cleanly
- Save/load works without data loss

### Gameplay Metrics

- Wesley asks to play it again
- Core loop (build → fight) is fun before meta-progression exists
- Game feel is satisfying — shooting, rolling, movement feel good
- Co-op works without frustration for either player
- Boss creation is intuitive enough for a 3-year-old to participate
- Broman is learning Godot and having fun building it

---

## Out of Scope

The following are explicitly **not** in scope for pre-MVP or MVP:

- Online multiplayer (couch co-op only)
- Procedurally generated levels/rooms (static arena first)
- Weapon modifier/rarity system (3-4 base weapons first)
- Goop crafting system
- Multiple biomes
- Story/narrative content
- Achievements/leaderboards
- Localization
- Steam store page or distribution
- Mobile/console ports
- Tutorial system (learn by playing, dad is right there)

---

## Assumptions and Dependencies

### Assumptions

- Godot 4.5 supports all needed features (multi-controller, export targets, sprite composition)
- Nano Banana can produce consistent art with strict prompting
- Sprite Sheet Gen skill can be adapted for modular boss part animations
- Chibi pixel art at ~64x64 provides enough detail for character personality
- A 3-year-old can navigate a boss creation menu with parent guidance

### Dependencies

- **Godot 4.5:** Engine for all development
- **Nano Banana (Gemini CLI):** Art asset generation
- **Sprite Sheet Gen skill:** Animation assembly pipeline
- **Claude Code:** Development assistance and code generation
- **Suno AI:** Music and SFX generation (when ready)
- **Controllers:** 8BitDo + Xbox/PowerA for testing

---

_This GDD serves as the comprehensive design reference for Double Twice development._

_Game Brief: `_bmad-output/game-brief.md`_
