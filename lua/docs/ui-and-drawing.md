# Script UI и drawing

Контролы скрипта отображаются в его popup внутри `Misc -> Lua API`.

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

Повторный вызов `ui.text` обновляет динамический текст. Значения toggle/slider/
select/input/color/keybind сохраняются на время жизни скрипта и читаются через
`get`. Элементы используют штатные контролы Aether и наследуют DPI/style.

## Drawing

Внутри `frame` можно вызывать:

- `line`, `rect`, `filled_rect`;
- `circle`, `filled_circle`;
- `text`;
- `world_line`, `world_text`.
- `load_texture`, `image` для локальных PNG/JPEG/BMP.
- `panel` для отдельной стилизованной информационной панели overlay.

Цвет передаётся четырьмя каналами RGBA `0..255`. World-команды проектируются
актуальной camera matrix на render thread, поэтому движение камеры не получает
дополнительного Lua-lag.

```lua
aether.events.on("frame", function(frame)
    for _, p in ipairs(frame.players) do
        aether.draw.world_text(p.origin, p.name, 255, 255, 255, 255)
    end
end)
```

Информационное окно можно собрать без копирования стилей основного меню:

```lua
aether.draw.panel(24, 180, 220, 90, "Web radar", 128, 90, 255, 255)
aether.draw.text(34, 216, "Helper: connected", 210, 212, 220, 255)
```

Текстуры разрешены только внутри директории конкретного скрипта, ограничены
4096×4096, 16 MiB на файл и 64 ресурсами runtime. Декодирование и создание D3D11
ресурса выполняются лениво на render thread; Lua получает только opaque id.

```lua
local logo = aether.draw.load_texture("assets/logo.png")
aether.events.on("frame", function()
    if logo then
        aether.draw.image(logo, 30, 120, 64, 64, 255, 255, 255, 255)
    end
end)
```
