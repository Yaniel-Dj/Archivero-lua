-- =========================================================
-- SCRIPT DEL CLIENTE (Arcade_Client.lua)
-- =========================================================

local AIO = AIO or require("AIO")
local AIO_PREFIX = "ARCADE_UI"

-- Creamos la tabla de la interfaz
local ArcadeUI = AIO.AddHandlers(AIO_PREFIX, {})

-- Función que el servidor invocará para abrir la ventana
function ArcadeUI.OpenUI(player)
    -- Si la ventana ya existe, solo la mostramos
    if not player.ArcadeFrame then
        local f = CreateFrame("Frame", "LionheartArcadeFrame", UIParent)
        f:SetSize(320, 220)
        f:SetPoint("CENTER")
        f:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32,
            insets = { left = 11, right = 12, top = 12, bottom = 11 }
        })
        f:SetMovable(true)
        f:EnableMouse(true)
        f:RegisterForDrag("LeftButton")
        f:SetScript("OnDragStart", f.StartMoving)
        f:SetScript("OnDragStop", f.StopMovingOrSizing)

        -- Título
        local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        title:SetPoint("TOP", 0, -15)
        title:SetText("Lionheart Arcade")

        -- Botón de cerrar (X)
        local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
        closeBtn:SetPoint("TOPRIGHT", -5, -5)

        -- Texto descriptivo
        local text = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("TOP", 0, -45)
        text:SetText("¡Bienvenido a la máquina!\n\n¿Qué deseas hacer?")
        text:SetJustifyH("CENTER")

        -- Botón 1: Jugar
        local btnPlay = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        btnPlay:SetSize(140, 25)
        btnPlay:SetPoint("BOTTOM", 0, 50)
        btnPlay:SetText("¡Jugar y Ganar!")
        btnPlay:SetScript("OnClick", function()
            -- Envía la señal al servidor para que ejecute TriggerReward
            AIO.Handle(AIO_PREFIX, "TriggerReward")
            f:Hide()
        end)

        -- Botón 2: Salir
        local btnExit = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        btnExit:SetSize(140, 25)
        btnExit:SetPoint("BOTTOM", 0, 20)
        btnExit:SetText("Salir")
        btnExit:SetScript("OnClick", function()
            f:Hide()
        end)

        -- Guardamos la ventana en el jugador para no crearla cada vez
        player.ArcadeFrame = f
    end
    
    -- Mostrar la ventana
    player.ArcadeFrame:Show()
end
