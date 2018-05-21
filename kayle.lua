
if FileExist(COMMON_PATH .. "HPred.lua") then
	require 'HPred'
else
	PrintChat("HPred.lua missing!")
end
if FileExist(COMMON_PATH .. "TPred.lua") then
	require 'TPred'
else
	PrintChat("TPred.lua missing!")
end

function EnemiesAround(pos, range)
	local N = 0
	for i = 1,Game.HeroCount() do
		local hero = Game.Hero(i)
		if ValidTarget(hero,range + hero.boundingRadius) and hero.isEnemy and not hero.dead then
			N = N + 1
		end
	end
	return N
end

function GetBestLinearFarmPos(range, width)
	local BestPos = nil
	local MostHit = 0
	for i = 1, Game.MinionCount() do
		local m = Game.Minion(i)
		if m and m.isEnemy and not m.dead then
			local EndPos = myHero.pos + (m.pos - myHero.pos):Normalized() * range
			local Count = MinionsOnLine(myHero.pos, EndPos, width, 300-myHero.team)
			if Count > MostHit then
				MostHit = Count
				BestPos = m.pos
			end
		end
	end
	return BestPos, MostHit
end

function GetDistanceSqr(Pos1, Pos2)
	local Pos2 = Pos2 or myHero.pos
	local dx = Pos1.x - Pos2.x
	local dz = (Pos1.z or Pos1.y) - (Pos2.z or Pos2.y)
	return dx^2 + dz^2
end

function GetDistance(Pos1, Pos2)
	return math.sqrt(GetDistanceSqr(Pos1, Pos2))
end

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

function GetHeroByHandle(handle)
	for i = 1, Game.HeroCount() do
		local hr = Game.Hero(i)
		if hr.handle == handle then
			return hr
		end
	end
end

function GetItemSlot(unit, id)
	for i = ITEM_1, ITEM_7 do
		if unit:GetItemData(i).itemID == id then
			return i
		end
	end
	return 0
end

function GetPercentHP(unit)
	return 100*unit.health/unit.maxHealth
end

function GetTarget(range)
	if _G.SDK then
		return _G.SDK.TargetSelector:GetTarget(range, _G.SDK.DAMAGE_TYPE_PHYSICAL);
	else
		return _G.GOS:GetTarget(range,"AD")
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

function GotBuff(unit, buffname)
	for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
		if buff.name == buffname and buff.count > 0 then 
			return buff.count
		end
	end
	return 0
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

function IsKnocked(unit)
	for i = 0, unit.buffCount do
		local buff = unit:GetBuff(i)
		if buff and (buff.type == 29 or buff.type == 30 or buff.type == 31) and buff.count > 0 then
			return true
		end
	end
	return false
end

function IsReady(spell)
	return Game.CanUseSpell(spell) == 0
end

function MinionsOnLine(startpos, endpos, width, team)
	local Count = 0
	for i = 1, Game.MinionCount() do
		local m = Game.Minion(i)
		if m and m.team == team and not m.dead then
			local w = width + m.boundingRadius
			local pointSegment, pointLine, isOnSegment = VectorPointProjectionOnLineSegment(startpos, endpos, m.pos)
			if isOnSegment and GetDistanceSqr(pointSegment, m.pos) < w^2 and GetDistanceSqr(startpos, endpos) > GetDistanceSqr(startpos, m.pos) then
				Count = Count + 1
			end
		end
	end
	return Count
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

function ValidTarget(target, range)
	range = range and range or math.huge
	return target ~= nil and target.valid and target.visible and not target.dead and target.distance <= range
end

function VectorPointProjectionOnLineSegment(v1, v2, v)
	local cx, cy, ax, ay, bx, by = v.x, (v.z or v.y), v1.x, (v1.z or v1.y), v2.x, (v2.z or v2.y)
	local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) ^ 2 + (by - ay) ^ 2)
	local pointLine = { x = ax + rL * (bx - ax), y = ay + rL * (by - ay) }
	local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
	local isOnSegment = rS == rL
	local pointSegment = isOnSegment and pointLine or {x = ax + rS * (bx - ax), y = ay + rS * (by - ay)}
	return pointSegment, pointLine, isOnSegment
