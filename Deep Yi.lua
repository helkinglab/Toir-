IncludeFile("Lib\\TOIR_SDK.lua")

MasterYi = class()

function OnLoad()
    if GetChampName(GetMyChamp()) == "MasterYi" then
		MasterYi:Jungle()
	end
end

function MasterYi:Jungle()

    --Pd
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
	
	self.posEndDash = Vector(0, 0, 0)
	
    self:MasterYiMenus()

		--Spells
    self.Q = Spell(_Q, 600)
    self.W = Spell(_W, 800)
    self.E = Spell(_E, 300)
    self.R = Spell(_R, GetTrueAttackRange())
  
    self.Q:SetTargetted()
    self.W:SetActive()
    self.E:SetActive()
    self.R:SetActive()
	
	self.listSpellInterrup = {
	["CaitlynAceintheHole"] = true,
	["DrainChannel"] = true,
	["JhinR"] = true,
    ["AatroxE"] = true,
    ["AbsoluteZero"] = true,                       
    ["AhriSeduce"] = true,
    ["AlZaharNetherGrasp"] = true,
    ["Anivia2"] = true,
    ["BandageToss"] = true,
    ["BlindingDart"] = true,
    ["BlindMonkQOne"] = true,
    ["BrandWildfire"] = true,
    ["BraumRWapper"] = true,
    ["BusterShot"] = true,
    ["CaitlynAceintheHole"] = true,
    ["CassiopeiaMiasma"] = true,
    ["CassiopeiaPetrifMasterYingGaze"] = true,
    ["Crowstorm"] = true,
    ["CurseoftheSadMummy"] = true,
    ["DariusExecute"] = true,
    ["DarkBindingMissile"] = true,
    ["DianaArc"] = true,
    ["Disintegrate"] = true,
    ["Drain"] = true,
    ["DravenDoubleShot"] = true,
    ["DravenRCast"] = true,
    ["dravenspinning"] = true,
    ["EliseHumanE"] = true,
    ["EnchantedCrystalArrow"] = true,
    ["EvelynnR"] = true,
    ["FizzMarinerDoom"] = true,
    ["GalioResoluteSmite"] = true,
    ["GarenR"] = true,
    ["GnarR"] = true,
    ["GragasR"] = true,
    ["GravesClusterShot"] = true,
    ["HecarimUlt"] = true,
    ["HeimerdingerW"] = true,
    ["HowlingGale"] = true,
    ["InfernalGuardian"] = true,--annieR
    ["InfiniteDuress"] = true,
    ["JavelinToss"] = true,
    ["jayceshockblast"] = true,
    ["JayceToTheSkies"] = true,
    ["JinxR"] = true,
    ["JinxW"] = true,
    ["KalistaMysticShot"] = true,
    ["KarmaQ"] = true,
    ["KarthusFallenOne"] = true,
    ["LeblancChaosOrb"] = true,
    ["LeblancSoulShackle"] = true,
    ["LeblancSoulShackleM"] = true,
    ["LeonaZenithBladeMissle"] = true,
    ["LucianR"] = true,
    ["LuxLightBinding"] = true,
    ["LuxMaliceCannon"] = true,
    ["MissFortuneBulletTime"] = true,
    ["MissileBarrage"] = true,
    ["NamiR"] = true,
    ["NocturneDuskbringer"] = true,
    ["NullLance"] = true,
    ["Overload"] = true,
    ["PantheonRJump"] = true,
    ["Pantheon_Throw"] = true,
    ["Parley"] = true,
    ["QuinnQ"] = true,
    ["ReapTheWhirlwind"] = true,
    ["RengarE"] = true,
    ["rivenizunablade"] = true,
    ["RocketGrabMissile"] = true,
    ["SejuaniGlacialPrisonStart"] = true,
    ["SivirQ"] = true,
    ["SkarnerFractureMissileSpell"] = true,
    ["SonaCrescendo"] = true,
    ["SwainDecrepify"] = true,
    ["SwainMetamorphism"] = true,
    ["SyndraE"] = true,
    ["SyndraR"] = true,
    ["TalonShadowAssault"] = true,
    ["ThreshQ"] = true,
    ["UFSlash"] = true,--malr
    ["UrgotSwap2"] = true,
    ["VarusQ"] = true,
    ["VarusR"] = true,
    ["VayneCondemm"] = true,
    ["VeigarPrimordialBurst"] = true,
    ["VelkozQ"] = true,
    ["VelkozR"] = true,
    ["VelkozE"] = true,
    ["ViktorDeathRay"] = true,
    ["VladimirHemoplague"] = true,
    ["XerathArcanoPulseChargeUp"] = true,
    ["XerathLocusOfPower2"] = true,
    ["ZedShuriken"] = true,
    ["zedulttargetmark"] = true,
    ["ZiggsR"] = true,
    ["ZyraGraspingRoots"] = true,
	["akalimota"] = true,
	["aurelionsolq"] = true,
	["bardq"] = true,
	["jayceshockblastwall"] = true,
	["kennenshurikenhurlmissile1"] = true,
	["khazixw"] = true,
	["khazixQ"] = true,
	["kogmawq"] = true,
	["iceblast"] = true,
	["rengarefinal"] = true,
	["swaintorment"] = true,
	["twoshivpoison"] = true,
	["sejuaniglacialprison"] = true,
	["rumblegrenade"] = true,
	["goldcardpreattack"] = true,
	["vladimirtidesofbloodnuke"] = true,
	["yasuoq3w"] = true,
	["velkozr"] = true,
	["lucianq"] = true,
	["consume"] = true,
}

	MasterYi:aa()
	self.isWactive = false

    Callback.Add("Update", function(...) self:OnUpdate(...) end)	
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(source, unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	Callback.Add("BeforeAttack", function(...) self:OnBeforeAttack(...) end)
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep MasterYi</font></b> <font color=\"#ffffff\">Loaded. Enjoy The Wuju Bladesman</font>")
 end 

  --SDK {{Toir+}}
