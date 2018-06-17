IncludeFile("Lib\\SDK.lua")
IncludeFile("Lib\\DamageIndicator.lua")

class "DeepSinged"

local ScriptXan = 8.12
local NameCreat = "Deep"

function OnLoad()
    if myHero.CharName ~= "Singed" then return end
    __PrintTextGame("<b><font color=\"#00FF00\">Champion:</font></b> " ..myHero.CharName.. "<b><font color=\"#cffffff00\"> The Mad Chemist!</font></b>")
    __PrintTextGame("<b><font color=\"#00FF00\">Singed for LOL version</font></b> " ..ScriptXan)
    __PrintTextGame("<b><font color=\"#00FF00\">By: </font></b> " ..NameCreat)
    DeepSinged:__init()
end

function DeepSinged:__init()

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
	
    self.Q = Spell({Slot = 0, Range = 200})
    self.W = Spell({Slot = 1, SpellType = Enum.SpellType.SkillShot, Range = 1000, SkillShotType = Enum.SkillShotType.Circle, Collision = false, Width = 175, Delay = 0.25, Speed = 1600})
    self.E = Spell({Slot = 2, Range = 200})
    self.R = Spell({Slot = 3, Range = 200})

--	DeepSinged:aa()
	
    self:MenuDeep()
--	self.isQactive = false
	

    
    AddEvent(Enum.Event.OnTick, function(...) self:OnTick(...) end)
--    AddEvent(Enum.Event.OnUpdate, function(...) self:OnUpdate(...) end)
    AddEvent(Enum.Event.OnProcessSpell, function(...) self:OnProcessSpell(...) end)
--    AddEvent(Enum.Event.OnUpdateBuff, function(...) self:OnUpdateBuff(...) end)
--    AddEvent(Enum.Event.OnRemoveBuff, function(...) self:OnRemoveBuff(...) end)
    AddEvent(Enum.Event.OnDrawMenu, function(...) self:OnDrawMenu(...) end)
    AddEvent(Enum.Event.OnDraw, function(...) self:OnDraw(...) end)
--    AddEvent(Enum.Event.OnAfterAttack, function(...) self:OnAfterAttack(...) end)

    __PrintTextGame("<b><font color=\"#cffffff00\">Deep Singed</font></b> <font color=\"#ffffff\">Loaded. Enjoy The Mad Chemist</font>")
end

--[[
  function Singed:OnUpdateBuff(source,unit,buff,stacks)
  	--	__PrintTextGame(buff.Name)
		
      if buff.Name == "PoisonTrail" and unit.IsMe then
__PrintTextGame("Q is on")
            self.isQactive = true
          end
  end

  function Singed:OnRemoveBuff(unit,buff)
    	--	__PrintTextGame(buff.Name)
      if buff.Name == "PoisonTrail" and unit.IsMe then
	  __PrintTextGame("Q is off")
			self.isQactive = false
          end
   end ]]
--[[
function DeepSinged:OnUpdate()
	if self.menu_Combo_QendDash then
		self:autoQtoEndDash()
	end
	if self.menu_Combo_EendDash then
		self:autoEtoEndDash()
	end
end ]]
   
function DeepSinged:OnTick()
    if IsDead(myHero.Addr) or myHero.IsRecall or IsTyping() or not IsRiotOnTop() then return end

    myHero = GetMyHero()

    if GetBuffByName(myHero.Addr, "PoisonTrail") > 0 then
        self.Q.SQ = true
    else
        self.Q.SQ = false
    end

    if GetKeyPress(self.Harass) > 0 then
		self:HarassSinged()
	end
	
	if GetKeyPress(self.Combo) > 0 then
        self:ComboSinged()
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


function DeepSinged:Automatic()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 1100) then
                self:AutoQ(target)
            end			
        end 
    end 
end

--[[

function DeepSinged:AutomaticQoff()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v == 0 then
    __PrintTextGame("off Q")
self:OffQ()
            end			
        end 
    end ]]
	
