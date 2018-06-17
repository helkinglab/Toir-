IncludeFile("Lib\\SDK.lua")
IncludeFile("Lib\\DamageIndicator.lua")

class "DeepShen"

local ScriptXan = 8.12
local NameCreat = "Deep"

function OnLoad()
    if myHero.CharName ~= "Shen" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#cffffff00\"> The Eye Of Twilight!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Shen for LOL version</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    DeepShen:__init()
end

function DeepShen:__init()

    SetLuaCombo(true)
    SetLuaHarass(true)
    SetLuaLaneClear(true)

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
	
	self.listSpelldangerous = {
    ["NocturneParanoia2"] = true,                     
    ["rivenizunablade"] = true,
    ["Anivia2"] = true,
    ["BrandWildfire"] = true,
    ["BusterShot"] = true,
    ["CassiopeiaPetrifyingGaze"] = true,
    ["DariusExecute"] = true,
	["InfernalGuardian"] = true,--annieR
    ["DravenRCast"] = true,
    ["EvelynnR"] = true,
    ["GarenR"] = true,
    ["GravesClusterShot"] = true,
    ["HecarimUlt"] = true,
    ["jayceshockblast"] = true,
	["JinxR"] = true,
    ["KarthusFallenOne"] = true,
    ["LucianR"] = true,
    ["LuxMaliceCannon"] = true,
    ["PantheonRJump"] = true,
    ["SwainMetamorphism"] = true,
    ["SyndraR"] = true,
    ["TalonShadowAssault"] = true,
    ["VeigarPrimordialBurst"] = true,
	["vladimirtidesofbloodnuke"] = true,
    ["zedulttargetmark"] = true,
    ["ZiggsR"] = true,
	["jayceshockblastwall"] = true,
    ["Anivia2"] = true,
    ["BrandWildfire"] = true,
    ["BusterShot"] = true,
    ["CassiopeiaPetrifyingGaze"] = true,
    ["Crowstorm"] = true,
    ["CurseoftheSadMummy"] = true,
    ["DariusExecute"] = true,
    ["UFSlash"] = true,--malr
    ["SejuaniGlacialPrisonStart"] = true,
	}
	
    self.Q = Spell({Slot = 0, Range = 200})
    self.W = Spell({Slot = 1, Range = 200})
    self.E = Spell({Slot = 2, SpellType = Enum.SpellType.SkillShot, Range = 600, SkillShotType = Enum.SkillShotType.Line, Collision = false, Width = 185, Delay = 0.25, Speed = 1600})
    self.R = Spell({Slot = 3, Range = 9999})

--	DeepShen:aa()
	
    self:MenuDeep()
--	self.isQactive = false
	

    
    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
