# Input API

```lua
aether.input.is_down(0x20)
local jump = aether.input.binding("jump")
aether.input.key(0x20, true)
aether.input.key(0x20, false)
aether.input.tap(0x20)
aether.input.mouse_move(4, -2)
aether.input.mouse_button("primary", true)
aether.input.mouse_button("primary", false)
```

Binding names are `forward`, `back`, `left`, `right`, `walk`, `duck`, `jump`,
`attack`, and `attack2`.

Input reaches CS2 only. A press, tap, mouse move or click is refused unless the
menu is closed, the game takes input, no chat line is being typed and the CS2
window is in the foreground at that moment; a click also needs the pointer over
the game window. `is_down` reports `false` while another program is in the
foreground. Keys a script may press are letters, digits, F1-F12, Space, Tab,
Shift, Ctrl, arrows, the numeric keypad and punctuation; Windows, Alt, Escape,
Enter, the console key, application, browser and media keys and Aether's own menu
and exit keys are refused. The runtime tracks ownership per script and releases
all owned states when that script stops.
