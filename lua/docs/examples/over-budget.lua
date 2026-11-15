-- Deliberately exceeds the callback execution budget.
aether.events.on("tick", function()
    while true do end
end)
