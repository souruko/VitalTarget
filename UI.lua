VITALTARGET = class ( Turbine.UI.Window )

 function VITALTARGET:Constructor()
	Turbine.UI.Window.Constructor( self )	
	
	self.TARGET = LOCALPLAYER:GetTarget()
	self.STARTMORALE = 0
	self.STARTTIME = 0
	
	self:SetSize(WIDTH+TTKSPACE, HEIGHT+4)
	self:SetPosition(LEFT, TOP)
	self:SetBackColor(Turbine.UI.Color.Black)
	self:SetMouseVisible(false)
		
--BarBackground		
	self.barBack    = Turbine.UI.Control()
	self.barBack:SetParent(self)
	self.barBack:SetPosition(TTKSPACE-2, 2)
	self.barBack:SetSize(WIDTH, HEIGHT)
	self.barBack:SetMouseVisible(false)

	
-- MoraleBar	
	self.moraleBar    = Turbine.UI.Control()
	self.moraleBar:SetParent(self.barBack)
	self.moraleBar:SetSize(WIDTH, HEIGHT)
	self.moraleBar:SetBackColor(MORALECOLOR)
	self.moraleBar:SetMouseVisible(false)
	
-- BubbleBar	
	self.bubbleBar    = Turbine.UI.Control()
	self.bubbleBar:SetParent(self.barBack)
	self.bubbleBar:SetHeight(HEIGHT)
	self.bubbleBar:SetBackColor(BUBBLECOLOR)
	self.bubbleBar:SetVisible(false)
	self.bubbleBar:SetMouseVisible(false)
	
-- Label Background	
	self.labelBack    = Turbine.UI.Window()
	self.labelBack:SetParent(self)
	self.labelBack:SetSize(WIDTH+TTKSPACE, HEIGHT+4)
	self.labelBack:SetVisible(true)
	self.labelBack:SetMouseVisible(false)
	
-- Percent Label	
	self.percentLabel = Turbine.UI.Label()
	self.percentLabel:SetParent(self.labelBack)
	self.percentLabel:SetSize(WIDTH+TTKSPACE, HEIGHT+4)
	self.percentLabel:SetLeft(TTKSPACE+5)
	self.percentLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	self.percentLabel:SetFont(FONT)
	self.percentLabel:SetFontStyle(Turbine.UI.FontStyle.Outline)
	self.percentLabel:SetMouseVisible(false)
	
-- Bubble Label	
	self.bubbleValue = Turbine.UI.Label()
	self.bubbleValue:SetParent(self.labelBack)
	self.bubbleValue:SetSize(WIDTH+TTKSPACE, HEIGHT/2+4)
	self.bubbleValue:SetTop(HEIGHT/2)
	self.bubbleValue:SetLeft(TTKSPACE+5)
	self.bubbleValue:SetForeColor(BUBBLECOLOR)
	self.bubbleValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
	self.bubbleValue:SetFont(FONT)
	self.bubbleValue:SetFontStyle(Turbine.UI.FontStyle.Outline)
	self.bubbleValue:SetMouseVisible(false)
	
	
-- TimeToKill Label	
	self.ttkLabel     = Turbine.UI.Label()
	self.ttkLabel:SetParent(self.labelBack)
	self.ttkLabel:SetSize(TTKSPACE-7, HEIGHT/2+4)
	self.ttkLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight)
	self.ttkLabel:SetFont(FONT)
	self.ttkLabel:SetMouseVisible(false)
	
-- RaidDPS Label
	self.raidDPSLabel     = Turbine.UI.Label()
	self.raidDPSLabel:SetParent(self.labelBack)
	self.raidDPSLabel:SetTop(HEIGHT/2)
	self.raidDPSLabel:SetSize(TTKSPACE-7, HEIGHT/2+4)
	self.raidDPSLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight)
	self.raidDPSLabel:SetFont(FONT)
	self.raidDPSLabel:SetMouseVisible(false)
	
-- MoveControl
	self.moveControl 	= Turbine.UI.Control()
	self.moveControl:SetParent(self)
	self.moveControl:SetWidth(self:GetWidth())
	self.moveControl:SetHeight(self:GetHeight())
	self.moveControl:SetMouseVisible(MOVE)

	self:ShowTTKSpaceChanged()
		
	LOCALPLAYER.TargetChanged = function(sender, args)
		self:UpdateWindow(LOCALPLAYER:GetTarget())
	end
	
	self.moveControl.MouseDown = function( sender, args )
		if args.Button == Turbine.UI.MouseButton.Left then
			self.dragging = true	
			self.dragStartX = args.X
			self.dragStartY = args.Y
		end
	
	end
	
	self.moveControl.MouseMove = function( sender, args )
		if self.dragging then
			local x,y = self:GetPosition()	
			x = x + ( args.X - self.dragStartX )
			y = y + ( args.Y - self.dragStartY )	
			self:SetPosition( x, y )	
		end
	end
	
	self.moveControl.MouseUp = function( sender, args )
		if args.Button == Turbine.UI.MouseButton.Left then
			self.dragging = false
			LEFT = self:GetLeft()
			TOP = self:GetTop()
			save()
		end
	end

