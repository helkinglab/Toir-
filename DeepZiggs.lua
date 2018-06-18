IncludeFile("Lib\\TOIR_SDK.lua")

Ziggs = class()

local Version = 8.12
local Author = "Deep"

function OnLoad()
    if myHero.CharName ~= "Ziggs" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> The Hexplosives Expert!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Ziggs for LOL version</font></b> " ..Version)
    __PrintTextGame("<b><font color=\"#00FF00\">Author: </font></b> " ..Author)
	Ziggs:Midlane()
end

function Ziggs:Midlane()

    --Pd
   -- SetLuaCombo(true)
   -- SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
	vpred = VPrediction(true)
	
	self.posEndDash = Vector(0, 0, 0)
	
    self:ZiggsMenus()

		--Spells
    self.Q = Spell(_Q, 1450)
    self.W = Spell(_W, 1000)
    self.E = Spell(_E, 900)
    self.R = Spell(_R, 5300)
	
    self.Q:SetSkillShot(0.1,math.huge,180,false)
    self.W:SetSkillShot(0.1,math.huge,350,false)
    self.E:SetSkillShot(0.1,math.huge,350,false)
    self.R:SetSkillShot(0.1,math.huge,550,false)
	
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

	Ziggs:aa()
	--self.isWactive = false

    Callback.Add("Update", function(...) self:OnUpdate(...) end)	
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    --Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(source, unit, buff) end)
    --Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	Callback.Add("AfterAttack", function(...) self:OnBeforeAttack(...) end)
	
 end 

  --SDK {{Toir+}}
function Ziggs:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Ziggs:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Ziggs:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Ziggs:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Ziggs:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
	if self.menu_Combo_QendDash then
		self:autoQtoEndDash()
	end
	if self.menu_Combo_WendDash then
		self:autoWtoEndDash()
	end
	if self.menu_Combo_EendDash then
		self:autoEtoEndDash()
	end
end 

