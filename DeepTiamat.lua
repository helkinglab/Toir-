IncludeFile("Lib\\TOIR_SDK.lua")

Tiamat = class()

local Version = 8.12
local Author = "Deep"

function OnLoad()
    __PrintTextGame("<b><font color=\"#00FF00\">Deep Tiamat for LOL version</font></b> " ..Version)
    __PrintTextGame("<b><font color=\"#00FF00\">Creator: </font></b> " ..Author)
	Tiamat:__init()
end

function Tiamat:__init()

    --Minion [[ SDK Toir+ ]]
    self.EnemyMinions = minionManager(MINION_ENEMY, 2000, myHero, MINION_SORT_HEALTH_ASC)
	self.JungleMinions = minionManager(MINION_JUNGLE, 2000, myHero, MINION_SORT_HEALTH_ASC)
	--Target

    self:TiamatMenus()
	
    Callback.Add("Tick", function() self:OnTick() end) 
    Callback.Add("DrawMenu", function(...) self:OnDrawMenu(...) end)
    Callback.Add("AfterAttack", function(...) self:OnAfterAttack(...) end)
 --   Callback.Add("UpdateBuff", function(unit, buff, stacks) self:OnUpdateBuff(source, unit, buff, stacks) end)
--	Callback.Add("RemoveBuff", function(unit, buff) self:OnRemoveBuff(unit, buff) end)
	
 __PrintTextGame("<b><font color=\"#cffffff00\">Deep Tiamat</font></b> <font color=\"#ffffff\">Loaded. Enjoy Your Game!</font>")
 end 
 
function Tiamat:OnUpdateBuff(source,unit,buff,stacks)
      if unit.Type == 0 and not unit.IsMe then
--__PrintTextGame("He get buff:" ..buff.Name)
		end
      if unit.IsMe then
--__PrintTextGame("You get buff:" ..buff.Name)
		end
	end

function Tiamat:OnRemoveBuff(unit, buff)
      if unit.IsMe then
--__PrintTextGame("You lose buff:" ..buff.Name)
		end
      if unit.Type == 0 and not unit.IsMe then
--__PrintTextGame("He lose buff:" ..buff.Name)
		end
end

function Tiamat:OnAfterAttack(unit, target)
	local delaytia = self.TiamatONdelay / 1000
	if unit.IsMe then
		if GetKeyPress(self.Harass) > 0 then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) 
				and CanCast(tiamat) 
				and self.TiamatHarass 
				and not self.IsReset
				then
						CastSpellTarget(myHero.Addr, tiamat)
				end
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) 
				and CanCast(tiamat) 
				and self.TiamatHarass 
				and not self.TiamatON
				then
						CastSpellTarget(myHero.Addr, tiamat)
				end
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) 
				and CanCast(tiamat) 
				and self.TiamatHarass
				and self.TiamatON
				and self.IsReset
				then    

					DelayAction(function() CastSpellTarget(myHero.Addr, tiamat) end, delaytia)	
				end
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) 
				and CanCast(titanic) 
				and self.TitanicHarass 
				and not self.IsReset
				then
							CastSpellTarget(myHero.Addr, titanic)
				end
				if myHero.HasItem(3748) 
				and CanCast(titanic) 
				and self.TitanicHarass 
				and not self.TiamatON
				then
							CastSpellTarget(myHero.Addr, titanic)
				end
				if myHero.HasItem(3748) 
				and CanCast(titanic) 
				and self.TitanicHarass 
				and self.TiamatON
				and self.IsReset
				then
					DelayAction(function() CastSpellTarget(myHero.Addr, tiamat) end, delaytia)	
				end
    		end
    		if GetKeyPress(self.Combo) > 0 then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) 
				and CanCast(tiamat) 
				and self.TiamatCombo 
				and not self.IsReset
				then
