if in_astate("gravel", 0) then
    statecaught = true

    local img = tileset_image(levelmetadata_get(roomx, roomy))

	love.graphics.setColor(12,12,12,255)
	love.graphics.rectangle("fill", 8, 16, love.graphics.getWidth()-136, love.graphics.getHeight()-24)
	love.graphics.setColor(255,255,255,255)

    love.graphics.setScissor(GRAVEL_PICKER_OFFSET_X, GRAVEL_PICKER_OFFSET_Y, GRAVEL_PICKER_OFFSET_X + tilesets[img].tiles_width * 16, love.graphics.getHeight() - 24 - 8)

    for i = 0, (tilesets[img].tiles_width * tilesets[img].tiles_height) - 1 do
        local x = GRAVEL_PICKER_OFFSET_X + (i % 40) * 16
        local y = GRAVEL_PICKER_SCROLL_OFFSET + GRAVEL_PICKER_OFFSET_Y + math.floor(i / 40) * 16
        love.graphics.setColor(255,255,255)
        love.graphics.draw(tilesets[img].img, tilesets[img].tiles[i], x, y, 0, 2)

        for j = 1, #GRAVEL_TILES do
            if GRAVEL_TILES[j] == i then
                love.graphics.setColor(0, 255, 255, 255)
                love.graphics.setLineWidth(2)
                love.graphics.rectangle("line", x + 1, y + 1, 14, 14)
                break
            end
        end

        if mouseon(x, y, 16, 16) then
            love.graphics.draw(cursorimg[0], x, y)
        end

    end
    love.graphics.setScissor()

    for i = 0, #GRAVEL_TILES - 1 do
        local x = (GRAVEL_PICKER_OFFSET_X + tilesets[img].tiles_width * 16 + 32) + (i % 8) * 16
        local y = GRAVEL_PICKER_OFFSET_Y + math.floor(i / 8) * 16
        love.graphics.setColor(255,255,255)
        love.graphics.draw(tilesets[img].img, tilesets[img].tiles[GRAVEL_TILES[i + 1]], x, y, 0, 2)
    end

    for i = 0, #GRAVEL_PREVIEW - 1 do
        local x = (GRAVEL_PICKER_OFFSET_X + tilesets[img].tiles_width * 16 + 32) + (i % 8) * 16
        local y = GRAVEL_PICKER_OFFSET_Y + math.floor(i / 8) * 16 + 256
        love.graphics.setColor(255,255,255)
        love.graphics.draw(tilesets[img].img, tilesets[img].tiles[GRAVEL_PREVIEW[i + 1]], x, y, 0, 2)
    end

    love.graphics.setColor(255, 255, 255)

    ved_print("Left click to\nadd to pool,\nright click to\nremove", love.graphics.getWidth()-24 - 64 - 32, love.graphics.getHeight()-8 - 128 + 16)

    rbutton({L.RETURN, "b"}, 0, nil, true)
	rbutton({"Clear", "C"}, 1, nil, true)
    rbutton({"Remove Duplicates", "R"}, 2, nil, true)

    if nodialog and love.mouse.isDown("l") and not mousepressed then
        if onrbutton(0, nil, true) then
            -- Return
            tostate(1, true)
            mousepressed = true
            return
        end
        if onrbutton(1, nil, true) then
            GRAVEL_TILES = {}
            GRAVEL_PREVIEW = {}
            mousepressed = true
            return
        end
        if onrbutton(2, nil, true) then
            -- Remove duplicate tiles from GRAVEL_TILES
            local new_gravel = {}
            for i = 1, #GRAVEL_TILES do
                local found = false
                for j = 1, #new_gravel do
                    if new_gravel[j] == GRAVEL_TILES[i] then
                        found = true
                        break
                    end
                end
                if not found then
                    new_gravel[#new_gravel + 1] = GRAVEL_TILES[i]
                end
            end

            GRAVEL_TILES = new_gravel

            GRAVEL_PREVIEW = {}
            love.math.setRandomSeed(GRAVEL_PREVIEW_SEED)
            for i = 1, GRAVEL_PREVIEW_TILES do
                -- pick random thing from GRAVEL_TILES
                table.insert(GRAVEL_PREVIEW, GRAVEL_TILES[love.math.random(#GRAVEL_TILES)])
            end

            mousepressed = true
            return
        end
    end
end