end

class "Kayle"

local HeroIcon = "https://www.mobafire.com/images/avatars/kayle-classic.png"
local IgniteIcon = "http://pm1.narvii.com/5792/0ce6cda7883a814a1a1e93efa05184543982a1e4_hq.jpg"
local QIcon = "https://vignette.wikia.nocookie.net/leagueoflegends/images/2/20/Reckoning.png"
local WIcon = "ttps://vignette.wikia.nocookie.net/leagueoflegends/images/a/a1/Divine_Blessing.png"
local EIcon = "https://vignette.wikia.nocookie.net/leagueoflegends/images/9/9b/Righteous_Fury.png"
local RIcon = "https://vignette.wikia.nocookie.net/leagueoflegends/images/3/3f/Intervention.png"
local ETravel = true
local IS = {}

function Kayle:Menu()
	self.KayleMenu = MenuElement({type = MENU, id = "Kayle", name = "Kayle", leftIcon = HeroIcon})
	self.KayleMenu:MenuElement({id = "Auto", name = "Auto", type = MENU})
	self.KayleMenu.Auto:MenuElement({id = "autoW", name = "Auto W if health is below %", value = 20, min = 0, max = 100, step = 1})
	self.KayleMenu.Auto:MenuElement({id = "autoWA", name = "Auto W on ally if health is below %", value = 15, min = 0, max = 100, step = 1})
	self.KayleMenu.Auto:MenuElement({id = "autoR", name = "Auto R if health is below %", value = 10, min = 0, max = 100, step = 1})
	self.KayleMenu.Auto:MenuElement({id = "autoRA", name = "Auto R on ally if health is below %", value = 5, min = 0, max = 100, step = 1})
	
	
	self.KayleMenu:MenuElement({id = "Combo", name = "Combo", type = MENU})
	self.KayleMenu.Combo:MenuElement({id = "UseQ", name = "Use Q ", value = true, leftIcon = QIcon})
	self.KayleMenu.Combo:MenuElement({id = "UseE", name = "Use E ", value = true, leftIcon = EIcon})
	self.KayleMenu.Combo:MenuElement({id = "UseR", name = "Use R ", value = true, leftIcon = RIcon})
	
	self.KayleMenu:MenuElement({id = "Harass", name = "Harass", type = MENU})
	self.KayleMenu.Harass:MenuElement({id = "UseQ", name = "Use Q ", value = true, leftIcon = QIcon})
	
	self.KayleMenu.Harass:MenuElement({id = "UseE", name = "Use E", value = true, leftIcon = EIcon})
	
	self.KayleMenu:MenuElement({id = "KillSteal", name = "KillSteal", type = MENU})
	self.KayleMenu.KillSteal:MenuElement({id = "UseIgnite", name = "Use Ignite", value = true, leftIcon = IgniteIcon})
	self.KayleMenu.KillSteal:MenuElement({id = "UseQ", name = "Use Q", value = true, leftIcon = QIcon})
	
	self.KayleMenu:MenuElement({id = "LaneClear", name = "LaneClear", type = MENU})
	self.KayleMenu.LaneClear:MenuElement({id = "UseE", name = "Use E ", value = true, leftIcon = EIcon})
	
	self.KayleMenu:MenuElement({id = "LastHit", name = "LastHit", type = MENU})
	self.KayleMenu.LastHit:MenuElement({id = "UseQ", name = "Use Q", value = false, leftIcon = QIcon})
	self.KayleMenu.LastHit:MenuElement({id = "UseE", name = "Use E", value = true, leftIcon = EIcon})
	
	self.KayleMenu:MenuElement({id = "AntiGapcloser", name = "Anti-Gapcloser", type = MENU})
	self.KayleMenu.AntiGapcloser:MenuElement({id = "UseW", name = "Use W", value = false, leftIcon = WIcon})
	self.KayleMenu.AntiGapcloser:MenuElement({id = "Distance", name = "Distance: W", value = 400, min = 25, max = 500, step = 25})
	
	self.KayleMenu:MenuElement({id = "Flee", name = "Flee", type = MENU})
	
	self.KayleMenu.Flee:MenuElement({id = "UseW", name = "Use W ", value = true, leftIcon = WIcon})
	
	
	
	self.KayleMenu:MenuElement({id = "Drawings", name = "Drawings", type = MENU})
	self.KayleMenu.Drawings:MenuElement({id = "DrawQ", name = "Draw Q Range", value = true})
	self.KayleMenu.Drawings:MenuElement({id = "DrawE", name = "Draw E Range", value = true})
	self.KayleMenu.Drawings:MenuElement({id = "DrawW", name = "Draw W Range", value = true})
	self.KayleMenu.Drawings:MenuElement({id = "DrawR", name = "Draw R Range", value = true})
	self.KayleMenu.Drawings:MenuElement({id = "DrawAA", name = "Draw Killable AAs", value = true})
	self.KayleMenu.Drawings:MenuElement({id = "DrawJng", name = "Draw Jungler Info", value = true})
	
	self.KayleMenu:MenuElement({id = "Items", name = "Items", type = MENU})
	self.KayleMenu.Items:MenuElement({id = "UseBC", name = "Use Bilgewater Cutlass", value = true})
	self.KayleMenu.Items:MenuElement({id = "UseBOTRK", name = "Use BOTRK", value = true})
	self.KayleMenu.Items:MenuElement({id = "UseHG", name = "Use Hextech Gunblade", value = true})
	self.KayleMenu.Items:MenuElement({id = "UseMS", name = "Use Mercurial Scimitar", value = true})
	self.KayleMenu.Items:MenuElement({id = "UseQS", name = "Use Quicksilver Sash", value = true})
	self.KayleMenu.Items:MenuElement({id = "OI", name = "%HP To Use Offensive Items", value = 35, min = 0, max = 100, step = 5})
