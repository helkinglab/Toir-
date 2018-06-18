IncludeFile("Lib\\TOIR_SDK.lua")

Irelia = class()

local Version = 8.12
local Author = "Deep"

function OnLoad()
    if myHero.CharName ~= "Irelia" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> The Blade Dancer!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Deep Irelia for LOL version</font></b> " ..Version)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..Author)
	Irelia:TopLane()
end

function Irelia:TopLane()

    --Pd
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
    self.Predc = VPrediction(true)


	self.IreliaE1 = false
    self.IreliaE2 = false
	
	self.isQactive = false;
	self.qtime = 0	
	
    self:IreliaMenus()
	
    self.listSpellInterrup = {
    ["CaitlynAceintheHole"] = true,
    ["Crowstorm"] = true,
    ["Drain"] = true,
    ["ReapTheWhirlwind"] = true,
	["JhinR"] = true,
    ["KarthusFallenOne"] = true,
    ["KatarinaR"] = true,
    ["LucianR"] = true,
    ["AlZaharNetherGrasp"] = true,
    ["MissFortuneBulletTime"] = true,
    ["AbsoluteZero"] = true,                       
    ["PantheonRJump"] = true,
    ["ShenStandUnited"] = true,
    ["Destiny"] = true,
    ["UrgotSwap2"] = true,
    ["VarusQ"] = true,
    ["VelkozR"] = true,
    ["InfiniteDuress"] = true,
    ["XerathLocusOfPower2"] = true,
	}
	
    self.listSpellDash = {
    ["MaokaiW"] = true,
    ["Crowstorm"] = true,
    ["CamilleE"] = true,
    ["BlindMonkQTwo"] = true,
	["BlindMonkWOne"] = true,
    ["NocturneParanoia2"] = true,
    ["XinZhaoE"] = true,
    ["PantheonW"] = true,
    ["AkaliShadowDance"] = true,
    ["Headbutt"] = true,
    ["BraumW"] = true,                       
    ["DianaTeleport"] = true,
    ["JaxLeapStrike"] = true,
    ["MonkeyKingNimbus"] = true,
    ["PoppyE"] = true,
    ["IreliaGatotsu"] = true,
    ["LucianE"] = true,
    ["EzrealArcaneShift"] = true,
    ["TristanaW"] = true,
    ["AhriTumble"] = true,
	["CarpetBomb"] = true,
	["FioraQ"] = true,
	["SummonerFlash"] = true,
	["FioraQ"] = true,
	["KindredQ"] = true,
	["RiftWalk"] = true,
	["FizzETwo"] = true,
	["FizzE"] = true,
	["CamilleEDash2"] = true,
	["AatroxQ"] = true,
	["RakanW"] = true,
	["QuinnE"] = true,
	["ShyvanaTransformLeap"] = true,
	["ShenE"] = true,
	["Deceive"] = true,
	["SejuaniQ"] = true,
	["KhazixE"] = true,
	["KhazixELong"] = true,
	["TryndamereE"] = true,
	["LeblancW"] = true,
	["GalioE"] = true,
	["ZacE"] = true,
	["ViQ"] = true,
	["EkkoEAttack"] = true,
	["TalonQ"] = true,
	["EkkoE"] = true,
	["FizzQ"] = true,
	["GragasE"] = true,
	["GravesMove"] = true,
	["OrnnE"] = true,
	["Pounce"] = true,
	["RivenFeint"] = true,
	["KaynQ"] = true,
	["RenektonSliceAndDice"] = true,
	["RenektonDice"] = true,
	["VayneTumble"] = true,
	["UrgotE"] = true,
	["JarvanIVDragonStrike"] = true,
	["WarwickR"] = true,
	["ZiggsDashWrapper"] = true,
	["CaitlynEntrapment"] = true,
	}
	
    self.listSpellDangerous = {
    ["NocturneParanoia2"] = true,                     
    ["rivenizunablade"] = true,
    ["Anivia2"] = true,
    ["BrandWildfire"] = true,
    ["BusterShot"] = true,
    ["CassiopeiaPetrifyingGaze"] = true,
    ["DariusExecute"] = true,
	["InfernalGuardian"] = true,--annieR
    ["DravenRCast"] = true,
    ["EvelynnR"] = true,
    ["GarenR"] = true,
    ["GravesClusterShot"] = true,
    ["HecarimUlt"] = true,
    ["jayceshockblast"] = true,
	["JinxR"] = true,
    ["KarthusFallenOne"] = true,
    ["LucianR"] = true,
    ["LuxMaliceCannon"] = true,
    ["PantheonRJump"] = true,
    ["SwainMetamorphism"] = true,
    ["SyndraR"] = true,
    ["TalonShadowAssault"] = true,
    ["VeigarPrimordialBurst"] = true,
	["vladimirtidesofbloodnuke"] = true,
    ["zedulttargetmark"] = true,
    ["ZiggsR"] = true,
	["jayceshockblastwall"] = true,
	}

		--Spells
    self.Q = Spell(_Q, 625)
    self.W = Spell(_W, 825)
    self.E = Spell(_E, 900)
    self.R = Spell(_R, 1000)
  
    self.Q:SetTargetted()
    self.W:SetSkillShot(0.1, math.huge, 100 ,false)
    self.E:SetSkillShot(0.1, math.huge, 100 ,false)
    self.R:SetSkillShot(0.1, math.huge, 100 ,false)

    Callback.Add("Update", function(...) self:OnUpdate(...) end)	
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("UpdateBuff", function(unit, buff, stacks) self:OnUpdateBuff(source, unit, buff, stacks) end)
	Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("AfterAttack", function(...) self:OnAfterAttack(...) end)
	
	Irelia:aa()
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep Irelia</font></b> <font color=\"#ffffff\">Loaded. Enjoy The Blade Dancer</font>")
 end 