function Ziggs:ZiggsMenus()
    self.menu = "Deep Ziggs"
    --Combo [[ Ziggs ]]
    self.CQ = self:MenuBool("Combo Q", true)
	self.CW = self:MenuBool("Combo W", false)
    self.CE = self:MenuBool("Combo E", true)
  --  self.ComboR = self:MenuBool("Combo R", true)
  --  self.CRlow = self:MenuSliderInt("Enemy min HP% to R", 50)
   
	--Auto
	self.menu_Combo_QendDash = self:MenuBool("Auto Q End Dash", true)
	self.menu_Combo_WendDash = self:MenuBool("Auto W End Dash", false)
	self.menu_Combo_EendDash = self:MenuBool("Auto E End Dash", true)
	self.Winterrupt = self:MenuBool("Interrupt Channeling With W", true)
    self.WinterruptHP = self:MenuSliderInt("Your min HP% to interrupt with W", 100)
   
    --Lane
    self.JQ = self:MenuBool("Clear Q", true)
	self.HoldJQ = self:MenuBool("Keep Q for killing jungle monsters", false)
    self.JQMana = self:MenuSliderInt("Mana Clear Q %", 30)
    self.JW = self:MenuBool("Clear W", true)
	self.HoldJW = self:MenuBool("Keep W for killing jungle monsters", false)
    self.JWMana = self:MenuSliderInt("Mana Clear W %", 30)
    self.JE = self:MenuBool("Clear E", true)
	self.HoldJE = self:MenuBool("Keep E for killing jungle monsters", false)
    self.JEMana = self:MenuSliderInt("Mana Clear E %", 30)

	--Last hit
    self.LHQ = self:MenuBool("Last hit Q", true)
    self.LHQMana = self:MenuSliderInt("Min MP for using Q", 20)
    self.LHE = self:MenuBool("Last hit E", true)
    self.LHEMana = self:MenuSliderInt("Min MP for using E", 20)
	
    --Harass
    self.HarE = self:MenuBool("Harass E", true)
    self.HarQ = self:MenuBool("Harass Q", true)

    --KillSteal [[ Ziggs ]]
    self.KQ = self:MenuBool("KillSteal with Q", true)
    self.KW = self:MenuBool("KillSteal with W", true)
    self.KE = self:MenuBool("KillSteal with E", true)
    self.KR = self:MenuBool("KillSteal with R", true)

    --Draws [[ Ziggs ]]
    self.DQWER = self:MenuBool("Draw On/Off", true)
    self.DQ = self:MenuBool("Draw Q", true)
    self.DW = self:MenuBool("Draw W", true)
    self.DE = self:MenuBool("Draw E", true)
	self.DR = self:MenuBool("Draw R Range Minimap",true)

	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", false)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 5) 

    --KeyS [[ Ziggs ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
	self.Harass = self:MenuKeyBinding("Harass", 67)
	  self.Flee = self:MenuKeyBinding("Flee", 71)
	    self.FE = self:MenuBool("Flee E", true)
	    self.FW = self:MenuBool("Flee W", true)	
	    self.FQ = self:MenuBool("Flee Q", true)
end

function Ziggs:OnDrawMenu()
if not Menu_Begin(self.menu) then return end

		if Menu_Begin("Combo") then
            self.CQ = Menu_Bool("Combo Q (recommend using Combo Use Q in Initialization)", self.CQ, self.menu)
            self.CW = Menu_Bool("Combo W", self.CW, self.menu)
			self.CE = Menu_Bool("Combo E", self.CE, self.menu)

   --         self.ComboR = Menu_Bool("Combo R", self.ComboR, self.menu)
 --           self.CRlow = Menu_SliderInt("Enemy min HP% to R", self.CRlow, 0, 100, self.menu)
			Menu_End()
        end
		if Menu_Begin("Auto") then
			self.menu_Combo_QendDash = Menu_Bool("Auto Q Dasing Enemies", self.menu_Combo_QendDash, self.menu)
			self.menu_Combo_WendDash = Menu_Bool("Auto W Dasing Enemies", self.menu_Combo_WendDash, self.menu)
			self.menu_Combo_EendDash = Menu_Bool("Auto E Dasing Enemies", self.menu_Combo_EendDash, self.menu)
            self.Winterrupt = Menu_Bool("Interrupt Channeling With W", self.Winterrupt, self.menu)
            self.WinterruptHP = Menu_SliderInt("Your min HP% to interrupt with W", self.WinterruptHP, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Harass") then
			self.HarQ = Menu_Bool("Harass Q", self.HarQ, self.menu)
			self.HarE = Menu_Bool("Harass E", self.HarE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Clear skills") then
			self.JQ = Menu_Bool("Clear Q", self.JQ, self.menu)
			self.HoldJQ = Menu_Bool("Keep Q for ksing jungle monsters", self.HoldJQ, self.menu)
            self.JQMana = Menu_SliderInt("Min MP % to Clear Q", self.JQMana, 0, 100, self.menu)
			self.JW = Menu_Bool("Clear W", self.JW, self.menu)
			self.HoldJW = Menu_Bool("Keep W for ksing jungle monsters", self.HoldJW, self.menu)
            self.JWMana = Menu_SliderInt("Min MP % to Clear W", self.JWMana, 0, 100, self.menu)
			self.JE = Menu_Bool("Clear E", self.JE, self.menu)
			self.HoldJE = Menu_Bool("Keep E for ksing jungle monsters", self.HoldJE, self.menu)
            self.JEMana = Menu_SliderInt("Min MP % to Clear E", self.JEMana, 0, 100, self.menu)
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
            self.DQWER = Menu_Bool("Draw On/Off", self.DQWER, self.menu)
            self.DQ = Menu_Bool("Draw Q", self.DQ, self.menu)
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
			self.DR = Menu_Bool("Draw R Range Minimap",self.DR,self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal with Q", self.KQ, self.menu)
            self.KW = Menu_Bool("KillSteal with W", self.KW, self.menu)
			self.KE = Menu_Bool("KillSteal with E", self.KE, self.menu)
			self.KR = Menu_Bool("KillSteal with R", self.KR, self.menu)
			Menu_End()
        end
		if Menu_Begin("Keys") then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
            self.LastHit = Menu_KeyBinding("Last Hit", self.LastHit, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
			  self.Flee = Menu_KeyBinding("Flee", self.Flee, self.menu)
			self.FQ = Menu_Bool("Flee Q", self.FQ, self.menu)
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

function Ziggs:OnBeforeAttack(unit, target)
	if unit.IsMe then
		if target ~= nil and target.Type == 0 and CanCast(_W) then
    		if self.CW and GetKeyPress(self.Combo) > 0 then
    			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
				DelayAction(function() 
				self.W:Cast(myHero.Addr) 
				end, 0.3)
end
end
end
end
end
	
function Ziggs:OnProcessSpell(unit, spell)			
  if   unit
   and unit.IsEnemy
   and self.Winterrupt
   and GetPercentHP(myHero.Addr) < self.WinterruptHP
   and self.listSpellInterrup[spell.Name]
   and IsValidTarget(unit, self.W.Range)
   then
	 			target = GetAIHero(unit.Addr)
        			local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
				DelayAction(function() 
				self.W:Cast(myHero.Addr) 
				end, 0.3)
	end
	end	
	end
	
function Ziggs:GetQCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Ziggs:GetWCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Ziggs:GetECirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Ziggs:GetRCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.R.delay, self.R.width, self.R.range, self.R.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end	
	
function Ziggs:EnemyMinionsTbl() --SDK Toir+
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

function Ziggs:FarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LHQMana and self.LHQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
		CastSpellTarget(minion.Addr, _Q)
       end 
       if GetPercentMP(myHero.Addr) >= self.LHEMana and self.LHE and IsValidTarget(minion.Addr, self.E.range) and GetDamage("E", minion) > minion.HP then
		CastSpellTarget(minion.Addr, _E)
       end 
       end 
    end 
end

function Ziggs:LaneFarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JQMana and self.JQ and IsValidTarget(minion.Addr, self.Q.range) then
	   CastSpellTarget(minion.Addr, _Q)
       end
       if GetPercentMP(myHero.Addr) >= self.JEMana and self.JE and IsValidTarget(minion.Addr, self.E.range) then
	   CastSpellTarget(minion.Addr, _E)
       end	   
       end 
    end 
end 

function Ziggs:OnDraw()
    if self.DQWER then

    if self.DQ then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.Q.range+120, Lua_ARGB(255,255,0,0))
      end
	  
    if self.DW then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.W.range+140, Lua_ARGB(255,255,0,0))
      end

      if self.DE then
        DrawCircleGame(myHero.x, myHero.y, myHero.z, self.E.range+130, Lua_ARGB(255,0,0,255))
      end

      if self.DR then
        DrawCircleMiniMap(myHero.x, myHero.y, myHero.z, self.R.range, Lua_ARGB(255,0,0,255))
    end
   end 
end 

function Ziggs:KillEnemy()
    local QKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetQCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
    end
	end
    local WKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(WKS)
    if CanCast(_W) and self.KW and WKS ~= 0 and GetDistance(Enemy) < self.W.range and GetDamage("W", Enemy) > Enemy.HP then
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
				DelayAction(function() 
				self.W:Cast(myHero.Addr) 
				end, 0.3)
    end
	end
    local EKS = GetTargetSelector(self.E.range)
    Enemy = GetAIHero(EKS)
    if CanCast(_E) and self.KE and EKS ~= 0 and GetDistance(Enemy) < self.E.range and GetDamage("E", Enemy) > Enemy.HP then
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetECirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
    end
	end
    local RKS = GetTargetSelector(self.R.range)
    Enemy = GetAIHero(RKS)
    if CanCast(_R) and self.KR and RKS ~= 0 and GetDistance(Enemy) < self.R.range and GetDamage("R", Enemy) > Enemy.HP then
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetRCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _R)
        end
    end	
end 

function Ziggs:CastQ()
    local UseQ = GetTargetSelector(1500)
    if UseQ then Enemy = GetAIHero(UseQ) end
    if CanCast(_Q)
	and self.CQ
	and IsValidTarget(Enemy, self.Q.range)
	then 
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetQCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
    end 
end
end

function Ziggs:QHarass()
    local UseQ = GetTargetSelector(1500)
    if UseQ then Enemy = GetAIHero(UseQ) end
    if CanCast(_Q)
	and self.HarQ
	and IsValidTarget(Enemy, self.Q.range)
	then 
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetQCirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _Q)
        end
    end 
end
	
function Ziggs:CastE()
    local UseE = GetTargetSelector(1500)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.CE
	and IsValidTarget(Enemy, self.E.range)
	then 
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetECirclePreCore(target)
			if HitChance >= 1 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
        end
    end 
end

function Ziggs:EHarass()
    local UseE = GetTargetSelector(1500)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.HarE
	and IsValidTarget(Enemy, self.E.range)
	then 
	 			target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetECirclePreCore(target)
			if HitChance >= 1 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
        end
    end 
end
	
function Ziggs:autoQtoEndDash()
	for i, enemy in pairs(GetEnemyHeroes()) do
		if enemy ~= nil then
		    target = GetAIHero(enemy)
		    if IsValidTarget(target.Addr, self.Q.range) then
		    --local QPos, QHitChance = HPred:GetPredict(self.HPred_Q_M, target, myHero)
			    local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(target, self.Q.delay, self.Q.width, self.Q.speed, myHero, true)	    	
			    --if IsValidTarget(target.Addr, self.maxGrab) then
			    	if target.IsDash then
					    	CastSpellToPos(DashPosition.x, DashPosition.z, _Q)
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
		
function Ziggs:autoWtoEndDash()
	for i, enemy in pairs(GetEnemyHeroes()) do
		if enemy ~= nil then
		    target = GetAIHero(enemy)
		    if IsValidTarget(target.Addr, self.W.range) then
		    --local QPos, QHitChance = HPred:GetPredict(self.HPred_Q_M, target, myHero)
			    local TargetDashing, CanHitDashing, DashPosition = vpred:IsDashing(target, self.W.delay, self.W.width, self.W.speed, myHero, true)	    	
			    --if IsValidTarget(target.Addr, self.maxGrab) then
			    	if target.IsDash then
					    	CastSpellToPos(DashPosition.x, DashPosition.z, _W)
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
		
function Ziggs:autoEtoEndDash()
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

--  function Ziggs:OnUpdateBuff(source,unit,buff,stacks)
  --__PrintTextGame(buff.Name)
--	  if buff.Name == "Meditate" and unit.IsMe then
--            SetLuaMoveOnly(true)
--            SetLuaBasicAttackOnly(true)
--          end
--  end

--  function Ziggs:OnRemoveBuff(unit,buff)
  --__PrintTextGame(buff.Name)
--	  if buff.Name == "Meditate" and unit.IsMe then
--            SetLuaMoveOnly(false)
--            SetLuaBasicAttackOnly(false)
--          end
--   end
				
function Ziggs:JungleMinionsKILL() --SDK Toir+
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

function Ziggs:JungleW()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JWMana
	   and IsValidTarget(jungle.Addr, self.W.range)
	   and self.JW
	   then
		target = GetUnit(jungle.Addr)
	    	local targetPos, HitChance, Position = vpred:GetCircularCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _W)
       end 
    end 
end
end

function Ziggs:JungleQ()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JQMana
	   and IsValidTarget(jungle.Addr, self.Q.range)
	   and self.JQ
	   then
		target = GetUnit(jungle.Addr)
	    	local targetPos, HitChance, Position = vpred:GetCircularCastPosition(target, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _Q)
       end 
    end 
end
end
	
function Ziggs:JungleE()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JEMana
	   and IsValidTarget(jungle.Addr, self.E.range)
	   and self.JE
	   then
		target = GetUnit(jungle.Addr)
	    	local targetPos, HitChance, Position = vpred:GetCircularCastPosition(target, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _E)
       end 
    end 
end
end

function Ziggs:QJungleKill()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JQMana
	   and IsValidTarget(jungle.Addr, self.Q.range)
	   and self.JQ
	   and GetDamage("Q", jungle) > jungle.HP
	   then
		target = GetUnit(jungle.Addr)
	    	local targetPos, HitChance, Position = vpred:GetCircularCastPosition(target, self.Q.delay, self.Q.width, self.Q.range, self.Q.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _Q)
       end 
    end 
end
end

function Ziggs:WJungleKill()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JWMana
	   and IsValidTarget(jungle.Addr, self.W.range)
	   and self.JW
	   and GetDamage("W", jungle) > jungle.HP
	   then
		target = GetUnit(jungle.Addr)
	    	local targetPos, HitChance, Position = vpred:GetCircularCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _W)
       end 
    end 
