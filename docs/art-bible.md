---
title: Double Twice Art Bible
status: pre-mvp
style_anchor: nanobanana-output/nanobanana-output/spy_dad_labcoat_base.png
---

# Double Twice — Art Bible

This document is the single source of truth for all visual asset creation in Double Twice. Every Nano Banana prompt, every sprite sheet generation, every UI element must conform to these rules. The Sprite Sheet Gen skill and any other art-generating agent should reference this document.

---

## Style Overview

**Style:** Chibi pixel art
**Perspective:** 3/4 top-down (slight overhead angle, character faces camera at ~30° tilt)
**Tone:** Charming, expressive, kid-friendly. Enter the Gungeon's cohesive pixel craft meets Castle Crashers' personality. Not overly detailed — clarity and readability at small scale are paramount.

**Style Anchor:** `nanobanana-output/nanobanana-output/spy_dad_labcoat_base.png`
All assets must look like they belong in the same game as this sprite.

---

## Pixel Resolution Standards

| Asset Type | Resolution | Notes |
|-----------|-----------|-------|
| Player characters | 64x64 | Chibi proportions, ~40% head |
| Boss parts (head) | 48x48 | Must compose with torso/legs |
| Boss parts (torso) | 48x64 | Central piece, widest |
| Boss parts (legs) | 48x32 | Below torso |
| Boss (composed) | ~96x128 | Larger than players, imposing |
| Mini-creatures | 32x32 | Smaller than players, simple |
| Weapons (held overlay) | 24x24 | Overlaid on character, rotates with aim |
| Projectiles | 8x8 or 16x16 | Must be visible against backgrounds |
| Items (ground) | 16x16 | Readable at a glance |
| Items (UI icon) | 32x32 | Used in HUD/inventory |
| Environment tiles | 16x16 | Tileable, top-down perspective |
| UI elements | Variable | Must match pixel density of game world |

**Critical rule:** Never mix resolutions within an asset type. A 32x32 enemy next to a 64x64 enemy breaks cohesion instantly.

---

## Color Palette

Derived from the style anchor sprite. All assets must use colors from this palette or close harmonics. No neon, no pure saturated colors.

### Core Palette

| Swatch | Hex | Usage |
|--------|-----|-------|
| Dark outline | #2C2C2C | All sprite outlines, 1px |
| Black (deep) | #1A1A1A | Glasses, dark details |
| Dark brown (hair) | #5C3A1E | Hair base |
| Medium brown (hair) | #8B5E3C | Hair highlights |
| Light brown (hair) | #A67C52 | Hair bright spots |
| Skin tone (base) | #D4A574 | Face/hands base |
| Skin tone (shadow) | #B8875A | Face/hands shadow |
| White (lab coat) | #F0F0F0 | Lab coat, light clothing |
| Off-white (coat shadow) | #D0D0D0 | Lab coat folds/shadows |
| Gray (coat deep shadow) | #A0A0A0 | Deep folds, undershirt |
| Dark gray (pants/shirt) | #4A4A4A | Pants, dark clothing |
| Medium gray | #6B6B6B | Clothing mid-tones |

### Extended Palette (for environments, effects, enemies)

| Swatch | Hex | Usage |
|--------|-----|-------|
| Grass green | #5B8C3E | Environment — grass, foliage |
| Dark green | #3D6B2A | Environment — shadows, trees |
| Sky blue | #6BA4C9 | UI accents, portal effects |
| Portal purple | #7B4FA0 | Portal, energy effects |
| Warning red | #C94040 | Enemy projectiles, damage |
| Loot gold | #D4A832 | Item drops, legendary glow |
| Health green | #4CAF50 | HP bars, healing |
| Shadow dark | #2A1A2A | Shadow creatures base |
| Shadow mid | #4A3050 | Shadow creature details |

### Palette Rules

