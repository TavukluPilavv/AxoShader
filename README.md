# AxoShader

AxoShader is an experimental Iris shader pack for Minecraft Java 1.21.1.

## Current prototype

- Iris-style terrain and entity G-buffer outputs
- First shadow-map pass and screen-space shadow sampling
- Alpha-tested shadow casters (helps cutout foliage render in the shadow pass)
- Warm daylight color tint
- Conservative 1024 shadow map resolution for a performance-first default

## Planned visuals

- Better realistic sky and animated cloud layers
- Sun glow and sunlight rays
- More convincing ground, tree, player and mob shadows
- Wind-driven leaf/grass animation that only affects foliage
- Water movement/reflections
- Lite / Balanced / High quality presets

## Install / build

1. Install Iris for Minecraft 1.21.1.
2. Download the **AxoShader.zip** artifact from GitHub Actions.
3. Put the ZIP in `.minecraft/shaderpacks`.
4. Select AxoShader in Iris.

## Important

This is still a **work-in-progress prototype**. The shader files have been reworked toward Iris's documented G-buffer and shadow pipeline, but they have **not yet been tested inside Minecraft/Iris**. Shadow rendering, shader compilation, and the final look must be verified in-game before calling it stable. The current version does not yet include finished volumetric clouds, sun rays, or full realistic water.
