IncludeFile("Lib\\TOIR_SDK.lua")

Veigar = class()

local ScriptXan = 2.0
local NameCreat = "Deep"

function OnLoad()
    if myHero.CharName ~= "Veigar" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> The Tiny Master Of Evil!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Veigar, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
	Veigar:TopLane()
end

function Veigar:TopLane()

    --Pd
  --  SetLuaCombo(true)
  --  SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
    self.Predc = VPrediction(true)

	self.posEndDash = Vector(0, 0, 0)	
	
    self:VeigarMenus()

		--Spells	
    self.Q = Spell(_Q, 950)
    self.W = Spell(_W, 900)
    self.E = Spell(_E, 700)
    self.R = Spell(_R, 650)
  
    self.Q:SetSkillShot(0.30, 2000, 100, true)
	self.W:SetSkillShot(0.30, 1600, 100, false)
	self.E:SetSkillShot(0.30, 1600, 100, false)
	self.R:SetSkillShot(0.30, 1600, 100, false)
	
	Veigar:aa()
	
    self.listSpellInterrup = {
    ["CaitlynAceintheHole"] = true,
    ["Crowstorm"] = true,
    ["DrainChannel"] = true,
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
				
	Callback.Add("Update", function(...) self:OnUpdate(...) end)
  Callback.Add("Tick", function() self:OnTick() end) 
  Callback.Add("Draw", function(...) self:OnDraw(...) end)
  Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
	Callback.Add("AfterAttack", function(...) self:OnAfterAttack(...) end)
	Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep Veigar</font></b> <font color=\"#ffffff\">Loaded. Enjoy The Tiny Master Of Evil</font>")
 end 
 
--SDK {{Toir+}}
function Veigar:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Veigar:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Veigar:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Veigar:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end
 
function Veigar:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
	if self.menu_Combo_QendDash then
		self:autoQtoEndDash()
	end
end 

function Veigar:autoQtoEndDash()
	for i, enemy in pairs(GetEnemyHeroes()) do
		if enemy ~= nil then
		    target = GetAIHero(enemy)
		    if IsValidTarget(target.Addr, self.E.range) then
		    --local QPos, QHitChance = HPred:GetPredict(self.HPred_Q_M, target, myHero)
			    local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(target, self.E.delay, self.E.width, self.E.speed, myHero, true)	    	
			    --if IsValidTarget(target.Addr, self.maxGrab) then
			    	if target.IsDash then
					    	CastSpellToPos(DashPosition.x, DashPosition.z, _E)
						--CastSpellToPos(QPos.x, QPos.z, _Q)
					--end
			    --end
			    --if DashPosition ~= nil then
			    	--if GetDistance(DashPosition) <= self.Q.range then
			  		--local Collision = CountObjectCollision(0, target.Addr, myHero.x, myHero.z, DashPosition.x, DashPosition.z, self.Q.width, self.Q.range, 65)
				  		--local Collision = CountCollision(myHero.x, myHero.z, DashPosition.x, DashPosition.z, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, 0, 5, 5, 5, 5)
				  		--if Collision == 0 then
					    	--CastSpellTarget(target.Addr, _Q)
					    end
					end
				end
			end
		end
 
  function Veigar:VeigarMenus()
   self.menu = "Deep Veigar"
   --Combo [[ Veigar ]]
