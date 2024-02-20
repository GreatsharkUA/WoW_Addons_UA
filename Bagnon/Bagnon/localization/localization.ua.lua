--[[
	Bagnon Localization Information: Ukrainian localization by Greatshark
		This file must be present to have partial translations
--]]

local L = LibStub('AceLocale-3.0'):NewLocale('Bagnon', 'ruRU')
if not L then return end

--keybinding text
L.ToggleBags = 'Перемикач інвентарю'
L.ToggleBank = 'Перемикач банку'
L.ToggleKeys = 'Перемикач брелка'


--system messages
L.NewUser = 'Виявлено нового користувача, завантажено стандартні налаштування'
L.Updated = 'Оновлено до v%s'
L.UpdatedIncompatible = 'Оновлення з несумісної версії, завантажено стандартні налаштування'


--slash commands
L.Commands = 'Команди:'
L.CmdShowInventory = 'Перемикає рамку інвентарю'
L.CmdShowBank = 'Перемикає рамку банку'
L.CmdShowKeyring = 'Перемикає брелок'
L.CmdShowVersion = 'Друкує поточну версію'


--frame text
L.TitleBags = 'Інвентарь  |3-1(%s)'
L.TitleBank = 'Банк |3-1(%s)'
L.TitleKeys = 'Колючі |3-1(%s)'


--tooltips
L.TipBank = 'Банк'
L.TipChangePlayer = 'Клік щоб переглянути предмети іншого персонажа.'
L.TipGoldOnRealm = 'Всього золота на %s'
L.TipHideBag = 'Клік щоб сховати цю сумку.'
L.TipHideBags = 'Клік щоб приховати рамну сумки.'
L.TipHideSearch = 'Клік щоб приховати рамку пошуку.'
L.TipPurchaseBag = 'Клік щоб придбати цю банківську ячейку.'
L.TipShowBag = 'Клік щоб показати цю сумку.'
L.TipShowBags = 'Клік щоб показати рамку сумки.'
L.TipShowMenu = 'Правий-Клік щоб налаштувати.'
L.TipShowSearch = 'Клік щоб показати рамку пошуку.'
L.TipShowSearch = 'Клік Пошук.'
L.TipShowFrameConfig = 'Клік щоб налаштувати.'
L.TipDoubleClickSearch = 'Alt-Перетягнути щоб рухати.\nПравий-Клік щоб налаштувати.\nПодвійний-Клік пошук.'
L.Total = 'Всього'

--databroker plugin tooltips
L.TipShowBank = '<Shift Лівий Клік> Перемикає рамку банку.'
L.TipShowInventory = '<Лівий Клік> Перемикає рамку інвентарю.'
L.TipShowKeyring = '<Alt Лівий Клік> Перемикає брелок.'
L.TipShowOptions = '<Правий Клік> щоб відкрити Налаштування.'