--    AddEvent(Enum.Event.OnUpdate, function(...) self:OnUpdate(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
--    AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)

    __PrintTextGame("<b><font color=\"#cffffff00\">Deep Shen</font></b> <font color=\"#ffffff\">Loaded. Enjoy The Eye Of Twilight</font>")
end


  function DeepShen:OnUpdateBuff(source,unit,buff,stacks)
  	--	__PrintTextGame(buff.Name)
		
	  if buff.Name == "shenrchannelmanager" and unit.IsMe then
            SetLuaMoveOnly(true)
            SetLuaBasicAttackOnly(true)
          end
  end

  function DeepShen:OnRemoveBuff(unit,buff)
    	--	__PrintTextGame(buff.Name)
	  if buff.Name == "shenrchannelmanager" and unit.IsMe then
            SetLuaMoveOnly(false)
            SetLuaBasicAttackOnly(false)
          end
   end
--[[
function DeepShen:OnUpdate()
	if self.menu_Combo_QendDash then
		self:autoQtoEndDash()
	end
	if self.menu_Combo_EendDash then
		self:autoEtoEndDash()
	end
end ]]
   
function DeepShen:Fleey()
    local mousePos = Vector(GetMousePos())
    MoveToPos(mousePos.x,mousePos.z)
end 

function DeepShen:WFlee()
    if CanCast(_W)
	and not CanCast(_E)
	and self.FW
	then 
        CastSpellTarget(myHero.Addr, _W)
        end
    end
	
function DeepShen:EFlee()
	local mousePos = Vector(GetMousePos())
    if CanCast(_E)
	and self.FE
	then 
        CastSpellToPos(mousePos.x, mousePos.z, _E)
        end
    end
	
function DeepShen:QFlee()
    if CanCast(_Q)
	and not CanCast(_E)
	and self.FQ
	then
        CastSpellTarget(myHero.Addr, _Q)
        end
    end
   
function DeepShen:OnTick()
    if IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or not IsRiotOnTop() then return end

    myHero = GetMyHero()

	--[[
    if GetBuffByName(myHero.Addr, "PoisonTrail") > 0 then
        self.Q.SQ = true
    else
        self.Q.SQ = false
    end]]

    if GetKeyPress(self.Harass) > 0 then
		self:HarassShen()
	end
	
	if GetKeyPress(self.Combo) > 0 then
        self:ComboShen()
    end 

	if GetKeyPress(self.Flee) > 0 then	
		self:Fleey()
		self:WFlee()
		self:EFlee()
		self:QFlee()
    end
	
    if GetKeyPress(self.LaneClear) > 0 then	
        self:ClearY()  
        self:ClearQ()  
    end 
	
--	self:TurnoffQ()
    self:KillEnemy()
	self:Automatic()
--	self:AutomaticQoff()

    if self.Enable_Mod_Skin then
		ModSkin(self.Set_Skin)
    end
    
    if self.AutoLevelTop then
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
    if self.AutoLevelSupport then
        if myHero.Level == 1 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 2 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 3 then
            LevelUpSpell(_W)
        end 
        if myHero.Level == 4 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 5 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 6 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 7 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 8 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 9 then
            LevelUpSpell(_E)
        end 
        if myHero.Level == 10 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 11 then
            LevelUpSpell(_R)
        end 
        if myHero.Level == 12 then
            LevelUpSpell(_Q)
        end 
        if myHero.Level == 13 then
            LevelUpSpell(_Q)
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


function DeepShen:Automatic()
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
end

--[[

function DeepShen:AutomaticQoff()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v == 0 then
    __PrintTextGame("off Q")
self:OffQ()
            end			
        end 
    end ]]
	
function DeepShen:HarassShen()
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

function DeepShen:ComboShen()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 1100) then
                self:CastQ(target)
				self:CastW(target)
				if self.menu_ComboE then
				self:CastE(target)
				end
            end  
        end 
    end 
end

function DeepShen:ClearY()
    for i, minion in pairs(self:EnemyMinionsTbl(500)) do
        if minion ~= 0 then
            if self.Q:IsReady() and self.LQ and GetDistance(Vector(minion)) <= 300 then
                CastSpellTarget(myHero.Addr, _Q)            
            end
        end 
    end 
end 

function DeepShen:ClearQ()
    for i, junged in pairs(self:EnemyJungleTbl(500)) do 
        if junged ~= 0 then
            if self.Q:IsReady() and self.JQ and GetDistance(Vector(junged)) <= 300 then
                CastSpellTarget(myHero.Addr, _Q)
            end 
            if self.W:IsReady() and self.JW and GetDistance(Vector(junged)) <= 200 then
                CastSpellTarget(junged.Addr, _W)
            end
        end 
    end           
end 

function DeepShen:DashEndPos(target)
    local Estent = 0

    if GetDistance(target) < 410 then
        Estent = Vector(myHero):Extended(Vector(target), 410)
    else
        Estent = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
    end

    return Estent
end

function DeepShen:KillEnemy()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if self.KE and IsValidTarget(target, 600) and self.E:GetDamage(target) > target.HP then 
				local CastPosition, HitChance, Position = self:GetELinePreCore(target)
