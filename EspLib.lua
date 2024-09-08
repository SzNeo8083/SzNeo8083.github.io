local player    = game:GetService("Players").LocalPlayer
local camera    = game:GetService("Workspace").CurrentCamera

if isfile("menu_plex.font") then
    delfile("menu_plex.font")
end

writefile("ProggyClean.ttf", game:HttpGet("https://github.com/f1nobe7650/other/raw/main/ProggyClean.ttf"))

do
    getsynasset = getcustomasset or getsynasset
    Font = setreadonly(Font, false);
    function Font:Register(Name, Weight, Style, Asset)
        if not isfile(Name .. ".font") then
            if not isfile(Asset.Id) then
                writefile(Asset.Id, Asset.Font);
            end
            local Data = {
                name = Name,
                faces = {{
                    name = "Regular",
                    weight = Weight,
                    style = Style,
                    assetId = getsynasset(Asset.Id);
                }}
            }
            writefile(Name .. ".font", game:GetService("HttpService"):JSONEncode(Data))
            return getsynasset(Name .. ".font")
        else 
            warn("Font already registered")
        end
    end
    function Font:GetRegistry(Name)
        if isfile(Name .. ".font") then
            return getsynasset(Name .. ".font")
        end
    end

    Font:Register("menu_plex", 400, "normal", {Id = "ProggyClean.ttf", Font = ""})
end

local realfont = Font.new(Font:GetRegistry("menu_plex"))


local espvars = {
    enemy = {
        enabled = nil,
        boxEsp = nil,
        boxEspColor = Color3.fromRGB(255, 255, 255),
        boxOutlineColor = Color3.fromRGB(0, 0, 0),
        healthBar = nil,
        healthBarColor = Color3.fromRGB(148, 255, 98),
        healthBarOutlineColor = Color3.fromRGB(0, 0, 0),
        healthBarGradient = nil,
        healthBarGradientColor1 = Color3.fromRGB(0, 255, 0),
        healthBarGradientColor2 = Color3.fromRGB(255, 0, 0),
        healthText = nil,
        healthTextColor = Color3.fromRGB(255, 255, 2552),
        healthTextOutlineColor = Color3.fromRGB(0, 0, 0),
        userText = nil,
        userTextColor = Color3.fromRGB(255, 255, 255),
        userTextOutlineColor = Color3.fromRGB(0, 0, 0),
        distanceText = nil,
        distanceTextColor = Color3.fromRGB(255, 255, 255),
        distanceTextOutlineColor = Color3.fromRGB(0, 0, 0),
        weaponText = nil,
        weaponTextColor = Color3.fromRGB(255, 255, 255),
        weaponTextOutlineColor = Color3.fromRGB(0, 0, 0),
        fontSize = nil,
        fontFamily = "nil" , --Code, RobotoMono, Plex, System & Arcade
        skele = nil,
        skeleColor = Color3.fromRGB(255, 255, 255),
        skeleOutlineColor = Color3.fromRGB(0, 0, 0),

    },
    team = {
        enabled = nil,
        boxEsp = nil,
        boxEspColor = Color3.fromRGB(117, 138, 255),
        boxOutlineColor = Color3.fromRGB(0, 0, 0),
        healthBar = nil,
        healthBarColor = Color3.fromRGB(250, 98, 255),
        healthBarOutlineColor = Color3.fromRGB(0, 0, 0),
        healthBarGradient = nil,
        healthText = nil,
        healthTextColor = Color3.fromRGB(255, 255, 2552),
        healthTextOutlineColor = Color3.fromRGB(0, 0, 0),
        userText = nil,
        userTextColor = Color3.fromRGB(255, 255, 255),
        userTextOutlineColor = Color3.fromRGB(0, 0, 0),
        distanceText = nil,
        distanceTextColor = Color3.fromRGB(255, 255, 255),
        distanceTextOutlineColor = Color3.fromRGB(0, 0, 0),
        weaponText = nil,
        weaponTextColor = Color3.fromRGB(255, 255, 255),
        weaponTextOutlineColor = Color3.fromRGB(0, 0, 0),
        fontSize = 13,
        fontFamily = "10", --Code, RobotoMono, Plex, System & Arcade
        skele = nil,
        skeleColor = Color3.fromRGB(255, 255, 255),
        skeleOutlineColor = Color3.fromRGB(0, 0, 0),
    }
}
    


