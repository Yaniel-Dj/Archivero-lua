-- =========================================================
-- SCRIPT DEL SERVIDOR (Arcade_Server.lua)
-- =========================================================

local GOB_ENTRY = 500001 -- ⚠️ REEMPLAZA ESTO con el ID real de tu GameObject
local AIO_PREFIX = "ARCADE_UI" -- Prefijo para la comunicación

-- 1. Definir la tabla de manejadores del servidor
local ArcadeHandlers = {}

-- Función que se ejecuta cuando el cliente pide la recompensa
function ArcadeHandlers.TriggerReward(player)
    -- Aquí puedes poner la lógica de tu minijuego o recompensa
    player:AddItem(6948, 1) -- Ejemplo: Piedra de Hogar
    player:ModifyMoney(10000) -- Ejemplo: 1 de oro (10000 cobre)
    player:SendBroadcastMessage("|cff00ff00¡Has ganado un premio en la máquina arcade!|r")
end

-- 2. Registrar los manejadores en AIO
-- (Asegúrate de que AIO esté cargado globalmente)
AIO.RegisterHandlers(AIO_PREFIX, ArcadeHandlers)

-- 3. Función que se ejecuta al hacer clic derecho en el GameObject
local function OnArcadeUse(event, go, player)
    -- Enviamos la orden al cliente para que abra la ventana (OpenUI)
    AIO.Handle(player, AIO_PREFIX, "OpenUI")
end

-- 4. Registrar el evento OnUse (14) para el GameObject
-- Se usa el ID numérico 14 o la constante GAMEOBJECT_EVENT_ON_USE
RegisterGameObjectEvent(GOB_ENTRY, 14, OnArcadeUse)

print("[Arcade] Script del servidor cargado correctamente.")