function DeepSinged:HarassSinged()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 1100) then
				if self.HarQ then
                self:HarassQ(target)
				end
				if self.HarW then
				self:CastWKeep(target)
				end
				if self.HarE then
                self:CastE(target)
				end
            end  
        end 
    end 
end

function DeepSinged:ComboSinged()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if IsValidTarget(target, 1100) then
                self:CastQ(target)
				self:CastW(target)
				self:CastR(target)
				if self.menu_ComboE then
				self:CastE(target)
				end
            end  
        end 
    end 
end

function DeepSinged:ClearY()
    for i, minion in pairs(self:EnemyMinionsTbl(500)) do
        if minion ~= 0 then
            if self.Q:IsReady() and self.JQ and GetDistance(Vector(minion)) <= 200 then
                CastSpellTarget(myHero.Addr, _Q)            
            end
            if self.E:IsReady() and self.JE and GetDistance(Vector(minion)) <= 200 and self.E:GetDamage(minion) > minion.HP then
                CastSpellTarget(minion.Addr, _E)
            end
--[[            for k, v in pairs(self:GetEnemies(1100)) do
                if v ~= 0 then
                    local target = GetAIHero(v)
                    if IsValidTarget(target, 1100) then
                        self:CastQ3(target)
                    end 
                end 
            end]]
        end 
    end 
end 

function DeepSinged:ClearQ()
    for i, junged in pairs(self:EnemyJungleTbl(500)) do 
        if junged ~= 0 then
            if self.Q:IsReady() and self.JQ and GetDistance(Vector(junged)) <= 200 then
                CastSpellTarget(myHero.Addr, _Q)
            end 
            if self.E:IsReady() and self.JEKeep and GetDistance(Vector(junged)) <= 200 and self.E:GetDamage(junged) > junged.HP then
                CastSpellTarget(junged.Addr, _E)
            end
            if self.E:IsReady() and not self.JEKeep and GetDistance(Vector(junged)) <= 200 then
                CastSpellTarget(junged.Addr, _E)
            end
        end 
    end           
end 

function DeepSinged:DashEndPos(target)
    local Estent = 0

    if GetDistance(target) < 410 then
        Estent = Vector(myHero):Extended(Vector(target), 410)
    else
        Estent = Vector(myHero):Extended(Vector(target), GetDistance(target) + 65)
    end

    return Estent
end

function DeepSinged:KillEnemy()
    for k, v in pairs(self:GetEnemies(1100)) do
        if v ~= 0 then
            local target = GetAIHero(v)
            if self.KE and IsValidTarget(target, 250) and self.E:GetDamage(target) > target.HP then 
                self:CastE(target)
            end 
            if  IsValidTarget(target, 250) and (self.Q:GetDamage(target) + self.E:GetDamage(target) > target.HP) then 
                self:CastE(target)
                self:CastQ(target)
            end 
        end 
    end
end

function DeepSinged:autoEtoEndDash()
	for i, enemy in pairs(GetEnemyHeroes()) do
		if enemy ~= nil then
		    target = GetAIHero(enemy)
		    if IsValidTarget(target.Addr, self.W.range) then
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
	
function DeepSinged:autoQtoEndDash()
	for i, enemy in pairs(GetEnemyHeroes()) do
		if enemy ~= nil then
		    target = GetAIHero(enemy)
		    if IsValidTarget(target.Addr, self.W.range) then
		    --local QPos, QHitChance = HPred:GetPredict(self.HPred_Q_M, target, myHero)
			    local TargetDashing, CanHitDashing, DashPosition = self.Predc:IsDashing(target, self.W.delay, self.W.width, self.W.speed, myHero, true)	    	
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

function DeepSinged:MenuDeep()
    self.menu = "Deep Singed"

    --Combo
    self.menu_ComboR = self:MenuBool("Use R", true)
    self.menu_ComboQ = self:MenuBool("Use Q", true)
    self.Qonall = self:MenuBool("Use Q", true)
    self.menu_ComboW = self:MenuBool("Use W", true)