function Irelia:OnAfterAttack(unit, target)
	if unit.IsMe then
		if target ~= nil and target.Type == 0 then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) and CanCast(tiamat) then
						CastSpellTarget(myHero.Addr, tiamat)
				end
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) and CanCast(titanic) then
							CastSpellTarget(myHero.Addr, titanic)
				end
    		end
    		if GetKeyPress(self.Combo) > 0 then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) and CanCast(tiamat) then
						CastSpellTarget(myHero.Addr, tiamat)
						
				end
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) and CanCast(titanic) then
							CastSpellTarget(myHero.Addr, titanic)
				end
			    			end
							
	for i, minions in ipairs(self:JungleClear()) do
        if minions ~= 0 then
		local jungle = GetUnit(minions)
		if jungle.Type == 3 then

	  if GetKeyPress(self.LaneClear) > 0 then
		if jungle ~= nil and GetDistance(jungle) < 380 then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) and CanCast(tiamat) then
						CastSpellTarget(myHero.Addr, tiamat)
						
				end
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) and CanCast(titanic) then
							CastSpellTarget(myHero.Addr, titanic)
				end
        end						
			    		end
			    	end
		if jungle.Type == 1 then

	  if GetKeyPress(self.LaneClear) > 0 then
		if jungle ~= nil and GetDistance(jungle) < 380 then
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) and CanCast(titanic) then
							CastSpellTarget(myHero.Addr, titanic)
				end
        end						
			    		end
	  if GetKeyPress(self.LastHit) > 0 then
		if jungle ~= nil and GetDistance(jungle) < 380 then
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) and CanCast(titanic) then
							CastSpellTarget(myHero.Addr, titanic)
				end
        end						
			    		end			
			    	end		    								
				end			
    		end
			end
			end
			
function Irelia:LastLane()
  --  __PrintTextGame("Calling lastlane = ")
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
		if IsValidTarget(minion.Addr, 360) and (GetAADamageHitEnemy(minion.Addr) * 0.7) > minion.HP then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) and CanCast(tiamat) then
						CastSpellTarget(myHero.Addr, tiamat)
						
				end
        end						
			    		end
			    	end		    						
				end			
	
function Irelia:JungleClear()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minion) and not IsInFog(minions) and (GetType(minions) == 3 or GetType(minions) == 1) then
            table.insert(result, minions)
        end
    end

    return result
end 
	
 --[[
function Irelia:LastTia()
    local aa = myHero.TotalDmg * 0.7
    for i, minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
            if GetDistance(Vector(minion)) <= 380 
			and aa > minion.HP 
			then
			CastSpellTarget(minion.Addr, self:CheckTiama())
--		__PrintTextGame("Jungle HP = " ..minion.HP)
--  		__PrintTextGame("Tiamat damage = " ..aa)
--                self:UseTiama()
            end
		end
	end
end	]]

 --[[
function Irelia:CheckTiama()
    if GetSpellIndexByName("ItemTiamatCleave") > -1 then
        return GetSpellIndexByName("ItemTiamatCleave")
    end

    if GetSpellIndexByName("ItemTitanicHydraCleave") > -1 then
        return GetSpellIndexByName("ItemTitanicHydraCleave")
    end 
    return -1
end]]
 