--		  	__PrintTextGame(HitChance)
				if HitChance >= 5 then
				CastSpellToPos(CastPosition.x, CastPosition.z, _E)
				end
            end 
        end 
    end
end
	 
function DeepShen:MenuDeep()
    self.menu = "Deep Shen"

    --Combo
    self.menu_ComboQ = self:MenuBool("Use Q", true)
--    self.Qonall = self:MenuBool("Use Q", true)
    self.menu_ComboW = self:MenuBool("Use W", true)
--    self.menu_KeepW = self:MenuBool("Keep W for E+W combo", true)
    self.menu_ComboE = self:MenuBool("Use E", true)
    self.CEdis = self:MenuSliderInt("Minimun range required to Combo E", 200)
    self.AutoLevelTop = self:MenuBool("Auto level top", false)
    self.AutoLevelSupport = self:MenuBool("Auto level support", false)
--    self.CRlow = self:MenuSliderInt("HP Minimum %", 90)

    self.menu_ComboR = self:MenuBool("Auto R", true)
    self.CRlow = self:MenuSliderInt("Ally min HP to use R", 400)
    self.CRnum = self:MenuSliderInt("Enemies around ally to auto R", 2)
    self.CRnumrange = self:MenuSliderInt("Range to count enemies around ally", 800)
--    self.CRextra = self:MenuBool("Extra R", true)
    self.CRlowHP = self:MenuBool("Auto R HP %", true)
    self.CRlowHPrange = self:MenuSliderInt("HP range", 30)


    self.HarQ = self:MenuBool("Harass Q", true)
    self.HarW = self:MenuBool("Harass W", true)
    self.HarE = self:MenuBool("Harass E", true)

    --KillSteal [[ Shen ]]
    self.KE = self:MenuBool("KillSteal with E", true)
	
    self.LQ = self:MenuBool("Lane Q", true)
    self.JQ = self:MenuBool("Jungle Q", true)
    self.JW = self:MenuBool("Jungle W", true)
 --   self.JEMana = self:MenuSliderInt("Mana Jungle E %", 30)
 --    self.JQMana = self:MenuSliderInt("Mana Jungle Q %", 30)
	
    self.menu_interruptE2 = self:MenuBool("Use E on dashing enemies", true)
    self.menu_interruptE = self:MenuBool("Use E to interrupt channeling spells", true)
    self.menu_interruptQ = self:MenuBool("Use Q+W to block dangerous spells", true)
    self.menu_dashrange = self:MenuSliderInt("Spell dash detection range", 900)
    self.menu_interruptrange = self:MenuSliderInt("Spell dangerous detection range", 900)
  --	self.menu_Combo_QendDash = self:MenuBool("Auto W End Dash", true)
	--self.menu_Combo_EendDash = self:MenuBool("Auto E End Dash", true)
  
  
    self.menu_DrawDamage = self:MenuBool("Draw Damage", true)
    self.menu_DrawERange = self:MenuBool("Draw Engage Range", true)
 --   self.BuffDraw_Q = self:MenuBool("Draw Shen Buff", true)
  
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	self.Harass = self:MenuKeyBinding("Harass", 67)
	  self.Flee = self:MenuKeyBinding("Flee", 71)
	    self.FE = self:MenuBool("Flee E", true)
	    self.FW = self:MenuBool("Flee W", true)	
	    self.FQ = self:MenuBool("Flee Q", true)
  
    self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", true)
    self.Set_Skin = self:MenuSliderInt("Set Skin", 3)

--[[
    self.R.Whitelist = {}
    for k, v in pairs(self:GetAllies(math.huge)) do
        self.R.Whitelist[v.CharName] = ReadIniBoolean("Use [R] on ".. v.CharName, true) 
    end]]
  end
  
function DeepShen:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end

    if (Menu_Begin("Combo")) then
        self.menu_ComboQ = Menu_Bool("Use Q", self.menu_ComboQ, self.menu)
