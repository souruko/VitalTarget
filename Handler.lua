-- ------------------------------------------------------------------------
-- Callbacks
-- ------------------------------------------------------------------------
function AddCallback(object, event, callback)
    if (object[event] == nil) then
        object[event] = callback;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], callback);
        else
            object[event] = {object[event], callback};
        end
    end
    return callback;
end

function RemoveCallback(object, event, callback)
    if (object[event] == callback) then
        object[event] = nil;
    else
        if (type(object[event]) == "table") then
            local size = table.getn(object[event]);
            for i = 1, size do
                if (object[event][i] == callback) then
                    table.remove(object[event], i);
                    break;
                end
            end
        end
    end
end

-- ------------------------------------------------------------------------
-- Morale Change Handler
-- ------------------------------------------------------------------------
function MoraleChangedHandler(sender, args)
    local CurrentFrame = OBJECT
	
    if not CurrentFrame.TARGET then
        return
    end
       
    local TargetMorale = CurrentFrame.TARGET:GetMorale()	
    local TargetMaxMorale = CurrentFrame.TARGET:GetMaxMorale()
	
	if CurrentFrame.STARTMORALE == 0 and TargetMorale > 0 then
		CurrentFrame.STARTMORALE = TargetMorale
		CurrentFrame.STARTTIME = Turbine.Engine:GetGameTime()
	end

    if TargetMorale <= 1 then
        CurrentFrame.percentLabel:SetText(string.format("0.0%%"))
    else
        CurrentFrame.percentLabel:SetText(string.format("%.1f", 100 * TargetMorale / TargetMaxMorale).."%")
    end
	
    local BarSize = math.floor(TargetMorale/TargetMaxMorale * ACTUALWIDTH)
    CurrentFrame.moraleBar:SetWidth(BarSize)
    if REVERSE_BAR then
        CurrentFrame.moraleBar:SetLeft(ACTUALWIDTH - BarSize)
    else
        CurrentFrame.moraleBar:SetLeft(0)
    end

    if SHOW_TTKSPACE then

        local elapsed = Turbine.Engine:GetGameTime()

        if CurrentFrame.STARTMORALE ~= TargetMorale then
            local timetokill = TargetMorale*(elapsed-CurrentFrame.STARTTIME)/(CurrentFrame.STARTMORALE-TargetMorale)

            if timetokill > 0 and timetokill < 6000 then
                local minu = math.floor(timetokill/60)
                local seco = math.floor(timetokill % 60)

                local dps = math.floor((CurrentFrame.STARTMORALE-TargetMorale)/(elapsed-CurrentFrame.STARTTIME)/1000)
                CurrentFrame.raidDPSLabel:SetText(dps.."k")
                CurrentFrame.ttkLabel:SetText(string.format("%02d:%02d",  minu, seco))
            else
                CurrentFrame.ttkLabel:SetText("--")
                CurrentFrame.raidDPSLabel:SetText("--")
            end
        else
            CurrentFrame.ttkLabel:SetText("--")
            CurrentFrame.raidDPSLabel:SetText("--")
        end

    end
end

function TempMoraleChangedHandler(sender, args)

    local CurrentFrame = OBJECT
	
	if not CurrentFrame.TARGET then
        return
    end
	
	local TargetTempMorale = CurrentFrame.TARGET:GetTemporaryMorale()
	
	local TargetMaxMorale = CurrentFrame.TARGET:GetMaxMorale()
	local TargetMorale = CurrentFrame.TARGET:GetMorale()
	
	if TargetTempMorale ~= 0 then
		
		local TargetMaxTempMorale = CurrentFrame.TARGET:GetMaxTemporaryMorale()
		
	
		CurrentFrame.percentLabel:SetHeight(HEIGHT/2+4)
		CurrentFrame.bubbleValue:SetText(math.floor(TargetTempMorale))
		
		ACTUALWIDTH = math.floor(WIDTH*(1-(TargetMaxTempMorale/TargetMaxMorale)))
		
		
		local mBarWidth = TargetMorale/TargetMaxMorale * ACTUALWIDTH
		local bBarWidth = (WIDTH-ACTUALWIDTH)*(TargetTempMorale/TargetMaxTempMorale)
		if REVERSE_BAR then
			CurrentFrame.moraleBar:SetWidth(mBarWidth)
			CurrentFrame.moraleBar:SetLeft(ACTUALWIDTH - mBarWidth)
			CurrentFrame.bubbleBar:SetLeft(0)
			CurrentFrame.bubbleBar:SetWidth(bBarWidth)
		else
			CurrentFrame.moraleBar:SetWidth(mBarWidth)
			CurrentFrame.moraleBar:SetLeft(0)
			CurrentFrame.bubbleBar:SetLeft(ACTUALWIDTH)
			CurrentFrame.bubbleBar:SetWidth(bBarWidth)
		end
		CurrentFrame.bubbleBar:SetVisible(true)
		
	else
		local BarSize = math.floor(TargetMorale/TargetMaxMorale * ACTUALWIDTH)
		CurrentFrame.moraleBar:SetWidth(BarSize)
		if REVERSE_BAR then
			CurrentFrame.moraleBar:SetLeft(ACTUALWIDTH - BarSize)
		else
			CurrentFrame.moraleBar:SetLeft(0)
		end

		CurrentFrame.bubbleBar:SetVisible(false)
		CurrentFrame.percentLabel:SetHeight(HEIGHT+4)
		CurrentFrame.bubbleValue:SetText("")
				
		ACTUALWIDTH = WIDTH
	end

end