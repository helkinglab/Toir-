IncludeFile("Lib\\TOIR_SDK.lua")

Nunu = class()

local ScriptXan = 8.12
local NameCreat = "Deep"

function OnLoad()
    if myHero.CharName ~= "Nunu" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#cffffff00\"> The Yeti Rider!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Nunu for LOL version</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    Nunu:Jungle()
end

function Nunu:Jungle()

    --Pd
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
	
    self:NunuMenus()

		--Spells
    self.Q = Spell(_Q, GetTrueAttackRange())
    self.W = Spell(_W, 700)
    self.E = Spell(_E, 550)
    self.R = Spell(_R, 650)
  
    self.Q:SetTargetted()
    self.W:SetTargetted()
    self.E:SetTargetted()
    self.R:SetActive()
	
	self.isRactive = false
	self.vision = false
	
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

    Callback.Add("Update", function(...) self:OnUpdate(...) end)	
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(source, unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	Callback.Add("AfterAttack", function(...) self:OnAfterAttack(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep Nunu</font></b> <font color=\"#ffffff\">Loaded. Enjoy The Yeti Rider</font>")
 end 
 
  --SDK {{Toir+}}
function Nunu:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Nunu:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Nunu:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Nunu:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Nunu:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
end 

function Nunu:OnProcessSpell(unit, spell)
    if self.E:IsReady() and self.menu_interruptE and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) and GetDistance(unit) < self.menu_dashrange then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellDash[spell.Name] ~= nil and not unit.IsMe then
            CastSpellTarget(unit.Addr, _E)   
        end 
    end 
end

function Nunu:NunuMenus()
    self.menu = "Deep Nunu"
    --Combo [[ Nunu ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CQlow = self:MenuSliderInt("My min HP% to Combo Q", 70)
    self.CW = self:MenuBool("Combo W", true)
    self.CE = self:MenuBool("Only E when you have passive", false)
    self.CEKeep = self:MenuBool("Combo E", true)
    self.CR = self:MenuBool("Combo R", true)
    self.CRlow = self:MenuSliderInt("My min HP% to R", 90)
	self.CRdis = self:MenuSliderInt("Combo max R Distance", 500)
	self.CRnum = self:MenuSliderInt("Combo R number", 2)
    self.CRend = self:MenuBool("End R max range", true)
   
	--Auto
    self.menu_interruptE = self:MenuBool("Use E on dashing enemies", true)
    self.menu_dashrange = self:MenuSliderInt("Spell dash detection range", 900)
	self.Qauto = self:MenuBool("Auto Q on low HP", true)
    self.QautoHP = self:MenuSliderInt("My min HP% to auto Q", 25)
    self.AutoLevel = self:MenuBool("Auto level", true)
   
    --Lane
    self.JW = self:MenuBool("Clear W", true)
    self.JWMana = self:MenuSliderInt("Mana Clear W %", 30)
    self.JQ = self:MenuBool("Clear Q", true)
    self.HoldJQ = self:MenuBool("Keep Q for killing jungle monsters", true)
    self.JQMana = self:MenuSliderInt("Mana Clear Q %", 30)
    self.JE = self:MenuBool("Clear E", true)
    self.JEMana = self:MenuSliderInt("Mana Clear E %", 30)

	--Last hit
    self.LHQ = self:MenuBool("Last hit Q", true)
    self.LHQMana = self:MenuSliderInt("Min MP for using Q", 30)
    self.LHE = self:MenuBool("Last hit E", true)
    self.LHEMana = self:MenuSliderInt("Min MP for using E", 30)
	
    --Harass
    self.HarE = self:MenuBool("Harass E", true)

    --KillSteal [[ Nunu ]]
    self.KE = self:MenuBool("KillSteal with E", true)

    --Draws [[ Nunu ]]
    self.DW = self:MenuBool("Draw W", false)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", false)

	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", false)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 5) 

    --KeyS [[ Nunu ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
	self.Harass = self:MenuKeyBinding("Harass", 67)
	self.Flee = self:MenuKeyBinding("Flee", 71)
	    self.FE = self:MenuBool("Flee E", true)
	    self.FW = self:MenuBool("Flee W", true)	
end

function Nunu:OnDrawMenu()
if not Menu_Begin(self.menu) then return end

		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
            self.CQlow = Menu_SliderInt("My min HP% to Combo Q", self.CQlow, 0, 100, self.menu)
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
			self.CE = Menu_Bool("Combo E", self.CE, self.menu)
			self.CEKeep = Menu_Bool("Only E when you have passive", self.CEKeep, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.CRlow = Menu_SliderInt("My max HP% to R", self.CRlow, 0, 100, self.menu)
            self.CRdis = Menu_SliderInt("R when enemies within range", self.CRdis, 0, 650, self.menu)
            self.CRnum = Menu_SliderInt("R when X enemies within range", self.CRnum, 1, 5, self.menu)
            self.CRend = Menu_Bool("End R if enemy is at the edge of R AOE", self.CRend, self.menu)
			Menu_End()
        end
		if Menu_Begin("Auto") then
			self.menu_interruptE = Menu_Bool("Use E on dashing enemies", self.menu_interruptE, self.menu)
			self.menu_dashrange = Menu_SliderInt("Dash spells detection range", self.menu_dashrange, 500, 1200, self.menu)
            self.Qauto = Menu_Bool("Auto Q on low HP", self.Qauto, self.menu)
			self.QautoHP = Menu_SliderInt("My min HP% to auto Q", self.QautoHP, 0, 100, self.menu)
			self.AutoLevel = Menu_Bool("Auto Level", self.AutoLevel, self.menu)
			Menu_End()
        end
        if Menu_Begin("Harass") then
			self.HarE = Menu_Bool("Harass E", self.HarE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Clear skills") then
			self.JQ = Menu_Bool("Clear Q", self.JQ, self.menu)
            self.JQMana = Menu_SliderInt("Min MP % for using Clear Q", self.JQMana, 0, 100, self.menu)
			self.HoldJQ = Menu_Bool("Keep Q for killing jungle monsters", self.HoldJQ, self.menu)
			self.JW = Menu_Bool("Clear W", self.JW, self.menu)
            self.JWMana = Menu_SliderInt("Min MP % for using Clear W", self.JWMana, 0, 100, self.menu)
			self.JE = Menu_Bool("Clear E", self.JE, self.menu)
            self.JEMana = Menu_SliderInt("Min MP % for using Clear E", self.JEMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Last Hit") then
			self.LHQ = Menu_Bool("Last hit with Q", self.LHQ, self.menu)
            self.LHQMana = Menu_SliderInt("Min MP % for using Last Hit Q", self.LHQMana, 0, 100, self.menu)
			self.LHE = Menu_Bool("Last hit with E", self.LHE, self.menu)
            self.LHEMana = Menu_SliderInt("Min MP % for using Last Hit E", self.LHEMana, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Draws") then
            self.DW = Menu_Bool("Draw W range", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E range", self.DE, self.menu)
            self.DR = Menu_Bool("Draw R range", self.DR, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KE = Menu_Bool("KillSteal with E", self.KE, self.menu)
			Menu_End()
        end
		if Menu_Begin("Keys") then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LastHit = Menu_KeyBinding("Last Hit", self.LastHit, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
			self.Flee = Menu_KeyBinding("Flee", self.Flee, self.menu)
            self.FW = Menu_Bool("Flee W", self.FW, self.menu)
            self.FE = Menu_Bool("Flee E", self.FE, self.menu)
			Menu_End()
		end
		if Menu_Begin("Mod Skin") then
			self.Enable_Mod_Skin = Menu_Bool("Enable Mod Skin", self.Enable_Mod_Skin, self.menu)
			self.Set_Skin = Menu_SliderInt("Set Skin", self.Set_Skin, 0, 20, self.menu)
			Menu_End()
		end
		Menu_End()
	end
	
function Nunu:EnemyMinionsTbl() --SDK Toir+
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

function Nunu:FarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LHQMana and self.LHQ and IsValidTarget(minion.Addr, self.E.range) and GetDamage("Q", minion) > minion.HP then
		CastSpellTarget(minion.Addr, _Q)
       end 
       if GetPercentMP(myHero.Addr) >= self.LHEMana and self.LHE and IsValidTarget(minion.Addr, self.E.range) and GetDamage("E", minion) > minion.HP then
		CastSpellTarget(minion.Addr, _E)
       end 
       end 
    end 
end

function Nunu:LaneFarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JQMana and self.JQ and IsValidTarget(minion.Addr, self.E.range) and GetDamage("Q", minion) > minion.HP then
	   CastSpellTarget(minion.Addr, _Q)
       end
       if GetPercentMP(myHero.Addr) >= self.JWMana and self.JW and IsValidTarget(minion.Addr, self.E.range) then
	   CastSpellTarget(myHero.Addr, _W)
       end
       if GetPercentMP(myHero.Addr) >= self.JEMana and self.JE and IsValidTarget(minion.Addr, self.E.range) and GetDamage("E", minion) > minion.HP then
	   CastSpellTarget(minion.Addr, _E)
       end	   
       end 
    end 
end 

function Nunu:OnDraw()
    if self.DW and self.W:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.W.range+100, Lua_ARGB(255,255,0,0))
      end

      if self.DE and self.E:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range+80, Lua_ARGB(255,0,0,255))
      end

      if self.DR and self.R:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.range+90, Lua_ARGB(255,0,0,255))
    end
end 

function Nunu:KillEnemy()
	local mousePos = Vector(GetMousePos())
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if self.KE and IsValidTarget(target, 650) and GetDamage("E", target) > target.HP then 
                self:CastE(target)
            end
            if self.isRactive and self.CRend and IsValidTarget(target, 650) and GetDistance(target) > 630 then 
				MoveToPos(mousePos.x,mousePos.z)
            end 
        end 
    end
end 


function Nunu:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function Nunu:GetEnemies(range)
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

function Nunu:CastQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if self.CQ
	   and GetPercentHP(myHero.Addr) < self.CQlow
	   and IsValidTarget(minion.Addr, 200)
	   then
		CastSpellTarget(minion.Addr, _Q)
       end
	   end
	   end
	   end

  function Nunu:OnUpdateBuff(source,unit,buff,stacks)
        	--	__PrintTextGame(buff.Name)
	  if buff.Name == "AbsoluteZero" and unit.IsMe then
			self.isRactive = true
            SetLuaMoveOnly(true)
            SetLuaBasicAttackOnly(true)
          end
	  if buff.Name == "visionary" and unit.IsMe then
			self.vision = true
          end 
  end

  function Nunu:OnRemoveBuff(unit,buff)
          	--	__PrintTextGame(buff.Name)
      if buff.Name == "AbsoluteZero" and unit.IsMe then
			self.isRactive = false
			SetLuaMoveOnly(false)
            SetLuaBasicAttackOnly(false)
          end
	  if buff.Name == "visionary" and unit.IsMe then
			self.vision = false
         end 
   end
   
function Nunu:ToTurrent()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
        if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 and IsValidTarget(v, GetTrueAttackRange()) then
			CastSpellTarget(myHero.Addr, _W)
        end 
    end 
end

function Nunu:JungleClear()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and (GetType(minions) == 3 or GetType(minions) == 1) then
            table.insert(result, minions)
        end
    end

    return result
end

function Nunu:AutoQ()
	for i, minions in ipairs(self:JungleClear()) do
        if minions ~= 0 then
		local jungle = GetUnit(minions)
		if (jungle.Type == 3 or jungle.Type == 1) then
		
		if CanCast(_Q)
		and self.Qauto
		and GetPercentHP(myHero.Addr) < self.QautoHP
		then
		if jungle ~= nil and GetDistance(jungle) < 300 then
			self.Q:Cast(jungle.Addr)
			
        end
	end
	end
	end
	end
	end

function Nunu:OnAfterAttack(unit, target)
	if unit.IsMe then
		if target ~= nil and target.Type == 0 and CanCast(_W) then

    		if self.CW and GetKeyPress(self.Combo) > 0 then
    			CastSpellTarget(myHero.Addr, _W)
			    			end
							end
		
	for i, minions in ipairs(self:JungleClear()) do
        if minions ~= 0 then
		local jungle = GetUnit(minions)
		if jungle.Type == 3 then
		
	  if GetKeyPress(self.LaneClear) > 0
	  and CanCast(_W)
	  and self.JW
	  and GetPercentMP(myHero.Addr) > self.JWMana
	  then
		if jungle ~= nil and GetDistance(jungle) < self.E.range then
			self.W:Cast(myHero.Addr)
        end
	end
end
end
end
end
end						

function Nunu:CastW()
    if CanCast(_W)
	and self.CW
	then 
        CastSpellTarget(myHero.Addr, _W)
        end
    end

function Nunu:CastE()
    local UseE = GetTargetSelector(1000)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.CE
	and UseE ~= 0
	and IsValidTarget(Enemy, 600)
	then 
        self.E:Cast(Enemy.Addr)
        end
    end
	
function Nunu:CastEKeep()
    local UseE = GetTargetSelector(1000)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.vision
	and self.CE
	and UseE ~= 0
	and IsValidTarget(Enemy, 600)
	then 
        self.E:Cast(Enemy.Addr)
        end
    end
	
function Nunu:Eharass()
    local UseE = GetTargetSelector(1000)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.HarE
	and UseE ~= 0
	and IsValidTarget(Enemy, 600)
	then 
        self.E:Cast(Enemy.Addr)
        end
    end
  	
function Nunu:CastR()
    local UseR = GetTargetSelector(1000)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(_R)
	and self.CR
	and UseR ~= 0
	and IsValidTarget(Enemy, 400)
	and GetPercentHP(myHero.Addr) <= self.CRlow
	and GetDistance(Enemy) <= self.CRdis
	and CountEnemyChampAroundObject(myHero.Addr, self.CRdis) >= self.CRnum
	then 
        self.R:Cast(myHero)
            SetLuaMoveOnly(true)
            SetLuaBasicAttackOnly(true)
        end
    end

function Nunu:JungleMinionsKILL() --SDK Toir+
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

function Nunu:JungleQ()
    for i ,minion in pairs(self:JungleMinionsKILL()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JQMana and self.JQ and IsValidTarget(minion.Addr, self.E.range) then
	   CastSpellTarget(minion.Addr, _Q)
       end
       end 
    end 
end 

function Nunu:JungleE()
    for i ,minion in pairs(self:JungleMinionsKILL()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JEMana and self.JE and IsValidTarget(minion.Addr, self.E.range) then
	   CastSpellTarget(minion.Addr, _E)
       end	   
       end 
    end 
end 

function Nunu:QJungleKill()
    for i ,minion in pairs(self:JungleMinionsKILL()) do
        if minion ~= 0 then
       if IsValidTarget(minion.Addr, self.E.range) and GetDamage("Q", minion) > minion.HP then
		CastSpellTarget(minion.Addr, _Q)
       end
	   end
	   end
end

function Nunu:Junglefarm()
	if not self.HoldJQ then
     self:JungleQ()
	end
	if self.JE then
     self:JungleE()
	end
	if self.HoldJQ then
     self:QJungleKill()
	end
end

function Nunu:Fleey()
    local mousePos = Vector(GetMousePos())
    MoveToPos(mousePos.x,mousePos.z)
end 

function Nunu:WFlee()
    if CanCast(_W)
	and self.FW
	then 
        self.W:Cast(myHero.Addr)
        end
    end
	
function Nunu:EFlee()
    local UseE = GetTargetSelector(1000)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.FE
	and UseE ~= 0
	and IsValidTarget(Enemy, 600)
	then 
        self.E:Cast(Enemy.Addr)
        end
    end
	
function Nunu:CastNunuE()
	if self.CEKeep then
	self:CastEKeep()
	end
	if not self.CEKeep then
	self:CastE()
	end
    end
	
function Nunu:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()
	self:AutoQ()
	
	if GetKeyPress(self.Flee) > 0 then	
		self:Fleey()
		self:WFlee()
		self:EFlee()
    end
	
    if GetKeyPress(self.LastHit) > 0 then	
            SetLuaMoveOnly(false)
            SetLuaBasicAttackOnly(false)
        self:FarmeQ()
    end
	
    if GetKeyPress(self.Harass) > 0 then	
            SetLuaMoveOnly(false)
            SetLuaBasicAttackOnly(false)
        self:Eharass()
    end

    if GetKeyPress(self.LaneClear) > 0 then
            SetLuaMoveOnly(false)
            SetLuaBasicAttackOnly(false)
		local target = self.menu_ts:GetTarget()	
        self:ToTurrent()
        self:LaneFarmeQ()
		self:Junglefarm()
    end

	if GetKeyPress(self.Combo) > 0 then
		self:CastQ()
		self:CastW()
		self:CastNunuE()
		self:CastR()
    end
	
    if self.AutoLevel then
        if myHero.Level == 1 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 2 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 3 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 4 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 5 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 6 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 7 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 8 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 9 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 10 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 11 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 12 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 13 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 14 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 15 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 16 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 17 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 18 then
            LevelUpSpell(_W)
        end    
    end 
end 
