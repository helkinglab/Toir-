IncludeFile("Lib\\TOIR_SDK.lua")

XinZhao = class()

local ScriptXan = 2.0
local NameCreat = "Deep"

function OnLoad()
    if myHero.CharName ~= "XinZhao" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> The Seneschal Of Demacia!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Xin Zhao, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
	XinZhao:TopLane()
end

function XinZhao:TopLane()

    --Pd
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
    self.Predc = VPrediction(true)

	self.posEndDash = Vector(0, 0, 0)	
	
    self:XinZhaoMenus()

		--Spells	
    self.Q = Spell(_Q, GetTrueAttackRange())
    self.W = Spell(_W, 900)
    self.E = Spell(_E, 650)
    self.R = Spell(_R, 500)
  
    self.Q:SetActive()
	self.W:SetSkillShot(0.30, 1600, 100, false)
    self.E:SetTargetted()
    self.R:SetActive()
	
	XinZhao:aa()
	
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
  Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
	Callback.Add("AfterAttack", function(...) self:OnAfterAttack(...) end)
	Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep XinZhao</font></b> <font color=\"#ffffff\">Loaded. Enjoy The Seneschal Of Demacia</font>")
 end 
 
--SDK {{Toir+}}
function XinZhao:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function XinZhao:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function XinZhao:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function XinZhao:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end
 
function XinZhao:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
	if self.menu_Combo_QendDash then
		self:autoQtoEndDash()
	end
end 

function XinZhao:autoQtoEndDash()
	for i, enemy in pairs(GetEnemyHeroes()) do
		if enemy ~= nil then
		    target = GetAIHero(enemy)
		    if IsValidTarget(target.Addr, self.E.range) then
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
					    	CastSpellTarget(target.Addr, _E)
					    end
					end
				end
			end
			end
 
  function XinZhao:XinZhaoMenus()
   self.menu = "Deep XinZhao"
   --Combo [[ XinZhao ]]
   self.CQ = self:MenuBool("Combo Q", true)
   self.CW = self:MenuBool("Combo W", true)
   self.CE = self:MenuBool("Combo E", true)
	self.menu_Combo_QendDash = self:MenuBool("Auto Q End Dash", false)
   self.CWdis = self:MenuSliderInt("Combo W distance", 250)
   self.CWhar = self:MenuBool("Harass W", true)
   self.CWHarassdis = self:MenuSliderInt("Harass W distance", 900)
   self.CEdis = self:MenuSliderInt("Combo minimum E Distance", 350)
   
	--Auto
	self.Rinterrupt = self:MenuBool("Interrupt Spells With R", true)
   
   --Add R
   self.CR = self:MenuBool("Combo R", true)
   self.URS = self:MenuSliderInt("HP Minimum %", 100)
   self.AR = self:MenuBool("Auto R on low HP", true)
   self.ARlow = self:MenuSliderInt("%HP to auto R", 20)
 
   --Clear [[ XinZhao ]]
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JQMana = self:MenuSliderInt("Mana Jungle Q %", 30)
    self.JW = self:MenuBool("Jungle W", true)
    self.JWMana = self:MenuSliderInt("Mana Jungle W %", 30)
    self.JE = self:MenuBool("Jungle E", true)
    self.JEMana = self:MenuSliderInt("Mana Jungle E %", 30)
 
   --Draws [[ XinZhao ]]
   self.DW = self:MenuBool("Draw W", true)
   self.DE = self:MenuBool("Draw E", true)
   self.DR = self:MenuBool("Draw R", true)
   
   --Keys [[ XinZhao ]]
   self.Combo = self:MenuKeyBinding("Combo", 32)
   self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	self.Harass = self:MenuKeyBinding("Harass", 67)
   
	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", false)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 5) 
 end
 
 function XinZhao:OnDrawMenu()
if not Menu_Begin(self.menu) then return end
	
     if Menu_Begin("Combo") then
       self.CQ = Menu_Bool("Combo Q", self.CQ, self.menu)
       self.CW = Menu_Bool("Combo W", self.CW, self.menu)
       self.CWdis = Menu_SliderInt("Combo W distance", self.CWdis, 100, 900, self.menu)
       self.CE = Menu_Bool("Combo E", self.CE, self.menu)
		self.menu_Combo_QendDash = Menu_Bool("Auto E Dasing Enemies", self.menu_Combo_QendDash, self.menu)
       self.CEdis = Menu_SliderInt("Combo minimum E Distance", self.CEdis, 0, 500, self.menu)
       self.CWhar = Menu_Bool("Harass W", self.CWhar, self.menu)
       self.CWHarassdis = Menu_SliderInt("Harass W distance", self.CWHarassdis, 100, 900, self.menu)
       self.CR = Menu_Bool("Combo R", self.CR, self.menu)
       self.URS = Menu_SliderInt("Your min HP to combo R", self.URS, 0, 100, self.menu)
       self.AR = Menu_Bool("Auto R on low HP", self.AR, self.menu)
       self.ARlow = Menu_SliderInt("%HP to auto R", self.ARlow, 0, 100, self.menu)
       Menu_End()
     end

        if Menu_Begin("Auto Interrupt") then
		self.Rinterrupt = Menu_Bool("Interrupt Spells With R", self.Rinterrupt, self.menu)
        Menu_End()
       end

     if Menu_Begin("Clear skills") then
			self.JQ = Menu_Bool("Jungle Q", self.JQ, self.menu)
            self.JQMana = Menu_SliderInt("Min MP % for using Jungle Q", self.JQMana, 0, 100, self.menu)
			self.JW = Menu_Bool("Jungle W", self.JW, self.menu)
            self.JWMana = Menu_SliderInt("Min MP % for using Jungle W", self.JWMana, 0, 100, self.menu)
			self.JE = Menu_Bool("Jungle E", self.JE, self.menu)
            self.JEMana = Menu_SliderInt("Min MP % for using Jungle E", self.JEMana, 0, 100, self.menu)
       Menu_End()
     end
	   
     if Menu_Begin("Draws") then
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
		self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
		self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
       Menu_End()
     end
     Menu_End()
   end


 function XinZhao:OnDraw()
  if self.W:IsReady() and self.DW then 
    DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range+50, Lua_ARGB(255,255,255,255))
  end
  if self.E:IsReady() and self.DE then 
    DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range+80, Lua_ARGB(255,255,255,255))
	end
  if self.R:IsReady() and self.DR then 
    DrawCircleGame(myHero.x , myHero.y, myHero.z, self.R.range+70, Lua_ARGB(255,255,255,255))
	end
