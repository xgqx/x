local UIS = game:GetService("UserInputService")

local window = library:CreateWindow(
    {
        WindowName = "purple haze - phantom forces",
        Color = Color3.fromRGB(179, 51, 196),
    },
    game.CoreGui
)

local aimbot_tab = window:CreateTab("aimbot")
local visuals_tab = window:CreateTab("visuals")
local character_tab = window:CreateTab("character")
do
    local fov_circle = Drawing.new("Circle")
    fov_circle.Thickness = 1
    fov_circle.NumSides = 100
    fov_circle.Radius = 180
    fov_circle.Filled = false
    fov_circle.Visible = true
    fov_circle.ZIndex = 999
    fov_circle.Transparency = 1
    fov_circle.Color = Color3.fromRGB(255, 255, 255)
    
    task.spawn(function()
        while true do
            fov_circle.Position = get_mouse_pos() + Vector2.new(0, 36)
            task.wait()
        end
    end)
    
    local silentaim_sector = aimbot_tab:CreateSection("silent aim")
    silentaim_sector:CreateToggle("enabled", true, function(state)
        config.aimbot.silent_aim = state
    end)
    silentaim_sector:CreateToggle("only shoot visible", true, function(state)
        config.aimbot.only_shoot_visible = state
    end)
    silentaim_sector:CreateSlider("headshot percentage", 0, 100, 20, true, function(state)
        config.aimbot.headshot_percentage = state
    end)
    silentaim_sector:CreateSlider("hit percentage", 0, 100, 100, true, function(state)
        config.aimbot.hit_chance = state
    end)
    local fieldofview_sector = aimbot_tab:CreateSection("field of view")
    fieldofview_sector:CreateToggle("enabled", true, function(state)
        config.aimbot.field_of_view = state
    end)
    fieldofview_sector:CreateSlider("range", 0, 360, 20, true, function(state)
        config.aimbot.field_of_view_range = state
        fov_circle.Radius = state
    end)
    fieldofview_sector:CreateColorpicker("color", function(state)
        fov_circle.Color = state
    end)
    fieldofview_sector:CreateToggle("visible", true, function(state)
        fov_circle.Visible = state
    end)
    fieldofview_sector:CreateToggle("filled", false, function(state)
        fov_circle.Filled = state
    end)
    fieldofview_sector:CreateSlider("transparency", 0, 1, 1, false, function(state)
        fov_circle.Transparency = state
    end)
    local gunmod_sector = aimbot_tab:CreateSection("gun mod")
    gunmod_sector:CreateToggle("fast reload", false, function(state)
        config.gunmod.fast_reload = state
    end)
    gunmod_sector:CreateSlider("fast reload speed", 0.01, 3, 0.3, false, function(state)
        config.gunmod.fast_reload_speed = state
    end)
    gunmod_sector:CreateToggle("fast equip", false, function(state)
        config.gunmod.fast_equip = state
    end)
end
do
    local movement_sector = character_tab:CreateSection("movement")
    movement_sector:CreateToggle("walkspeed", false, function(state)
        config.character.walkspeed = state
    end)
    movement_sector:CreateToggle("jumppower", false, function(state)
        config.character.jumppower = state
    end)
    movement_sector:CreateToggle("auto deploy", false, function(state)
        config.character.auto_deploy = state
    end)
    movement_sector:CreateToggle("fake lag ( might be buggy )", false, function(state)
        config.character.fake_lag = state
    end)
    local settings_sector = character_tab:CreateSection("settings")
    settings_sector:CreateSlider("walkspeed amount", 0, 100, 35, true, function(state)
        set_speed(state)
    end)
    settings_sector:CreateSlider("jumppower amount", 0, 100, 35, true, function(state)
        set_jump_power(state)
    end)
    settings_sector:CreateSlider("fakelag amount", 0, 20, 15, true, function(state)
        config.character.fake_lag_limit = state
    end)
    
    local antiaim_sector = character_tab:CreateSection("anti aim")
    antiaim_sector:CreateToggle("enabled", false, function(state)
        config.character.antiaim = state
    end)
    antiaim_sector:CreateDropdown("stance type", {
        "prone",
        "crouch",
        "stand"
    }, function(state)
        config.character.antiaim_stance = state
    end)
end
do
    local esp_sector = visuals_tab:CreateSection("esp")
    esp_sector:CreateToggle("enabled", true, function(state)
        config.visuals.esp_enabled = state
    end)
    esp_sector:CreateColorpicker("color", function(state)
        config.visuals.esp_colour = state
    end)
    esp_sector:CreateToggle("visible thru walls", false, function(state)
        config.visuals.esp_not_visible_shown = state
    end)
    esp_sector:CreateColorpicker("visible color", function(state)
        config.visuals.esp_visible_colour = state
    end)
    esp_sector:CreateToggle("visible not thru walls", true, function(state)
        config.visuals.esp_visible_shown = state
    end)
end

local windowVisible = true
UIS.InputBegan:Connect(function(InputObject, Processed)
	if InputObject.KeyCode == Enum.KeyCode.RightShift then
        windowVisible = not windowVisible
		window:Toggle(windowVisible)
	end
end)