function Irelia:OnProcessSpell(unit, spell)
    if self.E:IsReady() 
	and self.menu_interruptE 
	and unit 
	and spell 
	and unit.IsEnemy 
	and IsChampion(unit.Addr) 
	and GetDistance(unit) < 980 
	then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellInterrup[spell.Name] ~= nil and not unit.IsMe then
            CastSpellToPos(unit.x, unit.z, _E)  
			            DelayAction(function()
            CastSpellToPos(unit.x+100, unit.z+100, _E) 
			end, 0.1)
        end 
    end 
    if self.E:IsReady() 
	and self.menu_interruptE2 
	and unit 
	and spell 
	and unit.IsEnemy 
	and IsChampion(unit.Addr) 
	and GetDistance(unit) < 980 
	then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellDash[spell.Name] ~= nil and not unit.IsMe then
            CastSpellToPos(spell.DestPos_x, spell.DestPos_z, _E)
			            DelayAction(function()
            CastSpellToPos(spell.DestPos_x+100, spell.DestPos_z+100, _E)
			end, 0.1)
        end 
    end 
    if self.W:IsReady() 
	and self.menu_interruptW 
	and unit 
	and spell 
	and unit.IsEnemy 
	and IsChampion(unit.Addr) 
	and GetDistance(unit) < 800 
	then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellDangerous[spell.Name] ~= nil and not unit.IsMe then
            CastSpellToPos(unit.x, unit.z, _W) 
        end 
    end 
    if self.R:IsReady() 
	and self.menu_interruptR 
	and unit 
	and spell 
	and unit.IsEnemy 
	and IsChampion(unit.Addr) 
	and GetDistance(unit) < 950 
	then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellDangerous[spell.Name] ~= nil and not unit.IsMe then
            CastSpellToPos(unit.x, unit.z, _R) 
        end 
    end 
end
 
 function Irelia:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Irelia:GetEnemies(range)
    local t = {}
    local h = self:GetHeroes()
    for k, v in pairs(h) do
        if v ~= 0 then
            local hero = GetAIHero(v)
            if hero.IsEnemy and hero.IsValid and hero.Type == 0 and (not range or range > GetDistance(hero)) then
                table.insert(t, hero)
            end 
        end 
    end
    return t
end

  --SDK {{Toir+}}
function Irelia:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Irelia:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Irelia:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
	if self.menu_Combo_QendDash then
		self:autoQtoEndDash()
	end
end 



function Irelia:IreliaMenus()
    self.menu = "Deep Irelia"
    --Combo [[ Irelia ]]
    self.CQ = self:MenuBool("Combo Q", true)
	self.CQEx = self:MenuBool("Use Q Extend", true)
--	self.CQchase = self:MenuBool("Use Q Chase", true)
	self.CQgapclose = self:MenuBool("Use Q Gap", false)
	self.CQgapclosekill = self:MenuBool("Use Q Gap", true)
    self.CQdis = self:MenuSliderInt("Combo minimum Q distance", 200)
    self.MQdis = self:MenuSliderInt("Combo minimum Q minion distance", 450)
	self.CW = self:MenuBool("Combo W", true)
    self.CWdis = self:MenuSliderInt("Combo max W range", 400)
	self.CWHP = self:MenuSliderInt("Combo min HP% to use W", 50)
    self.CE = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)
    self.CRlow = self:MenuSliderInt("HP Minimum %", 90)
     self.EMode = self:MenuComboBox("Mode [Q] [ TF ]", 0)
	 
	 --Auto
    self.AutoLevelTop = self:MenuBool("Auto level", true)
    self.menu_interruptE2 = self:MenuBool("Use E on dashing enemies", true)
    self.menu_interruptE = self:MenuBool("Use E to interrupt channeling spells", true)
    self.menu_interruptW = self:MenuBool("Use W to block dangerous spells", true)
    self.menu_interruptR = self:MenuBool("Use R to hinder dangerous spells", false)
	
	self.menu_Combo_QendDash = self:MenuBool("Auto Q End Dash", false)