function MasterYi:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function MasterYi:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function MasterYi:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function MasterYi:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function MasterYi:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
	if self.menu_Combo_QendDash then
		self:autoQtoEndDash()
	end
end 

function MasterYi:MasterYiMenus()
    self.menu = "Deep MasterYi"
    --Combo [[ MasterYi ]]
    self.ComboQ = self:MenuBool("Combo Q", true)
    self.HoldQ = self:MenuBool("Keep Q for evading spells", true)
    self.CE = self:MenuBool("Combo E", true)
    self.AR = self:MenuBool("Combo R", true)
    self.ARlow = self:MenuSliderInt("Enemy max HP% to R", 90)
   
	--Auto
	self.menu_Combo_QendDash = self:MenuBool("Auto Q End Dash", true)
	self.Qinterrupt = self:MenuBool("Evade Spells With Q", true)
    self.QinterruptHP = self:MenuSliderInt("Your min HP% to evade with Q", 100)
	self.Wauto = self:MenuBool("Auto W on low HP", true)
    self.WautoHP = self:MenuSliderInt("Your min HP% to auto W", 25)
   
    --Lane
    self.LQ = self:MenuBool("Lane Q", true)
    self.LQMana = self:MenuSliderInt("Mana Lane Q %", 30)
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JQMana = self:MenuSliderInt("Mana Jungle Q %", 30)
    self.JE = self:MenuBool("Jungle E", true)
    self.JEMana = self:MenuSliderInt("Mana Jungle E %", 30)

	--Last hit
    self.LHQ = self:MenuBool("Last hit Q", true)
    self.LHQMana = self:MenuSliderInt("Min MP for using Q", 30)
	
    --Harass
    self.HarE = self:MenuBool("Harass E", true)
    self.HarQ = self:MenuBool("Harass Q", true)

    --KillSteal [[ MasterYi ]]
    self.KQ = self:MenuBool("KillSteal with Q", true)

    --Draws [[ MasterYi ]]
    self.DQ = self:MenuBool("Draw Q", true)

	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", false)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 5) 

    --KeyS [[ MasterYi ]]
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
	self.Harass = self:MenuKeyBinding("Harass", 67)
end