--    self.menu_KeepW = self:MenuBool("Keep W for E+W combo", true)
    self.menu_ComboE = self:MenuBool("Use E", true)
    self.AutoLevel = self:MenuBool("Auto level", true)
    self.CRlow = self:MenuSliderInt("Enemy min % HP for Combo R", 90)
    self.CRnum = self:MenuSliderInt("Enemies around you to combo R", 2)

    self.HarQ = self:MenuBool("Harass Q", true)
    self.HarQdis = self:MenuSliderInt("Harass min Q Distance", 600)
    self.HarW = self:MenuBool("Harass W", true)
    self.HarWdis = self:MenuSliderInt("Harass max W range", 600)
    self.HarE = self:MenuBool("Harass E", true)

    --KillSteal [[ Singed ]]
    self.KE = self:MenuBool("KillSteal with E", true)
	
    self.JQ = self:MenuBool("Jungle Q", true)
--    self.JQMana = self:MenuSliderInt("Mana Jungle Q %", 30)
    self.JE = self:MenuBool("Jungle E", true)
    self.JEKeep = self:MenuBool("Keep E", true)
 --   self.JEMana = self:MenuSliderInt("Mana Jungle E %", 30)
	
    self.menu_interruptW = self:MenuBool("Use W on dashing enemies", true)
    self.menu_interruptE = self:MenuBool("Use E to interrupt channeling spells", true)
  --	self.menu_Combo_QendDash = self:MenuBool("Auto W End Dash", true)
	--self.menu_Combo_EendDash = self:MenuBool("Auto E End Dash", true)
  
  
    self.menu_DrawDamage = self:MenuBool("Draw Damage", true)
    self.menu_DrawERange = self:MenuBool("Draw Engage Range", true)
 --   self.BuffDraw_Q = self:MenuBool("Draw Singed Buff", true)
  
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	self.Harass = self:MenuKeyBinding("Harass", 67)
  
    self.Enable_Mod_Skin = self:MenuBool("Enable Mod Skin", true)
    self.Set_Skin = self:MenuSliderInt("Set Skin", 3)

    self.R.Whitelist = {}
    for k, v in pairs(self:GetEnemies(math.huge)) do
        self.R.Whitelist[v.CharName] = ReadIniBoolean("Use [R] for ".. v.CharName, true) 
    end
  end
  
function DeepSinged:OnDrawMenu()
    if not Menu_Begin(self.menu) then return end

    if (Menu_Begin("Combo")) then
        self.menu_ComboQ = Menu_Bool("Use Q", self.menu_ComboQ, self.menu)
		self.Qonall = Menu_Bool("Auto Q when a champ get near you", self.Qonall, self.menu)
            Menu_Separator()
        self.menu_ComboW = Menu_Bool("Use W", self.menu_ComboW, self.menu)
--        self.menu_KeepW = Menu_Bool("Keep W for E+W combo", self.menu_KeepW, self.menu)
        self.menu_ComboE = Menu_Bool("Use E", self.menu_ComboE, self.menu)
        self.menu_ComboR = Menu_Bool("Use R", self.menu_ComboR, self.menu)
        self.CRlow = Menu_SliderInt("Enemy min % HP to Combo R", self.CRlow, 0, 100, self.menu)
		self.CRnum = Menu_SliderInt("Enemies around you to combo R", self.CRnum, 1, 5, self.menu)
        Menu_Separator()
        Menu_Text("--Settings [R]--")
        if Menu_Begin("WhileList") then
            for k, v in pairs(self:GetEnemies(math.huge)) do
                self.R.Whitelist = Menu_Bool("Use [R] for ".. v.CharName, self.R.Whitelist)
            end
            Menu_End()  
        end
        Menu_End()
    end 
    if (Menu_Begin("Auto")) then
        self.AutoLevel = Menu_Bool("Auto Level", self.AutoLevel, self.menu)
        self.menu_interruptW = Menu_Bool("Use W on dashing enemies", self.menu_interruptW, self.menu)
        self.menu_interruptE = Menu_Bool("Use E to interrupt channeling spells", self.menu_interruptE, self.menu)
