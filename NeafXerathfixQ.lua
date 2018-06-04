--SDK
IncludeFile("Lib\\TOIR_SDK.lua")
--Check Champion
Xerath = class()
function OnLoad()
if GetChampName(GetMyChamp()) == "Xerath" then
  __PrintTextGame("<b><font color=\"#2EFEF7\">Neaf Xerath</font></b> <font color=\"#ffffff\">Loaded</font>")
  Xerath:Req()
end
end

function Xerath:Req()
  pred = VPrediction(true)
  --HPred = HPrediction()
  SetLuaCombo(true)
  SetLuaLaneClear(true)

  self.menu_ts = TargetSelector(1750, 0, myHero, true, true, true)



  self.Q = Spell(_Q,1500)
  self.W = Spell(_W,1000)
  self.E = Spell(_E,1150)
  self.R = Spell(_R,3200)

  self.Q:SetSkillShot(0.54,math.huge,200,false)
  self.W:SetSkillShot(0.7,math.huge,275,false)
  self.E:SetSkillShot(0.2,1400,140,true)
  self.R:SetSkillShot(0.54,math.huge,190,false)

  self.isQactive = false;
  self.qtime = 0
  self.isRactive = false;
  self.lastQtime = 0
  self.lastRtime = 0
  self.extraq = 0
  self.rstack = 0
  self.kalanstack = 0
  self.rkil= {}
  self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)

  Callback.Add("Tick", function(...) self:OnTick(...) end)
    Callback.Add("Draw", function(...) self:OnDraw(...) end)
    Callback.Add("ProcessSpell", function(...) self:OnProcessSpell(...) end)
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("UpdateBuff", function(unit, buff, stacks) self:OnUpdateBuff(source, unit, buff, stacks) end)
    Callback.Add("Update", function(...) self:OnUpdate(...) end)
   Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
     self:XerathMenu()
end


function Xerath:XerathMenu()
  self.menu ="Neaf-Xerath"
  self.Use_Combo_Q = self:MenuBool("Use Combo Q",true)
  self.Q_Extra = self:MenuSliderInt("Wait Extra Range For Q",200)
  self.Use_Combo_W = self:MenuBool("Use Combo W",true)
  self.Use_Combo_E = self:MenuBool("Use Combo E",true)
  self.Lane_Q = self:MenuBool("Use LaneClear Q",true)
  self.Lane_W = self:MenuBool("Use LaneClear W",true)
  self.Lane_Mana = self:MenuSliderInt("Min Mana Percent For LaneClear",60)

  self.Use_R = self:MenuBool("Use R On Enemies",true)
  --self.Target_R = self:MenuSliderInt("R Target Select NearMouse = 1 Auto = 2",1)
  --self.Distance_R = self:MenuSliderInt("NearMouse Max Distance To Target",100)
  self.Mode_R = self:MenuSliderInt("R Shoot Mode Tapkey = 1 Auto = 2",2)
  self.RTap = self:MenuKeyBinding("RTap",72)
  self.RDelay = self:MenuSliderInt("Delay Between R Shoots On Auto Shoot Mode",1)

  self.Draw_All = self:MenuBool("Draws",true)
  self.Draw_Q = self:MenuBool("Draw Q Range",true)
  self.Draw_W = self:MenuBool("Draw W Range",true)
  self.Draw_E = self:MenuBool("Draw E Range",true)
  self.Draw_R = self:MenuBool("Draw R Range Minimap",true)
  self.Draw_Killable = self:MenuBool("Draw Killables Text With R",true)
  self.Draw_KillableLine = self:MenuBool("Draw Killables Line With R",true)

  self.Evade_R = self:MenuBool("Dont Dodge When R Is Active",true)
  self.AntiGapclose = self:MenuBool("AntiGapclose E",true)

  self.LaneClear = self:MenuKeyBinding("LaneClear",86)
  self.Combo = self:MenuKeyBinding("Combo",32)
