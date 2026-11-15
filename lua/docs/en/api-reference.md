# API reference 1.0

## Core

- `aether.api.major`, `aether.api.minor`
- `aether.api.script_dir` — absolute directory of the active package
- `aether.api.data_dir` — absolute private writable data directory of the active package
- `aether.log(text)`
- `aether.events.on(name, callback) -> token`
- `aether.events.off(name [, token]) -> bool`

## Game

- `aether.game.snapshot()`
- `aether.game.radar_snapshot()`
- `aether.game.world_to_screen(vec3)`
- `aether.game.trace_ray(start, finish)`
- `aether.game.bomb_damage(position [, site, eye_angles, ducked])`
- `aether.game.predict_grenade(origin, velocity, kind [, remaining_lifetime])`
- `aether.game.radar_overview(map_name)`
- `aether.game.penetration_damage(start, finish [, target_handle])`

## Config and storage

- `aether.config.get(path)`
- `aether.config.set(path, value)`
- `aether.config.patch(table)`
- `aether.config.snapshot()`
- `aether.config.schema()`
- `aether.storage.get/set/remove(key [, value])`

## UI

- `aether.ui.text(id, label, value)`
- `aether.ui.button(id, label [, action_text])`
- `aether.ui.toggle(id, label, default)`
- `aether.ui.slider(id, label, default, min, max, step)`
- `aether.ui.select(id, label, options, default_index)`
- `aether.ui.input(id, label, default_text)`
- `aether.ui.color(id, label, {r,g,b,a})`
- `aether.ui.keybind(id, label, default_vk)`
- `aether.ui.separator(id, label)`
- `aether.ui.get(id)`, `aether.ui.consume(id)`

## External helpers

- `aether.helpers.start(relative_ps1, args) -> bool [, error]`
- `aether.helpers.copy_text(text) -> bool`

Only the built-in web radar sees `aether.helpers` (see the sandbox section of the
README); for every other script the table is absent. `start` accepts only a `.ps1`
file inside the active package directory and returns immediately after creating
the external process.

## Bundled assets

- `aether.assets.weapon_font() -> string`

Returns the bytes of the same TTF Aether uses for built-in weapon and grenade
icons. A script can write the string in binary mode and use the font in a local
UI or web frontend.

## Draw

- `line(x1,y1,x2,y2,r,g,b,a[,thickness])`
- `rect/filled_rect(x,y,w,h,r,g,b,a[,thickness])`
- `circle/filled_circle(x,y,radius,r,g,b,a[,thickness])`
- `text(x,y,text,r,g,b,a)`
- `world_line(vec3,vec3,r,g,b,a[,thickness])`
- `world_text(vec3,text,r,g,b,a)`
- `load_texture(relative_path) -> texture_id | nil,error`
- `image(texture_id,x,y,w,h[,r,g,b,a])`
- `panel(x,y,w,h,title[,accent_r,g,b,a])`

## Input

- `is_down(vk)`, `binding(action)`, `key(vk,down)`, `tap(vk)`
- `mouse_move(dx,dy)`, `mouse_button("primary"|"secondary",down)`