- **Characters:** Use only core palette colors
- **Environments:** Core palette + extended greens/blues
- **Effects/projectiles:** Extended palette, can be brighter for visibility
- **UI:** Core palette for frames/text, extended for status indicators
- **Enemies (shadow creatures):** Shadow dark/mid as base, can incorporate trait colors (fire = red accents, ice = blue accents)
- **Never use pure white (#FFFFFF)** — use #F0F0F0 for brightest
- **Never use pure black (#000000)** — use #1A1A1A or #2C2C2C
- **Outlines are always #2C2C2C, 1px** — no exceptions

---

## Character Proportions

**Chibi style:**
- Head: ~40% of total character height
- Body (torso + legs): ~60% of total character height
- Head width ≈ body width (or slightly wider)
- Arms: short, stubby, reach to about hip level
- Legs: short, ~25% of total height
- Eyes: large relative to head, expressive
- No visible neck — head sits directly on torso

**Boss proportions:**
- Bosses should be 1.5x-2x the size of player characters
- Head/torso/legs proportions can vary wildly (that's the fun of modular creation)
- Must still feel "chibi" — oversized features, stubby limbs

---

## Outline and Shading

**Outlines:**
- 1px dark outline (#2C2C2C) around all sprites
- Outlines are consistent thickness — no variable-width outlines
- Inner detail lines can be slightly lighter (#4A4A4A) for subtle features

**Shading:**
- 2-3 tone shading maximum per surface (base + shadow + optional highlight)
- Light source: top-left (consistent across ALL assets)
- No gradients — flat color fills with hard pixel edges
- Dithering: minimal, only for large surfaces that need texture (ground tiles)

---

## Animation Standards

**Frame rates:**
- Idle: 6 FPS (slow, relaxed)
- Run: 10 FPS (energetic)
- Dodge roll: 12 FPS (snappy, fast)
- Shoot: 12 FPS (punchy)
- Death: 8 FPS (dramatic timing)
- Ghost: 6 FPS (floaty, slow)
- Item pickup: 8 FPS (satisfying)

**Animation principles:**
- Squash and stretch where possible at pixel scale
- Anticipation frame before big actions (wind-up before roll)
- Hold/linger on impact frames (hit reaction, recoil)
- Return to idle pose cleanly from any animation
- All animation strips are horizontal (frames left to right)

See `docs/art-animation-spec.md` for full animation list, frame counts, and prompt templates.

---

## Environment Art

**Ground/floors:**
- 16x16 tileable
- Top-down perspective
- Subtle variation across tiles (2-3 variants per type to avoid tiling patterns)
- MVP: simple grass/dirt arena floor

**Walls/obstacles (future):**
- Same pixel density as ground tiles
- Clear visual distinction from walkable space
- Shadows cast toward bottom-right (consistent with top-left light source)

**Lab/home base:**
- Interior tileset — metal floors, lab equipment, monitors
- Dexter's Laboratory aesthetic — colorful but grounded
- Interactive objects (boss creation machine, trophy case, portal) should stand out from background with brighter colors or subtle glow/animation

---

## UI Art

**HUD elements:**
- Pixel-art styled, not smooth vector
- Same palette as game world
- Controller button prompts: Xbox-style icons (A/B/X/Y colored)
- Text: pixel font, short labels only ("Play", "Start", "Shop", "Build")
- HP bar: simple segmented bar, green (#4CAF50) to red (#C94040)

**Menus:**
- Dark semi-transparent background panels
- Bright text on dark backgrounds for readability
- Selection cursor: animated bounce or glow
- Boss creation UI: preview window showing composed boss in real-time

---

## Projectile and Effect Art

**Player projectiles:**
- 8x8 or 16x16, bright enough to track against any background
- Color-coded by weapon type (red, blue, green, etc.)
- Simple shapes: circles, ovals, small bolts — not realistic bullets

**Enemy projectiles:**
- Warning red (#C94040) base — must be instantly distinguishable from player projectiles
- Slightly larger than player projectiles for readability (player needs to dodge these)
- Can have trait-based visual variants (fire = orange, ice = blue, shadow = purple)

**Effects:**
- Screen shake: 2-4px, quick decay
- Hit flash: white frame on hit (1-2 frames)
- Hit particles: 3-5 small pixel squares scattered on impact
- Dodge roll trail: afterimage or dust puff
- Death: poof/sparkle, entity fades — no blood, no gore

---

## What NOT to Do

- No realistic proportions — everything is chibi
- No gradients or smooth anti-aliasing — hard pixel edges only
- No pure white or pure black — use the palette values
- No mixing pixel resolutions within asset types
- No detailed backgrounds that compete with gameplay readability
- No gore, blood, or violent imagery — enemies "poof" when defeated
- No inconsistent light sources — always top-left
- No variable outline thickness — always 1px #2C2C2C
- No generating assets without referencing the style anchor sprite

---

_This art bible is a living document. Update it as the visual style evolves, but always maintain consistency with existing assets._

_Related: `docs/art-animation-spec.md` (animation list and prompt templates)_
