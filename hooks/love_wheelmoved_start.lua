local xm, ym = ...

if in_astate("gravel", 0) and nodialog then

    local img = tileset_image(levelmetadata_get(roomx, roomy))

    local tile_count = (tilesets[img].tiles_width * tilesets[img].tiles_height)
    local tile_height = math.ceil(tile_count / 40) * 8 * 2
    local upper_bound = tile_height - (love.graphics.getHeight() - 24 - 8)

    GRAVEL_PICKER_SCROLL_OFFSET = -math.min(math.max(0, -(GRAVEL_PICKER_SCROLL_OFFSET + (ym * s.mousescrollingspeed))), upper_bound)
end
