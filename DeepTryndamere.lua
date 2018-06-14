IncludeFile("Lib\\TOIR_SDK.lua")

Tryndamere = class()

local ScriptXan = 2.0
local NameCreat = "Deep"

function OnLoad()
    if myHero.CharName ~= "Tryndamere" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#FF0000\"> The Barbarian King!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Tryndamere, v</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
	Tryndamere:Jungle()
end

function Tryndamere:Jungle()
    --Pd
    SetLuaCombo(true)
    SetLuaLaneClear(true)

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target
    self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)
    self.Predc = VPrediction(true)

    self:TryndamereMenus()

    self.Q = Spell(_Q, GetTrueAttackRange())
    self.W = Spell(_W, 850)
    self.E = Spell(_E, 660)
    self.R = Spell(_R, GetTrueAttackRange())
  
    self.Q:SetActive()
	self.W:SetActive()
    self.E:SetSkillShot(0.10, 2000, 225, false)
    self.R:SetActive()

    self.listSpellInterrup = {
    ["FizzMarinerDoom"] = true,
    ["AatroxE"] = true,
    ["AhriOrbofDeception"] = true,
    ["AhriFoxFire"] = true,
    ["AhriSeduce"] = true,
    ["AhriTumble"] = true,
    ["FlashFrost"] = true,
    ["Anivia2"] = true,
    ["Disintegrate"] = true,
    ["Volley"] = true,
    ["EnchantedCrystalArrow"] = true,
    ["BandageToss"] = true,
    ["RocketGrabMissile"] = true,
    ["BrandBlaze"] = true,
    ["BrandWildfire"] = true,
    ["BraumQ"] = true,
    ["BraumRWapper"] = true,
    ["CaitlynPiltoverPeacemaker"] = true,
    ["CaitlynEntrapment"] = true,
    ["CaitlynAceintheHole"] = true,
    ["CassiopeiaMiasma"] = true,
    ["CassiopeiaTwinFang"] = true,
    ["PhosphorusBomb"] = true,
    ["MissileBarrage"] = true,
    ["DianaArc"] = true,
    ["InfectedCleaverMissileCast"] = true,
    ["dravenspinning"] = true,
    ["DravenDoubleShot"] = true,
    ["DravenRCast"] = true,
    ["EliseHumanQ"] = true,
    ["EliseHumanE"] = true,
    ["EvelynnQ"] = true,
    ["EzrealMysticShot"] = true,
    ["EzrealEssenceFlux"] = true,
    ["EzrealArcaneShift"] = true,
    ["GalioRighteousGust"] = true,
    ["GalioResoluteSmite"] = true,
    ["Parley"] = true,
    ["GnarQ"] = true,
    ["GravesClusterShot"] = true,
    ["GravesChargeShot"] = true,
    ["HeimerdingerW"] = true,
    ["IreliaTranscendentBlades"] = true,
    ["HowlingGale"] = true,
    ["JayceToTheSkies"] = true,
    ["jayceshockblast"] = true,
    ["JinxW"] = true,
    ["JinxR"] = true,
    ["KalistaMysticShot"] = true,
    ["KarmaQ"] = true,
    ["NullLance"] = true,
    ["KatarinaR"] = true,
    ["LeblancChaosOrb"] = true,
    ["LeblancSoulShackle"] = true,
    ["LeblancSoulShackleM"] = true,
    ["BlindMonkQOne"] = true,
    ["LeonaZenithBladeMissle"] = true,
    ["LissandraE"] = true,
    ["LucianR"] = true,
    ["LuxLightBinding"] = true,
    ["LuxLightStrikeKugel"] = true,
    ["MissFortuneBulletTime"] = true,
    ["DarkBindingMissile"] = true,
    ["NamiR"] = true,
    ["JavelinToss"] = true,
    ["NocturneDuskbringer"] = true,
    ["Pantheon_Throw"] = true,
    ["QuinnQ"] = true,
    ["RengarE"] = true,
    ["rivenizunablade"] = true,
    ["Overload"] = true,
    ["SpellFlux"] = true,
    ["SejuaniGlacialPrisonStart"] = true,
    ["SivirQ"] = true,
    ["SivirE"] = true,
    ["SkarnerFractureMissileSpell"] = true,
    ["SonaCrescendo"] = true,
    ["SwainDecrepify"] = true,
    ["SwainMetamorphism"] = true,
    ["SyndraE"] = true,
    ["SyndraR"] = true,
    ["TalonRake"] = true,
    ["TalonShadowAssault"] = true,
    ["BlindingDart"] = true,
    ["Thresh"] = true,
    ["BusterShot"] = true,
    ["VarusQ"] = true,
    ["VarusR"] = true,
    ["VayneCondemm"] = true,
    ["VeigarPrimordialBurst"] = true,
    ["WildCards"] = true,
    ["VelkozQ"] = true,
    ["VelkozW"] = true,
    ["ViktorDeathRay"] = true,
    ["XerathArcanoPulseChargeUp"] = true,
    ["ZedShuriken"] = true,
    ["ZiggsR"] = true,
    ["ZiggsQ"] = true,
    ["ZyraGraspingRoots"] = true,
}	

  self.isRactive = false
  self.incomboR = false
  self.outcombo = false
  self.Rfoff = false
	
 	Callback.Add("Update", function(...) self:OnUpdate(...) end)
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("UpdateBuff", function(unit, buff) self:OnUpdateBuff(source, unit, buff) end)
    Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep Tryndamere</font></b> <font color=\"#ffffff\">Loaded successfully. Enjoy The Barbarian King</font>")
 end 
  