--	self.menu_Combo_EendDash = self:MenuBool("Auto E End Dash", true)
   
    --Lane
    self.LQ = self:MenuBool("Lane Q", true)
    self.LQMana = self:MenuSliderInt("Mana Lane Q %", 30)
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JQMana = self:MenuSliderInt("Mana Jungle Q %", 30)
    self.JW = self:MenuBool("Jungle W", true)
    self.JWMana = self:MenuSliderInt("Mana Jungle W %", 30)
    self.JE = self:MenuBool("Jungle E", true)
    self.JEMana = self:MenuSliderInt("Mana Jungle E %", 30)

	--Last hit
    self.LHQ = self:MenuBool("Last hit Q", true)
    self.LHQMana = self:MenuSliderInt("Min MP for using Q", 30)
	
    --Harass
    self.HarE = self:MenuBool("Harass E", true)
    self.HarEdis = self:MenuSliderInt("Harass max E Distance", 700)
    self.HarQ = self:MenuBool("Harass Q", true)
    self.HarQdis = self:MenuSliderInt("Harass min Q Distance", 250)
    self.HarW = self:MenuBool("Harass W", true)
    self.HarWdis = self:MenuSliderInt("Harass max W range", 500)

    --KillSteal [[ Irelia ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", false)

    --Draws [[ Irelia ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)

	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", false)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 5) 

    --KeyS [[ Irelia ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
	self.Harass = self:MenuKeyBinding("Harass", 67)
end

function Irelia:OnDrawMenu()
if not Menu_Begin(self.menu) then return end

		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CQdis = Menu_SliderInt("Combo minimum Q distance", self.CQdis, 0, 625, self.menu)
            Menu_Separator()
            self.CQEx = Menu_Bool("Use Q on killable minions during combo", self.CQEx, self.menu)
            self.MQdis = Menu_SliderInt("Max range for killing minions", self.MQdis, 0, 625, self.menu)
            Menu_Separator()
            self.CQgapclose = Menu_Bool("Use Q to close the gap in combo", self.CQgapclose, self.menu)
            self.CQgapclosekill = Menu_Bool("Use Q on killable to close the gap in combo", self.CQgapclosekill, self.menu)
            Menu_Separator()
   --         self.CQchase = Menu_Bool("Use Q to chase max Q range", self.CQchase, self.menu)
			self.menu_Combo_QendDash = Menu_Bool("Auto Q Dasing Enemies", self.menu_Combo_QendDash, self.menu)
            Menu_Separator()
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CWHP = Menu_SliderInt("Combo min HP% to use W", self.CWHP, 0, 100, self.menu)
            self.CWdis = Menu_SliderInt("Combo max W range", self.CWdis, 0, 500, self.menu)
            Menu_Separator()
			self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.EMode = Menu_ComboBox("[E] Mode", self.EMode, "ExtendPos\0MousePos\0\0\0\0", self.menu)
			self.menu_Combo_EendDash = Menu_Bool("Auto E Dasing Enemies", self.menu_Combo_EendDash, self.menu)
            Menu_Separator()
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.CRlow = Menu_SliderInt("Enemy min HP % for Combo R", self.CRlow, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Auto") then
        self.AutoLevelTop = Menu_Bool("Auto Level", self.AutoLevelTop, self.menu)
		Menu_Separator()
        self.menu_interruptE2 = Menu_Bool("Use E on dashing enemies", self.menu_interruptW, self.menu)
		Menu_Separator()
        self.menu_interruptE = Menu_Bool("Use E to interrupt channeling spells", self.menu_interruptE, self.menu)
		Menu_Separator()
        self.menu_interruptW = Menu_Bool("Use W to tank dangerous spells", self.menu_interruptW, self.menu)
		Menu_Separator()
        self.menu_interruptR = Menu_Bool("Use R to hinder dangerous spells", self.menu_interruptR, self.menu)
			Menu_End()
        end
        if Menu_Begin("Harass") then
			self.HarQ = Menu_Bool("Harass Q on marked enemies", self.HarQ, self.menu)
            self.HarQdis = Menu_SliderInt("Harass min Q Distance", self.HarQdis, 0, 625, self.menu)
			self.HarE = Menu_Bool("Harass E", self.HarE, self.menu)
            self.HarEdis = Menu_SliderInt("Harass max E Distance", self.HarEdis, 0, 800, self.menu)
			self.HarW = Menu_Bool("Harass W", self.HarW, self.menu)
            self.HarWdis = Menu_SliderInt("Harass max W range", self.HarWdis, 0, 500, self.menu)
			Menu_End()
        end
        if Menu_Begin("Clear skills") then
			self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LQMana = Menu_SliderInt("Min MP % for using Lane Q", self.LQMana, 0, 100, self.menu)
			self.JQ = Menu_Bool("Jungle Q", self.JQ, self.menu)
            self.JQMana = Menu_SliderInt("Min MP % for using Jungle Q", self.JQMana, 0, 100, self.menu)
			self.JW = Menu_Bool("Jungle W", self.JW, self.menu)
            self.JWMana = Menu_SliderInt("Min MP % for using Jungle W", self.JWMana, 0, 100, self.menu)
			self.JE = Menu_Bool("Jungle E", self.JE, self.menu)
            self.JEMana = Menu_SliderInt("Min MP % for using Jungle E", self.JEMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Last Hit") then
			self.LHQ = Menu_Bool("Last hit with Q", self.LHQ, self.menu)
            self.LHQMana = Menu_SliderInt("Min MP % for using Last Hit Q", self.LHQMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R", self.DR, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal with Q", self.KQ, self.menu)
            self.KR = Menu_Bool("KillSteal with R", self.KR, self.menu)
			Menu_End()
        end
		if Menu_Begin("Keys") then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LastHit = Menu_KeyBinding("Last Hit", self.LastHit, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
			Menu_End()
		end
		if Menu_Begin("Mod Skin") then
			self.Enable_Mod_Skin = Menu_Bool("Enable Mod Skin", self.Enable_Mod_Skin, self.menu)
			self.Set_Skin = Menu_SliderInt("Set Skin", self.Set_Skin, 0, 20, self.menu)
			Menu_End()
		end
		Menu_End()
	end

function Irelia:autoQtoEndDash()
	for i, enemy in pairs(GetEnemyHeroes()) do
		if enemy ~= nil then
		    target = GetAIHero(enemy)
		    if IsValidTarget(target.Addr, self.Q.range) then
		    --local QPos, QHitChance = HPred:GetPredict(self.HPred_Q_M, target, myHero)
			  --  local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(target, self.Q.delay, self.Q.width, self.Q.speed, myHero, true)	    	
			    --if IsValidTarget(target.Addr, self.maxGrab) then
			    	if target.IsDash then
						--CastSpellToPos(QPos.x, QPos.z, _Q)
					--end
			    --end
			    --if DashPosition ~= nil then
			    	--if GetDistance(DashPosition) <= self.Q.range then
			  		--local Collision = CountObjectCollision(0, target.Addr, myHero.x, myHero.z, DashPosition.x, DashPosition.z, self.Q.width, self.Q.range, 65)
				  		--local Collision = CountCollision(myHero.x, myHero.z, DashPosition.x, DashPosition.z, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, 0, 5, 5, 5, 5)
				  		--if Collision == 0 then
					    	CastSpellTarget(target.Addr, _Q)
					    end
					end
				end
			end
			end	
	
function Irelia:EnemyMinionsTbl() --SDK Toir+
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if IsEnemy(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and GetType(minions.Addr) == 1 then
                table.insert(result, minions)
            end
        end
    end
    return result
end

function Irelia:FarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LHQMana and self.LHQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > (minion.HP + 40) then
		CastSpellTarget(minion.Addr, _Q)
       end 
       end 
    end 
end

function Irelia:LaneFarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LQMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > (minion.HP + 40) then
	   CastSpellTarget(minion.Addr, _Q)
       end 
       end 
    end 
end 

function Irelia:OnDraw()
    if self.DQWER then

    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.Q.range+90, Lua_ARGB(255,255,0,0))
      end
	  
    if self.DW and self.W:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.W.range+120, Lua_ARGB(255,255,0,0))
      end

      if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range+140, Lua_ARGB(255,0,0,255))
      end

      if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.range+150, Lua_ARGB(255,0,0,255))
    end
   end 
end 

function Irelia:KillEnemy()
    local QKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
        CastSpellTarget(Enemy.Addr, _Q)
    end   
    local RKS = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(RKS)
    if CanCast(_R) and self.KR and RKS ~= 0 and GetDistance(Enemy) < 900 and GetDamage("R", Enemy) > Enemy.HP then
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetRLinePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _R)
        end
    end  
end 

function Irelia:CastQ(target)
    if target and target ~= 0 and IsEnemy(target) then
	if not self.E:IsReady() then 
		if CanCast(_Q)
			and self.CQ
			and IsValidTarget(target, self.Q.range)
			and self:IsMarked(GetAIHero(target)) 
			and GetDistance(GetAIHero(target)) >= self.CQdis
			then
				CastSpellTarget(Enemy.Addr, _Q)
			end 
		end
	end
end

--[[
function Irelia:CastQChase()
    local targetL = GetTargetSelector(1000, 0)
    target = GetAIHero(targetL)
    if targetL ~= 0 then
	if self.Q:IsReady() 
	and IsValidTarget(target, self.Q.Range)
	and GetDistance(GetAIHero(target)) > 610
	and not self.E:IsReady()
	then
        CastSpellTarget(target.Addr, _Q)
    end 
end
end]]

function Irelia:QHarass(target)
    if target and target ~= 0 and IsEnemy(target) then
	if not self.E:IsReady() then
    if CanCast(_Q)
	and self.HarQ
	and IsValidTarget(target, self.Q.range)
	and self:IsMarked(GetAIHero(target))
	and GetDistance(GetAIHero(target)) > self.HarQdis
	then
        CastSpellTarget(Enemy.Addr, _Q)
    end 
end
end
end

--Check W Casting
function Irelia:OnUpdateBuff(source,unit,buff,stacks)
      if buff.Name == "ireliawdefense" and unit.IsMe then
            self.isQactive = true
            self.qtime = GetTimeGame()
		end
	end

function Irelia:OnRemoveBuff(Object, buff)
      if buff.Name == "ireliawdefense" and unit.IsMe then
            self.isQactive = false
            self.qtime = 0
		end
end

--Check if target has buff E
function Irelia:IsMarked(target)
    return target.HasBuff("ireliamark")
end

function Irelia:CastW()
    local UseW = GetTargetSelector(1000)
    if not self.Q:IsReady() and UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.CW and GetPercentHP(myHero.Addr) < self.CWHP and IsValidTarget(Enemy, self.CWdis) then 
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(CEPosition.x, CEPosition.z, _W)
			DelayAction(function() 
				CastSpellToPos(CEPosition.x, CEPosition.z, _W)
			end,1.4)
			DelayAction(function() 
				CastSpellTarget(Enemy.Addr, _Q)
			end,0.1)  
        end
    end 

	
function Irelia:Wharass()
    local UseW = GetTargetSelector(1000)
    if not self.Q:IsReady() and UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.HarW and IsValidTarget(Enemy, self.HarWdis) then 
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(CEPosition.x, CEPosition.z, _W) 
			DelayAction(function() 
				CastSpellToPos(CEPosition.x, CEPosition.z, _W)
			end,1.4)
        end
    end 

function Irelia:CheckWalls(enemyPos)
	local distance = GetDistance(enemyPos)
	local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)

	for i = 100 , 900, 100 do
		local qPos = Vector(enemyPos.x + i, enemyPos.y + i, enemyPos.z)
		--pos = myHeroPos:Extended(enemyPos, distance + 60 * i)
		if IsWall(qPos.x, qPos.y, qPos.z) then
			return qPos
		end
	end
	--return false
end

function Irelia:GetELinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero.x, myHero.z, false, true, 1, 3, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Irelia:GetRLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero.x, myHero.z, false, true, 1, 3, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Irelia:CastE()
    local mousePosition = Vector(GetMousePos())
    local targetL = GetTargetSelector(2000, 0)
    target = GetAIHero(targetL)
    if targetL ~= 0 and self.CE then
        if self.EMode == 0 then
            if self.E:IsReady() and IsValidTarget(target, 800) then
                    if HavingE1() then
                    local point2 = Vector(myHero):Extended(Vector(target), -200)
                    CastSpellToPos(point2.x, point2.z, _E) 
                end   
            end
        end 
        if self.EMode == 1 then
            if self.E:IsReady() and IsValidTarget(target, 900) then
                if HavingE1() then
                    CastSpellToPos(mousePosition.x, mousePosition.z, _E)
                end 
            end
        end 
		if IsValidTarget(target.Addr, self.E.range) then
			      --[[ local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 3 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)]]
			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetELinePreCore(target)
--    __PrintTextGame(HitChance)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
            end 
        end 
   end                            
end 

function Irelia:DashEndPos(target)
    local Estent = 0

    if GetDistance(target) < 410 then
        Estent = Vector(myHero):Extended(Vector(target), 410)
    else
        Estent = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
    end

    return Estent
end

function Irelia:GetGapMinion(target)
    GetAllUnitAroundAnObject(myHero.Addr, 1600)
    local bestMinion = nil
    local closest = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and not IsDead(unit) and not IsInFog(unit) and GetTargetableToTeam(unit) == 4 and not self:IsMarked(GetUnit(unit)) and GetDistance(GetUnit(unit)) < 476 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), target) < GetDistance(target) and closest < GetDistance(GetUnit(unit)) then
                closest = GetDistance(GetUnit(unit))
                bestMinion = unit
            end
        end
    end
    return bestMinion
