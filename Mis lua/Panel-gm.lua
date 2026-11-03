local NpcEntry = 100071

-- Función auxiliar: notificar sanción globalmente
local function AnunciarSancion(tipo, nombre, tiempo, motivo, gm)
    local mensaje = "|cffff0000[Sanción]|r "..tipo.." |cffffcc00"..nombre.."|r | Tiempo: |cffffcc00"..tiempo.."|r | Motivo: |cffffcc00"..motivo.."|r | GM: "..gm
    SendWorldMessage(mensaje)
end

-- Menú principal
local function OnGossipHello(event, player, unit)
    if player:GetGMRank() < 1 then
        player:SendBroadcastMessage("|cffff0000No tienes permiso.|r")
        return
    end
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "|cff00ff00--- Jugadores en Línea ---|r", 0, 0)
    local jugadores = GetPlayersInWorld()
    local contador = 0
    for _, target in ipairs(jugadores) do
        if target ~= player then
            contador = contador + 1
            player:GossipMenuAddItem(0, "|cffffcc00"..target:GetName().."|r (Nivel "..target:GetLevel()..")", 0, 1000 + contador, false, "", 0, target:GetName())
        end
    end
    if contador == 0 then
        player:GossipMenuAddItem(0, "|cffff0000No hay otros jugadores conectados.|r", 0, 0)
    end
    player:GossipMenuAddItem(0, "|cffff0000--- Ver Lista de Baneados ---|r", 0, 5000)
    player:GossipMenuAddItem(0, "|cff00ff00--- Ver Lista de Silenciados ---|r", 0, 5500)
    player:GossipMenuAddItem(7, "|cffff0000Cerrar|r", 0, 999)
    player:GossipSendMenu(1, unit)
end

-- Submenú de acciones para un jugador
local function MostrarAccionesJugador(player, unit, targetName)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "|cffffcc00Jugador: "..targetName.."|r", 0, 0)
    player:GossipMenuAddItem(0, "|cff00ffff[Ver Información]|r", 0, 2000, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cff00ff00[Traer a mi lado]|r", 0, 2005, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cffff0000Ban 24h - Conducta tóxica|r", 0, 2001, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cffff0000Ban Permanente - Hack / Bug|r", 0, 2002, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cffff0000Mute 10 min - Spam (1er aviso)|r", 0, 2101, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cffff0000Mute 30 min - Spam (2do aviso)|r", 0, 2102, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cffff0000Mute 1 hora - Spam (3er aviso)|r", 0, 2103, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cffff0000Mute 7 horas - Spam (reincidente)|r", 0, 2104, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cffff0000Silenciar 1 hora - Insultos|r", 0, 2201, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cffff0000Silenciar 1 hora - Flood|r", 0, 2202, false, "", 0, targetName)
    player:GossipMenuAddItem(0, "|cff00ff00Desmutear (quitar silencio)|r", 0, 2203, false, "", 0, targetName)
    player:GossipMenuAddItem(7, "|cffff0000Volver|r", 0, 3000)
    player:GossipSendMenu(1, unit)
end

-- Lista de baneados
local function MostrarListaBaneados(event, player, unit)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "|cff00ff00--- Baneados Activos ---|r", 0, 0)
    local query = CharDBQuery("SELECT c.name, cb.banreason, cb.unbandate FROM character_banned cb JOIN characters c ON c.guid = cb.guid WHERE cb.active = 1 ORDER BY cb.bandate DESC LIMIT 50")
    local contador = 0
    if query then
        repeat
            local nombre = query:GetString(0)
            local razon = query:GetString(1) or "Sin razón"
            local unbandate = query:GetUInt32(2)
            local estado = "Permanente"
            if unbandate > 0 then estado = "Expira: "..os.date("%Y-%m-%d", unbandate) end
            contador = contador + 1
            player:GossipMenuAddItem(0, "|cffff0000"..nombre.."|r ("..estado..") - "..razon, 0, 6000 + contador, false, "", 0, nombre)
        until not query:NextRow()
    end
    if contador == 0 then
        player:GossipMenuAddItem(0, "|cff00ff00No hay baneados activos.|r", 0, 0)
    end
    player:GossipMenuAddItem(7, "|cffff0000Volver|r", 0, 3000)
    player:GossipSendMenu(1, unit)
end

