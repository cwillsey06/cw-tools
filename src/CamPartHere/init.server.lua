-- init.lua
-- Coltrane Willsey
-- 2022-03-29 [08:43]

local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local Modules = script.Parent.modules
local Promise = require(Modules.Promise)
local new  = require(Modules.new)

local Toolbar = plugin:CreateToolbar("cw-tools")
local Button = Toolbar:CreateButton("CamPart Here", "Inserts a \"CamPart\" at your camera's position.", "rbxassetid://4458901886")

function createPart()
    local function main()
        local camParts = workspace:FindFirstChild("CamParts") or new("Folder", workspace, {Name="CamParts"})
        ChangeHistoryService:SetWaypoint("__cw-tools_".. Button.Name:lower())
        local part = new("Part", camParts, {
            Name = "CamPart";
            CFrame = workspace.CurrentCamera.CFrame;
            Material = Enum.Material.Neon;
            TopSurface = Enum.SurfaceType.Smooth;
            BottomSurface = Enum.SurfaceType.Smooth;
            Color = Color3.new(1,1,1);
            Size = Vector3.new(1,1,1);
            Transparency = 0.5;
            CastShadow = false;
            CanCollide = false;
            CanTouch = false;
            CanQuery = false;
            Anchored = true;
            Massless = true;
        })
        part:SetAttribute("FieldOfView", workspace.CurrentCamera.FieldOfView)
    end
    
    local part
    Promise.try(main)
    :andThen(function(thisPart)
        part = thisPart
        Selection:Set({thisPart})
    end)
    :catch(function(err)
        warn(err)
        if part then
            part:Destroy()
        end
        part = nil
    end)
end

Button.Click:Connect(createPart)