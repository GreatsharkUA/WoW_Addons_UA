local _G = _G
local ipairs = ipairs
local hooksecurefunc = hooksecurefunc

local MovAny = _G.MovAny
local MOVANY = _G.MOVANY

local cats = {
	{name = "Досягнення та Завдання"},
	{name = "Арена"},
	{name = "Blizzard: Базові Панелі"},
	{name = "Blizzard: Панель сумок"},
	{name = "Blizzard: Банк"},
	{name = "Blizzard: Нижня панель"},
	{name = "Поля битви & PvP"},
	{name = "Класові панелі"},
	{name = "Підземелля & Рейд"},
	{name = "Головне меню"},
	{name = "Гільдія"},
	{name = "Інформаційні панелі"},
	{name = "Здобич"},
	{name = "Міні карта"},
	{name = "Різне"},
	{name = "MoveAnything"},
	{name = "Unit: Фокус"},
	{name = "Unit: Група"},
	{name = "Unit: Пет"},
	{name = "Unit: Гравець"},
	{name = "Unit: Таргет"},
	{name = "Транспортний засіб"},
    {name = "Інші Аддони"},
}

local API

local NEW_ICON = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|t"

local m = {
	Enable = function(self)
		API = MovAny.API
		self:LoadList()
		MovAny:DeleteModule(self)
		API = nil
		--m = nil
	end,
	LoadList = function(self)
		API.default = true
		for i, c in ipairs(cats) do
			API:AddCategory(c)
		end
		cats = nil
		local c, e
		c = API:GetCategory("Досягнення та Завдання")
		API:AddElement({name = "AchievementFrame", displayName = "Досягнення"}, c)
		API:AddElement({name = "AchievementAlertFrame1", displayName = "Повідомлення про Досягнення 1", runOnce = AchievementFrame_LoadUI, create = "AchievementAlertFrameTemplate"}, c)
		API:AddElement({name = "AchievementAlertFrame2", displayName = "Повідомлення про Досягнення 2", runOnce = AchievementFrame_LoadUI, create = "AchievementAlertFrameTemplate"}, c)
		API:AddElement({name = "WatchFrame", displayName = "Завдання",scaleWH = 1}, c)
		API:AddElement({name = "QuestLogDetailFrame", displayName = "Деталі завдань", runOnce = function()
			if not QuestLogDetailFrame:IsShown() then
				ShowUIPanel(QuestLogDetailFrame)
				HideUIPanel(QuestLogDetailFrame)
			end
		end}, c)
		API:AddElement({name = "QuestLogFrame", displayName = "Журнал завдань"}, c)
		API:AddElement({name = "QuestTimerFrame", displayName = "Таймер завдань"}, c)
		
		c = API:GetCategory("Арена")
		API:AddElement({name = "ArenaEnemyFrame1", displayName = "Арена Ворог 1", create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame2", displayName = "Арена Ворог 2", create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame3", displayName = "Арена Ворог 3", create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame4", displayName = "Арена Ворог 4", create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame5", displayName = "Арена Ворог 5", create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "PVPTeamDetails", displayName = "Інформація про команду Арени"}, c)
		API:AddElement({name = "ArenaFrame", displayName = "Список черги арени"}, c)
		API:AddElement({name = "ArenaRegistrarFrame", displayName = "Реєстратор Арени"}, c)
		API:AddElement({name = "PVPBannerFrame", displayName = "Банер арени"}, c)
		
		c = API:GetCategory("Поля битви & PvP")
		API:AddElement({name = "PVPFrame", displayName = "PVP Вікно"}, c)
		API:AddElement({name = "BattlefieldMinimap", displayName = "Міні карта Поля битви"}, c)
		API:AddElement({name = "MiniMapBattlefieldFrame", displayName = "Кнопка поля битви"}, c)
		API:AddElement({name = "BattlefieldFrame", displayName = "Черга на поле битви"}, c)
		API:AddElement({name = "WorldStateScoreFrame", displayName = "Оцінка поля битви"}, c)
		API:AddElement({name = "WorldStateCaptureBar1", displayName = "Позначити панель таймера захоплення", onlyOnceCreated = 1}, c)
        API:AddElement({name = "WorldStateAlwaysUpFrame", displayName = "Верхній центральний дисплей стану", noUnanchorRelatives = 1}, c)
		API:AddElement({name = "AlwaysUpFrame1", displayName = "Завжди вгору Фрейм 1", create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c) 
		API:AddElement({name = "AlwaysUpFrame2", displayName = "Завжди вгору Фрейм 2", create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c)
		API:AddElement({name = "AlwaysUpFrame3", displayName = "Завжди вгору Фрейм 3", create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c)

		c = API:GetCategory("Blizzard: Панель сумок")
		API:AddElement({name = "BagButtonsMover", displayName = "Панель сумок"}, c)
		API:AddElement({name = "BagButtonsVerticalMover", displayName = "Панель сумок - Вертикальна"}, c)
		API:AddElement({name = "BagFrame1", displayName = "Ранець"}, c)
		API:AddElement({name = "BagFrame2", displayName = "Сумка 1"}, c)
		API:AddElement({name = "BagFrame3", displayName = "Сумка 2"}, c)
		API:AddElement({name = "BagFrame4", displayName = "Сумка 3"}, c)
		API:AddElement({name = "BagFrame5", displayName = "Сумка 4"}, c)
		API:AddElement({name = "KeyRingFrame", displayName = "Ключі"}, c)
		API:AddElement({name = "MainMenuBarBackpackButton", displayName = "Кнопка для рюкзака"}, c)
		API:AddElement({name = "CharacterBag0Slot", displayName = "Кнопка сумки 1"}, c)
		API:AddElement({name = "CharacterBag1Slot", displayName = "Кнопка сумки 2"}, c)
		API:AddElement({name = "CharacterBag2Slot", displayName = "Кнопка сумки 3"}, c)
		API:AddElement({name = "CharacterBag3Slot", displayName = "Кнопка сумки 4"}, c)
		API:AddElement({name = "KeyRingButton", displayName = "Кнопка Ключі"}, c)
		
		c = API:GetCategory("Blizzard: Базові Панелі")
		API:AddElement({name = "BasicActionButtonsMover", displayName = "Активна Панель", linkedScaling = {"ActionBarDownButton", "ActionBarUpButton"}}, c)
		API:AddElement({name = "BasicActionButtonsVerticalMover", displayName = "Активна Панель - Вертикальна"}, c)
		API:AddElement({name = "MultiBarBottomLeft", displayName = "Верхня Ліва Активна Панель"}, c)
		API:AddElement({name = "MultiBarBottomRight", displayName = "Верхня Права Активна Панель"}, c)
		API:AddElement({name = "MultiBarRight", displayName = "Права Активна Панель 1", run = function()
			if MovAny:IsModified("MultiBarRightHorizontalMover") then
				MovAny:ResetFrame("MultiBarRightHorizontalMover")
			end
		end}, c)
		API:AddElement({name = "MultiBarRightHorizontalMover", displayName = "Права Активна Панель 1 - Горизонтальна"}, c)
		API:AddElement({name = "MultiBarLeft", displayName = "Права Активна Панель 2", run = function()
			if MovAny:IsModified("MultiBarLeftHorizontalMover") then
				MovAny:ResetFrame("MultiBarLeftHorizontalMover")
			end
		end}, c)
		API:AddElement({name = "MultiBarLeftHorizontalMover", displayName = "Права Активна Панель 2 - Горизонтальна"}, c)
		API:AddElement({name = "MainMenuBarPageNumber", displayName = "Номер Активної Панелі"}, c)
		API:AddElement({name = "ActionBarUpButton", displayName = "Активна Панель наступна"}, c)
		API:AddElement({name = "ActionBarDownButton", displayName = "Активна Панель попередня"}, c)
		API:AddElement({name = "PetActionButtonsMover", displayName = "Активна Панель пета"}, c)
		API:AddElement({name = "PetActionButtonsVerticalMover", displayName = "Активна Панель пета - Вертикальна"}, c)
--		API:AddElement({name = "SlidingActionBarTexture0", displayName = "Pet Action Bar Texture 0"}, c) пусті фрейми
--		API:AddElement({name = "SlidingActionBarTexture1", displayName = "Pet Action Bar Texture 1"}, c) пусті фрейми
		API:AddElement({name = "ShapeshiftButtonsMover", displayName = "Стойка / Аура / Зміна форми", onlyOnceCreated = nil}, c)
		API:AddElement({name = "ShapeshiftButtonsVerticalMover", displayName = "Стойка / Аура / Зміна форми - Вертикальна", onlyOnceCreated = nil}, c)

		c = API:GetCategory("Blizzard: Банк")
        API:AddElement({name = "BankFrame", displayName = "Банк"}, c)
		API:AddElement({name = "BankBagFrame1", displayName = "Сумка банку 1", refuseSync = MOVANY.FRAME_ONLY_WHEN_BANK_IS_OPEN}, c)
		API:AddElement({name = "BankBagFrame2", displayName = "Сумка банку 2", refuseSync = MOVANY.FRAME_ONLY_WHEN_BANK_IS_OPEN}, c)
		API:AddElement({name = "BankBagFrame3", displayName = "Сумка банку 3", refuseSync = MOVANY.FRAME_ONLY_WHEN_BANK_IS_OPEN}, c)
		API:AddElement({name = "BankBagFrame4", displayName = "Сумка банку 4", refuseSync = MOVANY.FRAME_ONLY_WHEN_BANK_IS_OPEN}, c)
		API:AddElement({name = "BankBagFrame5", displayName = "Сумка банку 5", refuseSync = MOVANY.FRAME_ONLY_WHEN_BANK_IS_OPEN}, c)
		API:AddElement({name = "BankBagFrame6", displayName = "Сумка банку 6", refuseSync = MOVANY.FRAME_ONLY_WHEN_BANK_IS_OPEN}, c)
		API:AddElement({name = "BankBagFrame7", displayName = "Сумка банку 7", refuseSync = MOVANY.FRAME_ONLY_WHEN_BANK_IS_OPEN}, c)

		c = API:GetCategory("Blizzard: Нижня панель")
		API:AddElement({name = "MainMenuBar", displayName = "Основна панель", run = function ()
			if not MovAny:IsModified(VehicleMenuBar, pos) then
				local v = _G["VehicleMenuBar"]
				v:ClearAllPoints()
				v:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", (UIParentGetWidth() / 2) - (v:GetWidth() / 2), 0)
			end
		end, hideList = {
			{"MainMenuBarArtFrame", "BACKGROUND","ARTWORK"},
			{"PetActionBarFrame", "OVERLAY"},
			{"ShapeshiftBarFrame", "OVERLAY"},
			{"MainMenuBar", "DISABLEMOUSE"},
			{"BonusActionBarFrame", "OVERLAY", "DISABLEMOUSE"},
			}
		}, c)
		API:AddElement({name = "MainMenuBarLeftEndCap", displayName = "Лівий Гріфон"}, c)
		API:AddElement({name = "MainMenuBarRightEndCap", displayName = "Правий Гріфон"}, c)
		API:AddElement({name = "MainMenuExpBar", displayName = "Панель досвіду", scaleWH = 1, hideOnScale = {
			MainMenuXPBarTexture0,
			MainMenuXPBarTexture1,
			MainMenuXPBarTexture2,
			MainMenuXPBarTexture3,
			ExhaustionTick,
			ExhaustionTickNormal,
			ExhaustionTickHighlight,
			ExhaustionLevelFillBar,
			MainMenuXPBarTextureLeftCap,
			MainMenuXPBarTextureRightCap,
			MainMenuXPBarTextureMid,
			MainMenuXPBarDiv1,
			MainMenuXPBarDiv2,
			MainMenuXPBarDiv3,
			MainMenuXPBarDiv4,
			MainMenuXPBarDiv5,
			MainMenuXPBarDiv6,
			MainMenuXPBarDiv7,
			MainMenuXPBarDiv8,
			MainMenuXPBarDiv9,
			MainMenuXPBarDiv10,
			MainMenuXPBarDiv11,
			MainMenuXPBarDiv12,
			MainMenuXPBarDiv13,
			MainMenuXPBarDiv14,
			MainMenuXPBarDiv15,
			MainMenuXPBarDiv16,
			MainMenuXPBarDiv17,
			MainMenuXPBarDiv18,
			MainMenuXPBarDiv19,
			}
		}, c)
		API:AddElement({name = "MainMenuBarMaxLevelBar", displayName = "Наповнювач барів максимального рівня", noFE = 1, noScale = 1}, c)
		API:AddElement({name = "ReputationWatchBar", displayName = "Панель репутації", runOnce = function()
			if ReputationWatchBar_Update then
				hooksecurefunc("ReputationWatchBar_Update", MovAny.hReputationWatchBar_Update)
			end
		end, scaleWH = 1, linkedScaling = {"ReputationWatchStatusBar"}, hideOnScale = {
			ReputationWatchBarTexture0,
			ReputationWatchBarTexture1,
			ReputationWatchBarTexture2,
			ReputationWatchBarTexture3,
			ReputationXPBarTexture0,
			ReputationXPBarTexture1,
			ReputationXPBarTexture2,
			ReputationXPBarTexture3,
			}
		}, c)
		API:AddElement({name = "MicroButtonsMover", displayName = "Мікро меню"}, c)
		API:AddElement({name = "MicroButtonsVerticalMover", displayName = "Мікро меню - Вертикальна"}, c)
		API:AddElement({name = "MainMenuBarVehicleLeaveButton", displayName = "Кнопка покинути транспортний засіб"}, c)

		c = API:GetCategory("Класові панелі")
		API:AddElement({name = "RuneFrame", displayName = "Руни рицаря смерті"}, c)
		API:AddElement({name = "MultiCastActionBarFrame", displayName = "Панель Тотемів Шамана"}, c)
		API:AddElement({name = "TotemFrame", displayName = "Таймер тотемів шамана"}, c)
		
		c = API:GetCategory("Підземелля & Рейд")
		API:AddElement({name = "LFDParentFrame", displayName = "Пошук підземелля"}, c)
		API:AddElement({name = "DungeonCompletionAlertFrame1", displayName = "Сповіщення про завершення підземелля"}, c)
		API:AddElement({name = "LFDSearchStatus", displayName = "Спливаюча підказка про статус пошуку підземелля", run = function()
			local opt = MovAny:GetUserData("LFDSearchStatus")
			if not opt or not opt.frameStrata then
				LFDSearchStatus:SetFrameStrata(TOOLTIP)
			end
		 end}, c)
		API:AddElement({name = "LFDDungeonReadyDialog", displayName = "Діалог готовності до підземелля"}, c)
		API:AddElement({name = "LFDDungeonReadyPopup", displayName = "Спливне вікно, готове до підземелля"}, c)
		API:AddElement({name = "LFDDungeonReadyStatus", displayName = "Статус готовності до підземелля"}, c)
		API:AddElement({name = "LFDRoleCheckPopup", displayName = "Спливне вікно перевірки ролі до підземелля"}, c)
		API:AddElement({name = "RaidBossEmoteFrame", displayName = "Емоції Босса"}, c)
		API:AddElement({name = "Boss1TargetFrame", displayName = "Панель здоров'я Босса 1"}, c)
		API:AddElement({name = "Boss2TargetFrame", displayName = "Панель здоров'я Босса 2"}, c)
		API:AddElement({name = "Boss3TargetFrame", displayName = "Панель здоров'я Босса 3"}, c)
		API:AddElement({name = "Boss4TargetFrame", displayName = "Панель здоров'я Босса 4"}, c)
		API:AddElement({name = "LFRParentFrame", displayName = "Список Рейдів"}, c)
		API:AddElement({name = "CompactRaidFrameBuffTooltipsMover", displayName = "Підказки Рейд фрейм бафа"}, c)
		API:AddElement({name = "CompactRaidFrameDebuffTooltipsMover", displayName = "Підказки Рейд фрейм дебафа"}, c)
		API:AddElement({name = "RaidUnitFramesMover", displayName = "Рейдова рамка"}, c)
		API:AddElement({name = "RaidPullout1", displayName = "Рейд група 1"}, c)
		API:AddElement({name = "RaidPullout2", displayName = "Рейд група 2"}, c)
		API:AddElement({name = "RaidPullout3", displayName = "Рейд група 3"}, c)
		API:AddElement({name = "RaidPullout4", displayName = "Рейд група 4"}, c)
		API:AddElement({name = "RaidPullout5", displayName = "Рейд група 5"}, c)
		API:AddElement({name = "RaidPullout6", displayName = "Рейд група 6"}, c)
		API:AddElement({name = "RaidPullout7", displayName = "Рейд група 7"}, c)
		API:AddElement({name = "RaidPullout8", displayName = "Рейд група 8"}, c)
		API:AddElement({name = "RaidWarningFrame", displayName = "Оголошення рейду /RW"}, c)
		API:AddElement({name = "ReadyCheckFrame", displayName = "Перевірка на готовність"}, c)
		
		c = API:GetCategory("Головне меню")
		API:AddElement({name = "GameMenuFrame", displayName = "Налаштування",
			hideList = {
				{"GameMenuFrame", "BACKGROUND","ARTWORK","BORDER"},
			}
		}, c)
		API:AddElement({name = "VideoOptionsFrame", displayName = "Зображення", runOnce = function()
				hooksecurefunc(VideoOptionsFrame, "Show", function()
					if MovAny:IsModified("VideoOptionsFrame") then
						HideUIPanel(GameMenuFrame)
					end
				end)
			end, positionReset = function(self, f, opt, readOnly)
		end}, c)
		API:AddElement({name = "AudioOptionsFrame", displayName = "Звуки", runOnce = function()
			hooksecurefunc(AudioOptionsFrame, "Show", function()
				if MovAny:IsModified("AudioOptionsFrame") then
					HideUIPanel(GameMenuFrame)
				end
			end)
		end}, c)
		API:AddElement({name = "InterfaceOptionsFrame", displayName = "Інтерфейс", runOnce = function()
			hooksecurefunc(InterfaceOptionsFrame, "Show", function()
				if MovAny:IsModified("InterfaceOptionsFrame") then
					HideUIPanel(GameMenuFrame)
				end
			end)
		end}, c)
		API:AddElement({name = "KeyBindingFrame", displayName = "Призначення клавіш"}, c)

		c = API:GetCategory("Гільдія")
		API:AddElement({name = "GuildBankFrame", displayName = "Банк Гільдії"}, c)
		API:AddElement({name = "GuildControlPopupFrame", displayName = "Керування гільдіею"}, c)
		API:AddElement({name = "GuildInfoFrame", displayName = "Інформація"}, c)
		API:AddElement({name = "GuildMemberDetailFrame", displayName = "Деталі по участника Гільдії"}, c)
		API:AddElement({name = "GuildRegistrarFrame", displayName = "Регістрація Гільдії"}, c)

		c = API:GetCategory("Інформаційні панелі")
		API:AddElement({name = "UIPanelMover1", displayName = "Загальна інформаційна панель 1", noHide = 1}, c)
		API:AddElement({name = "UIPanelMover2", displayName = "Загальна інформаційна панель 2", noHide = 1}, c)
		API:AddElement({name = "UIPanelMover3", displayName = "Загальна інформаційна панель 3", noHide = 1}, c)
		API:AddElement({name = "CharacterFrame", displayName = "Character / Reputation / Currency"}, c)
		API:AddElement({name = "DressUpFrame", displayName = "Гардероб"}, c)
		API:AddElement({name = "TaxiFrame", displayName = "Шляхи польоту"}, c)
		API:AddElement({name = "GossipFrame", displayName = "Спілкування з НПС"}, c)
		API:AddElement({name = "InspectFrame", displayName = "Огляд"}, c)
		API:AddElement({name = "LFRParentFrame", displayName = "Список Рейдів"}, c)
		API:AddElement({name = "MacroFrame", displayName = "Макроси"}, c)
		API:AddElement({name = "MailFrame", displayName = "Поштова скринька"}, c)
		API:AddElement({name = "MerchantFrame", displayName = "Торговець"}, c)
		API:AddElement({name = "OpenMailFrame", displayName = "Відкритей лист"}, c)
		API:AddElement({name = "PetStableFrame", displayName = "Стайня для тварин"}, c)
		API:AddElement({name = "FriendsFrame", displayName = "Друзі / Хто / Гільдія / Чат / Рейд"}, c)
		API:AddElement({name = "SpellBookFrame", displayName = "Книга заклинань / Професії / Маунти / Компаньйони"}, c)
		API:AddElement({name = "TabardFrame", displayName = "Дизайн гербової накидки"}, c)
		API:AddElement({name = "PlayerTalentFrame", displayName = "Таланти / Сувої", refuseSync = MOVANY.FRAME_ONLY_ONCE_OPENED}, c)
		API:AddElement({name = "TradeFrame", displayName = "Обмін"}, c)
		API:AddElement({name = "TradeSkillFrame", displayName = "Вивченя навичьок"}, c)
		API:AddElement({name = "ClassTrainerFrame", displayName = "Тренер"}, c)

		c = API:GetCategory("Здобич")
		API:AddElement({name = "LootFrame", displayName = "Здобич"}, c)
		API:AddElement({name = "GroupLootFrame1", displayName = "Здобич Roll 1", create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame2", displayName = "Здобич Roll 2", create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame3", displayName = "Здобич Roll 3", create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame4", displayName = "Здобич Roll 4", create = "GroupLootFrameTemplate"}, c)

		c = API:GetCategory("Міні карта")
		API:AddElement({name = "MinimapCluster", displayName = "Міні карта"}, c)
		API:AddElement({name = "MinimapBorder", displayName = "Кругла межа на міні карті"}, c)
		API:AddElement({name = "MinimapZoneTextButton", displayName = "Назва локації"}, c)
		API:AddElement({name = "MinimapBorderTop", displayName = "Верхній бордюр", noScale = 1}, c)
        API:AddElement({name = "MinimapBackdrop", displayName = "Minimap Round Border", noAlpha = 1, noMove = 1, noScale = 1, hideList = {{"MinimapBackdrop", "ARTWORK"}}}, c)
        API:AddElement({name = "MinimapNorthTag", displayName = "Індикатор півночі", noAlpha = 1, noMove = 1, noScale = 1}, c)
		API:AddElement({name = "GameTimeFrame", displayName = "Кнопка календаря"}, c)
		API:AddElement({name = "TimeManagerClockButton", displayName = "Кнопка годинника"}, c)
		API:AddElement({name = "MiniMapInstanceDifficulty", displayName = "Складність підземелля"}, c)
		API:AddElement({name = "MiniMapLFGFrame", displayName = "Кнопка LFD/R"}, c)
		API:AddElement({name = "MiniMapMailFrame", displayName = "Сповіщення поштою"}, c)
		API:AddElement({name = "MiniMapTracking", displayName = "Кнопка стеження"}, c)
		API:AddElement({name = "MinimapZoomIn", displayName = "Кнопка збільшення масштабу"}, c)
		API:AddElement({name = "MinimapZoomOut", displayName = "Кнопка зменшення масштабу"}, c)
		API:AddElement({name = "MiniMapWorldMapButton", displayName = "Кнопка карти світу"}, c)
		
		c = API:GetCategory("Різне")
		API:AddElement({name = "TimeManagerFrame", displayName = "Будильник"}, c)
		API:AddElement({name = "AuctionFrame", displayName = "Аукціонний Дім"}, c)
        API:AddElement({name = "AuctionProgressFrame", displayName = "Аукціонний Фрейм Прогресу"}, c)
        API:AddElement({name = "AuctionProgressBar", displayName = "Аукціонний Смуга Прогресу"}, c)
		API:AddElement({name = "BarberShopFrame", displayName = "Перукарня"}, c)
		API:AddElement({name = "MirrorTimer1", displayName = "Смуга дихання/втоми"}, c)
		API:AddElement({name = "CalendarFrame", displayName = "Календар"}, c)
		API:AddElement({name = "CalendarViewEventFrame", displayName = "Подія в календарі"}, c)
		API:AddElement({name = "ChannelPullout", displayName = "Витяг каналу"}, c)
		API:AddElement({name = "ChatConfigFrame", displayName = "Налаштування каналу чату"}, c)
		API:AddElement({name = "ColorPickerFrame", displayName = "Вибір кольору"}, c)
		API:AddElement({name = "TokenFramePopup", displayName = "Опції валюти"}, c)
		API:AddElement({name = "ItemRefTooltip", displayName = "Спливне вікно чату"}, c)
		API:AddElement({name = "DurabilityFrame", displayName = "Фігура міцності"}, c)
		API:AddElement({name = "UIErrorsFrame", displayName = "Помилки та попередження"}, c)
		API:AddElement({name = "FramerateLabel", displayName = "Частота кадрів", noAlpha = 1, noHide = 1, noScale = 1, noUnanchorRelatives = 1}, c)
		API:AddElement({name = "GearManagerDialog", displayName = "Керування екіпіровкі"}, c)
		API:AddElement({name = "ItemSocketingFrame", displayName = "Інкрустовуемий предмет"}, c)
		API:AddElement({name = "HelpFrame", displayName = "GM Поміч"}, c)
		API:AddElement({name = "MacroPopupFrame", displayName = "Назва та Іконка макросу"}, c)
		API:AddElement({name = "StaticPopup1", displayName = "Статичне спливаюче вікно 1"}, c)
		API:AddElement({name = "StaticPopup2", displayName = "Статичне спливаюче вікно 2"}, c)
		API:AddElement({name = "StaticPopup3", displayName = "Статичне спливаюче вікно 3"}, c)
		API:AddElement({name = "StaticPopup4", displayName = "Статичне спливаюче вікно 4"}, c)
		API:AddElement({name = "ItemTextFrame", displayName = "Матеріали для читання"}, c)
		API:AddElement({name = "ReputationDetailFrame", displayName = "Деталі репутації"}, c)
		API:AddElement({name = "TicketStatusFrame", displayName = "Статус Запиту"}, c)
		API:AddElement({name = "TooltipMover", displayName = "Підказка"}, c)
		API:AddElement({name = "BagItemTooltipMover", displayName = "Спливаюча підказка - предмет сумки"}, c)
		API:AddElement({name = "TutorialFrame", displayName = NEW_ICON ..  "Навчальні посібники"}, c)
		API:AddElement({name = "TutorialFrameAlertButton", displayName = NEW_ICON .. "Кнопка сповіщення підручників"}, c)
		API:AddElement({name = "VoiceChatTalkers", displayName = "Спікери голосового чату"}, c)
		API:AddElement({name = "ZoneTextFrame", displayName = "Текст зон зонування"}, c)
		API:AddElement({name = "SubZoneTextFrame", displayName = "Текст підзони зонування"}, c)

		c = API:GetCategory("MoveAnything")
		API:AddElement({name = "MAOptions", displayName = "MoveAnything Вікно",
			hideList = {
				{"MAOptions", "ARTWORK","BORDER"},
			}
		}, c)
		API:AddElement({name = "MA_FE", displayName = NEW_ICON .. " Конфігурація редактора фреймів MoveAnything", noHide = 1, noMove = 1}, c)
		API:AddElement({name = "MANudger", displayName = "MoveAnything Підштовхувач"}, c)
		API:AddElement({name = "GameMenuButtonMoveAnything", displayName = " Кнопка MoveAnything в меню гри"}, c)

		c = API:GetCategory("Unit: Фокус")
		API:AddElement({name = "FocusFrame", displayName = "Фокус"}, c)
		API:AddElement({name = "FocusFrameTextureFramePVPIcon", displayName = "Фокус PVP Іконка"}, c)
		API:AddElement({name = "FocusBuffsMover", displayName = "Фокус Баф"}, c)
		API:AddElement({name = "FocusDebuffsMover", displayName = "Фокус Дебаф"}, c)
		API:AddElement({name = "FocusFrameSpellBar", displayName = "Фокус смуга заклинань", noAlpha = 1}, c)
		API:AddElement({name = "FocusFrameToT", displayName = "Таргет Фокусу"}, c)
		API:AddElement({name = "FocusFrameToTDebuffsMover", displayName = "Дебаф на Таргету Фокуса"}, c)

		c = API:GetCategory("Unit: Група")
		API:AddElement({name = "PartyMemberFrame1", displayName = "Група гравец 1"}, c)
		API:AddElement({name = "PartyMember1DebuffsMover", displayName = "Група гравец 1 Дебаф"}, c)
		API:AddElement({name = "PartyMemberFrame2", displayName = "Група гравец 2"}, c)
		API:AddElement({name = "PartyMember2DebuffsMover", displayName = "Група гравец 2 Дебаф"}, c)
		API:AddElement({name = "PartyMemberFrame3", displayName = "Група гравец 3"}, c)
		API:AddElement({name = "PartyMember3DebuffsMover", displayName = "Група гравец 3 Дебаф"}, c)
		API:AddElement({name = "PartyMemberFrame4", displayName = "Група гравец 4"}, c)
		API:AddElement({name = "PartyMember4DebuffsMover", displayName = "Група гравец 4 Дебаф"}, c)

		c = API:GetCategory("Unit: Пет")
		API:AddElement({name = "PetFrame", displayName = "Пет гравця"}, c)
		API:AddElement({name = "PetDebuffsMover", displayName = "Пет дебаф"}, c)
		API:AddElement({name = "PartyMemberFrame1PetFrame", displayName = "Група пет 1"}, c)
		API:AddElement({name = "PartyMemberFrame2PetFrame", displayName = "Група пет 2"}, c)
		API:AddElement({name = "PartyMemberFrame3PetFrame", displayName = "Група пет 3"}, c)
		API:AddElement({name = "PartyMemberFrame4PetFrame", displayName = "Група пет 4"}, c)

		c = API:GetCategory("Unit: Гравець")
		API:AddElement({name = "PlayerFrame", displayName = "Гравець", linkedScaling = {"ComboFrame"}}, c)
        API:AddElement({name = "ConsolidatedBuffs", displayName = "Блок Баффи + Дебафи"}, c)
        API:AddElement({name = "ConsolidatedBuffsTooltip", displayName = "Баффи - Консолідована підказка"}, c)
		API:AddElement({name = "PlayerBuffsMover", displayName = "Бафи Гравця"}, c)
        API:AddElement({name = "TemporaryEnchantFrame", displayName = "Тимчасові баффи предметів"}, c) -- отрути , чарки шамана
		API:AddElement({name = "PlayerDebuffsMover", displayName = "Дебафи Гравця"}, c) -- новий пункт 
		API:AddElement({name = "CastingBarFrame", displayName = "Смуга читання заклинань", noAlpha = 1}, c)

		c = API:GetCategory("Unit: Таргет")
		API:AddElement({name = "TargetFrame", displayName = "Таргет"}, c)
		API:AddElement({name = "TargetBuffsMover", displayName = "Таргет баф"}, c)
		API:AddElement({name = "TargetDebuffsMover", displayName = "Таргет дебаф"}, c)
		API:AddElement({name = "ComboFrame", displayName = "Таргет Комбо поінт"}, c)
		API:AddElement({name = "TargetFrameSpellBar", displayName = "Таргет смуга заклинать", noAlpha = 1}, c)
		API:AddElement({name = "TargetFrameToT", displayName = "Таргет Таргету"}, c)
		API:AddElement({name = "TargetFrameToTDebuffsMover", displayName = "Таргет Таргету дебаф"}, c)
		API:AddElement({name = "TargetFrameNumericalThreat", displayName = "Індикатор цільової загрози"}, c)

		c = API:GetCategory("Транспортний засіб")
		API:AddElement({name = "VehicleMenuBar", displayName = "Панель транспортного засобу",
			hideList = {
				{"VehicleMenuBar", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
				{"VehicleMenuBarArtFrame", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
				{"VehicleMenuBarActionButtonFrame", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
			}
		}, c)
		API:AddElement({name = "VehicleMenuBarActionButtonFrame", displayName = "Панель дій транспорту", runOnce = function()
			VehicleMenuBarActionButtonFrame:SetSize((VehicleMenuBarActionButton1:GetWidth() + 2) * VEHICLE_MAX_ACTIONBUTTONS, VehicleMenuBarActionButton1:GetHeight() + 2)
		 end}, c)
		API:AddElement({name = "VehicleMenuBarHealthBar", displayName = "Панель стану транспорту", onlyOnceCreated = 1}, c)
		API:AddElement({name = "VehicleMenuBarPowerBar", displayName = "Панель потужності транспорту", onlyOnceCreated = 1}, c)
		API:AddElement({name = "VehicleMenuBarLeaveButton", displayName = "Кнопка виходу з транспорту"}, c)
		API:AddElement({name = "VehicleSeatIndicator", displayName = "Індикатор сидіння транспорту"}, c)


		c = API:AddCategory({name = "MA Internal Elements"})
		API:AddElement({name = "MainMenuBarArtFrame", hidden = 1, noScale = 1}, c)
		API:AddElement({name = "WorldMapFrame", hidden = 1, refuseSync = "Unsuppported", unsupported = 1}, c)
		API:AddElement({name = "PaperDollFrame", hidden = 1, unsupported = 1}, c)
        
        c = API:AddCategory({name = "Інші Аддони"})
        API:AddElement({name = "LibDBIcon10_DBM", displayName = "DBM"}, c)
        API:AddElement({name = "LibDBIcon10_WeakAuras", displayName = "WeakAuras"}, c)
        API:AddElement({name = "LibDBIcon10_Omen", displayName = "Omen"}, c)
        API:AddElement({name = "VuhDoMinimapButton", displayName = "VuhDo"}, c)
        API:AddElement({name = "QDKP2GUI_MiniBtn", displayName = "QDK2"}, c)
        API:AddElement({name = "", displayName = ""}, c)

       	API.default = nil

		API.customCat = API:AddCategory({name = "Custom Frames"})

	end
}

MovAny:AddCore("FrameList", m)