end


function Xerath:OnDrawMenu()
  if Menu_Begin(self.menu) then
    if Menu_Begin("Combo Menu") then
      self.Use_Combo_Q = Menu_Bool("Use Combo Q",self.Use_Combo_Q,self.menu)
      self.Q_Extra = Menu_SliderInt("Wait Extra Range For Q",self.Q_Extra,0,200,self.menu)
      self.Use_Combo_W = Menu_Bool("Use Combo W",self.Use_Combo_W,self.menu)
      self.Use_Combo_E = Menu_Bool("Use Combo E",self.Use_Combo_E,self.menu)
      Menu_End()
    end

    if Menu_Begin("LaneClear Menu") then
      self.Lane_Q = Menu_Bool("Use LaneClear Q",self.Lane_Q,self.menu)
      self.Lane_W = Menu_Bool("Use LaneClear W",self.Lane_W,self.menu)
      self.Lane_Mana = Menu_SliderInt("Min Mana Percent For LaneClear",self.Lane_Mana,0,100,self.menu)
    Menu_End()
    end

    if Menu_Begin("R Menu") then
      self.Use_R = Menu_Bool("Use R On Enemies",self.Use_R,self.menu)
      --self.Target_R = Menu_SliderInt("R Target Select NearMouse = 1 Auto = 2",self.Target_R,1,2,self.menu)
      --self.Distance_R = Menu_SliderInt("NearMouse Max Distance To Target",self.Distance_R,50,300,self.menu)
      self.Mode_R = Menu_SliderInt("R Shoot Mode Tapkey = 1 Auto = 2",self.Mode_R,1,2,self.menu)
      self.RTap = Menu_KeyBinding("RTap",self.RTap,self.menu)
      self.RDelay = Menu_SliderInt("Delay Between R Shoots On Auto Shoot Mode",self.RDelay,0,3,self.menu)
    Menu_End()
    end

    if Menu_Begin("Draw Menu") then
      self.Draw_All = Menu_Bool("Draws",self.Draw_All,self.menu)
      self.Draw_Q = Menu_Bool("Draw Q Range",self.Draw_Q,self.menu)
      self.Draw_W = Menu_Bool("Draw W Range",self.Draw_W,self.menu)
      self.Draw_E = Menu_Bool("Draw E Range",self.Draw_E,self.menu)
      self.Draw_R = Menu_Bool("Draw R Range Minimap",self.Draw_R,self.menu)
      self.Draw_Killable = Menu_Bool("Draw Killables Text With R",self.Draw_Killable,self.menu)
      self.Draw_KillableLine = Menu_Bool("Draw Killables Line With R",self.Draw_KillableLine,self.menu)
      Menu_End()
    end
   if Menu_Begin("Misc Menu") then
      self.Evade_R = Menu_Bool("Dont Dodge When R Is Active",self.Evade_R,self.menu)
      self.AntiGapclose = Menu_Bool("AntiGapclose E",self.AntiGapclose,self.menu)
      Menu_End()
      end
   if Menu_Begin("Key Menu") then
          self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
          self.LaneClear = Menu_KeyBinding("LaneClear",self.LaneClear,self.menu)
          Menu_End()
          end
  Menu_End()
  end
