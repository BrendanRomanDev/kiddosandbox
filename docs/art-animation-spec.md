---
title: Character Animation Specification
status: pre-mvp
base_sprite: nanobanana-output/nanobanana-output/spy_dad_labcoat_base.png
sprite_size: 64x64
---

# Character Animation Specification

## Game Context

**Double Twice** is a co-op bullet-hell boss-creator. Players are chibi sci-fi scientists in a cartoonish lab. They build modular bosses (head/torso/legs), then step through a portal to fight their creations in top-down arena combat. The tone is fun, charming, and kid-friendly — Enter the Gungeon's aesthetic energy meets Castle Crashers' personality. Violence is abstracted: "blasters" not guns, red dots and lasers not bullets, shadow monsters as enemies. Defeated enemies fall away — no gore, no guts. The game is designed for a parent and young child (age 3-9) to play together on the couch.

**Visual tone:** Charming and cohesive. Doesn't take itself seriously, but earns aesthetic respect. Think Dexter's Laboratory meets Rick and Morty portal vibes. Characters should feel expressive even at small pixel scale.

## Standard Prompt Preamble

When generating ANY sprite or animation frame for this project via Nano Banana, **always include this preamble** at the start of the prompt to ensure stylistic consistency:

```
Style: Chibi pixel art character for a top-down co-op bullet-hell game.
Resolution: 64x64 pixels per frame.
Palette: Warm muted tones — browns, tans, warm grays, white lab coat. Match the
reference sprite exactly. No new colors outside the established palette.
Perspective: 3/4 top-down view (same as reference sprite).
Outline: Dark pixel outline, 1px, consistent with reference.
Background: Transparent (or solid green #00FF00 for chroma key removal).
Character proportions: Oversized head (~40% of height), compact body, stubby limbs.
Tone: Cute, charming, expressive. Kid-friendly sci-fi scientist aesthetic.
Reference sprite: [attach nanobanana-output/nanobanana-output/spy_dad_labcoat_base.png]
```

## Standard Animation Prompt Template

When generating animation frames, use this template per animation:

```
[STANDARD PROMPT PREAMBLE above]

Generate a {FRAME_COUNT}-frame animation strip for: {ANIMATION_NAME}
Direction: {DIRECTION} (N/NE/E/SE/S/SW/W/NW or front-facing)
Action description: {ACTION_DESCRIPTION}

Layout: Horizontal strip, {FRAME_COUNT} frames side by side, each frame 64x64 pixels.
Total image size: {FRAME_COUNT * 64}x64 pixels.

The character should be clearly performing the described action with smooth frame
transitions. Each frame should be distinct but flow naturally into the next.
Maintain consistent proportions, palette, and outline style across all frames.
```

### Animation Action Descriptions

Use these descriptions in the `{ACTION_DESCRIPTION}` field to ensure consistent interpretation across all generation sessions:

| Animation | Action Description |
|-----------|-------------------|
| **idle** | "Scientist standing relaxed. Subtle bounce or breathing motion — slight vertical shift of the body. Arms at sides. Expressive but minimal movement. The character looks alert and ready." |
| **run** | "Scientist running with urgency. Clear leg movement alternating steps. Arms pump naturally. Lab coat flaps slightly with movement. Head bobs subtly. Should convey speed and energy at chibi scale." |
| **dodge_roll** | "Scientist tucking into a fast combat roll. Frame 1: crouch and lean. Frames 2-4: body curled mid-roll, rotating. Frame 5: coming out of roll. Frame 6: back to ready stance. Should feel snappy and athletic." |
| **shoot** | "Scientist in shooting stance, arms extended forward as if firing (but NO weapon in hands — weapon is overlaid separately). Frame 1: aim pose. Frame 2: recoil — slight backward lean, arms kick up. Frame 3: return to aim. Quick and punchy." |
| **death** | "Scientist dramatically defeated. Frame 1-2: hit reaction, stagger backward. Frame 3-4: spin with arms out. Frame 5-6: falling. Frame 7-8: collapsed on ground in silly/dramatic pose. Should be funny and theatrical, not sad or violent. A kid should laugh at this." |
| **ghost** | "Scientist as a translucent ghost — same character but faded/ethereal. Floating slightly above ground. Gentle bobbing up and down. Maybe a slight shimmer or transparency effect. Friendly ghost, not scary." |
| **item_pickup** | "Scientist triumphantly holding an item above their head with both hands. Frame 1: reach down. Frame 2: grab. Frame 3: lift overhead. Frame 4: hold pose with slight celebratory bounce. Classic Zelda treasure chest moment." |

## Base Character

- **Sprite:** `nanobanana-output/nanobanana-output/spy_dad_labcoat_base.png` (white lab coat scientist)
- **Size:** ~64x64 pixels per frame
- **Style:** Chibi pixel art, oversized head, compact body
- **Palette:** Warm muted tones — match existing base sprite exactly

## Required Animations

### 8-Directional Animations

These need frames for all 8 directions: N, NE, E, SE, S, SW, W, NW

| Animation | Frames | Description |
|-----------|--------|-------------|
| **idle** | 4 | Subtle breathing/bounce. Character standing still. |
| **run** | 6 | Clear leg movement visible at chibi scale. |
| **dodge_roll** | 6 | Tuck body and roll. Should feel snappy. i-frame window should match middle frames. |
| **shoot** | 3 | Body recoil pose. NO gun in hand — weapon is a separate sprite layered on top so weapons can be swapped visually. |

### Non-Directional Animations

These only need a single direction (front-facing unless noted).

| Animation | Frames | Direction | Description |
|-----------|--------|-----------|-------------|
| **death** | 8 | Front-facing | Dramatic and fun — stumble, spin, collapse. Should make a kid laugh, not feel sad. |
| **ghost** | 4 | Front-facing | Translucent/floaty idle for dead co-op player. Used when partner is still fighting. |
| **item_pickup** | 4 | Front-facing | Hold item above head, Zelda chest style. Celebratory pose. |

## Sprite Sheet Format

- **Layout:** Horizontal strip per animation per direction
- **Naming convention:** `{character}_{animation}_{direction}.png`
  - Example: `scientist_idle_N.png`, `scientist_run_SE.png`, `scientist_death.png`
- **Or combined:** One sheet per animation with all directions as rows
  - Row order: N, NE, E, SE, S, SW, W, NW (top to bottom)

## Frame Totals

| Category | Animations | Directions | Frames Each | Total Frames |
|----------|-----------|------------|-------------|--------------|
| 8-dir | 4 | 8 | 3-6 | ~152 |
| Non-dir | 3 | 1 | 4-8 | ~16 |
| **Total** | **7** | — | — | **~168** |

## Art Rules

- All frames must be the same pixel resolution as the base sprite (~64x64)
- Color palette must match the base sprite exactly — no new colors
- Transparent background on all frames
- Weapon is NEVER part of the character sprite — it's a separate overlay
- Outlines and shading style must match the base sprite
- When generating with Nano Banana, always reference the base sprite as the style anchor

## Notes

- This spec covers the first playable character (Dad/Scientist in white lab coat)
- Wesley's character will use the same animation set with a different base sprite
- Boss animations are a separate spec (TBD — modular parts have their own animation needs)
- Additional animations may be added later (melee attack, interact, emotes) but these 7 cover pre-MVP