--		self.menu_Combo_QendDash = Menu_Bool("Auto W Dasing Enemies", self.menu_Combo_QendDash, self.menu)
--		self.menu_Combo_EendDash = Menu_Bool("Auto E Dasing Enemies", self.menu_Combo_EendDash, self.menu)
        Menu_End()
    end 
        if (Menu_Begin("Harass ROOTING: W ==> E")) then
			self.HarQ = Menu_Bool("Harass Q", self.HarQ, self.menu)
            self.HarQdis = Menu_SliderInt("Harass max Q Distance", self.HarQdis, 0, 800, self.menu)
            Menu_Separator()
			self.HarW = Menu_Bool("Harass W", self.HarW, self.menu)
            self.HarWdis = Menu_SliderInt("Minimun range required to cast W", self.HarWdis, 600, 750, self.menu)
            Menu_Separator()
			self.HarE = Menu_Bool("Harass E", self.HarE, self.menu)
			Menu_End()
        end
    if (Menu_Begin("Killsteal")) then
            self.KE = Menu_Bool("KillSteal with E", self.KE, self.menu)
			Menu_End()
    end
	
        if (Menu_Begin("Clear skills")) then
			self.JQ = Menu_Bool("Clear Q", self.JQ, self.menu)
    --        self.JQMana = Menu_SliderInt("Min MP % for using Jungle Q", self.JQMana, 0, 100, self.menu)
			self.JE = Menu_Bool("Clear E", self.JE, self.menu)
			self.JEKeep = Menu_Bool("Keep E to last hit jungle minions", self.JEKeep, self.menu)
    --        self.JEMana = Menu_SliderInt("Min MP % for using Jungle E", self.JEMana, 0, 100, self.menu)
			Menu_End()
        end
	
    if (Menu_Begin("Drawings")) then
        self.menu_DrawDamage = Menu_Bool("Draw Damage", self.menu_DrawDamage, self.menu)
        self.menu_DrawERange = Menu_Bool("Draw W Range", self.menu_DrawERange, self.menu)
 --       self.BuffDraw_Q = Menu_Bool("Draw Singed Buff", self.BuffDraw_Q, self.menu)
        Menu_End()
    end
	
        if (Menu_Begin("Keys")) then
            self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
			self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
            self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
			Menu_End()
        end
	
    self.Enable_Mod_Skin = Menu_Bool("Enable Mod Skin", self.Enable_Mod_Skin, self.menu)
    self.Set_Skin = Menu_SliderInt("Set Skin", self.Set_Skin, 0, 20, self.menu)
    Menu_End()   
end

function DeepSinged:OnProcessSpell(unit, spell)
    if self.E:IsReady() and self.menu_interruptE and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) and GetDistance(unit) < 600 then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellInterrup[spell.Name] ~= nil and not unit.IsMe then
            CastSpellTarget(unit.Addr, _E)   
        end 
    end 
    if self.W:IsReady() and self.menu_interruptW and unit and spell and unit.IsEnemy and IsChampion(unit.Addr) and GetDistance(unit) < 1000 then
        spell.endPos = {x= spell.DestPos_x, y= spell.DestPos_y, z= spell.DestPos_z}
        if self.listSpellDash[spell.Name] ~= nil and not unit.IsMe then
            CastSpellToPos(spell.DestPos_x, spell.DestPos_z, _W)   
        end 
    end 
end 

function DeepSinged:OnDraw()
    local pos = Vector(myHero)

    if self.menu_DrawERange then
        DrawCircleGame(pos.x, pos.y, pos.z, 1000, Lua_ARGB(255, 0, 204, 255))
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

function DeepSinged:OffQ()
    if self.Q.SQ then
		CastSpellTarget(myHero.Addr, _Q)
    end 
end 

function DeepSinged:AutoQ(target)
    if self.Qonall and GetDistance(Vector(target), Vector(myHero)) <= 800 and not self.Q.SQ then
		CastSpellTarget(myHero.Addr, _Q)
    end 
end 

function DeepSinged:CastQ(target)
    if self.menu_ComboQ and GetDistance(Vector(target), Vector(myHero)) <= 600 and not self.Q.SQ then
		CastSpellTarget(myHero.Addr, _Q)
    end 
end 

