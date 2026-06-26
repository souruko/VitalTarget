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
	saveFile.heigth = HEIGHT
	saveFile.left = LEFT
	saveFile.top = TOP
	saveFile.ttkspace = TTKSPACE
	saveFile.show_ttkspace = SHOW_TTKSPACE
	saveFile.moraleColor = MORALECOLOR
	saveFile.bubbleColor = BUBBLECOLOR
	
	
	Turbine.PluginData.Save(Turbine.DataScope.Character, "vitalTargetSaveFile", saveFile);
	Turbine.PluginData.Save(Turbine.DataScope.Account, "vitalTargetSaveFileBackup", saveFile);

end

function loadSaveFile()

	if Turbine.PluginData.Load(Turbine.DataScope.Character, "vitalTargetSaveFile") ~= nil then
	
		local saveFile = Turbine.PluginData.Load(Turbine.DataScope.Character, "vitalTargetSaveFile")
	
		WIDTH 	= saveFile.width
		HEIGHT	= saveFile.heigth
		LEFT 	= saveFile.left
		TOP 	= saveFile.top
		TTKSPACE= saveFile.ttkspace
	
		if 	saveFile.show_ttkspace ~= nil then

			SHOW_TTKSPACE = saveFile.show_ttkspace 

		end

	else
	
		if Turbine.PluginData.Load(Turbine.DataScope.Account, "vitalTargetSaveFileBackup") ~= nil then
		
			local saveFile = Turbine.PluginData.Load(Turbine.DataScope.Account, "vitalTargetSaveFileBackup")
		
			WIDTH 	= saveFile.width
			HEIGHT	= saveFile.heigth
			LEFT 	= saveFile.left
			TOP 	= saveFile.top
			TTKSPACE= saveFile.ttkspace

			if 	saveFile.show_ttkspace ~= nil then

				SHOW_TTKSPACE = saveFile.show_ttkspace 
	
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

save()