end

function Kayle:Spells()
	KayleQ = {speed = 1500, range = 650}
	KayleW = {range = 900}
	KayleE = {range = 525}
	KayleR = {speed = math.huge,range = 900}
end

function Kayle:__init()
	Item_HK = {}
	self:Menu()
	self:Spells()
	Callback.Add("Tick", function() self:Tick() end)
	Callback.Add("Draw", function() self:Draw() end)
end

function Kayle:Tick()
	if myHero.dead or Game.IsChatOpen() == true then return end
	target = GetTarget(1400)
	Item_HK[ITEM_1] = HK_ITEM_1
	Item_HK[ITEM_2] = HK_ITEM_2
	Item_HK[ITEM_3] = HK_ITEM_3
	Item_HK[ITEM_4] = HK_ITEM_4
	Item_HK[ITEM_5] = HK_ITEM_5
	Item_HK[ITEM_6] = HK_ITEM_6
	Item_HK[ITEM_7] = HK_ITEM_7
	self:Items1()
	self:Items2()
	self:Auto() 
	self:Combo()
	self:Harass()
	self:KillSteal()
	self:LaneClear()
	self:LastHit()
	self:Flee()
	self:AntiGapcloser()
end

function Kayle:Items1()
	if EnemiesAround(myHero, 1000) >= 1 then
		if (target.health / target.maxHealth)*100 <= self.KayleMenu.Items.OI:Value() then
			if self.KayleMenu.Items.UseBC:Value() then
				if GetItemSlot(myHero, 3144) > 0 and ValidTarget(target, 550) then
					if myHero:GetSpellData(GetItemSlot(myHero, 3144)).currentCd == 0 then
						Control.CastSpell(Item_HK[GetItemSlot(myHero, 3144)], target)
					end
				end
			end
			if self.KayleMenu.Items.UseBOTRK:Value() then
				if GetItemSlot(myHero, 3153) > 0 and ValidTarget(target, 550) then
					if myHero:GetSpellData(GetItemSlot(myHero, 3153)).currentCd == 0 then
						Control.CastSpell(Item_HK[GetItemSlot(myHero, 3153)], target)
					end
				end
			end
			if self.KayleMenu.Items.UseHG:Value() then
				if GetItemSlot(myHero, 3146) > 0 and ValidTarget(target, 700) then
					if myHero:GetSpellData(GetItemSlot(myHero, 3146)).currentCd == 0 then
						Control.CastSpell(Item_HK[GetItemSlot(myHero, 3146)], target)
					end
				end
			end
		end
	end