--		self.Qonall = Menu_Bool("Auto Q when a champ get near you", self.Qonall, self.menu)
            Menu_Separator()
        self.menu_ComboW = Menu_Bool("Use W", self.menu_ComboW, self.menu)
--        self.menu_KeepW = Menu_Bool("Keep W for E+W combo", self.menu_KeepW, self.menu)
        self.menu_ComboE = Menu_Bool("Use E", self.menu_ComboE, self.menu)
        self.CEdis = Menu_SliderInt("Minimun range required to Combo E", self.CEdis, 0, 600, self.menu)
  --      self.CRlow = Menu_SliderInt("My min % HP for Combo R", self.CRlow, 0, 100, self.menu)

--[[        Menu_Text("--Settings [R]--")
        if Menu_Begin("Whilelist") then
            for k, v in pairs(self:GetAllies(math.huge)) do
                self.R.Whitelist = Menu_Bool("Use [R] on ".. v.CharName, self.R.Whitelist)
            end
            Menu_End()  
        end]]
        Menu_End()
    end 
        if (Menu_Begin("Auto R")) then
		self.menu_ComboR = Menu_Bool("Auto R", self.menu_ComboR, self.menu)
		self.CRlow = Menu_SliderInt("Ally min HP to auto R", self.CRlow, 0, 3000, self.menu)
		self.CRnum = Menu_SliderInt("Enemies around ally to auto R", self.CRnum, 0, 5, self.menu)
		self.CRnumrange = Menu_SliderInt("Range to count enemies around ally", self.CRnumrange, 600, 1000, self.menu)
--		self.CRextra = Menu_Bool("Use alter conditions", self.CRextra, self.menu)
		Menu_Text("Alternate conditions:")
            Menu_Separator()
		self.CRlowHP = Menu_Bool("Check ally % HP instead of HP amount", self.CRlowHP, self.menu)
		self.CRlowHPrange = Menu_SliderInt("R ally with less HP % than this", self.CRlowHPrange, 0, 100, self.menu)
			Menu_End()
        end
	        
	
    if (Menu_Begin("Auto misc")) then
        if Menu_Begin("Auto Level - Must choose one at level 1") then
		self.AutoLevelTop = Menu_Bool("Auto Level Top Lane", self.AutoLevelTop, self.menu)
		self.AutoLevelSupport = Menu_Bool("Auto Level Support", self.AutoLevelSupport, self.menu)
            Menu_End()  
        end
			Menu_Separator()
        self.menu_interruptE = Menu_Bool("Use E to interrupt channeling spells", self.menu_interruptE, self.menu)
			Menu_Separator()
        self.menu_interruptE2 = Menu_Bool("Use E on dashing enemies", self.menu_interruptE2, self.menu)
		self.menu_dashrange = Menu_SliderInt("Dash spells detection range", self.menu_dashrange, 500, 1200, self.menu)
			Menu_Separator()
        self.menu_interruptQ = Menu_Bool("Use Q+W to block dangerous spells", self.menu_interruptQ, self.menu)
		self.menu_interruptrange = Menu_SliderInt("Dangerous spell detection range", self.menu_interruptrange, 500, 1200, self.menu)
