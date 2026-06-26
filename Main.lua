import "Turbine.Gameplay"
import "Turbine.UI"
import "Turbine.UI.Lotro"
import "VitalTarget.Type"
import "VitalTarget.Class"

-----------------------------------------------------------------
--== PreSets ==--
-----------------------------------------------------------------

LOCALPLAYER = Turbine.Gameplay.LocalPlayer:GetInstance()

FONT 	= Turbine.UI.Lotro.Font.Verdana14
WIDTH 	= 100
HEIGHT	= 30
LEFT 	= 500
TOP 	= 500
SHOW_TTKSPACE = false
TTKSPACE= 54
MOVE    = false
REVERSE_BAR = false
MORALECOLOR = Turbine.UI.Color.Orange
BUBBLECOLOR = Turbine.UI.Color(0.1,0.6,1.0)
SETTINGSFONT = Turbine.UI.Lotro.Font.BookAntiqua20
SETTINGSFONTSMALL = Turbine.UI.Lotro.Font.BookAntiqua16
ACTUALWIDTH = WIDTH


-----------------------------------------------------------------
--== Imports ==--
-----------------------------------------------------------------

import "VitalTarget.Handler" 
import "VitalTarget.UI"
import "VitalTarget.Settings" 

-----------------------------------------------------------------
--== Save/Load ==--
-----------------------------------------------------------------

function save()

	local saveFile = {}
	
	saveFile.font = FONT
	saveFile.width = WIDTH
	saveFile.height = HEIGHT
	saveFile.left = LEFT
	saveFile.top = TOP
	saveFile.ttkspace = TTKSPACE
	saveFile.show_ttkspace = SHOW_TTKSPACE
	saveFile.reverse_bar = REVERSE_BAR
	saveFile.moraleColorR = MORALECOLOR.R
	saveFile.moraleColorG = MORALECOLOR.G
	saveFile.moraleColorB = MORALECOLOR.B
	saveFile.moraleColorA = MORALECOLOR.A
	saveFile.bubbleColorR = BUBBLECOLOR.R
	saveFile.bubbleColorG = BUBBLECOLOR.G
	saveFile.bubbleColorB = BUBBLECOLOR.B
	saveFile.bubbleColorA = BUBBLECOLOR.A
	
	
	Turbine.PluginData.Save(Turbine.DataScope.Character, "vitalTargetSaveFile", saveFile);
	Turbine.PluginData.Save(Turbine.DataScope.Account, "vitalTargetSaveFileBackup", saveFile);

end

function loadSaveFile()

	if Turbine.PluginData.Load(Turbine.DataScope.Character, "vitalTargetSaveFile") ~= nil then
	
		local saveFile = Turbine.PluginData.Load(Turbine.DataScope.Character, "vitalTargetSaveFile")
	
		WIDTH 	= saveFile.width
		HEIGHT	= saveFile.height or HEIGHT
		LEFT 	= saveFile.left
		TOP 	= saveFile.top
		TTKSPACE= saveFile.ttkspace

		if saveFile.show_ttkspace ~= nil then
			SHOW_TTKSPACE = saveFile.show_ttkspace
		end

		if saveFile.reverse_bar ~= nil then
			REVERSE_BAR = saveFile.reverse_bar
		end

		if saveFile.moraleColorR ~= nil then
			MORALECOLOR = Turbine.UI.Color(saveFile.moraleColorA, saveFile.moraleColorR, saveFile.moraleColorG, saveFile.moraleColorB)
		end
		if saveFile.bubbleColorR ~= nil then
			BUBBLECOLOR = Turbine.UI.Color(saveFile.bubbleColorA, saveFile.bubbleColorR, saveFile.bubbleColorG, saveFile.bubbleColorB)
		end

	else

		if Turbine.PluginData.Load(Turbine.DataScope.Account, "vitalTargetSaveFileBackup") ~= nil then

			local saveFile = Turbine.PluginData.Load(Turbine.DataScope.Account, "vitalTargetSaveFileBackup")

			WIDTH 	= saveFile.width
			HEIGHT	= saveFile.height or HEIGHT
			LEFT 	= saveFile.left
			TOP 	= saveFile.top
			TTKSPACE= saveFile.ttkspace

			if saveFile.show_ttkspace ~= nil then
				SHOW_TTKSPACE = saveFile.show_ttkspace
			end

			if saveFile.reverse_bar ~= nil then
				REVERSE_BAR = saveFile.reverse_bar
			end

			if saveFile.moraleColorR ~= nil then
				MORALECOLOR = Turbine.UI.Color(saveFile.moraleColorA, saveFile.moraleColorR, saveFile.moraleColorG, saveFile.moraleColorB)
			end
			if saveFile.bubbleColorR ~= nil then
				BUBBLECOLOR = Turbine.UI.Color(saveFile.bubbleColorA, saveFile.bubbleColorR, saveFile.bubbleColorG, saveFile.bubbleColorB)
			end
		
		end
	
	end
	
end

-----------------------------------------------------------------
--== StartUp ==--
-----------------------------------------------------------------

loadSaveFile()

OBJECT = VITALTARGET()

if LOCALPLAYER:GetTarget() then
	OBJECT:SetVisible(true)
	OBJECT:UpdateWindow(LOCALPLAYER:GetTarget())
end

optionsPanel = Options(OBJECT)

optionsPanel.SizeChanged = function( sender, args )
  local optionsPanelWidth = optionsPanel:GetWidth()
  
  optionsPanel:SetHeight( optionsPanelWidth )
end

plugin.GetOptionsPanel = function( self )
  return optionsPanel
end