-- Lista de silenciados (VERSIÓN ASÍNCRONA)
local function MostrarListaSilenciados(event, player, unit)
    player:GossipClearMenu()
    player:GossipMenuAddItem(0, "|cff00ff00--- Silenciados Activos ---|r", 0, 0)
    player:GossipMenuAddItem(0, "|cffffcc00Consultando base de datos...|r", 0, 0)
    player:GossipMenuAddItem(7, "|cffff0000Volver|r", 0, 3000)
    player:GossipSendMenu(1, unit)

    -- Consulta asíncrona: el callback se ejecuta cuando los resultados están listos
    AuthDBQueryAsync("SELECT a.username, am.mutereason, am.mutetime, am.mutedate FROM account_muted am JOIN account a ON a.id = am.guid WHERE am.mutetime > 0 ORDER BY am.mutedate DESC LIMIT 50", function(query)
        -- Reabrimos el menú (el jugador sigue en la conversación)
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "|cff00ff00--- Silenciados Activos ---|r", 0, 0)

        local contador = 0
        if query then
            repeat
                local username = query:GetString(0)
                local razon = query:GetString(1) or "Sin razón"
                local mutetime = query:GetUInt32(2)
                local mutedate = query:GetUInt32(3)
                local ahora = os.time()
                local expira = mutedate + (mutetime * 60)
                if expira > ahora then
                    local restante = math.floor((expira - ahora) / 60)
                    contador = contador + 1
                    player:GossipMenuAddItem(0, "|cffff0000"..username.."|r ("..restante.." min restantes) - "..razon, 0, 6500 + contador, false, "", 0, username)
                end
            until not query:NextRow()
        end

        if contador == 0 then
            player:GossipMenuAddItem(0, "|cff00ff00No hay silenciados activos.|r", 0, 0)
        end
        player:GossipMenuAddItem(7, "|cffff0000Volver|r", 0, 3000)
        player:GossipSendMenu(1, unit)
    end)
end

