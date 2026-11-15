-- This file is also used by the repository's manual runtime smoke test.
assert(aether.api.major == 1)
assert(debug == nil)

aether.ui.toggle("enabled", "Smoke overlay", true)
aether.ui.slider("x", "X", 30, 0, 400, 1)
aether.ui.select("style", "Style", {"Text", "Circle"}, 0)
aether.ui.input("label", "Label", "Lua smoke")
aether.ui.color("accent", "Accent", {r=120, g=200, b=255, a=255})
aether.ui.keybind("key", "Test key", 0)
aether.ui.separator("test_section", "Runtime test")
aether.ui.button("reset", "Reset counter")

local unused = aether.events.on("unused_test_event", function() end)
assert(aether.events.off("unused_test_event", unused))
assert(aether.config.schema() ~= nil)

local ticks = aether.storage.get("ticks") or 0

aether.events.on("load", function()
    aether.storage.set("loaded", true)
    aether.storage.set("loads", (aether.storage.get("loads") or 0) + 1)
end)

aether.events.on("tick", function()
    ticks = ticks + 1
    if ticks % 60 == 0 then aether.storage.set("ticks", ticks) end
    if aether.ui.consume("reset") then ticks = 0 end
end)

aether.events.on("frame", function(frame)
    assert(frame.sequence ~= nil)
    if not aether.ui.get("enabled") then return end
    local x = aether.ui.get("x")
    if aether.ui.get("style") == 0 then
        local color = aether.ui.get("accent")
        aether.draw.text(x, 120, aether.ui.get("label") .. ": " .. #frame.players,
            color.r, color.g, color.b, color.a)
    else
        aether.draw.circle(x, 120, 10, 120, 200, 255, 255, 2)
    end
end)