local function ESP(plr)
    local boxOutline = Drawing.new("Quad")
    boxOutline.Visible = false
    boxOutline.PointA = Vector2.new(0,0)
    boxOutline.PointB = Vector2.new(0,0)
    boxOutline.PointC = Vector2.new(0,0)
    boxOutline.PointD = Vector2.new(0,0)
    boxOutline.Filled = false
    boxOutline.Thickness = 3
    boxOutline.Transparency = 1
    boxOutline.zIndex = 1

    local boxFrame = Drawing.new("Quad")
    boxFrame.Visible = false
    boxFrame.PointA = Vector2.new(0,0)
    boxFrame.PointB = Vector2.new(0,0)
    boxFrame.PointC = Vector2.new(0,0)
    boxFrame.PointD = Vector2.new(0,0)
    boxFrame.Filled = false
    boxFrame.Thickness = 1
    boxFrame.Transparency = 1
    boxFrame.zIndex = 2

    local healthOutline = Drawing.new("Line")
    healthOutline.Visible = false
    healthOutline.From = Vector2.new(0, 0)
    healthOutline.To = Vector2.new(0, 0)
    healthOutline.Thickness = 3
    healthOutline.Transparency = 1
    healthOutline.zIndex = 1

    local healthFrame = Drawing.new("Line")
    healthFrame.Visible = false
    healthFrame.From = Vector2.new(0, 0)
    healthFrame.To = Vector2.new(0, 0)
    healthFrame.Thickness = 1
    healthFrame.Transparency = 1
    healthFrame.zIndex = 2

    local healthText = Drawing.new("Text")
    healthText.Center = true 
    healthText.Outline = true 
    healthText.Visible = false 
    healthText.FontFace = realfont


    local nameTag = Drawing.new("Text")
    nameTag.Center = true 
    nameTag.Outline = true 
    nameTag.Visible = false 
    nameTag.FontFace = realfont

    local distanceTag = Drawing.new("Text")
    distanceTag.Center = true 
    distanceTag.Outline = true 
    distanceTag.Visible = false 
    distanceTag.FontFace = realfont
   

    local WeaponTag = Drawing.new("Text")
    WeaponTag.Center = true 
    WeaponTag.Outline = true 
    WeaponTag.Visible = false 
    WeaponTag.FontFace = realfont

    local function Updater()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()

            if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
                local HumPos, OnScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local head = camera:WorldToViewportPoint(plr.Character.Head.Position)
                    local DistanceY = math.clamp((Vector2.new(head.X, head.Y) - Vector2.new(HumPos.X, HumPos.Y)).magnitude, 2, math.huge)
                    local d = (Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2) - Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)).magnitude 
                    local healthoffset = plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth * d
                    
                    if plr.TeamColor == player.TeamColor then
                        -- team esp
                        if espvars.team.enabled then
                            if espvars.team.boxEsp then
                                boxOutline.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                                boxOutline.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                                boxOutline.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                                boxOutline.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
                                boxOutline.Color = espvars.team.boxOutlineColor

                                boxFrame.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                                boxFrame.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                                boxFrame.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                                boxFrame.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
                                boxFrame.Color = espvars.team.boxEspColor

                                boxOutline.Visible  = true
                                boxFrame.Visible    = true
                            else
                                boxOutline.Visible  = false
                                boxFrame.Visible    = false
                            end

                            if espvars.team.healthBar then
                                healthOutline.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                                healthOutline.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y - DistanceY*2)
                                healthOutline.Color = espvars.team.healthBarOutlineColor

                                healthFrame.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*1.97)
                                healthFrame.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2 - healthoffset)
                                healthFrame.Color = espvars.team.healthBarColor

                                healthOutline.Visible  = true
                                healthFrame.Visible    = true
                            else
                                healthOutline.Visible  = false
                                healthFrame.Visible    = false
                            end

                            if espvars.team.healthText then
                                healthText.Text = math.floor(plr.Character.Humanoid.Health)
                                healthText.Position = Vector2.new(HumPos.X - DistanceY - 20, HumPos.Y + DistanceY*2 - healthoffset), Vector2.new(HumPos.X - DistanceY - 20, HumPos.Y + DistanceY*2) - Vector2.new(0, healthText.TextBounds.Y * 1.1)
                                healthText.Color = espvars.team.healthTextColor
                                healthText.OutlineColor = espvars.team.healthTextOutlineColor
                                healthText.Font = espvars.team.fontFamily
                                healthText.Size = espvars.team.fontSize
    
                                healthText.Visible  = true
                            else
                                healthText.Visible  = false
                            end

                            if espvars.team.userText then
                                nameTag.Text = plr.Name
                                nameTag.Position = ((Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2) + Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)) * 0.5) - Vector2.new(0, nameTag.TextBounds.Y * 1.1)
                                nameTag.Color = espvars.team.userTextColor
                                nameTag.OutlineColor = espvars.team.userTextOutlineColor
                                nameTag.Font = espvars.team.fontFamily
                                nameTag.Size = espvars.team.fontSize
    
                                nameTag.Visible = true
                            else
                                nameTag.Visible = false
                            end

                            if espvars.team.distanceText then
                                if espvars.team.weaponText then
                                    distanceTag.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 10)
                                else
                                    distanceTag.Position = ((Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2) + Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)) * 0.5) - Vector2.new(0, nameTag.TextBounds.Y * 0)
                                end
                                distanceTag.Text = ("["..tostring(math.floor((player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude)) .. "m]")
                                distanceTag.Color = espvars.team.distanceTextColor
                                distanceTag.OutlineColor = espvars.team.distanceTextOutlineColor
                                distanceTag.Font = espvars.team.fontFamily
                                distanceTag.Size = espvars.team.fontSize
                            
                                distanceTag.Visible = true
                            else
                                distanceTag.Visible = false
                            end

                            if espvars.team.weaponText then
                                local itemRoot = plr.Character and plr.Character:FindFirstChild("ItemRoot", true)
                                if itemRoot and itemRoot.Parent then
                                    WeaponTag.Text = itemRoot.Parent.Name
                                else
                                    WeaponTag.Text = "Nothing"
                                end
                                WeaponTag.Position = ((Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2) + Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)) * 0.5) - Vector2.new(0, nameTag.TextBounds.Y * 0)
                                WeaponTag.Color = espvars.team.weaponTextColor
                                WeaponTag.OutlineColor = espvars.team.weaponTextOutlineColor
                                WeaponTag.Font = espvars.team.fontFamily
                                WeaponTag.Size = espvars.team.fontSize
                            
                                WeaponTag.Visible = true
                            else
                                WeaponTag.Visible = false
                            end
                        else
                            healthText.Visible  = false
                            healthFrame.Visible = false
                            healthOutline.Visible = false
                            distanceTag.Visible = false
                            nameTag.Visible     = false
                            boxOutline.Visible  = false
                            boxFrame.Visible    = false
                            WeaponTag.Visible   = false
                        end

                    -- enemy esp
                    else
                        if espvars.enemy.enabled then
                            if espvars.team.boxEsp then
                                boxOutline.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                                boxOutline.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                                boxOutline.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                                boxOutline.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
                                boxOutline.Color = espvars.enemy.boxOutlineColor

                                boxFrame.PointA = Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2)
                                boxFrame.PointB = Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)
                                boxFrame.PointC = Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)
                                boxFrame.PointD = Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2)
                                boxFrame.Color = espvars.enemy.boxEspColor

                                boxOutline.Visible  = true
                                boxFrame.Visible    = true
                            else
                                boxOutline.Visible  = false
                                boxFrame.Visible    = false
                            end

                            if espvars.enemy.healthBar then
                                healthOutline.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                                healthOutline.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y - DistanceY*2)
                                healthOutline.Color = espvars.enemy.healthBarOutlineColor

                                healthFrame.From = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2)
                                healthFrame.To = Vector2.new(HumPos.X - DistanceY - 4, HumPos.Y + DistanceY*2 - healthoffset)
                                healthFrame.Color = espvars.enemy.healthBarColor

                                healthOutline.Visible  = true
                                healthFrame.Visible    = true
                            else
                                healthOutline.Visible  = false
                                healthFrame.Visible    = false
                            end

                            if espvars.enemy.healthText then
                                healthText.Text = math.floor(plr.Character.Humanoid.Health)
                                healthText.Position = Vector2.new(HumPos.X - DistanceY - 20, HumPos.Y + DistanceY*2 - healthoffset), Vector2.new(HumPos.X - DistanceY - 20, HumPos.Y + DistanceY*2) - Vector2.new(0, healthText.TextBounds.Y * 1.1)
                                healthText.Color = espvars.enemy.healthTextColor
                                healthText.OutlineColor = espvars.enemy.healthTextOutlineColor
                                healthText.Font = espvars.enemy.fontFamily
                                healthText.Size = espvars.enemy.fontSize
    
                                healthText.Visible  = true
                            else
                                healthText.Visible  = false
                            end

                            if espvars.enemy.userText then
                                nameTag.Text = plr.Name
                                nameTag.Position = ((Vector2.new(HumPos.X + DistanceY, HumPos.Y - DistanceY*2) + Vector2.new(HumPos.X - DistanceY, HumPos.Y - DistanceY*2)) * 0.5) - Vector2.new(0, nameTag.TextBounds.Y * 1.1)
                                nameTag.Color = espvars.enemy.userTextColor
                                nameTag.OutlineColor = espvars.enemy.userTextOutlineColor
                                nameTag.Font = espvars.enemy.fontFamily
                                nameTag.Size = espvars.enemy.fontSize
    
                                nameTag.Visible = true
                            else
                                nameTag.Visible = false
                            end

                            if espvars.enemy.distanceText then
                                if espvars.team.weaponText then
                                    distanceTag.Position = Vector2.new(HumPos.X, HumPos.Y + DistanceY * 2 + 10)
                                else
                                    distanceTag.Position = ((Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2) + Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)) * 0.5) - Vector2.new(0, nameTag.TextBounds.Y * 0)
                                end
                                distanceTag.Text = ("["..tostring(math.floor((player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude)) .. "m]")
                                distanceTag.Color = espvars.enemy.distanceTextColor
                                distanceTag.OutlineColor = espvars.enemy.distanceTextOutlineColor
                                distanceTag.Font = espvars.enemy.fontFamily
                                distanceTag.Size = espvars.enemy.fontSize
                            
                                distanceTag.Visible = true
                            else
                                distanceTag.Visible = false
                            end

                            if espvars.enemy.weaponText then
                                local itemRoot = plr.Character and plr.Character:FindFirstChild("ItemRoot", true)
                                if itemRoot and itemRoot.Parent then
                                    WeaponTag.Text = itemRoot.Parent.Name
                                else
                                    WeaponTag.Text = "Nothing"
                                end
                                WeaponTag.Position = ((Vector2.new(HumPos.X + DistanceY, HumPos.Y + DistanceY*2) + Vector2.new(HumPos.X - DistanceY, HumPos.Y + DistanceY*2)) * 0.5) - Vector2.new(0, nameTag.TextBounds.Y * 0)
                                WeaponTag.Color = espvars.enemy.weaponTextColor
                                WeaponTag.OutlineColor = espvars.enemy.weaponTextOutlineColor
                                WeaponTag.Font = espvars.enemy.fontFamily
                                WeaponTag.Size = espvars.enemy.fontSize
                            
                                WeaponTag.Visible = true
                            else
                                WeaponTag.Visible = false
                            end
                        else
                            healthText.Visible  = false
                            healthFrame.Visible = false
                            healthOutline.Visible = false
                            distanceTag.Visible = false
                            nameTag.Visible     = false
                            boxOutline.Visible  = false
                            boxFrame.Visible    = false
                            WeaponTag.Visible    = false
                        end
                    end
                else 
                    healthText.Visible  = false
                    healthFrame.Visible = false
                    healthOutline.Visible = false
                    distanceTag.Visible = false
                    nameTag.Visible     = false
                    boxOutline.Visible  = false
                    boxFrame.Visible    = false
                    WeaponTag.Visible    = false
                end
            else 
                healthText.Visible  = false
                healthFrame.Visible = false
                healthOutline.Visible = false
                distanceTag.Visible = false
                nameTag.Visible     = false
                boxOutline.Visible  = false
                boxFrame.Visible    = false
                WeaponTag.Visible    = false

                if game.Players:FindFirstChild(plr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(Updater)()
end

for i, v in pairs(game:GetService("Players"):GetPlayers()) do
    if v.Name ~= player.Name then
        coroutine.wrap(ESP)(v)
    end
end

game.Players.PlayerAdded:Connect(function(newplr)
    if newplr.Name ~= player.Name then
        coroutine.wrap(ESP)(newplr)
    end
end)

return {
    espvars = espvars
}
