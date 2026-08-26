---
title: Character Animation Specification
status: pre-mvp
base_sprite: assets/sprites/characters/brendo/base_greenscreen.png
sprite_size: 32x32
---

# Character Animation Specification

## Game Context

**Double Twice** is a co-op bullet-hell boss-creator. Players are chibi sci-fi scientists in a cartoonish lab. They build modular bosses (head/torso/legs), then step through a portal to fight their creations in top-down arena combat. The tone is fun, charming, and kid-friendly — Enter the Gungeon's aesthetic energy meets Castle Crashers' personality. Violence is abstracted: "blasters" not guns, red dots and lasers not bullets, shadow monsters as enemies. Defeated enemies fall away — no gore, no guts. The game is designed for a parent and young child (age 3-9) to play together on the couch.

**Visual tone:** Charming and cohesive. Doesn't take itself seriously, but earns aesthetic respect. Think Dexter's Laboratory meets Rick and Morty portal vibes. Characters should feel expressive even at small pixel scale.

## Design Philosophy: Prototype-First Simplicity

The character art is intentionally minimal. At 32x32, a character is roughly 14-18 pixels tall — hair is a color blob, glasses are 2 dark pixels, the coat is a flat color block, legs are pixel stumps. This is a deliberate stylistic choice inspired by Enter the Gungeon's character sprites (see `docs/Example Sprite Sheet Pilot ETG.png` for reference).

**Why this simple:**
1. AI image generation produces more consistent frame-to-frame results at low detail
2. Minor variations between frames read as bouncy animation, not errors
3. Drastically fewer frames needed — MVP ships faster
4. Art can be upgraded later without changing game architecture
5. At bullet-hell scale (zoomed out, lots of projectiles), players don't notice fine detail

**Hands/arms policy for MVP:** At 32x32, hands would be 1-2 pixels. They can exist or not — it barely matters visually. The armless architecture is still the right call for the node tree (weapon pivot handles aiming independently), but don't stress about whether a generated frame shows a pixel bump where an arm might be.

## Sprite Architecture

Characters use a **layered node approach** — NOT a single unified sprite:

```
CharacterBody2D
├── BodySprite (AnimatedSprite2D)     # body+head
│   └── animations: idle_S, run_S, dodge_S, etc.
├── WeaponPivot (Node2D)              # positioned at chest, rotates to aim
│   ├── WeaponSprite (Sprite2D)       # the weapon itself
│   └── Hand (Sprite2D or draw)       # small circle on grip (optional at 32x32)
└── CollisionShape2D
```

**Key rules:**
- **Body sprites are the full character silhouette** — head, torso, legs. At 32x32, arms are optional visual noise.
- **Hands are floating circles** — either `draw_circle()` in code or a tiny PNG. At 32x32 scale, a single pixel suffices.
- **Hands are children of the weapon pivot**, not the body. They rotate/move with the weapon automatically.
- **Recoil is code-driven** (tween on WeaponPivot), not animated in the sprite sheet.

## Standard Prompt Preamble

When generating ANY sprite or animation frame for this project via Nano Banana, **always include this preamble** at the start of the prompt:

```
Style: Ultra-simple chibi pixel art character for a top-down co-op bullet-hell game.
Inspired by Enter the Gungeon character sprites — chunky, minimal, readable.
Resolution: 32x32 pixels per frame. Character should be roughly 14-18 pixels tall.
Palette: Minimal — brown hair blob, skin-tone face, dark glasses (2px), tan/brown coat, dark legs. 4-6 colors max.
Perspective: 3/4 top-down view.
Detail level: VERY LOW. Hair is a solid color shape. No individual strands. Glasses are 2 dark pixels. Coat is a flat color block. Legs are pixel stumps.
Outline: 1px dark outline. Keep it chunky and readable.
Background: Solid bright green #00FF00 filling entire image.
Tone: Cute, charming. Kid-friendly sci-fi scientist.
Reference sprite: [attach base_greenscreen.png]
Reference style: [attach Example Sprite Sheet Pilot ETG.png]
```

## Animation Frame Generation Strategy

At 32x32 with minimal detail, frame generation is straightforward:

**For all animations:**
- Generate each frame by editing the base sprite with clear pose instructions
- At this detail level, style drift between frames is minimal — a few pixels shifting IS the animation
- Don't overthink consistency — embrace the slight variation as charm

