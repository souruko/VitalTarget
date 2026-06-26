
Options = class( Turbine.UI.ListBox )

local GOLD    = Turbine.UI.Color(0.75, 0.58, 0.18)
local DIMGOLD = Turbine.UI.Color(0.30, 0.22, 0.06)

function Options:Constructor( OBJECT )
	Turbine.UI.ListBox.Constructor( self )

	self.OBJECT = OBJECT

	self:SetSize( 600, 650 )

	self:AddItem(self:BuildHeader())
	self:AddItem(self:BuildDivider())
	self:AddItem(self:BuildMoveControl())
	self:AddItem(self:BuildDivider())
	self:AddItem(self:BuildWidthSlider())
	self:AddItem(self:BuildDivider())
	self:AddItem(self:BuildColorPicker())
	self:AddItem(self:BuildDivider())
	self:AddItem(self:BuildPositionControl())
	self:AddItem(self:BuildDivider())
	self:AddItem(self:BuildResetControl())

end

function Options:BuildHeader()

	local temp = Turbine.UI.Control()
	temp:SetParent(self)
	temp:SetSize(600, 70)

	local label = Turbine.UI.Label()
	label:SetParent(temp)
	label:SetSize(600, 70)
	label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	label:SetFont(Turbine.UI.Lotro.Font.BookAntiqua36)
	label:SetForeColor(GOLD)
	label:SetText("VitalTarget")

	return temp

end

function Options:BuildDivider()

	local temp = Turbine.UI.Control()
	temp:SetParent(self)
	temp:SetSize(600, 20)

	local line = Turbine.UI.Control()
	line:SetParent(temp)
	line:SetPosition(30, 9)
	line:SetSize(540, 1)
	line:SetBackColor(DIMGOLD)

	return temp

end

function Options:BuildMoveControl()

	local temp = Turbine.UI.Control()
	temp:SetParent(self)
	temp:SetSize(600, 65)

	local section = Turbine.UI.Label()
	section:SetParent(temp)
	section:SetPosition(30, 0)
	section:SetSize(200, 18)
	section:SetFont(SETTINGSFONTSMALL)
	section:SetForeColor(GOLD)
	section:SetText("WINDOW")

	local checkBox = Turbine.UI.Lotro.CheckBox()
	checkBox:SetParent(temp)
	checkBox:SetPosition(30, 22)
	checkBox:SetWidth(temp:GetWidth()-30)
	checkBox:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	checkBox:SetFont(SETTINGSFONT)
	checkBox:SetText(" Enable window drag")
	checkBox:SetChecked(MOVE)

	checkBox.CheckedChanged = function()
		if checkBox:IsChecked() then
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
	temp:SetSize(600, 110)

	local section = Turbine.UI.Label()
	section:SetParent(temp)
	section:SetPosition(30, 0)
	section:SetSize(200, 18)
	section:SetFont(SETTINGSFONTSMALL)
	section:SetForeColor(GOLD)
	section:SetText("DIMENSIONS")

	local wl = Turbine.UI.Label()
	wl:SetParent(temp)
	wl:SetPosition(30, 22)
	wl:SetSize(80, 16)
	wl:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
	wl:SetFont(SETTINGSFONTSMALL)
	wl:SetText("Width")

	local wtb = Turbine.UI.Lotro.TextBox()
	wtb:SetParent(temp)
	wtb:SetPosition(30, 40)
	wtb:SetSize(60, 26)
	wtb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	wtb:SetFont(SETTINGSFONT)
	wtb:SetText(WIDTH)

	local hl = Turbine.UI.Label()
	hl:SetParent(temp)
	hl:SetPosition(110, 22)
	hl:SetSize(80, 16)
	hl:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
	hl:SetFont(SETTINGSFONTSMALL)
	hl:SetText("Height")

	local htb = Turbine.UI.Lotro.TextBox()
	htb:SetParent(temp)
	htb:SetPosition(110, 40)
	htb:SetSize(60, 26)
	htb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	htb:SetFont(SETTINGSFONT)
	htb:SetText(HEIGHT)

	local tl = Turbine.UI.Label()
	tl:SetParent(temp)
	tl:SetPosition(190, 22)
	tl:SetSize(90, 16)
	tl:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
	tl:SetFont(SETTINGSFONTSMALL)
	tl:SetText("Timer Width")

	local ttb = Turbine.UI.Lotro.TextBox()
	ttb:SetParent(temp)
	ttb:SetPosition(190, 40)
	ttb:SetSize(60, 26)
	ttb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	ttb:SetFont(SETTINGSFONT)
	ttb:SetText(TTKSPACE)

	local button = Turbine.UI.Lotro.Button()
	button:SetParent(temp)
	button:SetText("Apply")
	button:SetPosition(270, 43)
	button:SetSize(80, 22)

	button.Click = function()
		WIDTH    = math.max(50,  math.min(500, tonumber(wtb:GetText()) or WIDTH))
		HEIGHT   = math.max(10,  math.min(100, tonumber(htb:GetText()) or HEIGHT))
		TTKSPACE = math.max(30,  math.min(200, tonumber(ttb:GetText()) or TTKSPACE))
		self.OBJECT:Resize()
		self.OBJECT:ShowTTKSpaceChanged()
		save()
	end

	local checkBox = Turbine.UI.Lotro.CheckBox()
	checkBox:SetParent(temp)
	checkBox:SetPosition(30, 76)
	checkBox:SetWidth(temp:GetWidth()-30)
	checkBox:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	checkBox:SetFont(SETTINGSFONT)
	checkBox:SetText(" Show TTK / DPS panel")
	checkBox:SetChecked(SHOW_TTKSPACE)

	checkBox.CheckedChanged = function()
		SHOW_TTKSPACE = checkBox:IsChecked()
		self.OBJECT:ShowTTKSpaceChanged()
		save()
	end

	return temp