function DeepSinged:HarassQ(target)
    if GetDistance(Vector(target), Vector(myHero)) <= self.HarQdis and not self.Q.SQ then
		CastSpellTarget(myHero.Addr, _Q)
    end 
end 

function DeepSinged:CastW(target)
    if self.menu_ComboW and self.W:IsReady() --[[and not self.menu_KeepW]]and IsValidTarget(target, 1000) then
        local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
        if HitChance >= 6 then
		CastSpellToPos(CastPosition.x, CastPosition.z, _W)
--            DelayAction(function() CastSpellToPos(CastPosition.x, CastPosition.z, _W) end, 0.5)
        end 
       -- CastSpellToPos(CastPosition.x, CastPosition.z, _W)
    end 
end 

function DeepSinged:CastWKeep(target)
    if self.W:IsReady() and IsValidTarget(target, 800) and GetDistance(target) >= self.HarWdis then
CastSpellTarget(myHero.Addr, _W)
     --   local CastPosition, HitChance, Position = self:GetWCirclePreCore(target)
      --  if HitChance >= 1 then
		--CastSpellToPos(CastPosition.x, CastPosition.z, _W)
--            DelayAction(function() CastSpellToPos(CastPosition.x, CastPosition.z, _W) end, 0.5)
        end 
       -- CastSpellToPos(CastPosition.x, CastPosition.z, _W)
    end 
--end 

function DeepSinged:CastE(target)
    if self.E:IsReady() and IsValidTarget(target, 300) then
		CastSpellTarget(target.Addr, _E)
    else
        if self:ComboDamage(target) > GetRealHP(target, 1) and self.E:IsReady() and IsValidTarget(target, 300)  then
            CastSpellTarget(target.Addr, _E)
        end 
    end 
end 

--GetPercentHP(myHero.Addr) <= self.CRlow and

function DeepSinged:CastR(target)
    if self.R.Whitelist and self.menu_ComboR then
            if self.R:IsReady() and IsValidTarget(target, 1000) and GetPercentHP(target) <= self.CRlow and CountEnemyChampAroundObject(myHero.Addr, 1000) >= self.CRnum then
                CastSpellTarget(myHero.Addr, _R)
            end 
        end 
    end 
--end 

function DeepSinged:GetHeroes()
	SearchAllChamp()
	local t = pObjChamp
	return t
end

function DeepSinged:GetEnemies(range)
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

function DeepSinged:GetIgniteIndex()
    if GetSpellIndexByName("SummonerDot") > -1 then
        return GetSpellIndexByName("SummonerDot")
    end
	return -1
end

function DeepSinged:EnemyMinionsTbl(range)
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

function DeepSinged:EnemyJungleTbl(range)
    GetAllUnitAroundAnObject(myHero.Addr, range)
    local result = {}
    for i, obj in pairs(pUnit) do
        if obj ~= 0  then
            local minions = GetUnit(obj)
            if not IsEnemy(minions.Addr) and not IsDead(minions.Addr) and not IsInFog(minions.Addr) and GetType(minions.Addr) == 3 then
                table.insert(result, minions)
            end
        end
    end
    return result
end

function DeepSinged:ComboDamage(target) -- Ty Nechrito <3 THAKS <3 
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

function DeepSinged:RealDamage(target, damage)
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

  
function DeepSinged:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function DeepSinged:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function DeepSinged:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function DeepSinged:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function DeepSinged:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end


--´PredCOre
function DeepSinged:GetWCirclePreCore(target)
	local castPosX, castPosZ, unitPosX, unitPosZ, hitChance, _aoeTargetsHitCount = GetPredictionCore(target.Addr, 0, self.W.delay, self.W.width, 1000, self.W.speed, myHero.x, myHero.z, false, false, 1, 1, 5, 5, 5, 5)
	if target ~= nil then
		 CastPosition = Vector(castPosX, target.y, castPosZ)
		 HitChance = hitChance
		 Position = Vector(unitPosX, target.y, unitPosZ)
		 return CastPosition, HitChance, Position
	end
	return nil , 0 , nil
end

--[[
function DeepSinged:aa()
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