--	self.menu_Combo_QendDash = self:MenuBool("Auto E End Dash", false)
   self.CQ = self:MenuBool("Combo Q", true)
   self.CW = self:MenuBool("Combo W (recommend using Combo Use W in Initialization)", false)
   self.CWstun = self:MenuBool("Only W CC", true)
   self.CE = self:MenuBool("Combo E", true)
   self.CQhar = self:MenuBool("Harass Q", true)
   self.CWhar = self:MenuBool("Harass W", true)
   self.CWharstun = self:MenuBool("Only W harass CC", true)
   
	--Auto
	self.Einterrupt = self:MenuBool("Interrupt Spells With E", true)
    self.AutoLevel = self:MenuBool("Auto Level", true)
	
   --Clear [[ Veigar ]]
   
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JQMana = self:MenuSliderInt("Mana Jungle Q %", 30)
    self.JW = self:MenuBool("Jungle W", true)
    self.JWMana = self:MenuSliderInt("Mana Jungle W %", 30)
    self.LQ = self:MenuBool("Last Hit Q", true)
    self.LQMana = self:MenuSliderInt("Mana Last Hit Q %", 30)
 
   --Draws [[ Veigar ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
    self.DR = self:MenuBool("Draw R", true)
   
    --KillSteal [[ Veigar ]]
    self.KQ = self:MenuBool("KillSteal > Q", true)
    self.KR = self:MenuBool("KillSteal > R", true)
   
   --Keys [[ Veigar ]]
   self.Combo = self:MenuKeyBinding("Combo", 32)
   self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	self.Harass = self:MenuKeyBinding("Harass", 67)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
   
	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", false)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 5) 
 end
 
 function Veigar:OnDrawMenu()
if not Menu_Begin(self.menu) then return end
	
     if Menu_Begin("Combo") then
--		self.menu_Combo_QendDash = Menu_Bool("Auto E Dasing Enemies", self.menu_Combo_QendDash, self.menu)
       self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
       self.CW = Menu_Bool("Combo W (recommend using Combo Use W in Initialization)", self.CW, self.menu)
       self.CWstun = Menu_Bool("Only combo W on CCed champions", self.CWstun, self.menu)
       self.CE = Menu_Bool("Combo E", self.CE, self.menu)
       self.CQhar = Menu_Bool("Harass Q", self.CQhar, self.menu)
       self.CWhar = Menu_Bool("Harass W", self.CWhar, self.menu)
       self.CWharstun = Menu_Bool("Only harrass W on CCed champions", self.CWharstun, self.menu)
		self.AutoLevel = Menu_Bool("Auto Level", self.AutoLevel, self.menu)
       Menu_End()
     end

        if Menu_Begin("Auto Interrupt") then
		self.Einterrupt = Menu_Bool("Interrupt Spells With E", self.Einterrupt, self.menu)
        Menu_End()
       end

     if Menu_Begin("Clear skills") then
			self.JQ = Menu_Bool("Jungle Q", self.JQ, self.menu)
            self.JQMana = Menu_SliderInt("Min MP % for using Jungle Q", self.JQMana, 0, 100, self.menu)
			self.JW = Menu_Bool("Jungle W", self.JW, self.menu)
            self.JWMana = Menu_SliderInt("Min MP % for using Jungle W", self.JWMana, 0, 100, self.menu)
			self.LQ = Menu_Bool("Last hit Q", self.LQ, self.menu)
            self.LQMana = Menu_SliderInt("Min MP % for using Last hit Q", self.LQMana, 0, 100, self.menu)
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

		if Menu_Begin("Mod Skin") then
			self.Enable_Mod_Skin = Menu_Bool("Enable Mod Skin", self.Enable_Mod_Skin, self.menu)
			self.Set_Skin = Menu_SliderInt("Set Skin", self.Set_Skin, 0, 20, self.menu)
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
     Menu_End()
   end


function Veigar:OnDraw()
    if self.DQWER then

    if self.DQ then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.Q.range+80, Lua_ARGB(255,255,0,0))
      end
	  
    if self.DW then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.W.range+130, Lua_ARGB(255,255,0,0))
      end

      if self.DE then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range+130, Lua_ARGB(255,0,0,255))
      end

      if self.DR then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.R.range+100, Lua_ARGB(255,0,0,255))
    end
   end 
end

function Veigar:GetQLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero.x, myHero.z, false, true, 1, 3, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Veigar:KillEnemy()
    local QKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
        				target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
    end   
	end
    local RKS = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(RKS)
    if CanCast(_R) and self.KR and RKS ~= 0 and GetDistance(Enemy) < 900 and GetDamage("R", Enemy) > Enemy.HP then
	 			        CastSpellTarget(Enemy.Addr, _R)
        end
    end 

function Veigar:CastQ()
    local CastQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(CastQ)
    if CanCast(_Q) and self.CQ and CastQ ~= 0 and GetDistance(Enemy) < 900 then
        				target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
    end   
	end
	end
	
function Veigar:HarassQ()
    local HarQ = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(HarQ)
    if CanCast(_Q) and self.CQhar and HarQ ~= 0 and GetDistance(Enemy) < self.Q.range then
        				target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetQLinePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
    end   
	end
	end
	
function Veigar:CastW()
    local CastW = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(CastW)
    if CanCast(_W) and self.CW and CastW ~= 0 and GetDistance(Enemy) < self.W.range then
        				target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
    end   
	end
	end
	
function Veigar:CastWstun()
    local CastWstun = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(CastWstun)
    if CanCast(_W) and self.CWstun and CastWstun ~= 0 and GetDistance(Enemy) < self.W.range then
        				target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
			if HitChance >= 8 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
    end   
	end
	end
	
function Veigar:HarassW()
    local HarW = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(HarW)
    if CanCast(_W) and self.CWhar and HarW ~= 0 and GetDistance(Enemy) < self.W.range then
        				target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
    end   
	end
	end
	
function Veigar:HarassWstun()
    local HarWstun = GetTargetSelector(self.W.range)
    Enemy = GetAIHero(HarWstun)
    if CanCast(_W) and self.CWharstun and HarWstun ~= 0 and GetDistance(Enemy) < self.W.range then
        				target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
			if HitChance >= 8 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
    end   
	end
	end	
	
function Veigar:CastE()
    local CastE = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(CastE)
    if CanCast(_E) and self.CE and CastE ~= 0 and GetDistance(Enemy) < self.E.range then
        				target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetECirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
    end   
	end
	end
	
function Veigar:GetWCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end	

function Veigar:GetECirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end
	