end

function Options:BuildColorPicker()

	local temp = Turbine.UI.Control()
	temp:SetParent(self)
	temp:SetSize(600, 130)

	local section = Turbine.UI.Label()
	section:SetParent(temp)
	section:SetPosition(30, 0)
	section:SetSize(200, 18)
	section:SetFont(SETTINGSFONTSMALL)
	section:SetForeColor(GOLD)
	section:SetText("COLORS")

	local function makeSwatch(parent, left, top, color, onClick)
		local s = Turbine.UI.Control()
		s:SetParent(parent)
		s:SetPosition(left, top)
		s:SetSize(38, 28)
		s:SetBackColor(color)
		s:SetMouseVisible(true)
		s.MouseDown = function(sender, args)
			if args.Button == Turbine.UI.MouseButton.Left then
				onClick(color)
			end
		end
		return s
	end

	local ml = Turbine.UI.Label()
	ml:SetParent(temp)
	ml:SetPosition(30, 22)
	ml:SetSize(100, 16)
	ml:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	ml:SetFont(SETTINGSFONTSMALL)
	ml:SetText("Morale Bar")

	local moraleColors = {
		Turbine.UI.Color(1.0, 0.5, 0.0),
		Turbine.UI.Color(1.0, 0.0, 0.0),
		Turbine.UI.Color(0.0, 1.0, 0.0),
		Turbine.UI.Color(1.0, 1.0, 0.0),
		Turbine.UI.Color(1.0, 1.0, 1.0),
		Turbine.UI.Color(0.6, 0.0, 1.0),
	}
	for i, color in ipairs(moraleColors) do
		makeSwatch(temp, 30 + (i-1)*46, 40, color, function(c)
			MORALECOLOR = c
			self.OBJECT.moraleBar:SetBackColor(MORALECOLOR)
			save()
		end)
	end

	local bl = Turbine.UI.Label()
	bl:SetParent(temp)
	bl:SetPosition(30, 76)
	bl:SetSize(100, 16)
	bl:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	bl:SetFont(SETTINGSFONTSMALL)
	bl:SetText("Bubble Bar")

	local bubbleColors = {
		Turbine.UI.Color(0.1, 0.6, 1.0),
		Turbine.UI.Color(0.0, 1.0, 1.0),
		Turbine.UI.Color(1.0, 1.0, 1.0),
		Turbine.UI.Color(1.0, 0.4, 0.8),
		Turbine.UI.Color(0.0, 1.0, 0.0),
		Turbine.UI.Color(0.6, 0.0, 1.0),
	}
	for i, color in ipairs(bubbleColors) do
		makeSwatch(temp, 30 + (i-1)*46, 94, color, function(c)
			BUBBLECOLOR = c
			self.OBJECT.bubbleBar:SetBackColor(BUBBLECOLOR)
			self.OBJECT.bubbleValue:SetForeColor(BUBBLECOLOR)
			save()
		end)
	end

	return temp

