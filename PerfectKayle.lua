local LocalGameTimer				= Game.Timer;
local LocalGameHeroCount 			= Game.HeroCount;
local LocalGameHero 				= Game.Hero;
local LocalGameMinionCount 			= Game.MinionCount;
local LocalGameMinion 				= Game.Minion;
local LocalGameTurretCount 			= Game.TurretCount;
local LocalGameTurret 				= Game.Turret;
local LocalGameWardCount 			= Game.WardCount;
local LocalGameWard 				= Game.Ward;
local LocalGameObjectCount 			= Game.ObjectCount;
local LocalGameObject				= Game.Object;
local LocalGameMissileCount 		= Game.MissileCount;
local LocalGameMissile				= Game.Missile;
local LocalGameParticleCount 		= Game.ParticleCount;
local LocalGameParticle				= Game.Particle;
local CastSpell 					= _G.Control.CastSpell
local LocalGameIsChatOpen			= Game.IsChatOpen;
local LocalStringSub				= string.sub;
local LocalStringLen				= string.len;
local LocalPairs					= pairs;


function GetEnemyHeroes()
	EnemyHeroes = {}
	for i = 1, Game.HeroCount() do
		local Hero = Game.Hero(i)
		if Hero.isEnemy then
			table.insert(EnemyHeroes, Hero)
		end
	end
	return EnemyHeroes
end
function StringEndsWith(str, word)
	return LocalStringSub(str, - LocalStringLen(word)) == word;
end
function Ready(spellSlot)
	return Game.CanUseSpell(spellSlot) == 0
end
function ValidTarget(target, range)
	range = range and range or math.huge
	return target ~= nil and target.valid and target.visible and not target.dead and target.distance <= range
end
function CurrentPctLife(entity)
	local pctLife =  entity.health/entity.maxHealth  * 100
	return pctLife
end
function GetItemSlot(unit, id)
	for i = ITEM_1, ITEM_7 do
		if unit:GetItemData(i).itemID == id then
			return i
		end
	end
	return 0
end
function CurrentPctMana(entity)
	local pctMana =  entity.mana/entity.maxMana * 100
	return pctMana
end
function IsImmobile(unit)
	for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
		if buff and (buff.type == 5 or buff.type == 11 or buff.type == 18 or buff.type == 22 or buff.type == 24 or buff.type == 28 or buff.type == 29 or buff.name == "recall") and buff.count > 0 then
			return true
		end
	end
	return false
end
function CanTarget(target)
	return target and target.pos and target.isEnemy and target.alive and target.health > 0 and target.visible and target.isTargetable
end

function CanTargetAlly(target)
	return target and target.pos and target.isAlly and target.alive and target.health > 0 and target.visible and target.isTargetable
end
function Mode()
	if _G.SDK then
		if _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_COMBO] then
			return "Combo"
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_HARASS] then
			return "Harass"
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_LANECLEAR] then
			return "LaneClear"
		elseif _G.SDK.Orbwalker.Modes[_G.SDK.ORBWALKER_MODE_FLEE] then
			return "Flee"
		end
	else
		return GOS.GetMode()
	end
end
function onRecall()
	for i = 0, myHero.buffCount do
		local buff = myHero:GetBuff(i)
		if buff and buff.name == "recall" and buff.duration > 0 then
			return true
		end
	end
	return false
end
function GetTarget(range, isAD)
	if forcedTarget and LocalGeometry:IsInRange(myHero.pos, forcedTarget.pos, range) then return forcedTarget end
	if isAD then		
		return _G.SDK.TargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_PHYSICAL);
	else
		return _G.SDK.TargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_MAGICAL);
	end
end

function WndMsg(msg,key)
	if msg == 513 then
		local starget = nil
		local dist = 10000
		for i  = 1,LocalGameHeroCount(i) do
			local enemy = LocalGameHero(i)
			if enemy and enemy.alive and enemy.isEnemy and LocalGeometry:GetDistanceSqr(mousePos, enemy.pos) < dist then
				starget = enemy
				dist = LocalGeometry:GetDistanceSqr(mousePos, enemy.pos)
			end
		end
		if starget then
			forcedTarget = starget
		else
			forcedTarget = nil
		end
	end	