--   __PrintTextGame("casting tiamat1")
						CastSpellTarget(myHero.Addr, tiamat)
						
				end
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) 
				and CanCast(tiamat) 
				and self.TiamatCombo 
				and not self.TiamatON
				then
  -- __PrintTextGame("casting tiamat11")
						CastSpellTarget(myHero.Addr, tiamat)
						
				end
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) 
				and CanCast(tiamat) 
				and self.TiamatCombo
				and self.TiamatON
				and self.IsReset
				then
 --  __PrintTextGame("casting tiamat2")
					DelayAction(function() CastSpellTarget(myHero.Addr, tiamat) end, delaytia)	
				end
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) 
				and CanCast(titanic) 
				and self.TitanicCombo
				and not self.IsReset
				then
							CastSpellTarget(myHero.Addr, titanic)
				end
				if myHero.HasItem(3748) 
				and CanCast(titanic) 
				and self.TitanicCombo
				and not self.TiamatON
				then
							CastSpellTarget(myHero.Addr, titanic)
				end
				if myHero.HasItem(3748) 
				and CanCast(titanic) 
				and self.TitanicCombo 
				and self.TiamatON
				and self.IsReset
				then
					DelayAction(function() CastSpellTarget(myHero.Addr, tiamat) end, delaytia)	
				end
			end
							
	for i, minions in ipairs(self:JungleIndex()) do
        if minions ~= 0 then
		local jungle = GetUnit(minions)
		if jungle.Type == 3 then

	  if GetKeyPress(self.LaneClear) > 0 then
		if jungle ~= nil and GetDistance(jungle) < 380 then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) and CanCast(tiamat) and self.TiamatClear then
						CastSpellTarget(myHero.Addr, tiamat)
						
				end
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) and CanCast(titanic) and self.TitanicClear then
							CastSpellTarget(myHero.Addr, titanic)
				end
        end						
			    		end
			    	end
		if jungle.Type == 1 then

	  if GetKeyPress(self.LaneClear) > 0 then
		if jungle ~= nil and GetDistance(jungle) < 380 then
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) and CanCast(titanic) and self.TitanicClear then
							CastSpellTarget(myHero.Addr, titanic)
				end
        end						
			    		end
	  if GetKeyPress(self.LastHit) > 0 then
		if jungle ~= nil and GetDistance(jungle) < 380 then
				local titanic = GetSpellIndexByName("ItemTitanicHydraCleave")
				if myHero.HasItem(3748) and CanCast(titanic) then
							CastSpellTarget(myHero.Addr, titanic)
				end
        end						
			    		end			
			    	end		    								
				end			
    		end
			end
			end
			
function Tiamat:LastLane()
    for i ,minion in pairs(self:EnemyMinionsIndex()) do
        if minion ~= 0 then
		if IsValidTarget(minion.Addr, 360) and (GetAADamageHitEnemy(minion.Addr) * 0.7) > minion.HP then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) and CanCast(tiamat) and self.TiamatLane then
						CastSpellTarget(myHero.Addr, tiamat)
						
				end
			end						
		end
	end		    						
end

function Tiamat:LastClear()
    for i ,minion in pairs(self:EnemyMinionsIndex()) do
        if minion ~= 0 then
		if IsValidTarget(minion.Addr, 360) and (GetAADamageHitEnemy(minion.Addr) * 0.7) > minion.HP then
				local tiamat = GetSpellIndexByName("ItemTiamatCleave")
				if (myHero.HasItem(3077) or myHero.HasItem(3074)) and CanCast(tiamat) and self.TiamatClearkill then
						CastSpellTarget(myHero.Addr, tiamat)
						
				end
			end						
		end
	end		    						
end			
	
function Tiamat:JungleIndex()
    GetAllUnitAroundAnObject(myHero.Addr, 2000)
    local result = {}
    for i, minions in pairs(pUnit) do
        if minions ~= 0 and not IsDead(minion) and not IsInFog(minions) and (GetType(minions) == 3 or GetType(minions) == 1) then
            table.insert(result, minions)
        end
    end
    return result
end 
 
  --SDK {{Toir+}}
function Tiamat:MenuBool(stringKey, bool)
	return ReadIniBoolean(self.menu, stringKey, bool)
end

