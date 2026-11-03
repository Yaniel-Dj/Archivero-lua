local GM_Gear = {
    {2586, 1},
    {11508, 1},
    {12064, 1},
    {17, 1},
    {32235, 1},
    {3536, 1}
}

local function GM_gearme(event, player, command)
    -- En el evento 42, command no incluye el punto, por lo que se compara directamente con "set"
    if command ~= "miset" then
        return
    end

    if player == nil then
        return false
    end

    if player:GetGMRank() < 1 then
        player:SendBroadcastMessage("|cffff0000No tienes permiso para usar este comando.|r")
        return false
    end

    for a = 1, #GM_Gear do
        local itemId = GM_Gear[a][1]
        local count  = GM_Gear[a][2]

        if player:GetItemCount(itemId) < count then
            player:AddItem(itemId, count - player:GetItemCount(itemId))
        else
            player:SendBroadcastMessage("You have "..count.." "..GetItemLink(itemId)..".")
        end
    end

    return false
end

RegisterPlayerEvent(42, GM_gearme)
