IncludeFile("Lib\\SDK.lua")
IncludeFile("Lib\\DamageIndicator.lua")

class "DeepMalphite"

local Version = 8.12
local Author = "Deep"

function OnLoad()
    if myHero.CharName ~= "Malphite" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#cffffff00\"> Shard Of The Monolith!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Malphite for LOL version</font></b> " ..Version)
    __PrintTextGame("<b><font color=\"#00FF00\">Author: </font></b> " ..Author)
    DeepMalphite:__init()
end

function DeepMalphite:__init()

    SetLuaCombo(true)
    SetLuaHarass(true)
    SetLuaLaneClear(true)

    self.listSpellInterrup = {
    ["CaitlynAceintheHole"] = true,
    ["Crowstorm"] = true,
	["JhinR"] = true,
    ["KarthusFallenOne"] = true,
    ["KatarinaR"] = true,
    ["LucianR"] = true,
    ["AlZaharNetherGrasp"] = true,
    ["MissFortuneBulletTime"] = true,
    ["Destiny"] = true,
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
	["CarpetBomb"] = true,
	["FioraQ"] = true,
	["KindredQ"] = true,
	["RiftWalk"] = true,
	["FizzETwo"] = true,
	["FizzE"] = true,
	["CamilleEDash2"] = true,
	["AatroxQ"] = true,
	["RakanW"] = true,
	["QuinnE"] = true,
	["JarvanIVDemacianStandard"] = true,
	["ShyvanaTransformLeap"] = true,
	["MalphiteE"] = true,
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
	
    self.Q = Spell({Slot = 0, Range = 625})
    self.W = Spell({Slot = 1, Range = 225})
    self.E = Spell({Slot = 2, Range = 200})
    self.R = Spell({Slot = 3, SpellType = Enum.SpellType.SkillShot, Range = 1000, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 300, Delay = 0.1, Speed = 1835 + myHero.MoveSpeed})

    self:MenuDeep()
    
    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
--    AddEvent(Enum.Event.OnUpdate, function(...) self:OnUpdate(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
--    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
--    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
--    AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)

    __PrintTextGame("<b><font color=\"#cffffff00\">Deep Malphite</font></b> <font color=\"#ffffff\">Loaded Successfully</font>")
end
   
function DeepMalphite:Fleemouse()
    local mousePos = Vector(GetMousePos())
    MoveToPos(mousePos.x,mousePos.z)
end 
	
function DeepMalphite:QFlee()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 625) then 
                self:CastQ(target)
            end 
        end 
    end
end

--[[
function DeepMalphite:Automatic()
    for k, v in pairs(self:GetAllies(9999)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 9999) then
			if not self.CRlowHP then
                self:CastRbasic(target)
				end
			if self.CRlowHP then
                self:CastRHP(target)
				end
            end			
        end 
    end 
end]]

function DeepMalphite:LastLane()
    for i, minion in pairs(self:EnemyMinionsTbl(500)) do
        if minion ~= 0 then
            if self.Q:IsReady() 
			and self.LhitQ 
			and GetPercentMP(myHero) >= self.LhitQMana 
			and GetDistance(Vector(minion)) <= 650 
			and self.Q:GetDamage(minion) > minion.HP 
			then
                CastSpellTarget(minion.Addr, _Q)
            end
		end
	end
end
	
function DeepMalphite:Clearlane()
    for i, minion in pairs(self:EnemyMinionsTbl(500)) do
        if minion ~= 0 then
            if self.Q:IsReady() 
			and self.LQ 
			and GetPercentMP(myHero) >= self.LQMana 
			and GetDistance(Vector(minion)) <= 650 
			and self.Q:GetDamage(minion) > minion.HP 
			then
                CastSpellTarget(minion.Addr, _Q)
            end
            if self.W:IsReady() 
			and self.LW 
			and GetPercentMP(myHero) >= self.LWMana 
			and GetDistance(Vector(minion)) <= 300 
			then
                CastSpellTarget(myHero.Addr, _W)
            end
            if self.E:IsReady() 
			and self.LE 
			and GetPercentMP(myHero) >= self.LEMana 
			and GetDistance(Vector(minion)) <= 300 
			and self.E:GetDamage(minion) > minion.HP 
			then
                CastSpellTarget(myHero.Addr, _E)
            end
        end 
    end 
end 

function DeepMalphite:Clearjungle()
    for i, junged in pairs(self:EnemyJungleTbl(500)) do 
        if junged ~= 0 then
            if self.Q:IsReady() 
			and not self.JQKeep 
			and GetPercentMP(myHero) >= self.JQMana 
			and GetDistance(Vector(junged)) <= 650 
			then
                CastSpellTarget(junged.Addr, _Q)
            end
            if self.Q:IsReady() 
			and self.JQKeep 
			and GetDistance(Vector(junged)) <= 650 
			and self.Q:GetDamage(junged) > junged.HP 
			then
                CastSpellTarget(junged.Addr, _Q)
            end
            if self.W:IsReady() 
			and self.JW 
			and GetPercentMP(myHero) >= self.JWMana 
			and GetDistance(Vector(junged)) <= 300 
			then
                CastSpellTarget(myHero.Addr, _W)
            end
            if self.E:IsReady() 
			and not self.JEKeep 
			and GetPercentMP(myHero) >= self.JEMana 
			and GetDistance(Vector(junged)) <= 200 
			then
                CastSpellTarget(myHero.Addr, _E)
            end
            if self.E:IsReady() 
			and self.JEKeep 
			and GetDistance(Vector(junged)) <= 300 
			and self.E:GetDamage(junged) > junged.HP 
			then
                CastSpellTarget(myHero.Addr, _E)
            end
        end 
    end           
end 

function DeepMalphite:KillEnemy()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if self.KQ 
			and IsValidTarget(target, 650) 
			and self.Q:GetDamage(target) > target.HP 
			then 
				CastSpellTarget(target.Addr, _Q)
            end
    end
end
end

function DeepMalphite:OnProcessSpell(unit, spell)
    if self.R:IsReady()
	and self.interruptR
	and unit
	and spell
	and unit.IsEnemy
	and not unit.IsDead
	and IsChampion(unit.Addr)
	and GetDistance(unit) <= 1000
	then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellInterrup[spell.Name] ~= nil and not unit.IsMe then
			target = GetAIHero(unit.Addr)
			local CastPosition, HitChance, Position = self:GetRCirclePreCore(target)
			if HitChance >= 6 then
				CastSpellToPos(CastPosition.x, CastPosition.z, _R)
			end
        end 
    end 
    if self.interruptQ
	and unit
	and spell
	and unit.IsEnemy
	and IsChampion(unit.Addr)
	and GetDistance(unit) < self.dashrange
	then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellDash[spell.Name] ~= nil and not unit.IsMe then
            CastSpellTarget(unit.Addr, _Q)  
        end 
    end 
end 

function DeepMalphite:OnDraw()
    local pos = Vector(myHero)

    if self.DrawERange then
        DrawCircleGame(pos.x, pos.y, pos.z, 600, Lua_ARGB(255, 0, 204, 255))
    end 

    if self.DrawDamage then
        local selected = GetTargetSelected()
        local target = GetUnit(selected)
        if target == 0 then
            target = GetTarget(range)
        end
        if not target then return end
        local dmg = self:ComboDamage(target)
        DamageIndicator:DrawDamage(target, dmg, Lua_ARGB(255, 255, 255, 255))
    end 
end 

function DeepMalphite:CastQ(target)
    if self.CQ and GetDistance(Vector(target), Vector(myHero)) <= 650 then
		CastSpellTarget(target.Addr, _Q)
    end 
end 

function DeepMalphite:CastQHarass(target)
    if GetDistance(Vector(target), Vector(myHero)) <= 650 then
		CastSpellTarget(target.Addr, _Q)
    end 
end 

function DeepMalphite:CastW(target)
    if self.CW and GetDistance(Vector(target), Vector(myHero)) <= 300 then
		CastSpellTarget(myHero.Addr, _W)
    end 
end 

function DeepMalphite:CastWHarass(target)
    if GetDistance(Vector(target), Vector(myHero)) <= 300 then
		CastSpellTarget(myHero.Addr, _W)
        end 
    end 

function DeepMalphite:CastE(target)
    if self.CE and GetDistance(Vector(target), Vector(myHero)) <= 300 then
		CastSpellTarget(myHero.Addr, _E)
    end 
end 

function DeepMalphite:CastEHarass(target)
    if GetDistance(Vector(target), Vector(myHero)) <= 300 then
		CastSpellTarget(myHero.Addr, _E)
    end 
end

function DeepMalphite:CastR(target)
    if self.CR 
	and self.R:IsReady() 
	and IsValidTarget(target, 1000) 
	and GetPercentHP(target) <= self.CRlow
	and CountEnemyChampAroundObject(target.Addr, 320) >= (self.CRnum - 1)
	then
        local CastPosition, HitChance, Position = self:GetRCirclePreCore(target)
        if HitChance >= 6 then
			CastSpellToPos(CastPosition.x, CastPosition.z, _R)
        end 
	end
end

function DeepMalphite:CastRkill(target)
	if self.KR 
	and self:ComboDamage(target) > GetRealHP(target, 1) 
	and self.R:IsReady() 
	and IsValidTarget(target, 1000) 
	then
		local CastPosition, HitChance, Position = self:GetRCirclePreCore(target)
		if HitChance >= 6 then
			CastSpellToPos(CastPosition.x, CastPosition.z, _R)
		end 
    end 	
end
	
function DeepMalphite:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function DeepMalphite:GetEnemies(range)
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

function DeepMalphite:GetIgniteIndex()
    if GetSpellIndexByName("SummonerDot") > -1 then
        return GetSpellIndexByName("SummonerDot")
    end
	return -1
end

function DeepMalphite:EnemyMinionsTbl(range)
    GetAllUnitAroundAnObject(myHero.Addr, range)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if IsEnemy(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and (GetType(minions.Addr) == 1 or GetType(minions.Addr) == 3) then
                table.insert(result, minions)
            end
        end
    end
    return result
end

function DeepMalphite:EnemyJungleTbl(range)
    GetAllUnitAroundAnObject(myHero.Addr, range)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if not IsEnemy(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and GetType(minions.Addr) == 3 then
			if (GetObjName(minions.Addr) ~= "PlantSatchel" and GetObjName(minions.Addr) ~= "PlantHealth" and GetObjName(minions.Addr) ~= "PlantVision") then
                table.insert(result, minions)
				end
            end
        end
    end
    return result
end

	 
function DeepMalphite:MenuDeep()
    self.menu = "Deep Malphite"

    --Combo
    self.CQ = self:MenuBool("Use Q", true)
    self.CW = self:MenuBool("Use W", true)
    self.CE = self:MenuBool("Use E", true)

    self.CR = self:MenuBool("Combo R", true)
    self.CRlow = self:MenuSliderInt("Enemy min HP to use R", 80)
    self.CRnum = self:MenuSliderInt("Combo R to X enemies", 2)

	--Harass
    self.HarQ = self:MenuBool("Harass Q", true)
    self.HarW = self:MenuBool("Harass W", true)
    self.HarE = self:MenuBool("Harass E", true)

    --Killsteal
    self.KQ = self:MenuBool("KillSteal with Q", true)
    self.KR = self:MenuBool("KillSteal with R", true)
	
	--Clear
    self.LhitQ = self:MenuBool("Lane last Q", true)
    self.LhitQMana = self:MenuSliderInt("Mana Lane last Q %", 30)
    self.LQ = self:MenuBool("Lane Q", true)
    self.LW = self:MenuBool("Lane W", true)
    self.LE = self:MenuBool("Lane E", true)
    self.LQMana = self:MenuSliderInt("Mana Lane Q %", 30)
    self.LWMana = self:MenuSliderInt("Mana Lane W %", 30)
    self.LEMana = self:MenuSliderInt("Mana Lane E %", 30)
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JQKeep = self:MenuBool("Jungle Q lasthit", false)
    self.JW = self:MenuBool("Jungle W", true)
    self.JE = self:MenuBool("Jungle E", true)
    self.JEKeep = self:MenuBool("Jungle E lasthit", false)
    self.JQMana = self:MenuSliderInt("Mana Jungle Q %", 30)
    self.JWMana = self:MenuSliderInt("Mana Jungle W %", 30)
    self.JEMana = self:MenuSliderInt("Mana Jungle E %", 30)

    --Auto
    self.AutoLevelTop = self:MenuBool("Auto level", true)
    self.interruptQ = self:MenuBool("Use Q on dashing enemies", true)
    self.interruptR = self:MenuBool("Use R to interrupt channeling spells", false)
    self.dashrange = self:MenuSliderInt("Spell dash detection range", 900)
  
	--Drawing
    self.DrawDamage = self:MenuBool("Draw Damage", true)
    self.DrawQRange = self:MenuBool("Draw Q Range", true)
    self.DrawRRange = self:MenuBool("Draw R Range", true)
	
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	self.Harass = self:MenuKeyBinding("Harass", 67)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
	self.Flee = self:MenuKeyBinding("Flee", 71)
	self.FQ = self:MenuBool("Flee Q", true)
  
    self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", true)
    self.Set_Skin = self:MenuSliderInt("Set Skin", 8)
  end
  
function DeepMalphite:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end

    if (Menu_Begin("Combo")) then
        self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
        self.CW = Menu_Bool("Combo W", self.CW, self.menu)
        self.CE = Menu_Bool("Combo E", self.CE, self.menu)
		Menu_Separator()
        self.CR = Menu_Bool("Combo R", self.CR, self.menu)
        self.CRlow = Menu_SliderInt("Enemy min % HP to Combo R", self.CRlow, 0, 100, self.menu)
        self.CRnum = Menu_SliderInt("Combo R to X enemies", self.CRnum, 1, 5, self.menu)
		        Menu_Text("--OR--")
        self.KR = Menu_Bool("Combo R if your combo can kill", self.KR, self.menu)
        Menu_End()
    end 
	     	
    if (Menu_Begin("Auto misc")) then
        self.AutoLevelTop = Menu_Bool("Auto Level", self.AutoLevelTop, self.menu)
		Menu_Separator()
        self.interruptR = Menu_Bool("Use R to interrupt channeling spells", self.interruptR, self.menu)
		Menu_Separator()
        self.interruptQ = Menu_Bool("Use Q on dashing enemies", self.interruptQ, self.menu)
		self.dashrange = Menu_SliderInt("Dash spells detection range", self.dashrange, 500, 1200, self.menu)
        Menu_End()
    end 
    if (Menu_Begin("Harass")) then
		self.HarQ = Menu_Bool("Harass Q", self.HarQ, self.menu)
        Menu_Separator()
		self.HarW = Menu_Bool("Harass W", self.HarW, self.menu)
        Menu_Separator()
		self.HarE = Menu_Bool("Harass E", self.HarE, self.menu)
		Menu_End()
    end
    if (Menu_Begin("Killsteal")) then
        self.KQ = Menu_Bool("Killsteal with Q", self.KQ, self.menu)
		Menu_End()
    end
	
    if (Menu_Begin("Clear skills")) then
		self.LhitQ = Menu_Bool("Last hit Q", self.LhitQ, self.menu)
        self.LhitQMana = Menu_SliderInt("Min MP % for using Last hit Q", self.LhitQMana, 0, 100, self.menu)
        Menu_Separator()
		self.LQ = Menu_Bool("Clear Q", self.LQ, self.menu)
        self.LQMana = Menu_SliderInt("Min MP % for using Clear Q", self.LQMana, 0, 100, self.menu)
        Menu_Separator()
		self.LW = Menu_Bool("Clear W", self.LW, self.menu)
        self.LWMana = Menu_SliderInt("Min MP % for using Clear W", self.LWMana, 0, 100, self.menu)
        Menu_Separator()
		self.LE = Menu_Bool("Clear E", self.LE, self.menu)
        self.LEMana = Menu_SliderInt("Min MP % for using Clear E", self.LEMana, 0, 100, self.menu)
        Menu_Separator()
		self.JQ = Menu_Bool("Jungle Q", self.JQ, self.menu)
		self.JQKeep = Menu_Bool("Keep Q to last hit jungle", self.JQKeep, self.menu)
        self.JQMana = Menu_SliderInt("Min MP % for using Jungle Q", self.JQMana, 0, 100, self.menu)
        Menu_Separator()
		self.JW = Menu_Bool("Jungle W", self.JW, self.menu)
        self.JWMana = Menu_SliderInt("Min MP % for using Jungle W", self.JWMana, 0, 100, self.menu)
        Menu_Separator()
		self.JE = Menu_Bool("Jungle E", self.JE, self.menu)
		self.JEKeep = Menu_Bool("Keep E to last hit jungle", self.JEKeep, self.menu)
        self.JEMana = Menu_SliderInt("Min MP % for using Jungle E", self.JEMana, 0, 100, self.menu)
		Menu_End()
    end
	
    if (Menu_Begin("Drawings")) then
        self.DrawDamage = Menu_Bool("Draw Damage", self.DrawDamage, self.menu)
        self.DrawQRange = Menu_Bool("Draw Q Range", self.DrawQRange, self.menu)
        self.DrawRRange = Menu_Bool("Draw R Range", self.DrawRRange, self.menu)
        Menu_End()
    end
	
    if (Menu_Begin("Keys")) then
        self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
		self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
        self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
        self.LastHit = Menu_KeyBinding("Last Hit", self.LastHit, self.menu)
		self.Flee = Menu_KeyBinding("Flee", self.Flee, self.menu)
		self.FQ = Menu_Bool("Flee Q", self.FQ, self.menu)
		Menu_End()
    end
	
    self.Enable_Mod_Skin = Menu_Bool("Enable Mod Skin", self.Enable_Mod_Skin, self.menu)
    self.Set_Skin = Menu_SliderInt("Set Skin", self.Set_Skin, 0, 20, self.menu)
    Menu_End()   
end

function DeepMalphite:HarassMalphite()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 1100) then
				if self.HarQ then
                self:CastQHarass(target)
				end
				if self.HarW then
				self:CastWHarass(target)
				end
				if self.HarE then
                self:CastEHarass(target)
				end
            end  
        end 
    end 
end

function DeepMalphite:ComboMalphite()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 1100) then
                self:CastQ(target)
				self:CastW(target)
				self:CastE(target)
				self:CastR(target)
				self:CastRkill(target)
            end  
        end 
    end 
end
   
function DeepMalphite:OnTick()
    if IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or not IsRiotOnTop() then return end

    myHero = GetMyHero()

    if GetKeyPress(self.Harass) > 0 then
		self:HarassMalphite()
	end
	
	if GetKeyPress(self.LastHit) > 0 then
        self:LastLane()
    end 
	
	if GetKeyPress(self.Combo) > 0 then
        self:ComboMalphite()
    end 

	if GetKeyPress(self.Flee) > 0 then	
		self:Fleemouse()
		self:QFlee()
    end
	
    if GetKeyPress(self.LaneClear) > 0 then	
        self:Clearlane()  
        self:Clearjungle()  
    end 
	
    self:KillEnemy()
--	self:Automatic()

    if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
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
        LevelUpSpell(_Q)
        end 
    if myHero.Level  == 9 then
        LevelUpSpell(_E)
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

function DeepMalphite:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
    local aa = myHero.TotalDmg
  
    local dmg = aa

    if self:GetIgniteIndex() > -1 and CanCast(self:GetIgniteIndex()) then
        dmg = dmg + 50 + 20 * GetLevel(myHero.Addr) / 5 * 3
    end
    
    if self.E:IsReady() then
        dmg = dmg + self.E:GetDamage(target)
    end
  
    if self.Q:IsReady() then
        dmg = dmg + self.Q:GetDamage(target)
    end
	
    if self.R:IsReady() then
        dmg = dmg + self.R:GetDamage(target)
    end
  
    dmg = self:RealDamage(target, dmg)
    return dmg
end

function DeepMalphite:RealDamage(target, damage)
    if target.HasBuff("KindredRNoDeathBuff") or target.HasBuff("JudicatorIntervention") or target.HasBuff("FioraW") or target.HasBuff("ShroudofDarkness")  or target.HasBuff("SivirShield") then
        return 0  
    end
    local pbuff = GetBuff(GetBuffByName(target, "UndyingRage"))
    if target.HasBuff("UndyingRage") and pbuff.EndT > GetTimeGame() + 0.3  then
        return 0
    end
    local pbuff2 = GetBuff(GetBuffByName(target, "ChronoShift"))
    if target.HasBuff("ChronoShift") and pbuff2.EndT > GetTimeGame() + 0.3 then
        return 0
    end
    if myHero.HasBuff("SummonerExhaust") then
        damage = damage * 0.6;
    end
    if target.HasBuff("BlitzcrankManaBarrierCD") and target.HasBuff("ManaBarrier") then
        damage = damage - target.MP / 2
    end
    if target.HasBuff("GarenW") then
        damage = damage * 0.6;
    end
    return damage
end

function DeepMalphite:GetRCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.R.delay, self.R.width, 1000, self.R.speed, myHero.x, myHero.z, false, false, 1, 1, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end
  
function DeepMalphite:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function DeepMalphite:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function DeepMalphite:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function DeepMalphite:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function DeepMalphite:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end