end

  function Xerath:OnProcessSpell(unit,spell)
  if unit.IsMe and spell.Name == "XerathLocusPulse" then
    if self.kalanstack > 0 then
      self.kalanstack = self.kalanstack - 1
      end
      end
  if not unit.IsMe and self.isRactive and self.Evade_R then
      SetEvade(true)
      end
  end


  function Xerath:OnDraw()
    if self.Draw_All then
      if self.Draw_Q then
        DrawCircleGame(myHero.x,myHero.y,myHero.z,self.Q.range,Lua_ARGB(255,255,0,0))
      end
      if self.Draw_W then
        DrawCircleGame(myHero.x,myHero.y,myHero.z,self.W.range,Lua_ARGB(255,0,255,0))
      end
      if self.Draw_E then
        DrawCircleGame(myHero.x,myHero.y,myHero.z,self.E.range,Lua_ARGB(255,0,0,255))
      end
      if self.Draw_R then
        DrawCircleMiniMap(myHero.x,myHero.y,myHero.z,self.R.range)
        end
      if self.Draw_Killable then
        for i,v in pairs(GetEnemyHeroes()) do
          hero = GetAIHero(v)
          hp = hero.HP
          totaldamac = GetDamage("R",hero) * self.rstack
          yuzde = totaldamac * 100 / hp
          yuzde = math.floor(yuzde)
          if self.rkil[hero.NetworkId] == "killable" then
            if not IsDead(hero.Addr) and not IsInFog(hero.Addr) then
            DrawTextD3DX(WorldToScreenPos(hero).x - 25, WorldToScreenPos(hero).y - 25, yuzde.."%".." Killable With R", Lua_ARGB(255,25510 ,255,0), 2)
            end
            end
            end
            end
     if self.Draw_KillableLine then
        for i,v in pairs(GetEnemyHeroes()) do
          hero = GetAIHero(v)
          if self.rkil[hero.NetworkId] == "killable" and CanCast(_R) then
            if not IsDead(hero.Addr) and GetDistance(myHero,hero) <= 5000 and not IsInFog(hero.Addr) then
            DrawLineD3DX(WorldToScreenPos(hero).x, WorldToScreenPos(hero).y,WorldToScreenPos(myHero).x,WorldToScreenPos(myHero).y,5, Lua_ARGB(150,25510 ,255,0))
            end
            end
            end
            end
        --local mini_x,mini_y = WorldToMiniMap(myHero.x,myHero.y,myHero.z)
        --DrawCircleGame(mini_x,mini_y,myHero.z,10,Lua_ARGB(255,255,0,0))

    end
  end

--Check Q And R Casting
  function Xerath:OnUpdateBuff(source,unit,buff,stacks)
      if buff.Name == "XerathArcanopulseChargeUp" and unit.IsMe then
            self.isQactive = true
            self.qtime = GetTimeGame()
            SetLuaBasicAttackOnly(true)
          end
      if buff.Name == "XerathLocusOfPower2" and unit.IsMe then
			      self.isRactive = true
            SetLuaMoveOnly(true)
            SetLuaBasicAttackOnly(true)
            self.kalanstack = self.rstack
       end
  end

  function Xerath:OnRemoveBuff(unit,buff)
      if buff.Name == "XerathArcanopulseChargeUp" and unit.IsMe then
            self.isQactive = false
            self.qtime = 0
            SetLuaBasicAttackOnly(false)
          end
      if buff.Name == "XerathLocusOfPower2" and unit.IsMe then
			      self.isRactive = false
            SetLuaMoveOnly(false)
            SetLuaBasicAttackOnly(false)
            self.kalanstack = 0
     end
   end


  function Xerath:QLogic()
    local target = GetTargetSelector(1500, 0)
    if not self.isRactive and target ~= nil and CanCast(_Q) and self.Use_Combo_Q then
      if not self.isQactive then
        if self.lastQtime == 0 or GetTimeGame() - self.lastQtime >= 1 and IsValidTarget(target,1500) then
        self.Q:Cast(target)
        self.lastQtime = GetTimeGame()
	return
      end
      end
      
      if self.isQactive and IsValidTarget(target,1500)  then
        local rangee = 750 + (GetTimeGame() - self.qtime)*self.extraq

            if rangee > 1500 then
              rangee = 1500
              end
      --self.HPred_Q_M = HPSkillshot({type = "PromptLine", delay = 0.55, range = rangee, width = 200})
        local tamget = GetTargetSelector(rangee,0)
      if tamget ~= nil and IsValidTarget(tamget,rangee) then
        tar = GetAIHero(tamget)
        local CastPosition, HitChance,Position = pred:GetLineCastPosition(tar,self.Q.delay,self.Q.width,range,self.Q.speed,myHero,false)
        --local QPos, QHitChance = HPred:GetPredict(self.HPred_Q_M, tar, myHero)
        if HitChance >= 2 then
        --self.Q:Cast(target)
        ReleaseSpellToPos(CastPosition.x,CastPosition.z,_Q)
        end
      end
      end
    end
  end