end

function Irelia:CastQFaraway()
    local mousePosition = Vector(GetMousePos())
    local targetL = GetTargetSelector(2000, 0)
    target = GetAIHero(targetL)
    if targetL ~= 0 then
        if self.Q:IsReady() and self.CQgapclose and IsValidTarget(target, 2000) then
                local gacha = self:GetGapMinion(target)
                if gacha and gacha ~= 0 then
                    CastSpellTarget(gacha, _Q)
                end 
            end 
        end 
        if self.Q:IsReady() and self.CQgapclosekill and IsValidTarget(target, 2000) then
                local gacha = self:GetGapMinion(target)
                if gacha and gacha ~= 0 and GetDamage("Q", gacha) > (gacha.HP + 30) then
                    CastSpellTarget(gacha, _Q)
                end 
            end 
--    end
    for i, minion in pairs(self:EnemyMinionsTbl(700)) do
        if minion ~= 0 then
            if self.CQEx and GetDamage("Q", minion) > (minion.HP + 40) and GetDistance(minion) <= self.MQdis then   
                    CastSpellTarget(minion.Addr, _Q)
                end 
            end 
        end 
    end 
--end 

function HavingE1()  
	if GetSpellNameByIndex(myHero.Addr, _E) == "IreliaE" then 
		return true 
	else 
		return false
	end
