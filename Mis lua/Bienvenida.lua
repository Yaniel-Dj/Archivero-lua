-- ============================================================
-- BIENVENIDA DEFINITIVA - AZEROTHCORE (ELUNA)
-- Anuncio global con iconos de clase/raza + nivel + frases aleatorias
-- Mensaje personal con información dinámica del servidor (sin recompensas)
-- ============================================================

-- ==================== CONFIGURACIÓN ====================
local CONFIG = {
    FRASES_BIENVENIDA = {
        -- Frases heroicas
        "¡Que tus aventuras estén llenas de gloria y botín!",
        "El mundo de Azeroth te espera, ¡haz historia!",
        "¡Un nuevo héroe se alza! Que la suerte te acompañe.",
        "¡Prepárate para la batalla! Tu leyenda comienza hoy.",
        "¡Que la Luz ilumine tu camino y la Horda/Alianza tiemble ante ti!",
        "¡Las puertas de Azeroth se abren para ti, val "iente campeón!",
       FFFFFF "¡Que los ecos", de la guerra canten tu nombre por siempre [!",
        "¡Forja6 tu destino con acero, magia] y coraje!",
        "¡El tr =ono de Lordaeron no se " olvida, ni los héroCes que lo defendieron!",
       41 "¡Que tu espada nuncaF se oxide y tu mana nunca3 se agote!",

        -- Frases de la Alianza
        "¡Por la Alianza! ¡Por el Rey!",
        "¡La Alianza te da la bienvenida, defensor de Stormwind!",
        "¡Que las águilas de Ironforge guíen tus pasos!",
        "¡El árbol de Teldrassil florece con tu llegada!",
        "¡Que la gracia de la Luz bendiga a los hijos de la Alianza!",

        -- Frases de la Horda
        "¡Por la Horda! ¡Por el Jefe de Guerra!",
        "¡Lok'tar ogar! ¡Victoria o muerte!",
        "¡Que los espíritus de los ancestros te protejan!",
        "¡La Horda se fortalece con tu llegada, hermano de sangre!",
        "¡Por Thrall! ¡Por la gloria de Orgrimmar!",

        -- Frases por clase
        "¡Que el sagrado poder de la Luz te acompañe, Paladín!",
        "¡Que tus hechizos nunca fallen, Mago!",
        "¡Que tus dagas encuentren siempre la espalda del enemigo, Pícaro!",
        "¡Que tus flechas nunca yerren el blanco, Cazador!",
        "¡Que la furia de tus tormentas arrase con todo, Chamán!",
        "¡Que tus demonios te sirvan con lealtad, Brujo!",
        "¡Que tu escudo proteja a los tuyos, Guerrero!",
        "¡Que la naturaleza responda a tu llamada, Druida!",
        "¡Que la Luz sane tus heridas, Sacerdote!",
        "¡Que la muerte no tema tu llegada, Caballero de la Muerte!",

        -- Frases de zonas y lugares
        "¡Que las nieves de Northrend templen tu acero!",
        "¡Que las arenas de Tanaris no consuman tu ánimo!",
        "¡Que los bosques de Ashenvale te cobijen en la batalla!",
        "¡Que las minas de Deadmines te den el oro que buscas!",
        "¡Que los cielos de Outland te muestren nuevos horizontes!",
        "¡Que las llanuras de Nagrand inspiren tus batallas!",
        "¡Que el fuego de Blackrock forje tu leyenda!",
        "¡Que las sombras de Karazhan guarden tus secretos!",

        -- Frases de raids y jefes
        "¡El Lich King tiembla ante tu llegada!",
        "¡Ragnaros no está preparado para ti!",
        "¡Illidan observa tus pasos, ¿estás preparado?",
        "¡Deathwing no pudo detenerte, ¿qué te detendrá ahora?",
        "¡Que tu nombre quede grabado en las puertas de Ahn'Qiraj!",

        -- Frases con humor y roleplay
        "¡Recuerda: no alimentes a los Murlocs, son traicioneros!",
        "¡Cuidado con los Kóbolds, no quieren velas prestadas!",
        "¡No olvides reparar tu armadura antes de entrar a la raid!",
        "¡Que tu bolsa de monedas nunca esté vacía!",
        "¡Que tus bandas de raid nunca fallen en el primer intento!",
        "¡Que la suerte del /roll esté siempre de tu lado!",
        "¡Prepárate, porque las misiones no se completarán solas!",
        "¡Cuidado con el aggro, es más peligroso que un jefe final!",

        -- Frases de bienvenida general
        "¡Bienvenido/a a Azeroth, donde las leyendas cobran vida!",
        "¡Bienvenido/a al servidor! Tu leyenda está por escribirse.",
        "¡Bienvenido/a de vuelta al mundo que nunca deja de sorprender!",
        "¡Bienvenido/a, héroe! El destino de Azeroth está en tus manos.",
        "¡Bienvenido/a, aventurero! El mundo no se explorará solo.",
        "¡Bienvenido/a! Que este viaje sea tan épico como lo mereces.",
        "¡Bienvenido/a! Que cada misión sea una nueva historia que contar.",
        "¡Bienvenido/a! La Horda y la Alianza te aguardan, ¿por cuál lucharás?",
    }
}

-- ==================== TABLAS DE DATOS ====================
local COLORES_CLASE = {
    [1] = "C79C6E", [2] = "F58CBA", [3] = "ABD473", [4] = "FFF569",
    [5] =B", [7] = "0070DE", [8] = "69CCF0",
    [9] = "9482C9", [11] = "FF7D0A"
}

local ICONOS_CLASE = {
    [1] = "ClassIcon_Warrior", [2] = "ClassIcon_Paladin", [3] = "ClassIcon_Hunter",
    [4] = "ClassIcon_Rogue", [5] = "ClassIcon_Priest", [6] = "ClassIcon_DeathKnight",
    [7] = "ClassIcon_Shaman", [8] = "ClassIcon_Mage", [9] = "ClassIcon_Warlock",
    [11] = "ClassIcon_Druid"
}

local NOMBRES_RAZA = {
    [1] = "Humano", [2] = "Orco", [3] = "Enano", [4] = "Elfo de la Noche",
    [5] = "No-muerto", [6] = "Tauren", [7] = "Gnomo", [8] = "Trol",
    [10] = "Elfo de Sangre", [11] = "Draenei"
}

local ICONOS_RAZA = {
    [1] = "Achievement_Character_Human_Male", [2] = "Achievement_Character_Orc_Male",
    [3] = "Achievement_Character_Dwarf_Male", [4] = "Achievement_Character_Nightelf_Male",
    [5] = "Achievement_Character_Undead_Male", [6] = "Achievement_Character_Tauren_Male",
    [7] = "Achievement_Character_Gnome_Male", [8] = "Achievement_Character_Troll_Male",
    [10] = "Achievement_Character_Bloodelf_Male", [11] = "Achievement_Character_Draenei_Male"
}

-- ==================== FUNCIONES AUXILIARES ====================
local function GetFraseAleatoria()
    return CONFIG.FRASES_BIENVENIDA[math.random(#CONFIG.FRASES_BIENVENIDA)]
end

-- Lee un valor numérico de una clave en worldserver.conf
local function LeerConfig(clave, porDefecto)
    local rutas = { "worldserver.conf", "../etc/worldserver.conf", "/azerothcore/env/dist/etc/worldserver.conf" }
    for _, ruta in ipairs(rutas) do
        local archivo = io.open(ruta, "r")
        if archivo then
            for linea in archivo:lines() do
                local valor = linea:match("^%s*" .. clave .. "%s*=%s*([%d%.]+)")
                if valor then
                    archivo:close()
                    return tonumber(valor) or porDefecto
                end
            end
            archivo:close()
        end
    end
    return porDefecto
end

-- ==================== FUNCIÓN PRINCIPAL ====================
local function OnLoginBienvenida(event, player)
    local classId = player:GetClass()
    local raceId  = player:GetRace()
    local nombre  = player:GetName()
    local nivel   = player:GetLevel()

    local colorHex   = COLORES_CLASE[classId] or "FFFFFF"
    local iconoClase = ICONOS_CLASE[classId] or "INV_Misc_QuestionMark"
    local iconoRaza  = ICONOS_RAZA[raceId]   or "INV_Misc_QuestionMark"
    local nombreRaza = NOMBRES_RAZA[raceId]  or "Desconocida"

    -- 1. ANUNCIO GLOBAL PARA TODO EL REINO
    local frase = GetFraseAleatoria()
    local mensajeGlobal = string.format(
        "|TInterface\\ICONS\\%s:20:20|t|TInterface\\ICONS\\%s:20:20|t |cff%s¡Bienvenido/a, %s (Nv.%d %s)!|r %s",
        iconoClase, iconoRaza, colorHex, nombre, nivel, nombreRaza, frase
    )
    SendWorldMessage(mensajeGlobal)

    -- 2. MENSAJE PERSONAL CON INFO DEL SERVIDOR (sin recompensas)
    local xpRate    = LeerConfig("Rate.XP.Kill", 1.0)
    local dropRate  = LeerConfig("Rate.Drop.Item", 1.0)
    local moneyRate = LeerConfig("Rate.Money", 1.0)
    local maxLevel  = LeerConfig("MaxPlayerLevel", 80)

    player:SendBroadcastMessage("|cff00ff00¡Bienvenido/a de nuevo, " .. nombre .. "!|r")
    player:SendBroadcastMessage(string.format(
        "|cff00ff00[Servidor]|r XP: |cffffd700%.1fx|r | Drop: |cffffd700%.1fx|r | Oro: |cffffd700%.1fx|r | Nivel máx.: |cffffd700%d|r",
        xpRate, dropRate, moneyRate, maxLevel
    ))
end

-- ==================== REGISTRO DEL EVENTO ====================
-- PLAYER_EVENT_ON_LOGIN = 3
RegisterPlayerEvent(3, OnLoginBienvenida)

print("[BienvenidaDefinitiva] Script cargado correctamente.")