function Xerath:FarmQ()
  self.EnemyMinions:update()
  for i ,minion in pairs(self.EnemyMinions.objects) do
    if not self.isRactive and minion ~= nil and CanCast(_Q) and self.Lane_Q and not IsDead(minion.Addr) and minion.Type == 1 then
       if not self.isQactive and GetPercentMP(myHero.Addr) >= self.Lane_Mana then
       if self.lastQtime == 0 or GetTimeGame() - self.lastQtime >= 1 and IsValidTarget(minion,1500) then
        CastSpellToPos(GetMousePos().x,GetMousePos().z,_Q)
        self.lastQtime = GetTimeGame()
       return
       end
    end
     if self.isQactive and IsValidTarget(minion,1500) then
        local range = 750 + (GetTimeGame() - self.qtime)*self.extraq

            if range > 1500 then
              range = 1500
              end
        if IsValidTarget(minion,range) and not IsDead(minion.Addr) then
            ReleaseSpellToPos(minion.x,minion.z,_Q)
        end
    end
    end
    end
    end

 function Xerath:FarmW()
  self.EnemyMinions:update()
  for i ,minion in pairs(self.EnemyMinions.objects) do
    if not self.isRactive and minion ~= nil and CanCast(_W) and self.Lane_W and IsValidTarget(minion,self.W.range) and GetPercentMP(myHero.Addr) >= self.Lane_Mana and not IsDead(minion.Addr) and minion.Type == 1 then
    CastSpellToPos(minion.x,minion.z,_W)
    end
    end
    end


function Xerath:WLogic()
  local target = GetTargetSelector(self.W.range, 0)
  if not self.isQactive and not self.isRactive and target ~= 0 and self.Use_Combo_W and CanCast(_W) then
    if CanCast(_W) then
      tar = GetAIHero(target)
      local CastPosition, HitChance, Position = pred:GetCircularAOECastPosition(tar,self.W.delay,self.W.width,self.W.range,self.W.speed,myHero,false)
      --local WPos, WHitChance = HPred:GetPredict(self.HPred_W_M, tar, myHero)
      if HitChance >= 2 then
      --self.W:Cast(target)
        CastSpellToPos(CastPosition.x,CastPosition.z,_W)
      end
    end
  end
end

function Xerath:ELogic()
  local target = GetTargetSelector(800, 0)
  if not self.isQactive and not self.isRactive and target ~= 0 and IsValidTarget(target, self.E.range) and self.Use_Combo_E then
    if CanCast(_E) then
      tar = GetAIHero(target)
      local CastPosition, HitChance, Position = pred:GetLineCastPosition(tar,self.E.delay,self.E.width,self.E.range,self.E.speed,myHero,true)
      --local EPos, EHitChance = HPred:GetPredict(self.HPred_E_M, tar, myHero)
      if HitChance >= 2 then
      --self.E:Cast(target)
        CastSpellToPos(CastPosition.x,CastPosition.z,_E)
      end
    end
  end
end

function Xerath:RLogic()
  targ = GetTargetSelector(self.R.range, 0)
  if self.isRactive and targ ~= nil and IsValidTarget(targ, self.R.range) then
    tar = GetAIHero(targ)
	local CastPosition, HitChance, Position = pred:GetLineCastPosition(tar,self.R.delay,self.R.width,self.R.range,self. R.speed,myHero,false)
  --local RPos, RHitChance = HPred:GetPredict(self.HPred_R_M, tar, myHero)
	if HitChance >= 2 and self.Mode_R == 1 and GetKeyPress(self.RTap) > 0 then
		CastSpellToPos(CastPosition.x,CastPosition.z,_R)
    self.lastRtime = GetTimeGame()
  elseif HitChance >= 2 and self.Mode_R == 2 and GetTimeGame() - self.lastRtime >= self.RDelay then
    CastSpellToPos(CastPosition.x,CastPosition.z,_R)
    self.lastRtime = GetTimeGame()
	end