function MasterYi:OnDrawMenu()
if not Menu_Begin(self.menu) then return end

		if Menu_Begin("Combo") then
            self.ComboQ = Menu_Bool("Combo Q", self.ComboQ, self.menu)
            self.HoldQ = Menu_Bool("Keep Q for evading spells", self.HoldQ, self.menu)
			self.CE = Menu_Bool("Combo E", self.CE, self.menu)
            self.AR = Menu_Bool("Combo R", self.AR, self.menu)
            self.ARlow = Menu_SliderInt("Enemy max HP% to R", self.ARlow, 0, 100, self.menu)
			Menu_End()
        end
		if Menu_Begin("Auto") then
			self.menu_Combo_QendDash = Menu_Bool("Auto Q Dasing Enemies", self.menu_Combo_QendDash, self.menu)
            self.Qinterrupt = Menu_Bool("Evade Spells With Q", self.Qinterrupt, self.menu)
            self.QinterruptHP = Menu_SliderInt("Your min HP% to evade with Q", self.QinterruptHP, 0, 100, self.menu)
            self.Wauto = Menu_Bool("Auto W on low HP", self.Wauto, self.menu)
			self.WautoHP = Menu_SliderInt("Your min HP% to auto W", self.WautoHP, 0, 100, self.menu)
			Menu_End()
        end
        if Menu_Begin("Harass") then
			self.HarQ = Menu_Bool("Harass Q", self.HarQ, self.menu)
			self.HarE = Menu_Bool("Harass E", self.HarE, self.menu)
			Menu_End()
        end
        if Menu_Begin("Clear skills") then
			self.LQ = Menu_Bool("Lane Q", self.LQ, self.menu)
            self.LQMana = Menu_SliderInt("Min MP % for using Lane Q", self.LQMana, 0, 100, self.menu)
			self.JQ = Menu_Bool("Jungle Q", self.JQ, self.menu)
            self.JQMana = Menu_SliderInt("Min MP % for using Jungle Q", self.JQMana, 0, 100, self.menu)
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
            self.DQ = Menu_Bool("Draw Q range", self.DQ, self.menu)
			Menu_End()
        end
        if Menu_Begin("KillSteal") then
            self.KQ = Menu_Bool("KillSteal with Q", self.KQ, self.menu)
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

function MasterYi:OnProcessSpell(unit, spell)			
  if   unit
   and unit.IsEnemy
   and self.Qinterrupt
   and GetPercentHP(myHero.Addr) < self.QinterruptHP
   and self.listSpellInterrup[spell.Name]
   and IsValidTarget(unit, self.Q.Range)
   then
	 			target = GetAIHero(unit.Addr)
        CastSpellTarget(unit.Addr, _Q)
	end
	end	
	
function MasterYi:EnemyMinionsTbl() --SDK Toir+
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

function MasterYi:FarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LHQMana and self.LHQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
		CastSpellTarget(minion.Addr, _Q)
       end 
       end 
    end 
end

function MasterYi:LaneFarmeQ()
    for i ,minion in pairs(self:EnemyMinionsTbl()) do
        if minion ~= 0 then
       if GetPercentMP(myHero.Addr) >= self.LQMana and self.LQ and IsValidTarget(minion.Addr, self.Q.range) and GetDamage("Q", minion) > minion.HP then
	   CastSpellTarget(minion.Addr, _Q)
       end 
       end 
    end 
end 

function MasterYi:OnDraw()
    if self.DQ and self.Q:IsReady() then
        DrawCircleGame(myHero.x, myHero.y, myHero.z,self.Q.range+90, Lua_ARGB(255,255,0,0))
      end
   end 

function MasterYi:KillEnemy()
    local QKS = GetTargetSelector(self.Q.range)
    Enemy = GetAIHero(QKS)
    if CanCast(_Q) and self.KQ and QKS ~= 0 and GetDistance(Enemy) < self.Q.range and GetDamage("Q", Enemy) > Enemy.HP then
        CastSpellTarget(Enemy.Addr, Q)
    end 
end 

function MasterYi:CastQ()
    local UseQ = GetTargetSelector(1000)
    if UseQ then Enemy = GetAIHero(UseQ) end
	if not self.HoldQ then
    if CanCast(_Q)
	and self.ComboQ
	and IsValidTarget(Enemy, self.Q.range)
	then
        CastSpellTarget(Enemy.Addr, _Q)
    end 
	end
	end

