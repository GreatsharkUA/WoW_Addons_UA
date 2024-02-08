local mod = LootMaster:NewModule("EPGPLootmaster_Options")

--local LootMasterML = false

function mod:OnEnable()
  local options = {
    name = "EPGPLootMaster Налаштування",
    type = "group",
    get = function(i) return LootMaster.db.profile[i[#i]] end,
    set = function(i, v) LootMaster.db.profile[i[#i]] = v end,
    args = {
        
        global = {
            order = 1,
            type = "group",
            hidden = function(info) return not LootMasterML end,
            name = "Головні налаштування",
            
                args = {
                
                help = {
                    order = 0,
                    type = "description",
                    name = "EPGP — це справедлива система розподілу здобичі в грі. LootMaster допомагає вам розподіляти здобич у вашому рейді та реєструє цю здобич у системі EPGP.",
                },
                
                
                
                no_ml = {
                    order = 2,
                    type = "description",
                    hidden = function(info) return LootMasterML end,
                    name = "\r\n\r\n|cFFFF8080УВАГА: Багато налаштувань було приховано, оскільки модуль EPGPLootmaster 'ML' було вимкнено. Увімкніть його на екрані конфігурації при виборі персонажа.|r",
                },
                
                config_group = {
                    order = 12,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Головні налаштування",
                    args = {
                        
                        use_epgplootmaster = {
                            order = 2,
                            type = "select",
			                width = "double",
                            set = function(i, v) 
                                LootMaster.db.profile.use_epgplootmaster = v;
                                if v == 'enabled' then
                                    LootMasterML:EnableTracking();
                                elseif v == 'disabled' then
                                    LootMasterML:DisableTracking();
                                else
                                    LootMasterML.current_ml = nil;
                                    LootMasterML:GROUP_UPDATE();
                                end                               
                                
                            end,
                            name = "Використовувати EPGPLootmaster",
                            desc = "Контролює коли EPGPLootmaster увімкнутий чи ні",
                            values = {
                                ['enabled'] = 'Завжди використовувати EPGPLootmaster для розподілу здобичі без запиту',
                                ['disabled'] = 'Ніколи не використовувати EPGPLootmaster для розподілу здобичі',
                                ['ask'] = 'Запитувати кожного разу, чи використовувати EPGPLootmaster'
                            },
                        },
                        
                        loot_timeout = {
                            order = 14,
                            type = "select",
			                width = "double",
                            name = "Час на розподіл здобичі",
                            desc = "Встановлює час, за який кандидат має визначитись, чи хоче він отримати здобич чи ні.",
                            values = {
                                [0] = 'нема часу',
                                [10] = '10 секунд',
                                [15] = '15 секунд',
                                [20] = '20 секунд',
                                [30] = '30 секунд',
                                [40] = '40 секунд',
                                [50] = '50 секунд',
                                [60] = '1 хвилина',
                                [90] = '1 хвилина 30 секунд',
                                [150] = '2 хвилини 30 секунд',
                                [300] = '5 хвилин',
                            },
                        }, 
                        
                        --[[defaultMainspecGP = {
                            order = 15.1,
                            type = "input",                    
                            name = "Default mainspec GP",
                            desc = "Fill this field to override the GP value for mainspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultMainspecGPPercentage = false;
                                    LootMaster.db.profile.defaultMainspecGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultMainspecGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultMainspecGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultMainspecGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultMinorUpgradeGP = {
                            order = 15.2,
                            type = "input",                    
                            name = "Default minor upgrade GP",
                            desc = "Fill this field to override the GP value for minor upgrade mainspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultMinorUpgradeGPPercentage = false;
                                    LootMaster.db.profile.defaultMinorUpgradeGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultMinorUpgradeGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultMinorUpgradeGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultMinorUpgradeGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultOffspecGP = {
                            order = 15.3,
                            type = "input",                    
                            name = "Default offspec GP",
                            desc = "Fill this field to override the GP value for offspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultOffspecGPPercentage = false;
                                    LootMaster.db.profile.defaultOffspecGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultOffspecGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultOffspecGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultOffspecGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultGreedGP = {
                            order = 15.4,
                            type = "input",                    
                            name = "Default greed GP",
                            desc = "Fill this field to override the GP value for greed loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultGreedGPPercentage = false;
                                    LootMaster.db.profile.defaultGreedGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultGreedGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultGreedGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultGreedGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },]]
                        
                        ignoreResponseCorrections = {
                            type = "toggle",
                            order = 17,
                            width = 'full',
                            name = "Приймати від гравця тільку першу відповідь на здобич.",
                            desc = "Зазвичай гравці можуть змінювати свою відповідь по здобич. Наприклад: спочатку вони вибрали головний спек, але потім вирішили змінити це на офф спек і надати більший пріоритет комусь іншому. Якщо ви увімкнете цю опцію, буде зараховано лише першу відповідь.",
                        },
                        
                        allowCandidateNotes = {
                            type = "toggle",
                            order = 18,
                            width = 'full',
                            name = "Дозвольте гравцям робити примітки до здобичі",
                            desc = "Увімкніть, якщо ви хочете, щоб гравці надсилали вам примітки. Примітки відображатимуться як значок у вашому інтерфейсі здобичі. Ви можете прочитати їх, навівши на іконку. Це дозволяє гравцям надсилати вам повідомлення на кшталт: «Потрібно, лише якщо нікому більше не потрібно» або «Елемент Б має вищий пріоритет». Ви можете вимкнути це, якщо вважаєте, що це сповільнює розподіл здобичі.",
                        },
                        
                        filterEPGPLootmasterMessages = {
                            type = "toggle",
                            order = 19,
                            width = 'full',
                            name = "Фільтруйте оголошення та шепіт у чаті.",
                            desc = "EPGPLootmaster має гарну систему, де навіть учасники рейду, у яких не встановлено EPGPLootmaster, можуть приймати участь у розподіл здобичі. Це буде зроблено шляхом надсилання повідомлень до рейдового каналу. Увімкніть цю опцію, щоб відфільтрувати всі ці повідомлення з вашого чату.",
                        },
                        
                        audioWarningOnSelection = {
                            type = "toggle",
                            order = 20,
                            width = 'full',
                            name = "Відтворити звукове попередження у спливаючому вікні вибору здобичі.",
                            desc = "Це відтворить звукове попередження, коли відкриється спливаюче вікно вибору здобичі та вимагає вашої відповіді.",
                        },
                    }
                },
                
                buttons_group = {
                    order = 12.5,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Кнопка вибору",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "Це дозволяє вам налаштувати кнопки вибору в інтерфейсі гравців ваших рейдерів. Зауважте, що кнопки вибору будуть відсортовано так само, як і кнопки нижче. Вам потрібно буде додати мінімум одну кнопку, і кнопка PASS завжди буде видно",
                        },
                        
                        buttonNum = {
                            type = "range",
                            width = 'full',
                            order = 1,
                            name = "Кількість кнопок вибору:",
                            min = 1,
                            max = EPGPLM_MAX_BUTTONS,
                            step = 1,
                            desc = "Укажіть, скільки кнопок ви хочете відображати в аддоні. Вам потрібно буде налаштувати мінімум 1 кнопку та пам’ятати, що кнопка пропуску(Pass) завжди буде включена.",
                        },
                        
                        
                        button1 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 1 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.1,
                            name = "Кнопка1",
                            desc = "Налаштуйте цю кнопку вибору.",
                        },
                        
                        button2 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 2 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.2,
                            name = "Кнопка2",
                            desc = "Налаштуйте цю кнопку вибору.",
                        },
                        
                        button3 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 3 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.3,
                            name = "Кнопка3",
                            desc = "Налаштуйте цю кнопку вибору.",
                        },
                        
                        button4 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 4 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.4,
                            name = "Кнопка4",
                            desc = "Налаштуйте цю кнопку вибору.",
                        },
                        
                        button5 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 5 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.5,
                            name = "Кнопка5",
                            desc = "Налаштуйте цю кнопку вибору.",
                        },
                        
                        button6 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 6 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.6,
                            name = "Кнопка6",
                            desc = "Налаштуйте цю кнопку вибору.",
                        },
                        
                        button7 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 7 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.7,
                            name = "Кнопка7",
                            desc = "Налаштуйте цю кнопку вибору.",
                        },
                        
                        btnTestPopup = {
                            order = 3,
                            type = "execute",
                            width = 'full',
                            name = "Відкрити тестове спливаюче вікно та вікна моніторингу",
                            desc = "Відкриває спливаюче вікно вибору та інтерфейс ML, щоб ви могли побачити, як це виглядатиме на вашому клієнті. Після завершення тестування просто натисніть кнопку скасування здобичі, щоб закрити інтерфейс ML.",
                            func = function()
                                local lootLink
                                for i=1, 20 do
                                  lootLink = GetInventoryItemLink("player", i)
                                  if lootLink then break end
                                end
                                if not lootLink then return end
                                
                                ml = LootMasterML        
                                local loot = ml:GetLoot(lootLink)
                                local added = false
                                if not loot then
                                    local lootID = ml:AddLoot(lootLink, true)
                                    loot = ml:GetLoot(lootID)
                                    loot.announced = false
                                    loot.manual = true
                                    added = true
                                end
                                if not loot then return self:Print('Не вдалося зареєструвати лут.') end          
                                ml:AddCandidate(loot.id, UnitName('player'))
                                ml:AnnounceLoot(loot.id)
                                for i=1, LootMaster.db.profile.buttonNum do
                                  ml:AddCandidate(loot.id, 'Button ' .. i)
                                  ml:SetCandidateResponse(loot.id, 'Button ' .. i, LootMaster.RESPONSE['button'..i], true)
                                end
                                ml:ReloadMLTableForLoot(loot.link)
                            end
                        },
                    },
                },
                
                auto_hiding_group = {
                    order = 13,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Автоматичне приховування",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "Це дозволяє вам керувати функціями автоматичного приховування EPGPLootmaster.",
                        },
                                
                        hideOnSelection = {
                            type = "toggle",
                            order = 16,
                            width = 'full',
                            name = "Приховати вікно монітора, коли відкривається вибір здобичі.",
                            desc = "Позначте це, щоб автоматично приховувати інтерфейс Master Looter/Monitor, коли потрібно зробити вибір при розіграші здобичі.",
                        },
                        
                        hideMLOnCombat = {
                            type = "toggle",
                            order = 17,
                            width = 'full',
                            name = "Приховати вікно Monitor під час вступу в бій.",
                            desc = "Позначте це, щоб автоматично приховувати інтерфейс Master Looter/Monitor, коли ви вступаєте в бій, він автоматично відновлюється, коли ви вийдете з бою.",
                        },
                        
                        hideSelectionOnCombat = {
                            type = "toggle",
                            order = 18,
                            width = 'full',
                            name = "Приховати вікно розіграшу здобичі під час вступу в бій.",
                            desc = "Позначте це, щоб автоматично приховувати інтерфейс вибіру при розіграші здобичі, коли ви вступаєте в бій, він автоматично відновиться, коли ви вийдете з бою.",
                        },
                    },
                },
                
                auto_announce_group = {
                    order = 14,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Авто оголошення",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "EPGP Lootmaster дозволяє вам автоматично повідомляти про певну здобич для рейду.",
                        },
                                
                        auto_announce_threshold = {
                            order = 13,
                            type = "select",
                            width = 'full',
                            hidden = function(info) return not LootMasterML end,
                            name = "Авто оголошення здобичі",
                            desc = "Встановлює порогове значення автоматичного оголошення здобичі, будь-яка здобич такої ж або вищої якості буде автоматично оголошена учасникам рейду.",
                            values = {
                                [0] = 'не оголошувати автоматично',
                                [2] = ITEM_QUALITY2_DESC,
                                [3] = ITEM_QUALITY3_DESC,
                                [4] = ITEM_QUALITY4_DESC,
                                [5] = ITEM_QUALITY5_DESC,
                            },
                        },
                    },
                },
                
                
                AutoLootGroup = {
            
                            type = "group",
                            order = 16,
                            guiInline = true,
                            name = "Авто лут",
                            desc = "Авто лут здобичі",
                            hidden = function(info) return not LootMasterML end,
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "Автоматичний лутер EPGP Lootmaster дозволяє надсилати певні предмети BoU та BoE попередньо визначеному кандидату, не ставлячи питань.",
                                },
                                
                                AutoLootThreshold = {
                                    order = 1,
                                    type = "select",
                                    width = 'full',
                                    hidden = function(info) return not LootMasterML end,
                                    name = "Авто лут збодичи (BoE та BoU виключно)",
                                    desc = "Встановлює автоматичний поріг здобичі, будь-яка здобич BoE та BoU нижчої або однакової якості автоматично надсилатиметься кандидату нижче.",
                                    values = {
                                        [0] = 'не використовувати Авто лут',
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                AutoLooter = {
                                    type = "select",
                                    style = 'dropdown',
                                    order = 2,
                                    width = 'full',
                                    name = "Ім'я гравці за замовчуванням (з урахуванням регістру):",
                                    desc = "Введіть тут ім’я гравця за замовчуванням, щоб отримати елементи BoE та BoU.",
                                    disabled = function(info) return (LootMaster.db.profile.AutoLootThreshold or 0)==0 end,
                                    values = function()
                                        local names = {}
                                        local name;
                                        local num = GetNumRaidMembers()
                                        if num>0 then
                                            -- we're in raid
                                            for i=1, num do 
                                                name = GetRaidRosterInfo(i)
                                                names[name] = name
                                            end
                                        else
                                            num = GetNumPartyMembers()
                                            if num>0 then
                                                -- we're in party
                                                for i=1, num do 
                                                    names[UnitName('party'..i)] = UnitName('party'..i)
                                                end
                                                names[UnitName('player')] = UnitName('player')
                                            else
                                                -- Just show everyone in guild.
                                                local num = GetNumGuildMembers(true);
                                                for i=1, num do repeat
                                                    name = GetGuildRosterInfo(i)
                                                    names[name] = name
                                                until true end     
                                            end                                   
                                        end
                                        sort(names)
                                        return names;
                                    end
                                },
                            }
                },
            
        
        
                MonitorGroup = {
                            type = "group",
                            order = 17,
                            guiInline = true,
                            hidden = function(info) return not LootMasterML end,
                            name = "Моніторинг",
                            desc = "Надсилайте та отримуйте повідомлення від Лут Мастера та дивіться, що вибрали інші учасники рейду.",
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "EPGP Lootmaster Monitor дозволяє надсилати повідомлення іншим користувачам у вашому рейді. Він покаже їм той самий інтерфейс, що й ML, що дозволить їм допомогти з розподілом здобичі.",
                                },
                
                                monitor = {
                                    type = "toggle",
                                    set = function(i, v)
                                        LootMaster.db.profile[i[#i]] = v;
                                        if LootMasterML and LootMasterML.UpdateUI then
                                            LootMasterML.UpdateUI( LootMasterML );
                                        end
                                    end,
                                    order = 1,
                                    width = 'full',
                                    name = "Слухайти вхідні оновлення.",
                                    desc = "Позначте це, якщо бажаєте ви щоб відображалися вхідні оновлення. Ця функція дозволяє вам бачити інтерфейс ML, щоб ви могли допомогти прийняти рішення щодо розподілу здобичі.",
                                    disabled = false,
                                },
                                
                                monitorIncomingThreshold = {
                                    order = 2,
                                    width = 'normal',
                                    type = "select",
                                    name = "Отримувати тільки за те, що дорівнює або перевищує",
                                    desc = "Слухайте лише повідомлення монітора від рейду для елементів, які відповідають цьому порогу або є вищим. (Будь ласка, майте на увазі, що шаблони тощо також відповідають цьому порогу)",
                                    disabled = function(info) return not LootMaster.db.profile.monitor end,
                                    values = {
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                monitorSend = {
                                    type = "toggle",
                                    order = 3.1,
                                    width = 'full',
                                    name = "Надсилати усім оновлення інтерфейсу ML",
                                    desc = "Позначте це, якщо хочете ви надсилати усім оновленя ML. Ця функція дозволяє іншим учасникам рейду бачити інтерфейс ML, щоб вони могли допомогти прийняти рішення щодо розподілу здобичі. Ви надсилатимете повідомлення, лише якщо ви Лут Мастер.",
                                    disabled = false,
                                },
                                
                                monitorSendAssistantOnly = {
                                    type = "toggle",
                                    order = 3.2,
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    width = 'full',
                                    name = "Надсилати помічникам оновлення інтерфейсу ML",
                                    desc = "Позначте це, якщо  хочете ви надсилати тільки помічникам оновлення ML. Залиште це вимкненим, якщо ви хочете, щоб усі могли бачити інтерфейс ML. Якщо вимкнути цей параметр, інтерфейс ML також реагуватиме швидше.",
                                },
                                
                                hideResponses = {
                                    type = "toggle",
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    order = 3.3,
                                    width = 'full',
                                    name = "Приховати оновлення інтерфейсу ML",
                                    desc = "Це конфігурація для всього рейду.Позначте це, для приховування відповіді від гравців в інтерфейсі ML, поки той, хто робить свій вибір для певного предмета. Це не дозволить гравцям робити вибір на основі відповідей інших людей. Це запобігає «обману» та прискорює процес відбору, оскільки люди перестануть чекати один одного",
                                },
                                
                                monitorThreshold = {
                                    order = 4,
                                    width = 'normal',
                                    type = "select",
                                    name = "Надсилайте лише за ціною рівною або вищою",
                                    desc = "Надсилайте повідомлення інтерфейсу ML в рейд лише для елементів, які відповідають цьому порогу або є вищим. (Будь ласка, майте на увазі, що шаблони тощо також відповідають цьому порогу)",
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    values = {
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                hint = {
                                    order = 5,
                                    width = 'normal',
                                    hidden = function(info) return not LootMaster.db.profile.monitorSend end,
                                    type = "description",
                                    name = " Будуть фільтруватися лише BoE та BoU\r\n Здобич BoP завжди будуть\r\n відправити повідомлення до інтерфейсу ML.",
                                },
                            }
                },
                
                ExtraFunctionGroup = {
                            type = "group",
                            order = 18,
                            guiInline = true,
                            hidden = function(info) return not LootMasterML end,
                            name = "Додаткові налаштування",
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "Деякі додаткові налаштування, які можуть стати в нагоді.",
                                },
                                btnVersionCheck = {
                                  order = 1000,
                                  type = "execute",
                                  name = "Перевірка версії",
                                  desc = "Відкрити перевірку версії",
                                  func = function()
                                           LootMaster:ShowVersionCheckFrame()
                                         end
                                },
                                
                                btnRaidInfoCheck = {
                                  order = 2000,
                                  type = "execute",
                                  name = "Перевірка КД рейдів",
                                  desc = "Перевіряє кд гравців на рейди",
                                  func = function()
                                           LootMasterML:ShowRaidInfoLookup()
                                         end
                                }
                                
                                
                                
                
                                
                            }
                }
            },
        },
    },
  }

  local config = LibStub("AceConfig-3.0")
  local dialog = LibStub("AceConfigDialog-3.0")

  config:RegisterOptionsTable("EPGPLootMaster-Bliz", options)
  dialog:AddToBlizOptions("EPGPLootMaster-Bliz", "EPGPLootMaster", nil, 'global')
  --dialog:AddToBlizOptions("EPGPLootMaster-Bliz", "Monitor", "EPGPLootMaster", 'MonitorGroup')
  
end
