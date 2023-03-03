allocate_states("gravel", 1)

GRAVEL_PICKER_OFFSET_X = 8 + 188 - 128
GRAVEL_PICKER_OFFSET_Y = 16 + 8
GRAVEL_PICKER_SCROLL_OFFSET = 0

GRAVEL_TILES = {}
GRAVEL_PREVIEW = {}
GRAVEL_PREVIEW_SEED = --[[Dav]]999
GRAVEL_PREVIEW_TILES = 8 * 4 -- 8x4 cube

AC_register_tool("Gravel fill", "gravel", "A", nil, {0, 0, 0, 0}, function(atx, aty, roomx, roomy)
    if not mousepressed then
        -- Fill bucket
        mousepressed = true

        if love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl") then
            to_astate("gravel", 0)
            return
        end

        if #GRAVEL_TILES == 0 then
            dialog.create("You need to select some tiles first!\nPress CTRL while clicking to select tiles.", {DB.OK})
            return
        end

        handle_fill(atx, aty)

    end
end, GRAVEL_PATH .. "graphics/gravel")
