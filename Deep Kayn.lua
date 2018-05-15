IncludeFile("Lib\\TOIR_SDK.lua")

Kayn = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "Kayn" then
		Kayn:Jungle()
	end
end

function Kayn:Jungle()

    --Pd
    SetLuaCombo(true)
	--SetLuaHarass(true)
    SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
    self.Predc = VPrediction(true)

    self:KaynMenus()

		--Spells	
    self.Q = Spell(_Q, 350)
    self.W = Spell(_W, 700)
    self.E = Spell(_E, GetTrueAttackRange())
    self.R = Spell(_R, 550)
  
    self.Q:SetTargetted()
	self.W:SetSkillShot(0.5, 1600, 200, false)
    self.E:SetActive()
    self.R:SetTargetted()
	
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
    ["UFSlash"] = true,--malr
    ["CassiopeiaPetrifyingGaze"] = true,
    ["GarenR"] = true,
    ["VarusR"] = true,
    ["GragasR"] = true,
    ["GnarR"] = true,
    ["FizzMarinerDoom"] = true,
    ["SyndraR"] = true,
    ["CurseoftheSadMummy"] = true,
    ["EnchantedCrystalArrow"] = true,
    ["InfernalGuardian"] = true,--anni
    ["BrandWildfire"] = true,
    ["DariusExecute"] = true,
    ["HecarimUlt"] = true,
    ["LuxMaliceCannon"] = true,
    ["zedulttargetmark"] = true,
    ["VladimirHemoplague"] = true,
	["DrainChannel"] = true,
	}
				
	Callback.Add("Update", function(...) self:OnUpdate(...) end)
  Callback.Add("Tick", function() self:OnTick() end) 
  Callback.Add("Draw", function(...) self:OnDraw(...) end)
  Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
	Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep Kayn</font></b> <font color=\"#ffffff\">Loaded. Enjoy</font>")
 end 
 
--SDK {{Toir+}}
function Kayn:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Kayn:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kayn:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Kayn:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Kayn:GetQCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero.x, myHero.z, false, true, 1, 3, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Kayn:GetWLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end
 
function Kayn:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
end 
 
  function Kayn:KaynMenus()
   self.menu = "Deep Kayn"
   --Combo [[ Kayn ]]
   self.CQ = self:MenuBool("Combo Q", true)
   self.CW = self:MenuBool("Combo W", true)
   self.CWhar = self:MenuBool("Harass W", true)
   
	--Auto Interrupt
	self.Winterrupt = self:MenuBool("Interrupt Spells With W", true)
	self.Rinterrupt = self:MenuBool("Evade Interruptible Spells With R", false)
   
   --Add R
   self.CR = self:MenuBool("Combo R", true)
   self.URS = self:MenuSliderInt("HP Minimum %", 100)
   self.AR = self:MenuBool("Auto R on low HP", true)
   self.ARlow = self:MenuSliderInt("%HP to auto R", 20)
 
   --Draws [[ Kayn ]]
   self.DQ = self:MenuBool("Draw Q", true)
   self.DW = self:MenuBool("Draw W", false)
   self.DR = self:MenuBool("Draw R", false)
   
   --Keys [[ Kayn ]]
   self.Combo = self:MenuKeyBinding("Combo", 32)
   self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	self.Harass = self:MenuKeyBinding("Harass", 67)
   
	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", true)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 1) 
 end
 
 function Kayn:OnDrawMenu()
