local key = ...

if in_astate("gravel", 0) and (key == "escape" or key == "return") then
    tostate(1, true)
end
