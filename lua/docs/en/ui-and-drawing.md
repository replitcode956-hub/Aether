# Script UI and drawing

Script controls appear in the script's popup under `Misc -> Lua API`.

```lua
aether.ui.text("status", "Status", "Waiting")
aether.ui.button("reset", "Reset", "Apply")
aether.ui.toggle("enabled", "Enabled", true)
aether.ui.slider("size", "Size", 10, 1, 40, 0.5)
aether.ui.select("mode", "Mode", {"First", "Second"}, 0)
aether.ui.input("endpoint", "Helper pipe", [[\\.\pipe\my_helper]])
aether.ui.color("accent", "Accent", {r=128, g=90, b=255, a=255})
aether.ui.keybind("toggle_key", "Toggle key", 0x74)
aether.ui.separator("advanced", "Advanced")

local enabled = aether.ui.get("enabled")
if aether.ui.consume("reset") then aether.storage.remove("counter") end
```

Calling `ui.text` again updates its dynamic value. Toggle, slider, select,
input, color, and keybind values persist for the script lifetime and are read
with `get`. Controls use Aether's native widgets and inherit its DPI and style.

## Drawing

The following calls are available inside `frame`:

- `line`, `rect`, `filled_rect`;
- `circle`, `filled_circle`;
- `text`;
- `world_line`, `world_text`;
- `load_texture`, `image` for local PNG/JPEG/BMP files;
- `panel` for a separate styled overlay information panel.

Colors use four RGBA channels in the `0..255` range. World commands are
projected with the current camera matrix on the render thread, so camera motion
does not receive an extra Lua frame of delay.

```lua
aether.events.on("frame", function(frame)
    for _, p in ipairs(frame.players) do
        aether.draw.world_text(p.origin, p.name, 255, 255, 255, 255)
    end
end)
```

An information window can reuse Aether styling:

```lua
aether.draw.panel(24, 180, 220, 90, "Web radar", 128, 90, 255, 255)
aether.draw.text(34, 216, "Helper: connected", 210, 212, 220, 255)
```

Textures must be inside the active script directory. They are limited to
4096×4096, 16 MiB per file, and 64 resources per runtime. Decode and D3D11
resource creation are lazy; Lua receives only an opaque id.

```lua
local logo = aether.draw.load_texture("assets/logo.png")
aether.events.on("frame", function()
    if logo then
        aether.draw.image(logo, 30, 120, 64, 64, 255, 255, 255, 255)
    end
end)
```