end

function HavingE2()  
	if GetSpellNameByIndex(myHero.Addr, _E) == "IreliaE2" then 
		return true 
	else 
		return false
	end
end	

function Irelia:Eharass()
    local mousePos = Vector(GetMousePos())
    local targetL = GetTargetSelector(2000, 0)
    target = GetAIHero(targetL)
    if targetL ~= 0 and self.HarE and GetDistance(Enemy) <= self.HarEdis then
        if self.EMode == 0 then
            if self.E:IsReady() and IsValidTarget(target, 800) then
                    if HavingE1() then
                    local point2 = Vector(myHero):Extended(Vector(target), -200)
                    CastSpellToPos(point2.x, point2.z, _E) 
                end   
            end
        end 
        if self.EMode == 1 then
            if self.E:IsReady() and IsValidTarget(target, 900) then
                if HavingE1() then
                    CastSpellToPos(mousePos.x, mousePos.z, _E)
                end 
            end
        end 
		if IsValidTarget(target.Addr, self.E.range) then
			      --[[ local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 3 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)]]
			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetELinePreCore(target)
			if HitChance >= 4 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
            end 
        end 
   end                            
end 

function Irelia:CastR()
    local Rcombo = GetTargetSelector(1000)
    Enemy = GetAIHero(Rcombo)
    if CanCast(_R) and self.CR and Rcombo ~= 0 and GetDistance(Enemy) < 800 and GetPercentHP(Enemy.Addr) <= self.CRlow then
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetRLinePreCore(target)
			if HitChance >= 5 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _R)
        end
    end   