-- Manejo de selecciones
local function OnGossipSelect(event, player, unit, sender, intid, code)
    if player:GetGMRank() < 1 then
        player:GossipComplete()
        return
    end
    if intid == 999 then player:GossipComplete() return end
    if intid == 3000 then OnGossipHello(event, player, unit) return end
    if intid == 5000 then MostrarListaBaneados(event, player, unit) return end
    if intid == 5500 then MostrarListaSilenciados(event, player, unit) return end

    if intid >= 1001 and intid < 2000 then
        local targetName = code
        if targetName and targetName ~= "" then
            MostrarAccionesJugador(player, unit, targetName)
        else
            player:GossipComplete()
        end
        return
    end

    -- Ver información
    if intid == 2000 then
        local targetName = code
        if targetName and targetName ~= "" then
            local target = GetPlayerByName(targetName)
            if target then
                player:GossipClearMenu()
                player:GossipMenuAddItem(0, "|cff00ffff--- Información de "..targetName.." ---|r", 0, 0)
                player:GossipMenuAddItem(0, "Cuenta: |cffffcc00"..target:GetAccountName().."|r", 0, 0)
                player:GossipMenuAddItem(0, "Nivel: |cffffcc00"..target:GetLevel().."|r", 0, 0)
                player:GossipMenuAddItem(0, "Oro: |cffffcc00"..(target:GetCoinage() / 10000).."|r", 0, 0)
                player:GossipMenuAddItem(7, "|cffff0000Volver|r", 0, 3000)
                player:GossipSendMenu(1, unit)
            else
                player:SendBroadcastMessage("|cffff0000El jugador ya no está conectado.|r")
                player:GossipComplete()
            end
        end
        return
    end

    -- Traer jugador a mi lado (Summon)
    if intid == 2005 then
        local targetName = code
        if targetName and targetName ~= "" then
            local target = GetPlayerByName(targetName)
            if target then
                target:SummonPlayer(player)
                player:SendBroadcastMessage("|cff00ff00Has invocado a "..targetName.." a tu lado.|r")
                target:SendBroadcastMessage("|cffff0000Has sido invocado por un GM.|r")
            else
                player:SendBroadcastMessage("|cffff0000El jugador ya no está conectado.|r")
            end
        end
        player:GossipComplete()
        return
    end

    -- Ban 24h
    if intid == 2001 then
        local targetName = code
        if targetName and targetName ~= "" then
            local result = Ban(1, targetName, 24 * 3600, "Conducta tóxica", player:GetName())
            if result == 0 then
                AnunciarSancion("BAN", targetName, "24 horas", "Conducta tóxica", player:GetName())
                RunCommand(".kick "..targetName)
                player:SendBroadcastMessage("|cff00ff00Baneado 24h: "..targetName.."|r")
            else
                player:SendBroadcastMessage("|cffff0000Error al banear (código: "..tostring(result)..").|r")
            end
        end
        player:GossipComplete()
        return
    end

    -- Ban Permanente
    if intid == 2002 then
        local targetName = code
        if targetName and targetName ~= "" then
            local result = Ban(1, targetName, 0, "Uso de hack / Abuso de bug", player:GetName())
            if result == 0 then
                AnunciarSancion("BAN PERMANENTE", targetName, "Permanente", "Uso de hack / Abuso de bug", player:GetName())
                RunCommand(".kick "..targetName)
                player:SendBroadcastMessage("|cff00ff00Baneado PERMANENTE: "..targetName.."|r")
            else
                player:SendBroadcastMessage("|cffff0000Error al banear (código: "..tostring(result)..").|r")
            end
        end
        player:GossipComplete()
        return
    end

    -- Mute 10 min
    if intid == 2101 then
        local targetName = code
        if targetName and targetName ~= "" then
            RunCommand(".mute "..targetName.." 10 Spam")
            AnunciarSancion("MUTE", targetName, "10 minutos", "Spam (1er aviso)", player:GetName())
        end
        player:GossipComplete()
        return
    end

    -- Mute 30 min
    if intid == 2102 then
        local targetName = code
        if targetName and targetName ~= "" then
            RunCommand(".mute "..targetName.." 30 Spam")
            AnunciarSancion("MUTE", targetName, "30 minutos", "Spam (2do aviso)", player:GetName())
        end
        player:GossipComplete()
        return
    end

    -- Mute 1 hora
    if intid == 2103 then
        local targetName = code
        if targetName and targetName ~= "" then
            RunCommand(".mute "..targetName.." 60 Spam")
            AnunciarSancion("MUTE", targetName, "1 hora", "Spam (3er aviso)", player:GetName())
        end
        player:GossipComplete()
        return
    end

    -- Mute 7 horas
    if intid == 2104 then
        local targetName = code
        if targetName and targetName ~= "" then
            RunCommand(".mute "..targetName.." 420 Spam")
            AnunciarSancion("MUTE", targetName, "7 horas", "Spam (reincidente)", player:GetName())
        end
        player:GossipComplete()
        return
    end

    -- Silenciar 1 hora - Insultos
    if intid == 2201 then
        local targetName = code
        if targetName and targetName ~= "" then
            RunCommand(".mute "..targetName.." 60 Insultos")
            AnunciarSancion("MUTE", targetName, "1 hora", "Insultos", player:GetName())
        end
        player:GossipComplete()
        return
    end

    -- Silenciar 1 hora - Flood
    if intid == 2202 then
        local targetName = code
        if targetName and targetName ~= "" then
            RunCommand(".mute "..targetName.." 60 Flood")
            AnunciarSancion("MUTE", targetName, "1 hora", "Flood", player:GetName())
        end
        player:GossipComplete()
        return
    end

    -- Desmutear
    if intid == 2203 then
        local targetName = code
        if targetName and targetName ~= "" then
            local target = GetPlayerByName(targetName)
            if target then
                local accountName = target:GetAccountName()
                RunCommand(".unmute "..accountName)
                player:SendBroadcastMessage("|cff00ff00Desmuteada la cuenta: "..accountName.."|r")
            else
                player:SendBroadcastMessage("|cffff0000El jugador ya no está conectado.|r")
            end
        end
        player:GossipComplete()
        return
    end

    -- Desbanear
    if intid >= 6001 and intid < 6500 then
        local targetName = code
        if targetName and targetName ~= "" then
            RunCommand(".unban "..targetName)
            player:SendBroadcastMessage("|cff00ff00Desbaneado: "..targetName..".|r")
        end
        MostrarListaBaneados(event, player, unit)
        return
    end

    -- Desmutear (desde lista de silenciados)
    if intid >= 6501 then
        local username = code
        if username and username ~= "" then
            RunCommand(".unmute "..username)
            player:SendBroadcastMessage("|cff00ff00Desmuteada la cuenta: "..username..".|r")
        end
        MostrarListaSilenciados(event, player, unit)
        return
    end
end

RegisterCreatureGossipEvent(NpcEntry, 1, OnGossipHello)
RegisterCreatureGossipEvent(NpcEntry, 2, OnGossipSelect)