function MasterYi:QHarass()
    local UseQ = GetTargetSelector(1000)
    if UseQ then Enemy = GetAIHero(UseQ) end
    if CanCast(_Q)
	and self.HarQ
	and IsValidTarget(Enemy, self.Q.range)
	then
        CastSpellTarget(Enemy.Addr, _Q)
    end 
	end

function MasterYi:autoQtoEndDash()
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

  function MasterYi:OnUpdateBuff(source,unit,buff,stacks)
  --__PrintTextGame(buff.Name)
	  if buff.Name == "Meditate" and unit.IsMe then
            SetLuaMoveOnly(true)
            SetLuaBasicAttackOnly(true)
          end
  end

  function MasterYi:OnRemoveBuff(unit,buff)
  --__PrintTextGame(buff.Name)
	  if buff.Name == "Meditate" and unit.IsMe then
            SetLuaMoveOnly(false)
            SetLuaBasicAttackOnly(false)
          end
   end

function MasterYi:JungleClear()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and not IsInFog(minions) and (GetType(minions) == 3 or GetType(minions) == 2 or GetType(minions) == 1) then
            table.insert(result, minions)
        end
    end

    return result
end

function MasterYi:OnBeforeAttack(unit, target)
	if unit.IsMe then
    		if GetKeyPress(self.Combo) > 0
			and self.CE
			then
    			CastSpellTarget(myHero.Addr, _E)
		end
		
	for i, minions in ipairs(self:JungleClear()) do
        if minions ~= 0 then
		local jungle = GetUnit(minions)
		if jungle.Type == 3 then

	  if GetKeyPress(self.LaneClear) > 0
	  and CanCast(_E)
	  and self.JE
	  and GetPercentMP(myHero.Addr) > self.JEMana
	  then
		if jungle ~= nil and GetDistance(jungle) < self.E.range then
			self.E:Cast(myHero.Addr)
        end
	end
end
end
end
end
end						

function MasterYi:CastW()
    local UseW = GetTargetSelector(1000)
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W)
	and self.Wauto
	and GetPercentHP(myHero.Addr) < self.WautoHP
	and IsValidTarget(Enemy, self.W.range)
	then 
        self.W:Cast(myHero.Addr)
		DelayAction(function() self:CastW(myHero) end, 4)
        end
    end 

function MasterYi:WautoTur()
    GetAllUnitAroundAnObject(myHero.Addr, 775)
	local objects = pUnit
	for k,v in pairs(objects) do
    if IsTurret(v) and not IsDead(v) and IsEnemy(v) 
	and CanCast(W) 
	and self.Wauto 
	and GetPercentHP(myHero.Addr) < self.WautoHP
	then 
        self.W:Cast(myHero.Addr)
		DelayAction(function() self:CastW(myHero) end, 4)
    end 
end
end
	
function MasterYi:Eharass()
    local UseE = GetTargetSelector(1000)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E)
	and self.HarE
	and IsValidTarget(Enemy, self.E.range)
	then 
        self.E:Cast(myHero.Addr)
        end
    end
  	
function MasterYi:Rauto()
    local UseR = GetTargetSelector(1600)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(R) and UseR ~= 0 and self.AR and IsValidTarget(Enemy, 800) and GetPercentHP(Enemy.Addr) <= self.ARlow then 
        CastSpellTarget(myHero.Addr, _R)
    end 
end

function MasterYi:JungleMinionsKILL() --SDK Toir+
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

function MasterYi:FarmQJungle()
    for i ,jungle in pairs(self:JungleMinionsKILL()) do
        if jungle ~= 0 then
       if self.JQ
	   and GetPercentMP(myHero.Addr) >= self.JQMana
	   and IsValidTarget(jungle.Addr, self.Q.range)
	   then
		CastSpellTarget(jungle.Addr, Q)
       end 
    end 
end
end
	
function MasterYi:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    self:KillEnemy()
	self:CastW()
	self:WautoTur()
	
    if GetKeyPress(self.LastHit) > 0 then	
        self:FarmeQ()
    end
	
    if GetKeyPress(self.Harass) > 0 then
        self:Eharass()
        self:QHarass()
    end

    if GetKeyPress(self.LaneClear) > 0 then	
        self:LaneFarmeQ()
		self:FarmQJungle()
    end

	if GetKeyPress(self.Combo) > 0 then
		self:CastQ()
		self:Rauto()
    end
end 

function MasterYi:aa()
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