--SDK {{Toir+}}
function Tryndamere:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Tryndamere:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Tryndamere:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Tryndamere:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Tryndamere:OnUpdate()
	if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
	end
end
  
function Tryndamere:TryndamereMenus()
      self.menu = "Deep Tryndamere"
      --Combo [[ Tryndamere ]]
      self.CW = self:MenuBool("Combo W", true)
      self.CE = self:MenuBool("Combo E", true)
	  
	  --Auto
    self.LMana = self:MenuSliderInt("Min rage % for auto Q", 50) 
	self.RRS = self:MenuBool("Auto R against spells", true)
	self.RRSlow = self:MenuSliderInt("%HP to auto R Spells", 30)
	self.AR = self:MenuBool("Auto R on low HP", true)
	self.ARlow = self:MenuSliderInt("%HP to auto R", 20)
	self.AQ = self:MenuBool("Auto Q on low HP", true)
	self.AQlow = self:MenuSliderInt("%HP to auto Q", 50)
			
      --Draws [[ Tryndamere ]]
      self.DW = self:MenuBool("Draw W", true)
      self.DE = self:MenuBool("Draw E", true)
  
      --Keys [[ Tryndamere ]]
      self.Combo = self:MenuKeyBinding("Combo", 32)
      self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	  
	  --Modskins
	  self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", true)
	  self.Set_Skin = self:MenuSliderInt("Set Skin", 6)
  end
   
function Tryndamere:OnDrawMenu()
if not Menu_Begin(self.menu) then return end
	
          if Menu_Begin("Combo") then
              self.CW = Menu_Bool("Combo W", self.CW, self.menu)
              self.CE = Menu_Bool("Combo E", self.CE, self.menu)
        Menu_End()
      end		  
	  		
          if Menu_Begin("Auto") then
            self.LMana = Menu_SliderInt("Min Rage % to auto Q", self.LMana, 0, 100, self.menu)
			self.RRS = Menu_Bool("Auto R against spells", self.RRS, self.menu)
			self.RRSlow = Menu_SliderInt("%HP to auto R against spells", self.RRSlow, 0, 100, self.menu)
			self.AQ = Menu_Bool("Auto Q on low HP", self.AQ, self.menu)
			self.AQlow = Menu_SliderInt("%HP to auto Q", self.AQlow, 0, 100, self.menu)
			self.AR = Menu_Bool("Auto R on low HP", self.AR, self.menu)
			self.ARlow = Menu_SliderInt("%HP to auto R", self.ARlow, 0, 100, self.menu)
            Menu_End()
          end

          if Menu_Begin("Drawings") then
            self.DW = Menu_Bool("Draw W", self.DW, self.menu)
            self.DE = Menu_Bool("Draw E", self.DE, self.menu)
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
            Menu_End()
          end
    Menu_End()
end