**Loop continuity:** For looping animations, the final frame must transition smoothly back to frame 1. Include in the prompt: "This is frame N of N — returning to the same position as frame 1."

## Animation Action Descriptions

Use these descriptions in prompts to ensure consistent interpretation:

| Animation | Action Description |
|-----------|-------------------|
| **idle** | "Tiny pixel scientist standing relaxed. Subtle 1-2 pixel vertical bob — body shifts up/down slightly. Legs planted. Minimal movement, just enough to feel alive." |
| **run** | "Tiny pixel scientist running. Legs alternate (2-pixel stumps swapping). Body leans slightly forward. Simple and readable at 32x32." |
| **dodge_roll** | "Tiny pixel scientist doing a quick roll. Body tucks into a ball shape, rotates, then pops back up. Should feel snappy — biggest pose change of any animation." |

## Base Character

- **Sprite:** `assets/sprites/characters/brendo/base_greenscreen.png` (to be regenerated at 32x32)
- **Promoted:** `assets/sprites/characters/brendo/base.png` (transparent)
- **Size:** 32x32 pixels per frame
- **Style:** Ultra-simple chibi pixel art, Enter the Gungeon level of detail
- **Palette:** 4-6 colors — brown hair, skin tone, dark glasses, tan coat, dark pants, dark outline

## MVP Animations

### South-Only for MVP

Start with south-facing only. Expand to 4-directional or 8-directional after mechanics are working.

| Animation | Frames | FPS | Loop | Description |
|-----------|--------|-----|------|-------------|
| **idle** | 2-3 | 6 | Yes | Subtle vertical bob. |
| **run** | 3 | 8 | Yes | Leg alternation, slight lean. |
| **dodge_roll** | 4-5 | 12 | No | Tuck, roll, pop up. |

### Future Animations (Post-MVP)

These are parked for later. Don't generate these yet.

| Animation | Frames | FPS | Loop | Notes |
|-----------|--------|-----|------|-------|
| **death** | 4-6 | 8 | No | Theatrical collapse. Funny, not sad. |
| **ghost** | 2-3 | 6 | Yes | Translucent floaty idle for dead co-op player. |
| **item_pickup** | 3 | 8 | No | Celebratory bounce. |

### Removed from body animations

| Animation | Why | Where it lives instead |
|-----------|-----|----------------------|
| **shoot** | Body doesn't animate for shooting — recoil is on WeaponPivot via tween | Code (tween on WeaponPivot node) |

## Directional Expansion Plan (Post-MVP)

When ready to add directions, generate 5 and mirror 3:

| Generate | Mirror to get |
|----------|--------------|
| S | — |
| E | W (flip horizontal) |
| N | — |
| NE | NW (flip horizontal) |
| SE | SW (flip horizontal) |

Mirror via `flip_h` at runtime in Godot or `magick sheet_E.png -flop sheet_W.png`.

## MVP Frame Totals

| Animation | Directions | Frames | Total |
|-----------|-----------|--------|-------|
| idle | 1 (S) | 2-3 | 3 |
| run | 1 (S) | 3 | 3 |
| dodge_roll | 1 (S) | 4-5 | 5 |
| **Total** | — | — | **~11** |

(Down from ~96 in the previous spec. Upgradeable anytime.)

## Sprite Sheet Format

- **Layout:** Horizontal strip per animation per direction
- **Naming:** `{character}_{animation}_{direction}.png`
  - Example: `brendo_idle_S.png`, `brendo_run_S.png`, `brendo_dodge_roll_S.png`
- **Background removal:** 3-step chroma pipeline (key → despill → black snap) on every frame

## Art Rules

- All frames: 32x32 resolution
- 4-6 color palette per character — keep it dead simple
- Solid green #00FF00 background during generation (chroma keyed after)
- 1px dark outline, chunky and readable
- Always reference the base sprite AND the ETG reference for style consistency
- Embrace imperfection — at this scale, slight frame variation is animation

## Notes

- This spec covers the first playable character (Brendo / Dad)
- Wesley's character will use the same animation set with a different base sprite
- Boss animations are a separate spec (TBD — modular parts)
- Weapon+hand sprites are a separate spec (TBD)
- Art can be upgraded to higher fidelity later without changing game architecture
- The previous 64x64 detailed sprites are preserved in git history if needed
