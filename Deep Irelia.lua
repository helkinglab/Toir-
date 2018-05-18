IncludeFile("Lib\\TOIR_SDK.lua")

Irelia = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Irelia" then
		Irelia:TopLane()
	end
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

	self.isQactive = false;
	self.qtime = 0	
	
    self:IreliaMenus()

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
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep Irelia</font></b> <font color=\"#ffffff\">Loaded. Enjoy The Blade Dancer</font>")
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

function Irelia:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Irelia:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
end 


function Irelia:IreliaMenus()
    self.menu = "Deep Irelia"
    --Combo [[ Irelia ]]
    self.CQ = self:MenuBool("Combo Q", true)
    self.CQdis = self:MenuSliderInt("Combo minimum Q distance", 200)
	self.CW = self:MenuBool("Combo W", true)
    self.CWdis = self:MenuSliderInt("Combo max W range", 400)
    self.CE = self:MenuBool("Combo E", true)
    self.CEdis = self:MenuSliderInt("Combo minimum E Distance", 150)
    self.CR = self:MenuBool("Combo R", true)
    self.CRlow = self:MenuSliderInt("HP Minimum %", 90)
   
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
    self.KE = self:MenuBool("KillSteal > E", false)
    self.KR = self:MenuBool("KillSteal > R", true)

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
			self.CW = Menu_Bool("Combo W", self.CW, self.menu)
            self.CWdis = Menu_SliderInt("Combo max W range", self.CWdis, 0, 500, self.menu)
			self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.CEdis = Menu_SliderInt("Combo minimum E distance", self.CEdis, 0, 800, self.menu)
            self.CR = Menu_Bool("Combo R", self.CR, self.menu)
            self.CRlow = Menu_SliderInt("Enemy min HP % for Combo R", self.CRlow, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Harass") then
			self.HarQ = Menu_Bool("Harass Q on marked enemies", self.HarQ, self.menu)
            self.HarQdis = Menu_SliderInt("Harass min Q Distance", self.HarQdis, 0, 625, self.menu)
			self.HarE = Menu_Bool("Harass E", self.HarE, self.menu)
            self.HarEdis = Menu_SliderInt("Harass max E Distance", self.HarEdis, 0, 800, self.menu)
			self.HarW = Menu_Bool("Harass E", self.HarW, self.menu)
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
            self.KE = Menu_Bool("KillSteal with E", self.KE, self.menu)
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
       if GetPercentMP(myHero.Addr) >= self.LHQMana and self.LHQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
		CastSpellTarget(minion.Addr, _Q)
       end 
       end 
    end 
end

function Irelia:LaneFarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LQMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
	   CastSpellTarget(minion.Addr, _Q)
       end 
       end 
    end 
end 

function Irelia:GetGapMinion(target)
    GetAllUnitAroundAnObject(myHero.Addr, 1500)
    local GabrityMinion = nil
    local CountIsMinion = 0
    local units = pUnit
    for i, unit in pairs(units) do
        if unit and unit ~= 0 and IsMinion(unit) and IsEnemy(unit) and IsDead(unit) and IsInFog(unit) and GetTargetableToTeam(unit) == 4 and GetDistance(GetUnit(unit)) < 375 then
            if GetDistance(self:DashEndPos(GetUnit(unit)), target) < GetDistance(target) and CountIsMinion < GetDistance(GetUnit(unit)) then
                CountIsMinion = GetDistance(GetUnit(unit))
                GabrityMinion = unit
            end
        end
    end
    return GabrityMinion
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
        CastSpellTarget(Enemy.Addr, Q)
    end 
    local EKS = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(EKS)
    if CanCast(_E) and self.KE and EKS ~= 0 and GetDistance(Enemy) < self.E.range and GetDamage("E", Enemy) > Enemy.HP then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
        end
    end  
    local RKS = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(RKS)
    if CanCast(_R) and self.KR and RKS ~= 0 and GetDistance(Enemy) < 900 and GetDamage("R", Enemy) > Enemy.HP then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 3 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _R)
        end
    end  
end 

local function GetDistanceSqr(p1, p2)
    p2 = GetOrigin(p2) or GetOrigin(myHero)
    return (p1.x - p2.x) ^ 2 + ((p1.z or p1.y) - (p2.z or p2.y)) ^ 2
end

function Irelia:CastQ(target)
    if target and target ~= 0 and IsEnemy(target) then
	if not self.E:IsReady() then 
		if CanCast(_Q)
			and self.CQ
			and IsValidTarget(target, self.Q.range)
			and self:IsMarked(GetAIHero(target)) 
			and GetDistance(GetAIHero(target)) > self.CQdis
			then
				CastSpellTarget(Enemy.Addr, _Q)
				DelayAction(
					function()
						self:CastQ2(target)
					end,
					0.1
				)
			end 
		end
	end