end
end

function Ziggs:EJungleKill()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.JEMana
	   and IsValidTarget(jungle.Addr, self.E.range)
	   and self.JE
	   and GetDamage("E", jungle) > jungle.HP
	   then
		target = GetUnit(jungle.Addr)
	    	local targetPos, HitChance, Position = vpred:GetCircularCastPosition(target, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _E)
       end 
    end 
end
end

function Ziggs:Fleey()
    local mousePos = Vector(GetMousePos())
    MoveToPos(mousePos.x,mousePos.z)
end 

function Ziggs:WFlee()
    if CanCast(_W)
	and self.FW
	then 
        self.W:Cast(myHero.Addr)
		DelayAction(function() 
		        self.W:Cast(myHero.Addr)
				end, 0.3)
        end
    end
	
function Ziggs:EFlee()
    local UseE = GetTargetSelector(1200)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.FE
	and UseE ~= 0
	and IsValidTarget(Enemy, self.E.range)
	then 
        self.E:Cast(Enemy.Addr)
        end
    end
	
function Ziggs:QFlee()
    local UseQ = GetTargetSelector(1200)
    if UseQ then Enemy = GetAIHero(UseQ) end
    if CanCast(_Q)
	and self.FQ
	and UseQ ~= 0
	and IsValidTarget(Enemy, self.Q.range)
	then 
        self.Q:Cast(Enemy.Addr)
        end
    end
	
