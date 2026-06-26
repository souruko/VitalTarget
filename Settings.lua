
Options = class( Turbine.UI.ListBox )

function Options:Constructor( OBJECT )
	Turbine.UI.ListBox.Constructor( self )
	
	self.OBJECT = OBJECT
	
	self:SetSize( 600, 600 )

	self:AddItem(self:BuildHeader())
	self:AddItem(self:BuildSpacer())
	self:AddItem(self:BuildMoveControl())
	self:AddItem(self:BuildSpacer())
	self:AddItem(self:BuildWidthSlider())
	
end

function Options:BuildHeader()

	local temp = Turbine.UI.Control()
	
	temp:SetParent(self)
	temp:SetSize(600, 50)
	
	temp.label = Turbine.UI.Label()
	temp.label:SetParent(temp)
	temp.label:SetSize(temp:GetSize())
	temp.label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	temp.label:SetFont(Turbine.UI.Lotro.Font.BookAntiqua36)
	temp.label:SetText("VitalTarget")
	
	return temp

end

function Options:BuildMoveControl()

	local temp = Turbine.UI.Control()
	
	temp:SetParent(self)
	temp:SetSize(600, 50)
	
	temp.checkBox = Turbine.UI.Lotro.CheckBox()
	temp.checkBox:SetParent(temp)
	temp.checkBox:SetLeft(50)
	temp.checkBox:SetWidth(temp:GetWidth()-50)
	temp.checkBox:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	temp.checkBox:SetFont(SETTINGSFONT)
	temp.checkBox:SetText(" If checked you can move the window.")
	temp.checkBox:SetChecked(MOVE)
	
	temp.checkBox.CheckedChanged = function()
		if temp.checkBox:IsChecked() then
			MOVE = true
			self.OBJECT.moveControl:SetMouseVisible(true)			
		else
			MOVE = false
			self.OBJECT.moveControl:SetMouseVisible(false)
		end	
	end
	
	return temp

end

function Options:BuildWidthSlider()

	local temp = Turbine.UI.Control()
	
	temp:SetParent(self)
	temp:SetSize(600, 100)
	
	temp.wl = Turbine.UI.Label()
	temp.wl:SetParent(temp)
	temp.wl:SetLeft(50)
	temp.wl:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
	temp.wl:SetFont(SETTINGSFONTSMALL)
	temp.wl:SetText("Width")
	
	temp.wtb = Turbine.UI.Lotro.TextBox()
	temp.wtb:SetParent(temp)
	temp.wtb:SetWidth(50)
	temp.wtb:SetTop(20)
	temp.wtb:SetHeight(25)
	temp.wtb:SetLeft(50)
	temp.wtb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	temp.wtb:SetFont(SETTINGSFONT)
	temp.wtb:SetText(WIDTH)
	
	temp.hl = Turbine.UI.Label()
	temp.hl:SetParent(temp)
	temp.hl:SetLeft(150)
	temp.hl:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
	temp.hl:SetFont(SETTINGSFONTSMALL)
	temp.hl:SetText("Height")
	
	temp.htb = Turbine.UI.Lotro.TextBox()
	temp.htb:SetParent(temp)
	temp.htb:SetWidth(50)
	temp.htb:SetTop(20)
	temp.htb:SetHeight(25)
	temp.htb:SetLeft(150)
	temp.htb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	temp.htb:SetFont(SETTINGSFONT)
	temp.htb:SetText(HEIGHT)
	
	temp.tl = Turbine.UI.Label()
	temp.tl:SetParent(temp)
	temp.tl:SetLeft(250)
	temp.tl:SetWidth(100)
	temp.tl:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
	temp.tl:SetFont(SETTINGSFONTSMALL)
	temp.tl:SetText("Timer-Width")
	
	temp.ttb = Turbine.UI.Lotro.TextBox()
	temp.ttb:SetParent(temp)
	temp.ttb:SetWidth(50)
	temp.ttb:SetTop(20)
	temp.ttb:SetHeight(25)
	temp.ttb:SetLeft(250)
	temp.ttb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	temp.ttb:SetFont(SETTINGSFONT)
	temp.ttb:SetText(TTKSPACE)
	
	temp.button = Turbine.UI.Lotro.Button()
	temp.button:SetParent(temp)
	temp.button:SetText("Accept")
	temp.button:SetLeft(350)
	temp.button:SetTop(30)
	temp.button:SetWidth(100)
	temp.button:SetHeight(20)
	
	temp.button.Click = function()
	
		WIDTH = tonumber(temp.wtb:GetText())
		HEIGHT = tonumber(temp.htb:GetText())
		TTKSPACE = tonumber(temp.ttb:GetText())
		self.OBJECT:Resize()
		save()
	end

	temp.checkBox = Turbine.UI.Lotro.CheckBox()
	temp.checkBox:SetParent(temp)
	temp.checkBox:SetLeft(50)
	temp.checkBox:SetTop(50)
	temp.checkBox:SetWidth(temp:GetWidth()-50)
	temp.checkBox:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	temp.checkBox:SetFont(SETTINGSFONT)
	temp.checkBox:SetText(" Show Extra Window.")
	temp.checkBox:SetChecked(SHOW_TTKSPACE)
	
	temp.checkBox.CheckedChanged = function()
		if temp.checkBox:IsChecked() then
			SHOW_TTKSPACE = true
			self.OBJECT:ShowTTKSpaceChanged()
		else
			SHOW_TTKSPACE = false
			self.OBJECT:ShowTTKSpaceChanged()
		end	

		save()
	end
	
	return temp

end


function Options:BuildSpacer()

	local temp = Turbine.UI.Control()
	
	temp:SetParent(self)
	temp:SetSize(600, 30)
	
	return temp

end