--		self.menu_Combo_QendDash = Menu_Bool("Auto W Dasing Enemies", self.menu_Combo_QendDash, self.menu)
--		self.menu_Combo_EendDash = Menu_Bool("Auto E Dasing Enemies", self.menu_Combo_EendDash, self.menu)
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
            self.KE = Menu_Bool("KillSteal with E", self.KE, self.menu)
			Menu_End()
    end
	
        if (Menu_Begin("Clear skills")) then
			self.LQ = Menu_Bool("Lane clear Q", self.LQ, self.menu)
    --        self.JQMana = Menu_SliderInt("Min MP % for using Jungle Q", self.JQMana, 0, 100, self.menu)
			self.JQ = Menu_Bool("Jungle Q", self.JQ, self.menu)
			self.JW = Menu_Bool("Clear W", self.JW, self.menu)
    --        self.JEMana = Menu_SliderInt("Min MP % for using Jungle E", self.JEMana, 0, 100, self.menu)
			Menu_End()
        end
	
    if (Menu_Begin("Drawings")) then
        self.menu_DrawDamage = Menu_Bool("Draw Damage", self.menu_DrawDamage, self.menu)
        self.menu_DrawERange = Menu_Bool("Draw E Range", self.menu_DrawERange, self.menu)
 --       self.BuffDraw_Q = Menu_Bool("Draw Shen Buff", self.BuffDraw_Q, self.menu)
        Menu_End()
    end
	
        if (Menu_Begin("Keys")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
			self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			  self.Flee = Menu_KeyBinding("Flee", self.Flee, self.menu)
			self.FQ = Menu_Bool("Flee Q", self.FQ, self.menu)
			self.FW = Menu_Bool("Flee W", self.FW, self.menu)
            self.FE = Menu_Bool("Flee E", self.FE, self.menu)
			Menu_End()
        end
	
    self.Enable_Mod_Skin = Menu_Bool("Enable Mod Skin", self.Enable_Mod_Skin, self.menu)
    self.Set_Skin = Menu_SliderInt("Set Skin", self.Set_Skin, 0, 20, self.menu)
    Menu_End()   
end

function DeepShen:OnProcessSpell(unit, spell)
    if self.E:IsReady() and self.menu_interruptE and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) and GetDistance(unit) < 600 then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellInterrup[spell.Name] ~= nil and not unit.IsMe then
		target = GetAIHero(unit.Addr)
		local CastPosition, HitChance, Position = self:GetELinePreCore(target)
--		  	__PrintTextGame(HitChance)
        if HitChance >= 5 then
		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
		end
        end 
    end 
    if self.E:IsReady() and self.menu_interruptE2 and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) and GetDistance(unit) < self.menu_dashrange then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellDash[spell.Name] ~= nil and not unit.IsMe then
            CastSpellToPos(spell.DestPos_x, spell.DestPos_z, _E)   
        end 
    end 
    if self.menu_interruptQ and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) and GetDistance(unit) < self.menu_interruptrange then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpelldangerous[spell.Name] ~= nil and not unit.IsMe then
            CastSpellTarget(myHero.Addr, _Q)  
            DelayAction(function() CastSpellTarget(myHero.Addr, _W) end, 0.5)
        end 
    end 
end 

function DeepShen:OnDraw()
    local pos = Vector(myHero)

    if self.menu_DrawERange then
        DrawCircleGame(pos.x, pos.y, pos.z, 600, Lua_ARGB(255, 0, 204, 255))
    end 

    if self.menu_DrawDamage then
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

function DeepShen:CastQ(target)
    if self.menu_ComboQ and GetDistance(Vector(target), Vector(myHero)) <= 250 then
		CastSpellTarget(myHero.Addr, _Q)
    end 
end 

function DeepShen:CastQHarass(target)
    if GetDistance(Vector(target), Vector(myHero)) <= 250 then
		CastSpellTarget(myHero.Addr, _Q)
    end 
end 

function DeepShen:CastW(target)
    if self.menu_ComboW and self.W:IsReady() --[[and not self.menu_KeepW]]and IsValidTarget(target, 250) then
		CastSpellTarget(myHero.Addr, _W)
       -- CastSpellToPos(CastPosition.x, CastPosition.z, _W)
    end 
end 

function DeepShen:CastWHarass(target)
    if self.W:IsReady() and IsValidTarget(target, 250) then
CastSpellTarget(myHero.Addr, _W)
     --   local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
      --  if HitChance >= 1 then
		--CastSpellToPos(CastPosition.x, CastPosition.z, _W)
