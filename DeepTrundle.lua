IncludeFile("Lib\\TOIR_SDK.lua")

Trundle = class()

local ScriptXan = 8.12
local NameCreat = "Deep"

function OnLoad()
    if myHero.CharName ~= "Trundle" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> The Troll King!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Deep Trundle for LOL version</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
	Trundle:TopLane()
end

function Trundle:TopLane()

    --Pd
    SetLuaCombo(true)
	SetLuaHarass(true)
    SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
    self.PredTrundle = VPrediction(true)

    self:TrundleMenus()
  
    self.Q = Spell(_Q, GetTrueAttackRange())
    self.W = Spell(_W, 1500)
    self.E = Spell(_E, 1500)
    self.R = Spell(_R, 700)
  
    self.Q:SetActive()
    self.W:SetTargetted()
    self.E:SetSkillShot(0.1,math.huge,100,false)
    self.R:SetActive()

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

	Callback.Add("Update", function(...) self:OnUpdate(...) end)	
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("AfterAttack", function(...) self:OnAfterAttack(...) end)  
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep Trundle</font></b> <font color=\"#ffffff\">Loaded successfully. Enjoy The Troll King</font>")
  end 
  
--SDK {{Toir+}}
function Trundle:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Trundle:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Trundle:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Trundle:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Trundle:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Trundle:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
end
  
  function Trundle:TrundleMenus()
      self.menu = "Deep Trundle"
      --Combo [[ Trundle ]]
      self.CQ = self:MenuBool("Combo Q", true)
      self.CW = self:MenuBool("Combo W", true)
      self.CE = self:MenuBool("Combo E", true)
	  self.Q_Extra = self:MenuSliderInt("Extra Range For E",50)
      self.CR = self:MenuBool("Combo R", true)
      self.URS = self:MenuSliderInt("HP Minimum %", 80)
	  
	  --Auto
	  self.Einterrupt = self:MenuBool("Interrupt Spells With E", true)
	self.AE = self:MenuBool("Auto E on low HP", false)
	self.AElow = self:MenuSliderInt("%HP to auto E", 25)
	self.AR = self:MenuBool("Auto R on low HP", true)
	self.ARlow = self:MenuSliderInt("%HP to auto R", 20)
			
      --LastHit
      self.AutoQ = self:MenuBool("Auto Q LastHit", false)
      self.AutoQMana = self:MenuSliderInt("Mana %", 45)
  
      --KillSteal [[ Trundle ]]
      self.KQ = self:MenuBool("KillSteal > Q", true)
  
      --Draws [[ Trundle ]]
      self.DW = self:MenuBool("Draw W", true)
      self.DE = self:MenuBool("Draw E", true)
      self.DR = self:MenuBool("Draw R", true)
  
      --Keys [[ Trundle ]]
      self.Combo = self:MenuKeyBinding("Combo", 32)
	  self.Flee = self:MenuKeyBinding("Flee", 71)
      self.LastHit = self:MenuKeyBinding("Last Hit", 90)
      self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	  
	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", false)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 5)
  end
   
function Trundle:OnDrawMenu()
if not Menu_Begin(self.menu) then return end
	
          if Menu_Begin("Combo") then
              self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
              self.CW = Menu_Bool("Combo W", self.CW, self.menu)
              self.CE = Menu_Bool("Combo E", self.CE, self.menu)
			  self.Q_Extra = Menu_SliderInt("Extra Range For E",self.Q_Extra,0,200,self.menu)
              self.CR = Menu_Bool("Combo R", self.CR, self.menu)
              self.URS = Menu_SliderInt("Your min HP to combo R", self.URS, 0, 100, self.menu)
			  
        Menu_End()
      end		  
	  
          if Menu_Begin("Last Hit") then
            self.AutoQ = Menu_Bool("Auto Q", self.AutoQ, self.menu)
            self.AutoQMana = Menu_SliderInt("Mana %", self.AutoQMana, 0, 100, self.menu)
            Menu_End()
          end
		
          if Menu_Begin("Auto") then
			self.Einterrupt = Menu_Bool("Auto Interrupt Spells With E", self.Einterrupt, self.menu)
			self.AE = Menu_Bool("Auto E on low HP", self.AE, self.menu)
			self.AElow = Menu_SliderInt("%HP to auto E", self.AElow, 0, 100, self.menu)
			self.AR = Menu_Bool("Auto R on low HP", self.AR, self.menu)
			self.ARlow = Menu_SliderInt("%HP to auto R", self.ARlow, 0, 100, self.menu)
            Menu_End()
          end
		  
          if Menu_Begin("KillSteal") then
              self.KQ = Menu_Bool("KillSteal > Q", self.KQ, self.menu)
            Menu_End()
          end
		  
          if Menu_Begin("Drawings") then
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
		  
          if Menu_Begin("Keys") then
              self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
			  self.Flee = Menu_KeyBinding("Flee", self.Flee, self.menu)
              self.LastHit = Menu_KeyBinding("Last Hit", self.LastHit, self.menu)
              self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
            Menu_End()
          end
		  
    Menu_End()
end	  
	  
  function Trundle:OnDraw()
    if self.R:IsReady() and self.DR then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range+50, Lua_ARGB(255,255,255,255))
    end
    if self.W:IsReady() and self.DW then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range, Lua_ARGB(255,255,255,255))
	end
    if self.E:IsReady() and self.DE then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range, Lua_ARGB(255,255,255,255))
	end
end