end

function VITALTARGET:ShowTTKSpaceChanged()

	if SHOW_TTKSPACE then

		self:SetWidth(WIDTH+TTKSPACE)
		self.barBack:SetLeft(TTKSPACE-2)

		
		self.labelBack:SetWidth(WIDTH+TTKSPACE)
		self.percentLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
		self.percentLabel:SetWidth(WIDTH+TTKSPACE)
		self.percentLabel:SetLeft(TTKSPACE+5)

		self.bubbleValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
		self.bubbleValue:SetWidth(WIDTH+TTKSPACE)
		self.bubbleValue:SetLeft(TTKSPACE+5)

	else

		self:SetWidth(WIDTH+4)
		self.barBack:SetLeft(2)

		self.labelBack:SetWidth(WIDTH)
		self.percentLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
		self.percentLabel:SetWidth(WIDTH)
		self.percentLabel:SetLeft(2)

		self.bubbleValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
		self.bubbleValue:SetWidth(WIDTH)
		self.bubbleValue:SetLeft(2)

		self.ttkLabel:SetText("")
		self.raidDPSLabel:SetText("")

	end

end

function VITALTARGET:Resize()

	self:SetSize(WIDTH+TTKSPACE, HEIGHT+4)	
	self.barBack:SetSize(WIDTH, HEIGHT)	
	self.moraleBar:SetSize(WIDTH, HEIGHT)	
	self.bubbleBar:SetHeight(HEIGHT)	
	self.labelBack:SetSize(WIDTH+TTKSPACE, HEIGHT+4)	
	self.percentLabel:SetSize(WIDTH+TTKSPACE, HEIGHT+4)
	self.bubbleValue:SetSize(WIDTH+TTKSPACE, HEIGHT/2+4)
	self.ttkLabel:SetSize(TTKSPACE-7, HEIGHT/2+4)
	self.raidDPSLabel:SetSize(TTKSPACE-7, HEIGHT/2+4)
	self.moveControl:SetWidth(self:GetWidth())
	self.moveControl:SetHeight(self:GetHeight())
	self.raidDPSLabel:SetTop(HEIGHT/2)
	
end

function VITALTARGET:UpdateWindow(newTarget)

	if self.TARGET then

		RemoveCallback(self.TARGET, "MoraleChanged", MoraleChangedHandler)
		RemoveCallback(self.TARGET, "BaseMaxMoraleChanged", MoraleChangedHandler)
		RemoveCallback(self.TARGET, "MaxMoraleChanged", MoraleChangedHandler)
		RemoveCallback(self.TARGET, "MaxTemporaryMoraleChanged", TempMoraleChangedHandler)
		RemoveCallback(self.TARGET, "TemporaryMoraleChanged", TempMoraleChangedHandler)

	end

	self.TARGET = newTarget

	if self.TARGET then

		if self.TARGET.GetLevel ~= nil then   

			self:SetVisible(true)
		
			AddCallback(self.TARGET, "MoraleChanged", MoraleChangedHandler)
			AddCallback(self.TARGET, "BaseMaxMoraleChanged", MoraleChangedHandler)
			AddCallback(self.TARGET, "MaxMoraleChanged", MoraleChangedHandler)
			AddCallback(self.TARGET, "MaxTemporaryMoraleChanged", TempMoraleChangedHandler)
			AddCallback(self.TARGET, "TemporaryMoraleChanged", TempMoraleChangedHandler)
			
			ACTUALWIDTH = WIDTH
			self.STARTMORALE = self.TARGET:GetMorale()
			self.STARTTIME = Turbine.Engine:GetGameTime()
			self.bubbleBar:SetVisible(false)
			self.percentLabel:SetHeight(HEIGHT+4)
			self.bubbleValue:SetText("")
			MoraleChangedHandler(self)
		
			if self.TARGET:GetTemporaryMorale() > 0 then
				TempMoraleChangedHandler()
			end
		
		end
	else
		self:SetVisible(false)
	end

end