end

function Irelia:CastQ2(target)
    if target and target ~= 0 and IsEnemy(target) then
	if self.Q:IsReady() then
    if CanCast(_Q)
	and self.CQ
	and IsValidTarget(target, self.Q.range)
	and GetDistance(GetAIHero(target)) > self.CQdis
	and not self:IsMarked(GetAIHero(target))
	then
        CastSpellTarget(Enemy.Addr, _Q)
    end 
end
end
end

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
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.CW and IsValidTarget(Enemy, self.CWdis) then 
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(CEPosition.x, CEPosition.z, _W)
        end
    end 

	
function Irelia:Wharass()
    local UseW = GetTargetSelector(1000)
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.HarW and IsValidTarget(Enemy, self.HarWdis) then 
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(CEPosition.x, CEPosition.z, _W)
        end
    end 


function Irelia:CastE()
    local UseE = GetTargetSelector(800)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.CE
	and UseE ~= 0
	and GetDistance(Enemy) > self.CEdis
	then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 3 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
			DelayAction(function() 
				CastSpellTarget(Enemy.Addr, _Q)
			end,0.5)  
    end 
end
end

function Irelia:Eharass()
    local UseE = GetTargetSelector(900)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.HarE
	and UseE ~= 0
	and GetDistance(Enemy) < self.HarEdis
	then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 3 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
    end 
end
end

function Irelia:CastR()
    local Rcombo = GetTargetSelector(1000)
    Enemy = GetAIHero(Rcombo)
    if CanCast(_R) and self.CR and Rcombo ~= 0 and GetDistance(Enemy) < 800 and GetPercentHP(Enemy.Addr) < self.CRlow then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero, false)
		if HitChance >= 3 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _R)
        end
    end   
end 

function Irelia:CountEnemyInLine(target)
	local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
    local targetPos = Vector(target.x, target.y, target.z)
    --local targetPosEx = myHeroPos:Extended(targetPos, 500)
	local NH = 0
	for i, heros in ipairs(GetEnemyHeroes()) do
		if heros ~= nil then
		local hero = GetUnit(heros)
			local proj2, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(myHeroPos, targetPos, Vector(hero))
			--__PrintTextGame(tostring(proj2.z).."--"..tostring(pointLine.z).."--"..tostring(isOnSegment))
			--__PrintTextGame(tostring(GetDistanceSqr(proj2, pointLine)))
		    if isOnSegment and (GetDistanceSqr(hero, proj2) <= (65) ^ 2) then
		        NH = NH + 1
		    end
		end
	end
    return NH



	--[[local myHeroPos = Vector(myHero.x, myHero.y, myHero.z)
    local targetPos = Vector(target.x, target.y, target.z)
    local targetPosEx = myHeroPos:Extended(targetPos, 500)
    local NH = 1
	for i=1, 4 do
		local h = GetAIHero(GetEnemyHeroes()[i])
		local proj2, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(myHeroPos, targetPosEx, h)
		if isOnSegment and GetDistanceSqr(proj2, h) < 65 ^ 2 then
			NH = NH + 1
		end
	end
	return NH]]
end

function Irelia:CountEnemiesInRange(pos, range)
    local n = 0
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    for i, object in ipairs(pUnit) do
        if GetType(object) == 0 and not IsDead(object) and not IsInFog(object) and GetTargetableToTeam(object) == 4 and IsEnemy(object) then
        	local objectPos = Vector(GetPos(object))
          	if GetDistanceSqr(pos, objectPos) <= math.pow(range, 2) then
            	n = n + 1
          	end
        end
    end
    return n
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
	   and GetDamage("Q", jungle) > jungle.HP
	   then
		CastSpellTarget(jungle.Addr, Q)
       end 
    end 
end
end

function Irelia:FarmQJungleMarked()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
	   if GetPercentMP(myHero.Addr) >= self.JQMana
	   and IsValidTarget(jungle.Addr, self.Q.range)
	   and self:IsMarked(GetUnit(jungle))
	   then
	   	CastSpellTarget(jungle.Addr, Q)
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
	if self.CQ and not self.E:IsReady() then
        self:CastQ2(target)
    end
end 

function Irelia:JungleIreli()
	if self.JE then
        self:FarmEJungle()
    end
	if self.JQ then
        self:FarmQJungle()
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
    end

	if GetKeyPress(self.Combo) > 0 then
		self:ComboQIreli()
        self:CastE()
        self:CastW()
        self:CastR()
    end
end 
