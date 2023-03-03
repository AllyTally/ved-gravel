local x, y, button = ...

if in_astate("gravel", 0) and not mousepressed and nodialog then

    local img = tileset_image(levelmetadata_get(roomx, roomy))

    local mouse_x = math.floor((x - GRAVEL_PICKER_OFFSET_X) / 16)
    local mouse_y = math.floor((y - (GRAVEL_PICKER_SCROLL_OFFSET + GRAVEL_PICKER_OFFSET_Y)) / 16)

    local tiles_count = tilesets[img].tiles_width * tilesets[img].tiles_height

    if mouse_x >= 0 and mouse_x < 40 then
        local tile_id = mouse_x + mouse_y * 40

        if tile_id < tiles_count then
            mousepressed = true

            if button == "l" then
                table.insert(GRAVEL_TILES, tile_id)
            elseif button == "r" then
                -- remove last instance of tile_id
                for i = #GRAVEL_TILES, 1, -1 do
                    if GRAVEL_TILES[i] == tile_id then
                        table.remove(GRAVEL_TILES, i)
                        break
                    end
                end
            end

            GRAVEL_PREVIEW = {}
            love.math.setRandomSeed(GRAVEL_PREVIEW_SEED)
            for i = 1, GRAVEL_PREVIEW_TILES do
                -- pick random thing from GRAVEL_TILES
                table.insert(GRAVEL_PREVIEW, GRAVEL_TILES[love.math.random(#GRAVEL_TILES)])
            end

            return
        end
    end
end

