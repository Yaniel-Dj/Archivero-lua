--[[
    ============================================================
    Script:      npc_nivel80.lua
    Autor:       Yaniel
    Repo:        https://github.com/Yaniel-Dj/Archivero-lua
    Descripción: NPC que ofrece subir al nivel 80 a cambio de
                 10.000 de oro. Compatible con Eluna.
    Requisitos:  Eluna Lua Engine (mod-eluna) + AzerothCore 3.3.5a
    Licencia:    GPL-3.0
    ============================================================
]]

-- ============================================================
-- CONFIGURACIÓN
-- ============================================================

local NPC_ENTRY     = 900001          -- Entry del NPC (cámbialo por el tuyo)
local COSTE_ORO     = 10000           -- Coste en oro
local NIVEL_MAX     = 80              -- Nivel al que sube

local MENSAJE_OK    = "¡Has alcanzado el nivel 80! Que los ancestros guíen tu camino."
local MENSAJE_POBRE = "No tienes suficiente oro. Necesitas 10.000 de oro."
local MENSAJE_MAX   = "Ya estás en el nivel máximo."

-- 1 oro = 10.000 cobre. El coste en cobre:
local COSTE_COBRE   = COSTE_ORO * 10000

-- ============================================================
-- FUNCIONES AUXILIARES
-- ============================================================

local function estaEnNivelMax(player)
    return player:GetLevel() >= NIVEL_MAX
end

local function tieneOroSuficiente(player)
    return player:GetCoinage() >= COSTE_COBRE
end

local function quitarOro(player)
    player:ModifyMoney(-COSTE_COBRE)
end

local function subirNivel(player)
    player:SetLevel(NIVEL_MAX)
end

local function textoCoste()
    return string.format("%d de oro", COSTE_ORO)
end

-- ============================================================
-- EVENTO 1: Al abrir el menú del NPC (Gossip Hello)
-- ============================================================

local function OnGossipHello(event, player, creature)
    if estaEnNivelMax(player) then
        player:GossipMenuAddItem(0, "|cffff0000Ya estás en el nivel máximo.|r", 0, 1)
        player:GossipMenuAddItem(0, "|cffff0000Salir|r", 0, 2)
        player:GossipSendMenu(1, creature)
        return
    end

    player:GossipMenuAddItem(0,
        "|cff00ff00Subir al nivel " .. NIVEL_MAX .. " por " .. textoCoste() .. "|r",
        0, 1)
    player:GossipMenuAddItem(0, "|cffff0000Salir|r", 0, 2)
    player:GossipSendMenu(1, creature)
end

-- ============================================================
-- EVENTO 2: Al seleccionar una opción (Gossip Select)
-- ============================================================

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        if estaEnNivelMax(player) then
            creature:SendUnitSay(MENSAJE_MAX, 0)
            player:GossipComplete()
            return
        end

        if not tieneOroSuficiente(player) then
            creature:SendUnitSay(MENSAJE_POBRE, 0)
            player:SendBroadcastMessage("|cffff0000No tienes suficiente oro. Necesitas " .. textoCoste() .. ".|r")
            player:GossipComplete()
            return
        end

        quitarOro(player)
        subirNivel(player)
        creature:SendUnitSay(MENSAJE_OK, 0)
        player:SendBroadcastMessage("|cff00ff00Has subido al nivel " .. NIVEL_MAX .. ". Se han descontado " .. textoCoste() .. ".|r")
        player:GossipComplete()

    elseif intid == 2 then
        player:GossipComplete()
    end
end

-- ============================================================
-- REGISTRO DE EVENTOS (Eluna)
-- ============================================================

RegisterCreatureGossipEvent(NPC_ENTRY, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY, 2, OnGossipSelect)

-- ============================================================
-- FIN DEL SCRIPT — Archivero-lua · Yaniel
-- ============================================================