function Veigar:OnProcessSpell(unit, spell)
  if   unit
   and unit.IsEnemy
   and self.Einterrupt
   and self.listSpellInterrup[spell.Name]
   and IsValidTarget(unit, self.E.Range)
   then

	 			target = GetAIHero(unit.Addr)
			--local CastPosition, HitChance, Position = vpred:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			local CastPosition, HitChance, Position = self:GetECirclePreCore(target)
			if HitChance >= 1 then
        		CastSpellToPos(CastPosition.x+220, CastPosition.z+220, _E)
   --  __PrintTextGame("Veigar tried to interrupt a skill with E")
	end
	end
	end
	
function Veigar:EnemyMinionsTbl() --SDK Toir+
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

function Veigar:LasthitFarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LQMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
			target = GetUnit(minion.Addr)
	    	local targetPos, HitChance, Position = self:GetQLinePreCore(target)

			CastSpellToPos(targetPos.x, targetPos.z, _Q)
       end
	   end
	   end
	   end

function Veigar:LaneFarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JQMana and self.JQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
			target = GetUnit(minion.Addr)
	    	local targetPos, HitChance, Position = self:GetQLinePreCore(target)
			CastSpellToPos(targetPos.x, targetPos.z, _Q)

	   end
       if GetPercentMP(myHero.Addr) >= self.JWMana and not CanCast(_Q) and self.JW and IsValidTarget(minion.Addr, self.W.range) and GetDamage("W", minion) > minion.HP then
	   CastSpellTarget(minion.Addr, _W)
       end	   
       end 
    end 
	end

function Veigar:JungleClear()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minion) and not IsInFog(minions) and (GetType(minions) == 3 or GetType(minions) == 2 or GetType(minions) == 1) then
            table.insert(result, minions)
        end
    end

    return result
end 

function Veigar:Junglefarm()
	if CanCast(_W) and not CanCast(_Q) and self.JW and GetPercentMP(myHero.Addr) > self.JWMana and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
	    	local targetPos, HitChance, Position = self.Predc:GetCircularCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _W)
		end
    end
	if CanCast(_Q) and self.JQ and GetPercentMP(myHero.Addr) > self.JQMana and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
	    	local targetPos, HitChance, Position = self.Predc:GetLineCastPosition(target, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _Q)
		end
    end
	end

function Veigar:JungleMinionsKILL() --SDK Toir+
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local jungle = GetUnit(obj)
            if not IsDead(jungle.Addr)
			and not	IsInFog(jungle.Addr)
			and GetType(jungle.Addr) == 3
			then
			if (GetObjName(jungle.Addr) ~= "PlantSatchel" and GetObjName(jungle.Addr) ~= "PlantHealth" and GetObjName(jungle.Addr) ~= "PlantVision") then
                table.insert(result, jungle)
            end
			end
        end
    end
    return result
end	
	
function Veigar:JungleE()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JEMana
	   and IsValidTarget(jungle.Addr, self.E.range)
	   and self.JE
	   then
	   CastSpellTarget(jungle.Addr, _E)
       end 
    end 
end
end

function Veigar:ComboW()
	if self.CWstun then
		self:CastWstun()
end
	if not self.CWstun then
		self:CastW()
end
end

function Veigar:MultiharW()
	if self.CWharstun then
		self:HarassWstun()
end
	if not self.CWharstun then
		self:HarassW()
end
end


function Veigar:OnTick()
  if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end
  
    self:KillEnemy()
  
    if GetKeyPress(self.LaneClear) > 0 then
		local target = self.menu_ts:GetTarget()	
		self:Junglefarm()
		self:LaneFarmeQ()
    end
	
    if GetKeyPress(self.Harass) > 0 then
        self:HarassQ()
        self:MultiharW()
    end
	
	if GetKeyPress(self.Combo) > 0 then
		self:CastQ()
		self:CastE()
		self:ComboW()
    end
	
    if GetKeyPress(self.LastHit) > 0 then	
		local target = self.menu_ts:GetTarget()	
        self:LasthitFarmeQ()
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
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 9 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 10 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 11 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 12 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 13 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 14 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 15 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 16 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 17 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 18 then
            LevelUpSpell(_E)
        end    
    end 
end 

function Veigar:aa()
	self.listEndDash =
	{
		{Name = "ZoeR", RangeMin = 570, Range = 570, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "MaokaiW", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CamilleE", RangeMin = 0, Range = math.huge, Type = 1, Duration = 1.25}, --MaokaiW
		--{Name = "BlindMonkQTwo", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
		{Name = "BlindMonkWOne", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
		{Name = "NocturneParanoia2", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
		{Name = "VeigarE", RangeMin = 0, Range = 100, Type = 2, Duration = 0.25}, --CHUAN
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
		--{Name = "ViQ", RangeMin = 0, Range = 720, Type = 1, Duration = 0.25}, --Ezreal E
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
		{Name = "YasuoDashWrapper", RangeMin = 480, Range = 480, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CaitlynEntrapment", RangeMin = -380, Range = -380, Type = 1, Duration = 0.25}, --CHUAN
	}
end