end
end

function Xerath:LaneClearLogic()
--__PrintTextGame(self.W.range + self.W.width)
end

function Xerath:GapClose()
    for i,enm in pairs(GetEnemyHeroes()) do
        if enm ~= nil and CanCast(_E) then
            local hero = GetAIHero(enm)
            local TargetDashing, CanHitDashing, DashPosition = pred:IsDashing(hero, self.E.delay, self.E.width, self.E.speed, myHero, false)
            if DashPosition ~= nil and GetDistance(DashPosition) <= self.E.range- 200 then
                CastSpellToPos(DashPosition.x,DashPosition.z,_E)
            end
        end
    end
end
                

function Xerath:MenuBool(stringKey, bool)
    return ReadIniBoolean(self.menu, stringKey, bool)
end

function Xerath:MenuSliderInt(stringKey, valueDefault)
    return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xerath:MenuKeyBinding(stringKey, valueDefault)
    return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Xerath:OnUpdate()
  if isRactive and self.Evade_R then
    SetEvade(true)
    end
    end


function Xerath:OnTick()
  if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end
  self:RLogic()

  if self.AntiGapclose then
  self:GapClose()
  end

  --self.HPred_Q_M = HPSkillshot({type = "PromptLine", delay = 0.55, range = 750, width = 200})
	--self.HPred_W_M = HPSkillshot({type = "PromptCircle", delay = 0.8, range = 1000, radius = 275})
  --self.HPred_E_M = HPSkillshot({type = "DelayLine", delay = 0.25, range = 1125, speed = 1400, collisionM = true, collisionH = true, width = 140})
	

  if GetKeyPress(self.Combo) > 0 then
      self:QLogic()
      self:WLogic()
      self:ELogic()
   end
  if GetKeyPress(self.LaneClear) > 0 then
      self:FarmQ()
      self:FarmW()
   end
    if GetSpellLevel(GetMyChamp(),_R) >= 1 then
    self.R.range = 1200 * GetSpellLevel(GetMyChamp(),_R) + 2000
    end
    --self.HPred_R_M = HPSkillshot({type = "PromptCircle", delay = 0.25,range = self.R.range, radius = 190})
   self.extraq = 500 - self.Q_Extra

   if GetSpellLevel(GetMyChamp(),_R) == 1 then
      self.rstack = 3
   elseif GetSpellLevel(GetMyChamp(),_R) == 2 then
      self.rstack = 4
   elseif GetSpellLevel(GetMyChamp(),_R) == 3 then
      self.rstack = 5
    else
      self.rstack = 0
    end

    for i,v in pairs(GetEnemyHeroes()) do
        hero = GetAIHero(v)
      if self.isRactive then
          totaldamac = GetDamage("R",hero) * self.kalanstack
          if hero.HP < totaldamac then
        if not IsDead(hero.Addr) then
        --chamname =  GetChampName(v)
          self.rkil[hero.NetworkId] = "killable"
        end
      else
          self.rkil[hero.NetworkId] = "unkillable"

      end  
      elseif not self.isRactive then
          totaldamac = GetDamage("R",hero) * self.rstack
          if hero.HP < totaldamac then
        if not IsDead(hero.Addr) then
        --chamname =  GetChampName(v)
          self.rkil[hero.NetworkId] = "killable"
        end
      else
          self.rkil[hero.NetworkId] = "unkillable"

      end  
      end

      if self.isRactive and self.Evade_R then
        SetEvade(true)
      end
    end
end