function Tiamat:MenuSliderInt(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Tiamat:MenuSliderFloat(stringKey, valueDefault)
	return ReadIniFloat(self.menu, stringKey, valueDefault)
end

function Tiamat:MenuComboBox(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end

function Tiamat:MenuKeyBinding(stringKey, valueDefault)
	return ReadIniInteger(self.menu, stringKey, valueDefault)
end


function Tiamat:TiamatMenus()
    self.menu = "Deep Tiamat/Hydra"
	self.TiamatON = self:MenuBool("Tiamat waits for reset", true)
	self.TiamatONdelay = self:MenuSliderInt("Delay for Tiamat Waits", 200)
	
	self.TiamatCombo = self:MenuBool("Use Tiamat/Hydra to reset AA combo", true)
	self.TitanicCombo = self:MenuBool("Use Titanic to reset AA combo", true)
	
	self.TiamatHarass = self:MenuBool("Use Tiamat/Hydra to reset AA harass", true)
	self.TitanicHarass = self:MenuBool("Use Titanic to reset AA harass", true)
	
	self.TiamatClear = self:MenuBool("Use Tiamat/Hydra to reset AA Clear", true)
	self.TitanicClear = self:MenuBool("Use Titanic to reset AA Clear", true)
	
	self.TiamatLane = self:MenuBool("Last Hit minions with Tiamat/Hydra", true)
	self.TiamatClearkill = self:MenuBool("Kill minions with Tiamat/Hydra in Lane Clear", true)
	
	self.Combo = self:MenuKeyBinding("Combo", 32)
    self.LaneClear = self:MenuKeyBinding("Lane Clear", 86)
	self.Harass = self:MenuKeyBinding("Harass", 67)
    self.LastHit = self:MenuKeyBinding("Last Hit", 88)
end

function Tiamat:OnDrawMenu()
if not Menu_Begin(self.menu) then return end
    self.TiamatON = Menu_Bool("Delay Tiamat/Hydra if you have reset abilities", self.TiamatON, self.menu)
	self.TiamatONdelay = Menu_SliderInt("Delay time in ms", self.TiamatONdelay, 0, 1000, self.menu)
	Menu_Separator()
    self.TiamatCombo = Menu_Bool("Use Tiamat/Hydra to reset AA in Combo", self.TiamatCombo, self.menu)
    self.TitanicCombo = Menu_Bool("Use Titanic to reset AA in Combo", self.TitanicCombo, self.menu)
	Menu_Separator()
    self.TiamatHarass = Menu_Bool("Use Tiamat/Hydra to reset AA in Harass", self.TiamatHarass, self.menu)
    self.TitanicHarass = Menu_Bool("Use Titanic to reset AA in Harass", self.TitanicHarass, self.menu)
	Menu_Separator()
	self.TiamatClear = Menu_Bool("Use Tiamat/Hydra to reset AA in Lane Clear", self.TiamatClear, self.menu)
    self.TitanicClear = Menu_Bool("Use Titanic to reset AA in Lane Clear", self.TitanicClear, self.menu)
	Menu_Separator()
    self.TiamatLane = Menu_Bool("Kill minions with Tiamat/Hydra in Last Hit", self.TiamatLane, self.menu)
    self.TiamatClearkill = Menu_Bool("Kill minions with Tiamat/Hydra in Lane Clear", self.TiamatClearkill, self.menu)
    if (Menu_Begin("Keys for Modes")) then
        self.Combo = Menu_KeyBinding("Combo", self.Combo, self.menu)
		self.Harass = Menu_KeyBinding("Harass", self.Harass, self.menu)
        self.LaneClear = Menu_KeyBinding("Lane Clear", self.LaneClear, self.menu)
        self.LastHit = Menu_KeyBinding("Last Hit", self.LastHit, self.menu)
		Menu_End()
    end
	Menu_End()
end
	
function Tiamat:EnemyMinionsIndex() --SDK Toir+
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


function Tiamat:OnTick()
    if IsDead(myHero.Addr) or IsTyping() or IsDodging() then return end

    if (GetBuffByName(myHero.Addr, "XinZhaoQ") > 0 or GetBuffByName(myHero.Addr, "ShyvanaDoubleAttackDragon") > 0 or GetBuffByName(myHero.Addr, "GarenQ") > 0 or GetBuffByName(myHero.Addr, "TrundleQ") > 0 or GetBuffByName(myHero.Addr, "NasusQ") > 0 or GetBuffByName(myHero.Addr, "JaxEmpowerTwo") > 0 or GetBuffByName(myHero.Addr, "DariusW") > 0) then
        self.IsReset = true
    else
        self.IsReset = false
    end
	
    if GetKeyPress(self.LastHit) > 0 then	
		self:LastLane()
    end
	
    if GetKeyPress(self.LaneClear) > 0 then	
		self:LastClear()
    end
end 