end

function Options:BuildPositionControl()

	local temp = Turbine.UI.Control()
	temp:SetParent(self)
	temp:SetSize(600, 80)

	local section = Turbine.UI.Label()
	section:SetParent(temp)
	section:SetPosition(30, 0)
	section:SetSize(200, 18)
	section:SetFont(SETTINGSFONTSMALL)
	section:SetForeColor(GOLD)
	section:SetText("POSITION")

	local ll = Turbine.UI.Label()
	ll:SetParent(temp)
	ll:SetPosition(30, 22)
	ll:SetSize(70, 16)
	ll:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
	ll:SetFont(SETTINGSFONTSMALL)
	ll:SetText("Left")

	local ltb = Turbine.UI.Lotro.TextBox()
	ltb:SetParent(temp)
	ltb:SetPosition(30, 40)
	ltb:SetSize(70, 26)
	ltb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	ltb:SetFont(SETTINGSFONT)
	ltb:SetText(LEFT)

	local tl = Turbine.UI.Label()
	tl:SetParent(temp)
	tl:SetPosition(120, 22)
	tl:SetSize(70, 16)
	tl:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
	tl:SetFont(SETTINGSFONTSMALL)
	tl:SetText("Top")

	local ttb = Turbine.UI.Lotro.TextBox()
	ttb:SetParent(temp)
	ttb:SetPosition(120, 40)
	ttb:SetSize(70, 26)
	ttb:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
	ttb:SetFont(SETTINGSFONT)
	ttb:SetText(TOP)

	local button = Turbine.UI.Lotro.Button()
	button:SetParent(temp)
	button:SetText("Apply")
	button:SetPosition(210, 43)
	button:SetSize(80, 22)

	button.Click = function()
		LEFT = math.max(0, math.min(3000, tonumber(ltb:GetText()) or LEFT))
		TOP  = math.max(0, math.min(3000, tonumber(ttb:GetText()) or TOP))
		self.OBJECT:SetPosition(LEFT, TOP)
		save()
	end

	return temp

end

function Options:BuildResetControl()

	local temp = Turbine.UI.Control()
	temp:SetParent(self)
	temp:SetSize(600, 60)

	local button = Turbine.UI.Lotro.Button()
	button:SetParent(temp)
	button:SetText("Reset to Defaults")
	button:SetPosition(30, 18)
	button:SetSize(160, 24)

	button.Click = function()
		WIDTH = 100
		HEIGHT = 30
		LEFT = 500
		TOP = 500
		TTKSPACE = 54
		SHOW_TTKSPACE = false
		MORALECOLOR = Turbine.UI.Color(1.0, 0.5, 0.0)
		BUBBLECOLOR = Turbine.UI.Color(0.1, 0.6, 1.0)
		self.OBJECT.moraleBar:SetBackColor(MORALECOLOR)
		self.OBJECT.bubbleBar:SetBackColor(BUBBLECOLOR)
		self.OBJECT.bubbleValue:SetForeColor(BUBBLECOLOR)
		self.OBJECT:Resize()
		self.OBJECT:ShowTTKSpaceChanged()
		self.OBJECT:SetPosition(LEFT, TOP)
		save()
	end

	return temp

end