end

function Kayle:Items2()
	if self.KayleMenu.Items.UseMS:Value() then
		if GetItemSlot(myHero, 3139) > 0 then
			if myHero:GetSpellData(GetItemSlot(myHero, 3139)).currentCd == 0 then
				if IsImmobile(myHero) then
					Control.CastSpell(Item_HK[GetItemSlot(myHero, 3139)], myHero)
				end
			end
		end
	end
	if self.KayleMenu.Items.UseQS:Value() then
		if GetItemSlot(myHero, 3140) > 0 then
			if myHero:GetSpellData(GetItemSlot(myHero, 3140)).currentCd == 0 then
				if IsImmobile(myHero) then
					Control.CastSpell(Item_HK[GetItemSlot(myHero, 3140)], myHero)
				end
			end
		end
	end
end

function Kayle:Draw()
	if myHero.dead then return end
	if self.KayleMenu.Drawings.DrawQ:Value() then Draw.Circle(myHero.pos, KayleQ.range, 1, Draw.Color(255, 0, 191, 255)) end
	if self.KayleMenu.Drawings.DrawE:Value() then Draw.Circle(myHero.pos, KayleE.range, 1, Draw.Color(255, 65, 105, 225)) end
	if self.KayleMenu.Drawings.DrawW:Value() then Draw.Circle(myHero.pos, KayleW.range, 1, Draw.Color(255, 30, 144, 255)) end
	if self.KayleMenu.Drawings.DrawR:Value() then Draw.Circle(myHero.pos, KayleR.range, 1, Draw.Color(255, 0, 0, 255)) end
	for i, enemy in pairs(GetEnemyHeroes()) do
		if self.KayleMenu.Drawings.DrawJng:Value() then
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
		if self.KayleMenu.Drawings.DrawAA:Value() then
			if ValidTarget(enemy) then
				AALeft = enemy.health / myHero.totalDamage
				Draw.Text("AA Left: "..tostring(math.ceil(AALeft)), 17, enemy.pos2D.x-38, enemy.pos2D.y+10, Draw.Color(0xFF00BFFF))
			end
		end
	end
end



function Kayle:Auto()
	if IsReady(_W) then
		    if myHero.health/myHero.maxHealth < self.KayleMenu.Auto.autoW:Value()/100 and not onRecall() then
			 Control.CastSpell(HK_W,myHero)
		    end
	end
	if IsReady(_R) and ValidTarget(target,600) then
		    if myHero.health/myHero.maxHealth < self.KayleMenu.Auto.autoR:Value()/100 and not onRecall() then
			 Control.CastSpell(HK_R,myHero)
		    end
	end

end


function Kayle:Combo()
	if target == nil then return end
	if Mode() == "Combo" then
		if self.KayleMenu.Combo.UseQ:Value() then
			if IsReady(_Q) and myHero.attackData.state ~= STATE_WINDUP then
				
					if ValidTarget(target, KayleQ.range) then
						Control.CastSpell(HK_Q, target)
					end
				
			end
		end
		
		if self.KayleMenu.Combo.UseE:Value() then
			if IsReady(_E) and myHero.attackData.state ~= STATE_WINDUP then
				if ValidTarget(target, KayleE.range) then
					Control.CastSpell(HK_E, target)
				end
			end
		end
		
	end
end

function Kayle:Harass()
	if target == nil then return end
	if Mode() == "Harass" then
		if self.KayleMenu.Harass.UseQ:Value() then
			if IsReady(_Q) and myHero.attackData.state ~= STATE_WINDUP then
				
					if ValidTarget(target, KayleQ.range) then
						Control.CastSpell(HK_Q, target)
					end
				
			end
		end
		if self.KayleMenu.Harass.UseE:Value() then
			if IsReady(_E) and myHero.attackData.state ~= STATE_WINDUP then
				if ValidTarget(target, KayleE.range) then
					Control.CastSpell(HK_E, target)
				end
			end
		end
	end