end 

function Irelia:JungleMinionsKILL() --SDK Toir+
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local jungle = GetUnit(obj)
            if not IsDead(jungle.Addr)
			and not	IsInFog(jungle.Addr)
			and GetType(jungle.Addr) == 3
			then
                table.insert(result, jungle)
            end
        end
    end
    return result
end

function Irelia:FarmQJungle()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JQMana
	   and IsValidTarget(jungle.Addr, self.Q.range)
	   and GetDamage("Q", jungle) > (jungle.HP + 40)
	   then
		CastSpellTarget(jungle.Addr, _Q)
       end 
    end 
end
end

function Irelia:FarmQMark()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if self.Q:IsReady()
	   and GetPercentMP(myHero.Addr) >= self.JQMana
	   and IsValidTarget(jungle.Addr, self.Q.range)
	   and self:IsMarked(GetUnit(jungle.Addr)) 
	   then
		CastSpellTarget(jungle.Addr, _Q)
       end 
    end 
end
end


function Irelia:FarmWJungle()
	if CanCast(_W) and self.JW and GetPercentMP(myHero.Addr) >= self.JWMana and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
	    	local targetPos, HitChance, Position = self.Predc:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _W)  
		end
    end
	end
	
function Irelia:FarmEJungle()
	if CanCast(_E) and self.JE and GetPercentMP(myHero.Addr) >= self.JEMana and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
	    	local targetPos, HitChance, Position = self.Predc:GetLineCastPosition(target, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _E)
		end
    end
end



function Irelia:ComboQIreli()
		local target = self.menu_ts:GetTarget()
    if self.CQ then
        self:CastQ(target)
    end
--	if self.CQchase then
--		self:CastQChase()
 --  end
end 

function Irelia:JungleIreli()
	if self.JE then
        self:FarmEJungle()
    end
	if self.JQ then
        self:FarmQJungle()
        self:FarmQMark()
    end
	if self.JW and not CanCast(_E) then
        self:FarmWJungle()
    end
	end

function Irelia:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()
	
    if GetKeyPress(self.LastHit) > 0 then	
        self:FarmeQ()
		self:LastLane()
    end
	
    if GetKeyPress(self.Harass) > 0 then	
		local target = self.menu_ts:GetTarget()
        self:Eharass()
		self:Wharass()
        self:QHarass(target)
    end

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneFarmeQ()
		self:JungleIreli()
		self:LastLane()
    end

	if GetKeyPress(self.Combo) > 0 then
		self:ComboQIreli()
        self:CastE()
        self:CastW()
        self:CastR()
		self:CastQFaraway()
    end
	
if self.AutoLevelTop then
    if myHero.Level  == 1 then
        LevelUpSpell(_Q)
        end 
    if myHero.Level  == 2 then
        LevelUpSpell(_E)
        end 
    if myHero.Level  == 3 then
        LevelUpSpell(_W)
        end 
    if myHero.Level  == 4 then
        LevelUpSpell(_Q)
        end 
    if myHero.Level  == 5 then
        LevelUpSpell(_Q)
        end 
    if myHero.Level  == 6 then
        LevelUpSpell(_R)
        end 
    if myHero.Level  == 7 then
        LevelUpSpell(_Q)
        end 
    if myHero.Level  == 8 then
        LevelUpSpell(_E)
        end 
    if myHero.Level  == 9 then
        LevelUpSpell(_Q)
        end 
    if myHero.Level  == 10 then
        LevelUpSpell(_E)
        end 
    if myHero.Level  == 11 then
        LevelUpSpell(_R)
        end 
    if myHero.Level  == 12 then
        LevelUpSpell(_E)
        end 
    if myHero.Level  == 13 then
        LevelUpSpell(_E)
        end 
    if myHero.Level  == 14 then
        LevelUpSpell(_W)
        end 
    if myHero.Level  == 15 then
        LevelUpSpell(_W)
        end 
    if myHero.Level  == 16 then
        LevelUpSpell(_R)
        end 
    if myHero.Level  == 17 then
        LevelUpSpell(_W)
        end 
    if myHero.Level  == 18 then
        LevelUpSpell(_W)
        end    
    end	
	
end 