if not Menu_Begin(self.menu) then return end
	
     if Menu_Begin("Combo") then
       self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
       self.CW = Menu_Bool("Combo W", self.CW, self.menu)
       self.CWhar = Menu_Bool("Harass W", self.CWhar, self.menu)
       Menu_End()
     end

          if Menu_Begin("Auto Interrupt") then
			self.Winterrupt = Menu_Bool("Interrupt Spells With W", self.Winterrupt, self.menu)
			self.Rinterrupt = Menu_Bool("Evade Interruptible Spells With R", self.Rinterrupt, self.menu)
            Menu_End()
          end
	 
     if Menu_Begin("Draws") then
       self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
       self.DW = Menu_Bool("Draw W", self.DW, self.menu)
       self.DR = Menu_Bool("Draw R", self.DR, self.menu)
       Menu_End()
     end
  
     if Menu_Begin("Configuration [R]") then
       self.CR = Menu_Bool("Combo R", self.CR, self.menu)
       self.URS = Menu_SliderInt("Your min HP to combo R", self.URS, 0, 100, self.menu)
       self.AR = Menu_Bool("Auto R on low HP", self.AR, self.menu)
       self.ARlow = Menu_SliderInt("%HP to auto R", self.ARlow, 0, 100, self.menu)
       Menu_End()
     end

		if Menu_Begin("Mod Skin") then
			self.Enable_Mod_Skin = Menu_Bool("Enable Mod Skin", self.Enable_Mod_Skin, self.menu)
			self.Set_Skin = Menu_SliderInt("Set Skin", self.Set_Skin, 0, 20, self.menu)
			Menu_End()
		end
	 
     if Menu_Begin("Keys") then
       self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
		self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
		self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
       Menu_End()
     end
     Menu_End()
   end


 function Kayn:OnDraw()
  if self.W:IsReady() and self.DW then 
    DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range+320, Lua_ARGB(255,255,255,255))
  end
  if self.Q:IsReady() and self.DQ then 
    DrawCircleGame(myHero.x , myHero.y, myHero.z, self.Q.range+390, Lua_ARGB(255,255,255,255))
	end
  if self.R:IsReady() and self.DR then 
    DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range+300, Lua_ARGB(255,255,255,255))
	end
end

function Kayn:GetWLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Kayn:OnProcessSpell(unit, spell)
  if   unit
   and unit.IsEnemy
   and self.Winterrupt
   and self.listSpellInterrup[spell.Name]
   and IsValidTarget(unit, self.W.Range)
   then
     __PrintTextGame("Kayn tried to interrupt a skill with W")
			target = GetAIHero(unit.Addr)
        CastSpellTarget(unit.Addr, _W)
	end

			
  if   unit
   and unit.IsEnemy
   and self.Rinterrupt
   and self.listSpellInterrup[spell.Name]
   and IsValidTarget(unit, self.R.Range)
   then
     __PrintTextGame("Kayn tried evade a skill with R")
	 			target = GetAIHero(unit.Addr)
        CastSpellTarget(unit.Addr, _R)
	end
	end
			
function Kayn:Qpos()
    local UseQ = GetTargetSelector(1000)
    if UseQ then Enemy = GetAIHero(UseQ) end
    if CanCast(_Q) and self.CQ and IsValidTarget(Enemy, 600) then 
        CastSpellTarget(Enemy.Addr, _Q)
    end 
end

function Kayn:Wlow()
    local UseW = GetTargetSelector(1000)
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.CW and IsValidTarget(Enemy, 1000) then 
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _W)
        end
    end 
end

function Kayn:WHarass()
    local UseW = GetTargetSelector(1000)
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.CWhar and IsValidTarget(Enemy, 1000) then 
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _W)
        end
    end 
end
					
function Kayn:Rcomp()
    local UseR = GetTargetSelector(1000)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(_R) and self.CR and IsValidTarget(Enemy, self.R.range) and GetPercentHP(myHero.Addr) < self.URS then 
        CastSpellTarget(Enemy.Addr, _R)
    end 
end

function Kayn:Rlow()
    local UseR = GetTargetSelector(1000)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(_R) and self.AR and IsValidTarget(Enemy, self.R.range) and GetPercentHP(myHero.Addr) < self.ARlow then 
        CastSpellTarget(Enemy.Addr, _R)
    end 
end 

function Kayn:CountEnemyInLine(target)
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

function Kayn:CountEnemiesInRange(pos, range)
    local n = 0
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    for i, object in ipairs(pUnit) do
        if GetType(object) == 0 and not IsDead(object) and GetTargetableToTeam(object) == 4 and IsEnemy(object) then
        	local objectPos = Vector(GetPos(object))
          	if GetDistanceSqr(pos, objectPos) <= math.pow(range, 2) then
            	n = n + 1
          	end
        end
    end
    return n
end

function Kayn:FarmJungle(target)
	if CanCast(_W) and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
	    	local targetPos, HitChance, Position = self.Predc:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _W)
		end
    end
	if CanCast(_Q) and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
			CastSpellTarget(target.Addr, _Q)
		end
	end
end

function Kayn:OnTick()
  if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end
  
    self:Rlow()  
  
    if GetKeyPress(self.LaneClear) > 0 then
		local target = self.menu_ts:GetTarget()	
		self:FarmJungle()
    end
	
    if GetKeyPress(self.Harass) > 0 then
		self:WHarass()
    end
	
    if GetKeyPress(self.Combo) > 0 then
		self:Qpos()
		self:Wlow()
		self:Rcomp()
    end
end 