function Ziggs:Junglefarm()
	if not self.HoldJQ then
     self:JungleQ()
	end
	if self.HoldJQ then
     self:QJungleKill()
	end
	if not self.HoldJW then
     self:JungleW()
	end
	if self.HoldJW then
     self:WJungleKill()
	end
	if not self.HoldJE then
     self:JungleE()
	end
	if self.HoldJE then
     self:EJungleKill()
	end
end
	
function Ziggs:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()
	
	if GetKeyPress(self.Flee) > 0 then	
		self:Fleey()
		self:WFlee()
		self:EFlee()
		self:QFlee()
    end
	
    if GetKeyPress(self.LastHit) > 0 then	
        self:FarmeQ()
    end
	
    if GetKeyPress(self.Harass) > 0 then
        self:Eharass()
        self:QHarass()
    end

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneFarmeQ()
		self:Junglefarm()
    end

	if GetKeyPress(self.Combo) > 0 then
		self:CastQ()
		self:CastE()
--		self:Rcomp()
    end
end 

function Ziggs:aa()
	self.listEndDash =
	{
		{Name = "ZoeR", RangeMin = 570, Range = 570, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "MaokaiW", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CamilleE", RangeMin = 0, Range = math.huge, Type = 1, Duration = 1.25}, --MaokaiW
		--{Name = "BlindMonkQTwo", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
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
		{Name = "ZiggsDashWrapper", RangeMin = 480, Range = 480, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CaitlynEntrapment", RangeMin = -380, Range = -380, Type = 1, Duration = 0.25}, --CHUAN
	}
end