function Irelia:aa()
	self.listEndDash =
	{
		{Name = "ZoeR", RangeMin = 570, Range = 570, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "MaokaiW", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CamilleE", RangeMin = 0, Range = math.huge, Type = 1, Duration = 1.25}, --MaokaiW
		{Name = "BlindMonkQTwo", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
		{Name = "BlindMonkWOne", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
		{Name = "NocturneParanoia2", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
		{Name = "XinZhaoE", RangeMin = 0, Range = 100, Type = 2, Duration = 0.25}, --CHUAN
		{Name = "PantheonW", RangeMin = 0, Range = 200, Type = 2, Duration = 0.25}, --CHUAN
		{Name = "AkaliShadowDance", RangeMin = 0, Range = - 100, Type = 2, Duration = 0.25}, --CHUAN
		{Name = "AkaliSmokeBomb", RangeMin = 0, Range = 250, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "Headbutt", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "BraumW", RangeMin = 0, Range = - 140, Type = 2, Duration = 0.25}, --CHUAN
		{Name = "DianaTeleport", RangeMin = 0, Range = 80, Type = 2, Duration = 0.25}, --50% CHUAN
		{Name = "JaxLeapStrike", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "MonkeyKingNimbus", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "PoppyE", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
		{Name = "IreliaGatotsu", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "UFSlash", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN MalphiteR
		{Name = "LucianE", RangeMin = 200, Range = 430, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "EzrealArcaneShift", RangeMin = 0, Range = 470, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "TristanaW", RangeMin = 0, Range = 900, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "SummonerFlash", RangeMin = 0, Range = 400, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "AhriTumble", RangeMin = 0, Range = 500, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CarpetBomb", RangeMin = 300, Range = 600, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "FioraQ", RangeMin = 0, Range = 400, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "KindredQ", RangeMin = 0, Range = 300, Type = 1, Duration = 0.25}, --CHUAn
		{Name = "RiftWalk", RangeMin = 0, Range = 500, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "FizzETwo", RangeMin = 0, Range = 300, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "FizzE", RangeMin = 0, Range = 400, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CamilleEDash2", RangeMin = 0, Range = 400, Type = 1, Duration = 0.25}, --50% CHUAN
		{Name = "AatroxQ", RangeMin = 0, Range = 650, Type = 1, Duration = 0.5}, --CHUAN
		{Name = "RakanW", RangeMin = 0, Range = 650, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "QuinnE", RangeMin = 0, Range = 600, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "JarvanIVDemacianStandard", RangeMin = 0, Range = 850, Type = 1, Duration = 0.25}, --Ezreal E
		{Name = "ShyvanaTransformLeap", RangeMin = 0, Range = 1000, Type = 1, Duration = 0.25}, --Ezreal E
		{Name = "ShenE", RangeMin = 300, Range = 600, Type = 1, Duration = 0.5}, --CHUAN
		{Name = "Deceive", RangeMin = 0, Range = 400, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "SejuaniQ", RangeMin = 0, Range = 650, Type = 1, Duration = 0.25}, --Ezreal E
		{Name = "KhazixE", RangeMin = 0, Range = 700, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "KhazixELong", RangeMin = 0, Range = 900, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "TryndamereE", RangeMin = 0, Range = 650, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "LeblancW", RangeMin = 0, Range = 600, Type = 1, Duration = 0.25}, --Ezreal E
		{Name = "GalioE", RangeMin = 0, Range = 625, Type = 1, Duration = 0.5}, --Ezreal E
		{Name = "ZacE", RangeMin = 0, Range = 1200, Type = 1, Duration = 1}, --Ezreal E
		{Name = "ViQ", RangeMin = 0, Range = 720, Type = 1, Duration = 0.25}, --Ezreal E
		{Name = "EkkoEAttack", RangeMin = 0, Range = 150, Type = 2, Duration = 0.25}, --CHUAN
		{Name = "TalonQ", RangeMin = 0, Range = 120, Type = 2, Duration = 0.25}, --CHUAN
		{Name = "EkkoE", RangeMin = 350, Range = 350, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "FizzQ", RangeMin = 550, Range = 600, Type = 1, Duration = 0.25}, --50% CHUAN
		{Name = "GragasE", RangeMin = 700, Range = 600, Type = 1, Duration = 0.25}, --Ezreal E
		{Name = "GravesMove", RangeMin = 280, Range = 370, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "OrnnE", RangeMin = 650, Range = 650, Type = 1, Duration = 0.75}, --CHUAN
		{Name = "Pounce", RangeMin = 370, Range = 370, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "RivenFeint", RangeMin = 250, Range = 250, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "KaynQ", RangeMin = 350, Range = 350, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "RenektonSliceAndDice", RangeMin = 450, Range = 450, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "RenektonDice", RangeMin = 450, Range = 450, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "VayneTumble", RangeMin = 300, Range = 300, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "UrgotE", RangeMin = 470, Range = 470, Type = 3, Duration = 0.25}, --Ezreal E
		{Name = "JarvanIVDragonStrike", RangeMin = 850, Range = 850, Type = 1, Duration = 0.25}, --Ezreal E
		{Name = "WarwickR", RangeMin = 1000, Range = 1000, Type = 1, Duration = 1}, --CHUAN
		{Name = "ZiggsDashWrapper", RangeMin = 480, Range = 480, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CaitlynEntrapment", RangeMin = -380, Range = -380, Type = 1, Duration = 0.25}, --CHUAN
	}
end