--            DelayAction(function() CastSpellToPos(CastPosition.x, CastPosition.z, _W) end, 0.5)
        end 
       -- CastSpellToPos(CastPosition.x, CastPosition.z, _W)
    end 
--end 

function DeepShen:CastE(target)
    if self.E:IsReady() and IsValidTarget(target, 600) and GetDistance(target) >= self.CEdis then
		local CastPosition, HitChance, Position = self:GetELinePreCore(target)
        if HitChance >= 6 then
		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
		end
    else
        if self:ComboDamage(target) > GetRealHP(target, 1) and self.E:IsReady() and IsValidTarget(target, 600) then
		local CastPosition, HitChance, Position = self:GetELinePreCore(target)
        if HitChance >= 6 then
		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
		end
        end 
    end 
end 

function DeepShen:CastEHarass(target)
    if self.E:IsReady() and IsValidTarget(target, 600) then
		local CastPosition, HitChance, Position = self:GetELinePreCore(target)
        if HitChance >= 6 then
		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
		end
    else
        if self:ComboDamage(target) > GetRealHP(target, 1) and self.E:IsReady() and IsValidTarget(target, 600) then
		local CastPosition, HitChance, Position = self:GetELinePreCore(target)
        if HitChance >= 6 then
		CastSpellToPos(CastPosition.x, CastPosition.z, _E)
		end
        end 
    end 
end 

--GetPercentHP(myHero.Addr) <= self.CRlow and

function DeepShen:CastRbasic(target)
    if self.menu_ComboR then
            if self.R:IsReady() and IsValidTarget(target, 9999) and CountEnemyChampAroundObject(target.Addr, self.CRnumrange) >= self.CRnum and GetRealHP(target, 1) <= self.CRlow then
                CastSpellTarget(target.Addr, _R)
            end 
        end 
    end 
	
function DeepShen:CastRHP(target)
    if self.menu_ComboR then
            if self.R:IsReady() and IsValidTarget(target, 9999) and CountEnemyChampAroundObject(target.Addr, self.CRnumrange) >= self.CRnum and GetPercentHP(target) <= self.CRlowHPrange then
                CastSpellTarget(target.Addr, _R)
            end 
        end 
    end

function DeepShen:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function DeepShen:GetEnemies(range)
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

function DeepShen:GetAllies(range)
    local t = {}
    local h = self:GetHeroes()
    for k, v in pairs(h) do
        if v ~= 0 then
		if IsAlly(v) then
            local hero = GetAIHero(v)
            if not hero.IsMe and hero.IsValid and hero.Type == 0 then
                table.insert(t, hero)
            end 
        end 
		end
    end
    return t
end

function DeepShen:GetIgniteIndex()
    if GetSpellIndexByName("SummonerDot") > -1 then
        return GetSpellIndexByName("SummonerDot")
    end
	return -1
end

function DeepShen:EnemyMinionsTbl(range)
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

function DeepShen:EnemyJungleTbl(range)
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

function DeepShen:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
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
  
    dmg = self:RealDamage(target, dmg)
    return dmg
end

function DeepShen:RealDamage(target, damage)
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

  
function DeepShen:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function DeepShen:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function DeepShen:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function DeepShen:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function DeepShen:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function DeepShen:GetELinePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.E.delay, self.E.width, 600, self.E.speed, myHero.x, myHero.z, false, false, 1, 1, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

--[[
function DeepShen:aa()
	self.listEndDash =
	{
		{Name = "ZoeR", RangeMin = 570, Range = 570, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "MaokaiW", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --CHUAN
		{Name = "CamilleE", RangeMin = 0, Range = math.huge, Type = 1, Duration = 1.25}, --MaokaiW
		{Name = "BlindMonkQTwo", RangeMin = 0, Range = math.huge, Type = 1, Duration = 0.25}, --MaokaiW
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
		{Name = "ViQ", RangeMin = 0, Range = 720, Type = 1, Duration = 0.25}, --Ezreal E
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
end]]