function Tryndamere:OnProcessSpell(unit, spell)
  if   unit
   and unit.IsEnemy
   and CanCast(_R)
   and self.RRS
   and self.listSpellInterrup[spell.Name]
   and IsValidTarget(unit, self.W.Range)
   and GetPercentHP(myHero.Addr) < self.RRSlow
   then
     __PrintTextGame("Tryndamere tried to tank a skill with R")
	 			target = GetAIHero(unit.Addr)
			--local CastPosition, HitChance, Position = vpred:GetLineCastPosition(target, self.W.delay, self.W.width, self.W.range, self.W.speed, myHero, false)
        CastSpellTarget(unit.Addr, _R)
	end
	end
	  
  function Tryndamere:OnDraw()
    if self.DW then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.W.range+110, Lua_ARGB(255,255,255,255))
	end
    if self.E:IsReady() and self.DE then 
        DrawCircleGame(myHero.x , myHero.y, myHero.z, self.E.range+80, Lua_ARGB(255,255,255,255))
	end
end

function Tryndamere:WLow()
    local UseW = GetTargetSelector(1000)
    if UseW then Enemy = GetAIHero(UseW) end
    if CanCast(_W) and self.CW and IsValidTarget(Enemy, 850) then
      CastSpellTarget(myHero.Addr, _W)
    end
end

function Tryndamere:Epos()
    local UseE = GetTargetSelector(1200)
    if UseE then Enemy = GetAIHero(UseE) end
    if CanCast(_E) and self.CE and IsValidTarget(Enemy, 740) then
        local CEPosition, HitChance, Position = self.Predc:GetLineCastPosition(Enemy, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
		if HitChance >= 2 then
			CastSpellToPos(CEPosition.x, CEPosition.z, _E)

        end
    end
end 

function Tryndamere:JungleClear()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minions) and (GetType(minions) == 3) then
            table.insert(result, minions)
        end

    end
    return result
end

function Tryndamere:FarmJungle(target)
	for i, minions in ipairs(self:JungleClear()) do
        if minions ~= 0 then
		local jungle = GetUnit(minions)
		if (GetType(minions) == 3) then

	  if CanCast(_E) then
		if jungle ~= nil and GetDistance(jungle) < self.E.range then
	    	local junglePos, HitChance, Position = self.Predc:GetLineCastPosition(jungle, self.E.delay, self.E.width, self.E.range, self.E.speed, myHero, false)
			CastSpellToPos(junglePos.x, junglePos.z, _E)
		end
    end
 end
end
end
end

function Tryndamere:Rauto()
    local UseR = GetTargetSelector(1600)
    if UseR then Enemy = GetAIHero(UseR) end
    if CanCast(R) and UseR ~= 0 and self.AR and IsValidTarget(Enemy, 800) and GetPercentHP(myHero.Addr) < self.ARlow then 
        CastSpellTarget(myHero.Addr, _R)
    end 
end

function Tryndamere:RautoTur()
    GetAllUnitAroundAnObject(myHero.Addr, 775)
	local objects = pUnit
	for k,v in pairs(objects) do
    if IsTurret(v) and not IsDead(v) and IsEnemy(v) and CanCast(R) and UseR ~= 0 and self.AR and GetPercentHP(myHero.Addr) < self.ARlow then 
        CastSpellTarget(myHero.Addr, _R)
    end 
end
end

function Tryndamere:OnUpdateBuff(source,unit,buff,stacks)
      if buff.Name == "UndyingRage" and unit.IsMe then
            self.isRactive = true
          end
end
		  
function Tryndamere:OnRemoveBuff(unit,buff)
      if buff.Name == "UndyingRage" and unit.IsMe then
            self.isRactive = false
          end
end	  

function Tryndamere:comboRcheck()
      if GetKeyPress(self.Combo) > 0 then
            self.incomboR = true;
        else
            self.outcombo = true;
          end
end

function Tryndamere:Roffcheck()
      if not self.R:IsReady() then
            self.Rfoff = true;
		else
            self.Rfoff = false;
          end
end	

function Tryndamere:Qauto()
    if not self.isRactive then 
	if self.outcombo and self.Rfoff then
	if CanCast(_Q) and GetPercentMP(myHero.Addr) >= self.LMana and self.AQ and GetPercentHP(myHero.Addr) < self.AQlow then
		CastSpellTarget(myHero.Addr, _Q)
    end
end
end
end

function Tryndamere:OnTick()
  if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    if GetKeyPress(self.LaneClear) > 0 then
		self:FarmJungle()
    end

	if GetKeyPress(self.Combo) > 0 then	
        self:WLow()
		self:Epos()
    end 

	self:Roffcheck()	
	self:comboRcheck()
	self:Rauto()
	self:RautoTur()
	self:Qauto()
end 