function Trundle:GetECirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 1, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero.x, myHero.z, false, false, 1, 5, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function Trundle:OnProcessSpell(unit, spell)
  if   unit
   and unit.IsEnemy
   and self.Einterrupt
   and self.listSpellInterrup[spell.Name]
   and IsValidTarget(unit, self.E.Range)
   then
     __PrintTextGame("Trundle tried to interrupt a skill with E")
	 			target = GetAIHero(unit.Addr)
			--local CastPosition, HitChance, Position = vpred:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			local CastPosition, HitChance, Position = self:GetECirclePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
	end
	end
	end

function Trundle:KillEnemy()
    local QKS = GetTargetSelector(GetTrueAttackRange())
    if QKS then Enemy = GetAIHero(QKS) end
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < GetTrueAttackRange() and GetDamage("Q", Enemy) > Enemy.HP then
        CastSpellTarget(myHero.Addr, Q)
    end 
end

function Trundle:Fleey()
    local mousePos = Vector(GetMousePos())
    MoveToPos(mousePos.x,mousePos.z)
end 

function Trundle:OnAfterAttack(unit, target)
	if unit.IsMe then
		if target ~= nil and target.Type == 0 and CanCast(_Q) then
    			CastSpellTarget(myHero.Addr, _Q)
    		end

    		if GetKeyPress(self.Combo) > 0 and myHero.MP > 30 then
    			CastSpellTarget(myHero.Addr, _Q)
			    			end
							
	for i, minions in ipairs(self:JungleClear()) do
        if minions ~= 0 then
		local jungle = GetUnit(minions)
		if (GetType(minions) == 3 or GetType(minions) == 1) then

	  if GetKeyPress(self.LaneClear) > 0 and CanCast(_Q) then
		if jungle ~= nil and GetDistance(jungle) < self.Q.range then
			self.Q:Cast(myHero.Addr)
        end						
			    		end
			    	end		    						
				end			
    		end
			end
			end

function Trundle:WLow()
    local UseW = GetTargetSelector(1600)
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.CW and UseW ~= 0 then
        CastSpellTarget(Enemy.Addr, _W)
    end
end

function Trundle:WFlee()
    if CanCast(_W) and self.CW and UseW ~= 0 then
        CastSpellTarget(myHero.Addr, _W)
    end
end 

function Trundle:Epos()
    local UseE = GetTargetSelector(1600)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E) and self.CE and UseE ~= 0 and IsValidTarget(Enemy, self.E.range) then
        local CEPosition, HitChance, Position = self.PredTrundle:GetCircularCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x+self.Q_Extra, CEPosition.z+self.Q_Extra, _E)
        end
    end 
end 

function Trundle:RComp()
    local UseR = GetTargetSelector(700)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(R) and UseR ~= 0 and self.CR and IsValidTarget(Enemy, self.R.range) and GetPercentHP(myHero.Addr) < self.URS then 
        CastSpellTarget(Enemy.Addr, _R)
    end 
end

function Trundle:Eauto()
    local UseE = GetTargetSelector(1000)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E) and self.AE and UseE ~= 0 and IsValidTarget(Enemy, 900) and GetPercentHP(myHero.Addr) < self.AElow then
        local CEPosition, HitChance, Position = self.PredTrundle:GetCircularCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)
        end
    end 
end 

function Trundle:Rauto()
    local UseR = GetTargetSelector(700)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(R) and UseR ~= 0 and self.AR and IsValidTarget(Enemy, self.R.range) and GetPercentHP(myHero.Addr) < self.ARlow then 
        CastSpellTarget(Enemy.Addr, _R)
    end 
end 

function Trundle:FarmeQ()
    self.EnemyMinions:update()
    for i ,minion in pairs(self.EnemyMinions.objects) do
       if GetPercentMP(myHero.Addr) >= self.AutoQMana and self.AutoQ and IsValidTarget(minion.Addr, GetTrueAttackRange()) and GetDamage("Q", minion) > (minion.HP + 40) then
        CastSpellTarget(myHero.Addr, Q)
       end 
    end 
end 

function Trundle:LaneFarmeQ()
    self.EnemyMinions:update()
    for i ,minion in pairs(self.EnemyMinions.objects) do
       if GetPercentMP(myHero.Addr) >= self.AutoQMana and self.AutoQ and IsValidTarget(minion.Addr, GetTrueAttackRange()) and GetDamage("Q", minion) > (minion.HP + 40) then
        CastSpellTarget(myHero.Addr, Q)
       end 
    end 
end 

function Trundle:ToTurrent()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
        if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 and IsValidTarget(v, GetTrueAttackRange()) then
            CastSpellTarget(myHero.Addr, _Q)
			CastSpellTarget(myHero.Addr, _W)
        end 
    end 
end 

function Trundle:JungleClear()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and (GetType(minions) == 3 or GetType(minions) == 1) then
            table.insert(result, minions)
        end
    end

    return result
end

function Trundle:FarmJungle(target)
	for i, minions in ipairs(self:JungleClear()) do
        if minions ~= 0 then
		local jungle = GetUnit(minions)
		if (GetType(minions) == 3 or GetType(minions) == 1) then

	  if CanCast(_W) then
		if jungle ~= nil and GetDistance(jungle) < self.W.range then
		  self.W:Cast(myHero.Addr)
		end
    end
 end
end
end
end

function Trundle:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()
	self:Eauto()
	self:Rauto()

    if GetKeyPress(self.LastHit) > 0 then	
        self:FarmeQ()
    end
   
    if GetKeyPress(self.LaneClear) > 0 then
		local target = self.menu_ts:GetTarget()	
        self:ToTurrent()
		self:FarmJungle()
    end
	if GetKeyPress(self.Flee) > 0 then	
		self:Fleey()
		self:WFlee()
		self:Epos()
    end

	if GetKeyPress(self.Combo) > 0 then	
        self:WLow()
		self:Epos()
        self:RComp()
    end
end 
