local texture, error_message = aether.draw.load_texture("ct.png")
aether.storage.set("texture_loaded", texture ~= nil)
aether.storage.set("texture_error", error_message)

aether.events.on("frame", function()
    if texture then
        aether.draw.image(texture, 20, 20, 48, 48, 255, 255, 255, 255)
    end
end)