end

function EnableOrb(bool)
    if _G.EOWLoaded then
        EOW:SetMovements(bool)
        EOW:SetAttacks(bool)
    elseif _G.SDK and _G.SDK.Orbwalker then
        _G.SDK.Orbwalker:SetMovement(bool)
        _G.SDK.Orbwalker:SetAttack(bool)
    else
        GOS.BlockMovement = not bool
        GOS.BlockAttack = not bool
    end
end


local vectorCast = {}
local mouseReturnPos = mousePos
local mouseCurrentPos = mousePos
local nextVectorCast = 0
function CastVectorSpell(key, pos1, pos2)
	if nextVectorCast > LocalGameTimer() then return end
	nextVectorCast = LocalGameTimer() + 1.5
	EnableOrb(false)
	vectorCast[#vectorCast + 1] = function () 
		mouseReturnPos = mousePos
		mouseCurrentPos = pos1
		Control.SetCursorPos(pos1)
	end
	vectorCast[#vectorCast + 1] = function () 
		Control.KeyDown(key)
	end
	vectorCast[#vectorCast + 1] = function () 
		local deltaMousePos =  mousePos-mouseCurrentPos
		mouseReturnPos = mouseReturnPos + deltaMousePos
		Control.SetCursorPos(pos2)
		mouseCurrentPos = pos2
	end
	vectorCast[#vectorCast + 1] = function ()
		Control.KeyUp(key)
	end
	vectorCast[#vectorCast + 1] = function ()	
		local deltaMousePos =  mousePos -mouseCurrentPos
		mouseReturnPos = mouseReturnPos + deltaMousePos
		Control.SetCursorPos(mouseReturnPos)
	end
	vectorCast[#vectorCast + 1] = function () 
		EnableOrb(true)
	end		
end

function CastSpell(key, pos, isLine)
	if not pos then Control.CastSpell(key) return end
	
	if type(pos) == "userdata" and pos.pos then
		pos = pos.pos
	end
	
	if not pos:ToScreen().onScreen and isLine then			
		pos = myHero.pos + (pos - myHero.pos):Normalized() * 250
	end
	
	if not pos:ToScreen().onScreen then
		return
	end
		
	EnableOrb(false)
	Control.CastSpell(key, pos)
	EnableOrb(true)		
end

function EnemyCount(origin, range)
	local count = 0
	for i  = 1,LocalGameHeroCount(i) do
		local enemy = LocalGameHero(i)
		if enemy and CanTarget(enemy) and LocalGeometry:IsInRange(origin, enemy.pos, range) then
			count = count + 1
		end			
	end
	return count
end

function NearestAlly(origin, range)
	local ally = nil
	local distance = range
	for i = 1,LocalGameHeroCount()  do
		local hero = LocalGameHero(i)
		if hero and hero ~= myHero and CanTargetAlly(hero) then
			local d =  LocalGeometry:GetDistance(origin, hero.pos)
			if d < range and d < distance then
				distance = d
				ally = hero
			end
		end
	end
	if distance < range then
		return ally, distance
	end
end

function NearestEnemy(origin, range)
	local enemy = nil
	local distance = range
	for i = 1,LocalGameHeroCount()  do
		local hero = LocalGameHero(i)
		if hero and CanTarget(hero) then
			local d =  LocalGeometry:GetDistance(origin, hero.pos)
			if d < range  and d < distance  then
				distance = d
				enemy = hero
			end
		end
	end
	if distance < range then
		return enemy, distance
	end
end

if FileExist(COMMON_PATH .. "Alpha.lua") then
	require 'Alpha'
else
	print("ERROR: Alpha.lua is not present in your Scripts/Common folder. Please re open loader.")
end

if not _G.SDK or not _G.SDK.TargetSelector then
	print("IC Orbwalker MUST be active in order to use this script.")
	return
end


print(myHero.charName .. " will load shortly")
DelayAction(function()
	LocalGeometry = _G.Alpha.Geometry
	LocalBuffManager = _G.Alpha.BuffManager
	LocalObjectManager = _G.Alpha.ObjectManager
	LocalDamageManager = _G.Alpha.DamageManager
	Callback.Add("WndMsg",function(Msg, Key) WndMsg(Msg, Key) end)
	LoadScript()
end, 1)

Q = {Speed = 1500, Range = 650}
W = {Range = 900, Radius = 400, Speed = 99999}
E = {Range = 525}	
R = {Range = 900, Radius = 400, Speed = 99999}
	

function LoadScript()
	Menu = MenuElement({type = MENU, id = "Kayle", name = "Kayle", leftIcon = HeroIcon})
	Menu:MenuElement({id = "Skills", name = "Skills", type = MENU})
	Menu.Skills:MenuElement({id = "Q", name = "Use Q on Harass", type = MENU})
	Menu.Skills.Q:MenuElement({id = "Mana", name = "Minimum Mana", value = 20, min = 1, max = 100, step = 1 })
	Menu.Skills.Q:MenuElement({id = "UseQ", name = "Cast Q", value = true, toggle = true })
	

		
	Menu.Skills:MenuElement({id = "W", name = "Heal", type = MENU})	
	Menu.Skills.W:MenuElement({id = "Targets", name = "Heal Targets ", type = MENU})	
	for i = 1, LocalGameHeroCount() do
		local hero = LocalGameHero(i)
		if hero and hero.isAlly then
			Menu.Skills.W.Targets:MenuElement({id = hero.networkID, name = hero.charName, value = true  })
		end
	end
	Menu.Skills.W:MenuElement({id = "Damage", name = "Heal On Damage", value = 125, min = 50, max = 1000, step = 50 })
	Menu.Skills.W:MenuElement({id = "autoW", name = "Auto Heal if health is below %", value = 20, min = 0, max = 100, step = 5})
	Menu.Skills.W:MenuElement({id = "Auto", name = "Auto Heals", value = true, toggle = true })
	Menu.Skills.W:MenuElement({id = "Mana", name = "Minimum Mana", value = 20, min = 1, max = 100, step = 1 })
		
		
	Menu.Skills:MenuElement({id = "R", name = "Intervention/Kayle R", type = MENU})
	Menu.Skills.R:MenuElement({id = "Targets", name = "Targets", type = MENU})
	Menu.Skills.R:MenuElement({id = "Auto", name = "Auto Cast and minimum health to start the check", value = true, toggle = true })
	for i = 1, LocalGameHeroCount() do
		local hero = LocalGameHero(i)
		if hero and hero.isAlly then
			Menu.Skills.R.Targets:MenuElement({id = hero.networkID, name = hero.charName, value = 50, min = 0, max = 100, step = 5 })
		end
	end
	Menu.Skills.R:MenuElement({id = "Damage", name = "Minimum Incoming Damage", value = 250, min = 50, max = 1000, step = 50 })
	Menu.Skills.R:MenuElement({id = "Count", name = "Enemy Count", value = 2, min = 1, max = 6, step = 1 })
	Menu.Skills.R:MenuElement({id = "autoR", name = "Auto Ult if health is below %", value = 20, min = 0, max = 100, step = 5})		
	
	Menu.Skills:MenuElement({id = "Combo", name = "Combo Key",value = false,  key = string.byte(" ") })	
	Menu.Skills:MenuElement({id = "Harass", name = "Harass Key",value = false,  key = string.byte(" ") })
	Menu:MenuElement({id = "Drawings", name = "Drawings", type = MENU})
	Menu.Drawings:MenuElement({id = "DrawQ", name = "Draw Q Range", value = true})
	Menu.Drawings:MenuElement({id = "DrawE", name = "Draw E Range", value = true})
	Menu.Drawings:MenuElement({id = "DrawW", name = "Draw W Range", value = true})
	Menu.Drawings:MenuElement({id = "DrawR", name = "Draw R Range", value = true})
	Menu.Drawings:MenuElement({id = "DrawJng", name = "Draw Jungler Info", value = true})
	Callback.Add("Draw", function() if myHero.dead then return end
	if Menu.Drawings.DrawQ:Value() then Draw.Circle(myHero.pos, Q.Range, 1, Draw.Color(255, 0, 191, 255)) end
	if Menu.Drawings.DrawE:Value() then Draw.Circle(myHero.pos, E.Range, 1, Draw.Color(255, 65, 105, 225)) end
	if Menu.Drawings.DrawW:Value() then Draw.Circle(myHero.pos, W.Range, 1, Draw.Color(255, 30, 144, 255)) end
	if Menu.Drawings.DrawR:Value() then Draw.Circle(myHero.pos, R.Range, 1, Draw.Color(255, 0, 0, 255)) end
	for i, enemy in pairs(GetEnemyHeroes()) do
		if Menu.Drawings.DrawJng:Value() then
			if enemy:GetSpellData(SUMMONER_1).name == "SummonerSmite" or enemy:GetSpellData(SUMMONER_2).name == "SummonerSmite" then
				Smite = true
			else
				Smite = false
			end
			if Smite then
				if enemy.alive then
					if ValidTarget(enemy) then
						if GetDistance(myHero.pos, enemy.pos) > 3000 then
							Draw.Text("Jungler: Visible", 17, myHero.pos2D.x-45, myHero.pos2D.y+10, Draw.Color(0xFF32CD32))
						else
							Draw.Text("Jungler: Near", 17, myHero.pos2D.x-43, myHero.pos2D.y+10, Draw.Color(0xFFFF0000))
						end
					else
						Draw.Text("Jungler: Invisible", 17, myHero.pos2D.x-55, myHero.pos2D.y+10, Draw.Color(0xFFFFD700))
					end
				else
					Draw.Text("Jungler: Dead", 17, myHero.pos2D.x-45, myHero.pos2D.y+10, Draw.Color(0xFF32CD32))
				end
			end
		end
		
	end end)


	
	Item_HK = {}
	LocalDamageManager:OnIncomingCC(function(target, damage, ccType) OnCC(target, damage, ccType) end)
	Callback.Add("Tick", function() Tick() end)
	
end


--This will record the current E owner for enemies - will not work for allies because the buff is not properly removed when it's cast on someone else...
--I think it's ok for now
local eTarget = nil



local NextTick = LocalGameTimer()
function Tick()
	if LocalGameIsChatOpen() then return end
	local currentTime = LocalGameTimer()
	if NextTick > currentTime then return end
	Item_HK[ITEM_1] = HK_ITEM_1
	Item_HK[ITEM_2] = HK_ITEM_2
	Item_HK[ITEM_3] = HK_ITEM_3
	Item_HK[ITEM_4] = HK_ITEM_4
	Item_HK[ITEM_5] = HK_ITEM_5
	Item_HK[ITEM_6] = HK_ITEM_6
	Item_HK[ITEM_7] = HK_ITEM_7
	
	if Ready(_R) then
		for i = 1, LocalGameHeroCount() do
			local hero = LocalGameHero(i)
			if hero and CanTargetAlly(hero) and LocalGeometry:IsInRange(myHero.pos, hero.pos, R.Range) then
				local incomingDamage = LocalDamageManager:RecordedIncomingDamage(hero)
				local remainingLifePct = (hero.health - incomingDamage) / hero.maxHealth * 100
				if Menu.Skills.R.Targets[hero.networkID]:Value() >= remainingLifePct and (incomingDamage > hero.health or incomingDamage / hero.health * 100 > 25) then
					NextTick = LocalGameTimer() + .25
					CastSpell(HK_R, hero)
					return
				end
				if EnemyCount(hero.pos, R.Radius) >= Menu.Skills.R.Count:Value() then
					NextTick = LocalGameTimer() + .25
					CastSpell(HK_R, hero)
					return
				end
			end
		end
	end



	if GetItemSlot(myHero, 3139) > 0 then
			if myHero:GetSpellData(GetItemSlot(myHero, 3139)).currentCd == 0 then
				if IsImmobile(myHero) then
					Control.CastSpell(Item_HK[GetItemSlot(myHero, 3139)], myHero)
				end
			end
	end
	if GetItemSlot(myHero, 3140) > 0 then
			if myHero:GetSpellData(GetItemSlot(myHero, 3140)).currentCd == 0 then
				if IsImmobile(myHero) then
					Control.CastSpell(Item_HK[GetItemSlot(myHero, 3140)], myHero)
				end
			end
	end

	if Ready(_R) and ValidTarget(target,600) then
		    if myHero.health/myHero.maxHealth < Menu.Skills.R.autoR:Value()/100 and not onRecall() then
			 CastSpell(HK_R,myHero)
		    end
 	end

	if Ready(_W) then
		    if myHero.health/myHero.maxHealth < Menu.Skills.W.autoW:Value()/100 and not onRecall() then
			 CastSpell(HK_W,myHero)
		    end
 	end
	
	if Ready(_W) then
		--Loop allies in range
		for i = 1, LocalGameHeroCount() do
			local hero = LocalGameHero(i)
			if hero and CanTargetAlly(hero) and LocalGeometry:IsInRange(myHero.pos, hero.pos, W.Range) then
				if Menu.Skills.W.Targets[hero.networkID] and Menu.Skills.W.Targets[hero.networkID]:Value() and hero.health/hero.maxHealth < 80/100 and LocalGeometry:IsInRange(myHero.pos, hero.pos, W.Range) and LocalDamageManager:RecordedIncomingDamage(hero) >= Menu.Skills.W.Damage:Value() then					
					NextTick = LocalGameTimer() + .25
					CastSpell(HK_W, hero)
					return
				end
			end
		end
	end	
	if Mode() == "Combo" then
	if Ready(_E) and Menu.Skills.Combo:Value() then
			local target = GetTarget(600)
			if target and CanTarget(target) then
				
				CastSpell(HK_E, target)
				return				
			end
	end
	if Ready(_Q) and Menu.Skills.Combo:Value() then
			local target = GetTarget(Q.Range)
			if target and CanTarget(target) then
				
				CastSpell(HK_Q, target)
				return				
			end
	end
	end
	if Mode() == "Harass" then
	if Ready(_Q) and Menu.Skills.Harass:Value() and Menu.Skills.Q.UseQ:Value() then
			local target = GetTarget(Q.Range)
			if target and CanTarget(target) then
				
				CastSpell(HK_Q, target)
				return				
			end
	end
	if Ready(_E) and Menu.Skills.Harass:Value() then
			local target = GetTarget(600)
			if target and CanTarget(target) then
			
				CastSpell(HK_E, target)
				return				
			end
	end
	end
	
   
	NextTick = LocalGameTimer() + .1

end


function OnCC(target, damage, ccType)
	if target.isAlly then
		if Ready(_R) and LocalGeometry:IsInRange(myHero.pos, target.pos, R.Range) and Menu.Skills.R.Targets[target.networkID] and Menu.Skills.R.Targets[target.networkID]:Value() >= CurrentPctLife(target) then
			if Menu.Skills.Combo:Value() or Menu.Skills.R.Auto:Value() then
				CastSpell(HK_R, target)				
				NextTick = LocalGameTimer() + .15
				return
			end
		end
		if Ready(_W) and LocalGeometry:IsInRange(myHero.pos, target.pos, W.Range) and Menu.Skills.W.Targets[target.networkID] and Menu.Skills.W.Targets[target.networkID]:Value() then
			CastSpell(HK_W, target)
			NextTick = LocalGameTimer() + .15
			return
		end		
	end
	
end

