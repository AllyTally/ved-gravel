
function handle_fill(atx, aty)
    levelmetadata_set(roomx, roomy, "directmode", 1)
    local previoustiles = table.copy(roomdata_get(roomx, roomy))
    local oldtile = roomdata[roomy][roomx][aty*40+atx+1]
    local tilesarea, i = {{atx, aty}}, 1
    roomdata[roomy][roomx][aty*40+atx+1] = tonumber(GRAVEL_TILES[love.math.random(#GRAVEL_TILES)])
    local placedat = {}
    while tilesarea[i] ~= nil and i < 1200 do
        local f_x, f_y = unpack(tilesarea[i])
        for _,dir in pairs({{-1,0}, {0,-1}, {1,0}, {0,1}}) do
            if  f_x+dir[1] >= 0 and f_x+dir[1] <= 39
            and f_y+dir[2] >= 0 and f_y+dir[2] <= 29
            and roomdata[roomy][roomx][(f_y+dir[2])*40+f_x+dir[1]+1] == oldtile
            and not AC_table_array_contains(tilesarea, {f_x+dir[1], f_y+dir[2]}) then
                roomdata[roomy][roomx][(f_y+dir[2])*40+f_x+dir[1]+1] = tonumber(GRAVEL_TILES[love.math.random(#GRAVEL_TILES)])
                table.insert(tilesarea, {f_x+dir[1], f_y+dir[2]})
            end
        end
        i = i + 1
    end
    table.insert(
        undobuffer,
        {
            undotype = "tiles",
            rx = roomx,
            ry = roomy,
            toundotiles = previoustiles,
            toredotiles = table.copy(roomdata_get(roomx, roomy))
        }
    )
    finish_undo("GRAVEL TOOL")
end