end

function XinZhao:OnProcessSpell(unit, spell)
  if   unit
   and unit.IsEnemy
   and self.Rinterrupt
   and self.listSpellInterrup[spell.Name]
   and IsValidTarget(unit, 500)
   then
     __PrintTextGame("Xin Zhao tried to interrupt a skill with R")
		target = GetAIHero(unit.Addr)
        CastSpellTarget(unit.Addr, _R)
	end
	end

function XinZhao:OnAfterAttack(unit, target)
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
		if jungle.Type == 3 then

	  if GetKeyPress(self.LaneClear) > 0
	  and CanCast(_Q)
	  and self.JQ
	  and GetPercentMP(myHero.Addr) >= self.JQMana
	  then
		if jungle ~= nil and GetDistance(jungle) < self.Q.range then
			self.Q:Cast(myHero.Addr)
        end						
			    		end
			    	end		    						
				end			
    		end
			end
			end
			
function XinZhao:Epos()
    local UseE = GetTargetSelector(1000)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E) and self.CE and IsValidTarget(Enemy, 700) and GetDistance(Enemy) > self.CEdis then 
        CastSpellTarget(Enemy.Addr, _E)
    end 
end

function XinZhao:Wcom()
    local UseW = GetTargetSelector(1000)
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.CW and IsValidTarget(Enemy, self.CWdis) then 
        target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
        end
    end 
end

function XinZhao:WHarass()
    local UseW = GetTargetSelector(1000)
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.CWhar and IsValidTarget(Enemy, self.CWHarassdis) then 
        target = GetAIHero(Enemy)
        			local CastPosition, HitChance, Position = self:GetWLinePreCore(target)
			if HitChance >= 6 then
        		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
        end
    end 
end
					
function XinZhao:RComp()
    local UseR = GetTargetSelector(1000)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(_R) and self.CR and IsValidTarget(Enemy, self.R.range) and GetPercentHP(myHero.Addr) < self.URS then 
        CastSpellTarget(myHero.Addr, _R)
    end 
end

function XinZhao:Rlow()
    local UseR = GetTargetSelector(1000)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(_R) and self.AR and IsValidTarget(Enemy, 1000) and GetPercentHP(myHero.Addr) < self.ARlow then 
        CastSpellTarget(myHero.Addr, _R)
    end 
end 

function XinZhao:ToTurrent()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
	local objects = pUnit
	for k,v in pairs(objects) do
        if IsTurret(v) and not IsDead(v) and IsEnemy(v) and GetTargetableToTeam(v) == 4 and IsValidTarget(v, GetTrueAttackRange()) then
            CastSpellTarget(myHero.Addr, _Q)
        end 
    end 
end  

function XinZhao:JungleClear()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minion) and not IsInFog(minions) and (GetType(minions) == 3 or GetType(minions) == 2 or GetType(minions) == 1) then
            table.insert(result, minions)
        end
    end

    return result
end 


function XinZhao:GetWLinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero.x, myHero.z, false, true, 1, 3, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

function XinZhao:CountEnemyInLine(target)
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
end

function XinZhao:CountEnemiesInRange(pos, range)
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

function XinZhao:JungleW()
	if CanCast(_W) and self.JW and GetPercentMP(myHero.Addr) > self.JWMana and (GetType(GetTargetOrb()) == 3) then
		if (GetObjName(GetTargetOrb()) ~= "PlantSatchel" and GetObjName(GetTargetOrb()) ~= "PlantHealth" and GetObjName(GetTargetOrb()) ~= "PlantVision") then
			target = GetUnit(GetTargetOrb())
	    	local targetPos, HitChance, Position = self.Predc:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
			CastSpellToPos(targetPos.x, targetPos.z, _W)
		end
    end
	end

function XinZhao:JungleMinionsKILL() --SDK Toir+
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
	
function XinZhao:JungleE()
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

function XinZhao:OnTick()
  if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end
  
    self:Rlow()  
  
    if GetKeyPress(self.LaneClear) > 0 then
		local target = self.menu_ts:GetTarget()	
        self:ToTurrent()
		self:JungleW()
		self:JungleE()
    end
	
    if GetKeyPress(self.Harass) > 0 then
		self:WHarass()
    end
	
    if GetKeyPress(self.Combo) > 0 then
		self:Epos()
		self:Wcom()
		self:RComp()
    end
end 

function XinZhao:aa()
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
		{Name = "YasuoDashWrapper", RangeMin = 480, Range = 480, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CaitlynEntrapment", RangeMin = -380, Range = -380, Type = 1, Duration = 0.25}, --CHUAN
	}
end