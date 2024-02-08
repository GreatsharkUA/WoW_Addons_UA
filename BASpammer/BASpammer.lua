BASpammerTooltip = CreateFrame("GameTooltip", "BASpammerTooltip", nil, "GameTooltipTemplate")

BASpammerDB = {
	posx , posy, posx1, posy1,
	Tumbler = false,
	Flag = false,
	Pattern = {},
	CheckedPattern = 1,
	Channel = 1,
	Interval = 10,
	LastTimeSpam = 0,
}

local BASpammerRaidIconList = {
[1] = { text = RAID_TARGET_1, color = {r = 1.0, g = 0.92, b = 0}, icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons", tCoordLeft = 0, tCoordRight = 0.25, tCoordTop = 0, tCoordBottom = 0.25 };
[2] = { text = RAID_TARGET_2, color = {r = 0.98, g = 0.57, b = 0}, icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons", tCoordLeft = 0.25, tCoordRight = 0.5, tCoordTop = 0, tCoordBottom = 0.25 };
[3] = { text = RAID_TARGET_3, color = {r = 0.83, g = 0.22, b = 0.9}, icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons", tCoordLeft = 0.5, tCoordRight = 0.75, tCoordTop = 0, tCoordBottom = 0.25 };
[4] = { text = RAID_TARGET_4, color = {r = 0.04, g = 0.95, b = 0}, icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons", tCoordLeft = 0.75, tCoordRight = 1, tCoordTop = 0, tCoordBottom = 0.25 };
[5] = { text = RAID_TARGET_5, color = {r = 0.7, g = 0.82, b = 0.875}, icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons", tCoordLeft = 0, tCoordRight = 0.25, tCoordTop = 0.25, tCoordBottom = 0.5 };
[6] = { text = RAID_TARGET_6, color = {r = 0, g = 0.71, b = 1}, icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons", tCoordLeft = 0.25, tCoordRight = 0.5, tCoordTop = 0.25, tCoordBottom = 0.5 };
[7] = { text = RAID_TARGET_7, color = {r = 1.0, g = 0.24, b = 0.168}, icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons", tCoordLeft = 0.5, tCoordRight = 0.75, tCoordTop = 0.25, tCoordBottom = 0.5 };
[8] = { text = RAID_TARGET_8, color = {r = 0.98, g = 0.98, b = 0.98}, icon = "Interface\\TargetingFrame\\UI-RaidTargetingIcons", tCoordLeft = 0.75, tCoordRight = 1, tCoordTop = 0.25, tCoordBottom = 0.5 };
}

function BASpammer_FillTable()
	for i=1,10 do
		BASpammerDB.Pattern[i] = "Пусто"
	end
	BASpammerDB.CheckedPattern = 1
	BASpammerDB.Channel = 1
	BASpammerDB.Interval = 10
	BASpammerDB.Tumbler = false
	BASpammerDB.Flag = true
	BASpammerDB.LastTimeSpam = 0
end

function BASpammer_SetText()
	if BASpammerDB.Tumbler == false then
		BASpammerText:SetText("BASpammer |cffff0000Off|r")
	else
		BASpammerText:SetText("BASpammer |cff00ff00On|r")
	end	
end

function BASpammer:OnMouseDown(self, arg1)
	if BASpammerDB.Flag == false then
		BASpammer_FillTable()
	end
	BASpammerSettingTextPatternEditBox:SetText("Шаблон " .. tostring(BASpammerDB.CheckedPattern))
	BASpammerSettingTextBox:SetText(BASpammerDB.Pattern[BASpammerDB.CheckedPattern])
	BASpammerSettingIntervalEditBox:SetText(tostring(BASpammerDB.Interval))
	BASpammerSettingChanelEditBox:SetText("Канал " .. BASpammerDB.Channel)
	if ( arg1 == "RightButton" ) then  
		if BASpammerSetting:IsShown() then
			BASpammerSetting:Hide()
		else
			BASpammerSetting:Show()
		end		
	end
end

local function BASpammer_GetCursorScaledPosition()
	local scale, x, y = UIParent:GetScale(), GetCursorPosition()
	return x / scale, y / scale
end

function BASpammerSettingTextBox_OnMouseDown(self,arg1)
	if ( arg1 == "RightButton" ) then
		local x,y = BASpammer_GetCursorScaledPosition()
		ToggleDropDownMenu(1, nil, BASpammerMarkersDropdown, "UIParent", x, y)
	end
end

function BASpammerSettingChanelButton_OnClick()
	ToggleDropDownMenu(1, nil, BASpammerChannelsDropdown, "BASpammerSettingChanelButton", 0, 0)
end

function BASpammerSettingTextPatternButton_OnClick()
	ToggleDropDownMenu(1, nil, TextPatternDropdown, "BASpammerSettingTextPatternButton", 0, 0)
end

local IntervalRandom

function BASpammer:OnUpdate() -- собственно сам спам!
	if BASpammerDB.Tumbler then
		if time() - BASpammerDB.LastTimeSpam >= tonumber(IntervalRandom) then
			if BASpammerDB.Pattern[BASpammerDB.CheckedPattern] ~= "" then
				SendChatMessage(BASpammerDB.Pattern[BASpammerDB.CheckedPattern], "CHANNEL", nil, BASpammerDB.Channel);
			end
			BASpammerDB.LastTimeSpam = time();
			if time() % 2 ~= 0 then
				IntervalRandom = BASpammerDB.Interval + math.random(2)
			else
				IntervalRandom = BASpammerDB.Interval - math.random(2)
			end
			
		end
		BASpammerSettingTaximeterText:SetText(tostring(tonumber(IntervalRandom) - (time()-BASpammerDB.LastTimeSpam)))
	end
end


function BASpammer:SavePosition(argpos)
	if argpos == 1 then
		local Left = BASpammer:GetLeft()
		local Top = BASpammer:GetTop()
		if Left and Top then
			BASpammerDB.posx = Left
			BASpammerDB.posy = Top
		end
	end
	if argpos == 2 then
		local Left = BASpammerSetting:GetLeft()
		local Top = BASpammerSetting:GetTop()
		if Left and Top then
			BASpammerDB.posx1 = Left
			BASpammerDB.posy1 = Top
		end
	end
end

local info = {}

function TextPattern_OnClick(arg1)
	BASpammerSettingTextPatternEditBox:SetText("Шаблон " .. tostring(arg1))
	BASpammerSettingTextBox:SetText(BASpammerDB.Pattern[arg1])
	BASpammerDB.CheckedPattern = arg1
end

function BASpammerChannelsDropdown_OnClick(arg1)
	BASpammerSettingChanelEditBox:SetText("Канал " .. arg1)
	BASpammerDB.Channel = arg1
end

local BASpammerChannelsDropdown = CreateFrame("Frame", "BASpammerChannelsDropdown");
BASpammerChannelsDropdown.displayMode = "MENU"
BASpammerChannelsDropdown.point = "TOPRIGHT"
BASpammerChannelsDropdown.relativePoint = "BOTTOMRIGHT"
BASpammerChannelsDropdown.relativeTo = "BASpammerSettingChanelButton"
BASpammerChannelsDropdown.initialize = function(self, level)
	if not level then return end
	wipe(info)
	local channels = { GetChannelList() }
	local chan = {}
	local j = 0
	for key,name in ipairs(channels) do
		if key % 2 ~= 0 then
			j = j + 1
			chan[j] = name
		else
			chan[j] = chan[j] .. ". " .. name
		end
	end
	for key, name in ipairs(chan) do
		info.text = name
		info.arg1 = string.sub(name, 1, 1)
		info.func = function(self, arg1, arg2, checked)
			CloseDropDownMenus()
			BASpammerChannelsDropdown_OnClick(arg1)
		end;
		UIDropDownMenu_AddButton(info);
	end
	info.text = CLOSE
	info.func = function() CloseDropDownMenus() end
	UIDropDownMenu_AddButton(info)
end

local TextPatternDropdown = CreateFrame("Frame", "TextPatternDropdown");
TextPatternDropdown.displayMode = "MENU"
TextPatternDropdown.point = "TOPRIGHT"
TextPatternDropdown.relativePoint = "BOTTOMRIGHT"
TextPatternDropdown.relativeTo = "BASpammerSettingTextPatternButton"
TextPatternDropdown.initialize = function(self, level)
	if not level then return end
	wipe(info)
	for i =1,10 do
		info.text = "Шаблон" .. i
		info.arg1 = i
		info.func = function(self, arg1, arg2, checked)
			CloseDropDownMenus()
			TextPattern_OnClick(arg1)
		end
		info.tooltipTitle = tostring("Шаблон " .. i)
		info.tooltipText = BASpammerDB.Pattern[i]
		UIDropDownMenu_AddButton(info);
	end
	info.text = CLOSE
	info.func = function() CloseDropDownMenus() end
	UIDropDownMenu_AddButton(info)
end

function BASpammerMarkersDropdown_OnClick(arg1)
	BASpammerSettingTextBox:Insert("{rt"..arg1.."}")
end

local BASpammerMarkersDropdown = CreateFrame("Frame", "BASpammerMarkersDropdown");
BASpammerMarkersDropdown.displayMode = "MENU"
BASpammerMarkersDropdown.initialize = function(self, level)
	if not level then return end
	local color
	wipe(info)
	for i = 1,8 do
		info = UIDropDownMenu_CreateInfo()
		info.text = BASpammerRaidIconList[i].text
		color = BASpammerRaidIconList[i].color
		info.colorCode = string.format("|cFF%02x%02x%02x", color.r*255, color.g*255, color.b*255)
		info.icon = BASpammerRaidIconList[i].icon
		info.tCoordLeft = BASpammerRaidIconList[i].tCoordLeft
		info.tCoordRight = BASpammerRaidIconList[i].tCoordRight
		info.tCoordTop = BASpammerRaidIconList[i].tCoordTop
		info.tCoordBottom = BASpammerRaidIconList[i].tCoordBottom
		info.arg1 = i
		info.func = function(self, arg1, arg2, checked)
			CloseDropDownMenus()
			BASpammerMarkersDropdown_OnClick(arg1)
		end
		UIDropDownMenu_AddButton(info)
	end
	info = UIDropDownMenu_CreateInfo()
	info.text = CLOSE
	info.func = function() CloseDropDownMenus() end
	UIDropDownMenu_AddButton(info)
end

function BASpammer:SetupFrames()
	if BASpammerDB.posx ~= nil and BASpammerDB.posy ~= nil then
		BASpammer:ClearAllPoints()
		BASpammer:SetPoint("TOPLEFT","UIParent", "BOTTOMLEFT", BASpammerDB.posx, BASpammerDB.posy)
	end
	if BASpammerDB.posx1 ~= nil and BASpammerDB.posy1 ~= nil then
		BASpammerSetting:ClearAllPoints()
		BASpammerSetting:SetPoint("TOPLEFT","UIParent", "BOTTOMLEFT", BASpammerDB.posx1, BASpammerDB.posy1)
	end
	BASpammerSettingTaximeter:Hide()
	BASpammerSettingStoptButton:Disable()
end

function BASpammerSettingTextBox_OnTextChanged()
	BASpammerDB.Pattern[BASpammerDB.CheckedPattern] = BASpammerSettingTextBox:GetText()
	if strlen(BASpammerDB.Pattern[BASpammerDB.CheckedPattern]) > 255 then
		BASpammerSettingTextBox:SetText(string.sub(BASpammerDB.Pattern[BASpammerDB.CheckedPattern],1,255))
	end
	BASpammerSettingTextSymbols:SetText("Символи: " .. tostring(strlen(BASpammerDB.Pattern[BASpammerDB.CheckedPattern])).."/255")	
end

function BASpammerSettingTextBox_OnEnterPressed()
	BASpammerSettingTextBox:Insert(" ")
end

function BASpammerSettingTextBox_OnTabPressed()
	BASpammerSettingTextBox:Insert("    ")
end

function BASpammer_OnEvent(BASpammer_self, BASpammer_event, BASpammer_arg1, ...)
	if( BASpammer_event == "ADDON_LOADED" and BASpammer_arg1 == "BASpammer") then
		print("Аддон " .. BASpammer_arg1 .. " завантажений.");
		BASpammer:SetupFrames()
	end
	if ( BASpammer_event == "VARIABLES_LOADED" ) then
		if BASpammerDB == nil then 
  		   BASpammerDB.Flag = false
		end
		BASpammerDB.Tumbler = false
		BASpammerDB.LastTimeSpam = 0
		BASpammer_SetText()
	end
end

BASpammer:SetScript("OnEvent", BASpammer_OnEvent);
BASpammer:RegisterEvent("ADDON_LOADED");
BASpammer:RegisterEvent("VARIABLES_LOADED");

function BASpammerSettingIntervalEditBox_OnChar(self,txt)
	local  indexByte = string.byte(txt)
	local  indexByteCheck = false
	for i = 48,57 do
		if indexByte == i then
			indexByteCheck = true
			break
		end
	end
	if indexByteCheck == false then
		local txt1 = BASpammerSettingIntervalEditBox:GetText()
		local length = string.len(txt1)
		local j = 0
		for i = 1,length do
			indexByte = string.byte(txt1, i)
			for i = 48,57 do
				if indexByte == i then
					j=j+1
				end
			end
		end
		if j < 4 then
			if length == 1 then BASpammerSettingIntervalEditBox:SetText("")
			else
				local txt2 = string.sub(txt1, 1 , length-1)
				BASpammerSettingIntervalEditBox:SetText(txt2)
			end		
		end
	end
end

function BASpammerSettingIntervalEditBox_OnTextChanged()
	BASpammerDB.Interval = BASpammerSettingIntervalEditBox:GetNumber()
	IntervalRandom = BASpammerDB.Interval
end

function BASpammerSettingStartButton_OnClick()
	if BASpammerDB.Interval < 10 then
		BASpammerDB.Interval = 10
		BASpammerSettingIntervalEditBox:SetText("10")
	end
	BASpammerDB.Tumbler = true
	BASpammer_SetText()
	BASpammerSettingStartButton:Disable()
	BASpammerSettingChanelButton:Disable()
	BASpammerSettingTextPatternButton:Disable()
	BASpammerSettingText:Hide()
	BASpammerSettingInterval:Hide()
	BASpammerSettingTaximeter:Show()
	BASpammerSettingStoptButton:Enable()
end

function BASpammerSettingStopButton_OnClick()
	BASpammerDB.Tumbler = false
	BASpammer_SetText()
	BASpammerSettingStartButton:Enable()
	BASpammerSettingChanelButton:Enable()
	BASpammerSettingTextPatternButton:Enable()
	BASpammerSettingTaximeter:Hide()
	BASpammerSettingText:Show()
	BASpammerSettingInterval:Show()	
	BASpammerSettingStoptButton:Disable()	
end

function BASpammerGetLink(lnk)
	if BASpammerSettingTextBox:HasFocus() then
		BASpammerSettingTextBox:Insert(lnk)
	else
		ChatEdit_InsertLink_Default(lnk)
	end
end

ChatEdit_InsertLink_Default=ChatEdit_InsertLink
ChatEdit_InsertLink=BASpammerGetLink

function BASpammer:OnEnter()
	if BASpammerDB.Tumbler then
		GameTooltip_SetDefaultAnchor(BASpammerTooltip,BASpammer)
		BASpammerTooltip:ClearLines()
		BASpammerTooltip:SetHyperlink("|cff9d9d9d|Hitem::0:0:0:0:0:0:0:0|h[]|h|r")
		BASpammerTooltip:AddLine("Йде спам!",0.77, 0.12, 0.23)
		BASpammerTooltip:AddLine("Канал: " .. "|cffffffff" .. tostring(BASpammerDB.Channel) .."|r")
		BASpammerTooltip:AddLine("Інтервал: " .. "|cffffffff" .. tostring(BASpammerDB.Interval) .." сек|r")
		BASpammerTooltip:AddLine("Текст:")
		BASpammerTooltip:AddLine(BASpammerDB.Pattern[BASpammerDB.CheckedPattern], 1, 1, 1, "true")
		BASpammerTooltip:Show()
	end
end

function BASpammer:OnLeave()
	BASpammerTooltip:Hide()
end