end

function Kayle:KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if self.KayleMenu.KillSteal.UseQ:Value() then
			if IsReady(_Q) then
				if ValidTarget(enemy, KayleQ.range) then
					local KayleQDmg = (({60, 110, 160, 210, 260})[myHero:GetSpellData(_Q).level] + myHero.totalDamage + 0.6 * myHero.ap)
					if (enemy.health + enemy.hpRegen * 6 + enemy.armor) < KayleQDmg then
						Control.CastSpell(HK_Q, target)
					end
				end
			end
		end
		if self.KayleMenu.KillSteal.UseIgnite:Value() then
			local IgniteDmg = (55 + 25 * myHero.levelData.lvl)
			if ValidTarget(enemy, 600) and enemy.health + enemy.shieldAD < IgniteDmg then
				if myHero:GetSpellData(SUMMONER_1).name == "SummonerDot" and IsReady(SUMMONER_1) then
					Control.CastSpell(HK_SUMMONER_1, enemy)
				elseif myHero:GetSpellData(SUMMONER_2).name == "SummonerDot" and IsReady(SUMMONER_2) then
					Control.CastSpell(HK_SUMMONER_2, enemy)
				end
			end
		end
	end
end

function Kayle:LaneClear()
	if Mode() == "LaneClear" then

		for i = 1, Game.MinionCount() do
			local minion = Game.Minion(i)
			if minion and minion.isEnemy then
				if self.KayleMenu.LaneClear.UseE:Value() then
					if IsReady(_E) then
						if ValidTarget(minion, KayleE.range) then
							Control.SetCursorPos(minion)
							Control.CastSpell(HK_E, minion)
						end
					end
				end
				
			end
		end
	end
end

function Kayle:LastHit()
	if Mode() == "LaneClear" then
		for i = 1, Game.MinionCount() do
			local minion = Game.Minion(i)
			if minion and minion.isEnemy then
				if self.KayleMenu.LastHit.UseQ:Value() then
					if IsReady(_Q) then
						if ValidTarget(minion, KayleQ.range) then
							local KayleQDmg = ((({60, 110, 160, 210, 260})[myHero:GetSpellData(_Q).level]) + myHero.totalDamage + 0.6 * myHero.ap)
							if minion.health < KayleQDmg then
								Control.CastSpell(HK_Q, minion)
							end
						end
					end
				end
				if self.KayleMenu.LastHit.UseE:Value() then
					if IsReady(_E) then
						if ValidTarget(minion, KayleE.range)  then
							local KayleEDmg = ((({20, 30, 40, 50, 60 })[myHero:GetSpellData(_E).level]) + 0.3 * myHero.ap)
							if minion.health < KayleEDmg then
								Control.CastSpell(HK_E, minion)
							end
						end
					end
				end
			end
		end
	end
end

function Kayle:Flee()
	if self.KayleMenu.Flee.UseW:Value() then
		if Mode() == "Flee" then
			--for i = 1, Game.MinionCount() do
				--local minion = Game.Minion(i)
				--if minion and minion.isEnemy then
					--if GetDistance(minion.pos) <= YasuoE.range and GotBuff(minion, "YasuoDashWrapper") == 0 then
						if IsReady(_W) then
							--if GotBuff(myHero, "YasuoQ3W") == 0 then
								--Control.CastSpell(HK_E, mousePos)
								Control.CastSpell(HK_W,myHero)
							--end
						--elseif IsReady(_E) then
							--Control.CastSpell(HK_E, mousePos)
						end
					--end
				--end
			--end
		end
	end
end

function Kayle:AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if IsReady(_W) then
			if self.KayleMenu.AntiGapcloser.UseW:Value() then
				if ValidTarget(antigap, self.KayleMenu.AntiGapcloser.Distance:Value()) then
					Control.CastSpell(HK_W,myHero)
				end
			end
		end
	end
end

function OnLoad()
	Kayle()
end
