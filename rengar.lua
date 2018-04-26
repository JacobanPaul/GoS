require('Inspired')
require('IPrediction')
require('OpenPredict')

function Mode()
	if _G.IOW_Loaded and IOW:Mode() then
		return IOW:Mode()
	elseif GoSWalkLoaded and GoSWalk.CurrentMode then
		return ({"Combo", "Harass", "LaneClear", "LastHit"})[GoSWalk.CurrentMode+1]
	end
end

OnProcessSpell(function(unit, spell)
	if unit == myHero then
		if spell.name:lower():find("attack") then
			DelayAction(function()
				AA = true
			end, GetWindUp(myHero)+0.01)
		else
			AA = false
		end
	end
end)

SpawnPos = nil
Recalling = {}
local GlobalTimer = 0
OnObjectLoad(function(Object)
	if GetObjectType(Object) == Obj_AI_SpawnPoint and GetTeam(Object) ~= GetTeam(myHero) then
		SpawnPos = Object
	end
end)
OnCreateObj(function(Object)
	if GetObjectType(Object) == Obj_AI_SpawnPoint and GetTeam(Object) ~= GetTeam(myHero) then
		SpawnPos = Object
	end
end)



OnTick(function(myHero)
	target = GetCurrentTarget()
--	Ferocity = GetCurrentMana(myHero)
	Items1()
	Items2()
	LevelUp()
	
end)



--OnDraw(function(myHero)
--	for _, enemy in pairs(GetEnemyHeroes()) do
--		
--			if GetCastName(enemy,SUMMONER_1):lower():find("smite") and SUMMONER_1 or (GetCastName(enemy,SUMMONER_2):lower():find("smite") and SUMMONER_2 or nil) then
--				DrawJng = WorldToScreen(1,GetOrigin(myHero).x, GetOrigin(myHero).y, GetOrigin(myHero).z)
--				if IsObjectAlive(enemy) then
--					if ValidTarget(enemy) then
--						if GetDistance(myHero, enemy) > 3000 then
--							DrawText("Jungler: Visible", 17, DrawJng.x-45, DrawJng.y+10, 0xff32cd32)
--						else
--							DrawText("Jungler: Near", 17, DrawJng.x-43, DrawJng.y+10, 0xffff0000)
--						end
--					else
--						DrawText("Jungler: Invisible", 17, DrawJng.x-55, DrawJng.y+10, 0xffffd700)
--					end
--				else
--					DrawText("Jungler: Dead", 17, DrawJng.x-45, DrawJng.y+10, 0xff32cd32)
--				end
--			end
--		
--		
--	end
--end)




function Items1()
	if EnemiesAround(myHero, 1000) >= 1 then
					if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 300) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
						CastSpell(GetItemSlot(myHero, 3074))
					end
				
				end
			
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 300) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
						CastSpell(GetItemSlot(myHero, 3077))
					end
				end
			
				if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end
				end

				if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end
				end

				if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end
				end
				
			
			
			


			
		
	end
end

function Items2()
	
		if GetItemSlot(myHero, 3139) >= 1 then
			if CanUseSpell(myHero, GetItemSlot(myHero, 3139)) == READY then
				if GotBuff(myHero, "veigareventhorizonstun") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "slow") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "knockup") > 0 then
					CastTargetSpell(myHero, GetItemSlot(myHero, 3139))
				end
			end
		end
	
	
		if GetItemSlot(myHero, 3140) >= 1 then
			if CanUseSpell(myHero, GetItemSlot(myHero, 3140)) == READY then
				if GotBuff(myHero, "veigareventhorizonstun") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "slow") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "knockup") > 0 then
					CastTargetSpell(myHero, GetItemSlot(myHero, 3140))
				end
			end
		end
	
end


function LevelUp()
	
		
		if "Rengar" == GetObjectName(myHero)  then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		
		end
	
	end









if "Rengar" == GetObjectName(myHero) then
	PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>GoS-U<font color='#1E90FF'>] <font color='#00BFFF'>Rengar loaded successfully!")

	local RengarE = { range = 775, radius = 70, width = 120, speed = 1500, delay = 0.25, type = "line", collision = true, source = myHero, col = {"minion","yasuowall"}}
    local Smite = (GetCastName(myHero,SUMMONER_1):lower():find("smite") and SUMMONER_1 or (GetCastName(myHero,SUMMONER_2):lower():find("smite") and SUMMONER_2 or nil))
 

  OnTick(function(myHero)
	--Auto()
	Combo()
	LaneClear()
	JungleClear()
	end)
 OnDraw(function(myHero)
	Ranges()
 end)



 function Ranges()
 local pos = GetOrigin(myHero)
 DrawCircle(pos,RengarE.range,1,25,0xff4169e1)

 end





 function useQ(target)
	
	CastSpell(_Q)
	if _G.IOW then
						IOW:ResetAA()
					elseif _G.GoSWalkLoaded then
						_G.GoSWalk:ResetAttack()
					end
 
 end

 function useW(target)
	if GetCurrentMana(myHero) < 3 then
        CastSpell(_W)
    end
	
end


function useE(target)
	if GetDistance(target) < RengarE.range then
	local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),RengarE.speed,RengarE.delay*1000,RengarE.range,RengarE.width,true,false)
		if GetCurrentMana(myHero) < 3  then
				if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
				end
		end
		if GetCurrentMana(myHero) == 4 and GetDistance(target, myHero) >= 400 then
				if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
				end
		end

		
		
	end
end
	


 function Combo()
	if Mode() == "Combo" then

		if GetItemSlot(myHero, 3142) >= 1 and ValidTarget(target, 1000) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3142)) == READY then
						CastSpell(GetItemSlot(myHero, 3142))
					end
				end


		
			if CanUseSpell(myHero,_Q) == READY  then
				if ValidTarget(target, GetRange(myHero)+GetHitBox(myHero)+50) then
					
						useQ(target)
					
				end
			end

			if CanUseSpell(myHero,_E) == READY   then
				if ValidTarget(target, RengarE.range) then
					useE(target)
					
				
				end
		
		    end
		
		
			if CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_W) == READY and GetCurrentMana(myHero) < 3 and not QCast and not ECast then
				if ValidTarget(target,GetHitBox(myHero)+350) then
					useW(target)
				
				end
			end


		
		
			

				if Ready(Smite) then
                        for i, enemy in pairs(GetEnemyHeroes()) do
                                if ValidTarget(target, 600)  then
                                        
                                        CastTargetSpell(enemy, Smite)
                                        
                                end
                        end
                end

	end
 end

 function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				
				if CanUseSpell(myHero,_Q) == READY then  
					if ValidTarget(mob, GetRange(myHero)+50) then
						
							useQ(mob) 
						
					end
				end


				if CanUseSpell(myHero,_Q) ~= READY and GetCurrentMana(myHero) < 3 and CanUseSpell(myHero,_W) == READY  and not QCast and not ECast then 
					if ValidTarget(mob, GetHitBox(myHero)+350) then
						if GetCurrentMana(myHero) == 4 then return end
						
						
							useW(mob)
						
						
					end
				end
				
				if CanUseSpell(myHero,_Q) ~= READY and GetCurrentMana(myHero) < 3  and CanUseSpell(myHero,_E) == READY and not QCast and not WCast then
				     if ValidTarget(mob, 1000) then
							if GetCurrentMana(myHero) == 4 then return end 
							CastSkillShot(_E,GetOrigin(mob))
					end
				end

				if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(mob, 200) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
						CastSpell(GetItemSlot(myHero, 3074))
					end
				
				end

				if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(mob, 200) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
						CastSpell(GetItemSlot(myHero, 3077))
					end
				
				end


			end
		end
	end
 end

 function LaneClear()
	if Mode() == "LaneClear" then
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then

				if CanUseSpell(myHero,_E) == READY and GetCurrentMana(myHero) < 3 then
					if ValidTarget(minion, 1000) then
							   
							CastSkillShot(_E,GetOrigin(minion))
				    end
			    end

				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(minion, GetRange(myHero)+50) then
						
							useQ(minion)
						
					end
				end
				if CanUseSpell(myHero,_W) == READY  and CanUseSpell(myHero,_Q) ~= READY and GetCurrentMana(myHero) < 3 then
					if ValidTarget(minion, 400) then
							CastSkillShot(_W,GetOrigin(minion))
					end
				end

			   if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(minion, 200) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
						CastSpell(GetItemSlot(myHero, 3074))
					end
				
				end

				if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(minion, 200) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
						CastSpell(GetItemSlot(myHero, 3077))
					end
				
				end

			end
		end
	end
  end



end

-- Smite

if not pcall( require, "Inspired" ) then PrintChat("You are missing Inspired.lua!") return end

Champ =
    {
	lilaJ = function(target) 
	if GotBuff(myHero,"enchantment_slayer_stacks") == 1 then
		local Stacks = GetBuffData(myHero,"enchantment_slayer_stacks")
		lila = CalcDamage(myHero,target,0,Stacks.Stacks)
	elseif GotBuff(myHero,"itemdevourertransform") == 1 then
		local Stacks = GetBuffData(myHero,"itemdevourertransform")
		lila = CalcDamage(myHero,target,0,Stacks.Stacks)
	else lila = 0 end
	return lila end,
	
	["Rengar"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["RengarQ"] = {
				spellSlot0 = 0, 
				spellName0 = "RengarQ", 
				spellRange0 = 300,
				spellDelay0 = function(target) return 260 - GetLatency() end, 
				spellCast0 = function(target) CastSpell(_Q) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero))+30*GetCastLevel(myHero,_Q)-30 + (GetBaseDamage(myHero)+GetBonusDmg(myHero))*(0.05*GetCastLevel(myHero,_Q)-0.05),0) end },
            ["RengarW"] = {
				spellSlot1 = 1, 
				spellName1 = "RengarW", 
				spellRange1 = 550,
				spellDelay1 = function(target) return 250 - GetLatency() end, 
				spellCast1 = function(target) CastSpell(_W) end, 
				spellDMG1 = function(target) return CalcDamage(myHero,target,0,30*GetCastLevel(myHero,_W)+20+GetBonusAP(myHero)*0.8) end },
        },

    }


if GetCastName(myHero,SUMMONER_1):lower():find("summonersmite") then
	useSmite = SUMMONER_1
elseif GetCastName(myHero,SUMMONER_2):lower():find("summonersmite") then
	useSmite = SUMMONER_2
else return 

end
	
PrintChat("Smite loaded: "..GetObjectName(myHero))

local smiteMenu = Menu("Smite God: "..GetObjectName(myHero), "Smite")
if Champ[GetObjectName(myHero)] ~= nil then
if Champ[GetObjectName(myHero)][GetCastName(myHero,0)] ~= nil then
	DelayAction(function()
		smiteMenu:Boolean("useQ", "Use Q", true)
	end, .005)
end
if Champ[GetObjectName(myHero)][GetCastName(myHero,1)] ~= nil then
	DelayAction(function()
		smiteMenu:Boolean("useW", "Use W", true)
	end, .005)
end
if GetObjectName(myHero) == "Nidalee" then
	DelayAction(function()
	smiteMenu:Boolean("useE", "Use E", true)
	end, .005)
elseif Champ[GetObjectName(myHero)][GetCastName(myHero,2)] ~= nil then
	DelayAction(function()
		smiteMenu:Boolean("useE", "Use E", true)
	end, .005)
end
if Champ[GetObjectName(myHero)][GetCastName(myHero,3)] ~= nil then
	DelayAction(function()
		smiteMenu:Boolean("useR", "Use R", true)
	end, .005)
end
else
	PrintChat(GetObjectName(myHero).." is not supported by Smite")
end

DelayAction(function()
smiteMenu:Boolean("blue", "Smite: Blue", true)
smiteMenu:Boolean("red", "Smite: Red", true)
smiteMenu:Boolean("dragon", "Smite: Dragon", true)
smiteMenu:Boolean("herald", "Smite: Rift Herald", true)
smiteMenu:Boolean("baron", "Smite: Baron", true)
smiteMenu:Boolean("draw", "Draw: Smite range", true)
smiteMenu:Boolean("drawNOT", "Draw: Disable all drawings", false)
smiteMenu:Boolean("ks", "Killsteal: Smite", true)
smiteMenu:Key("dontUse", "Turn off/on", string.byte("G"))
end, 0.010)

local global_ticks = 0
local smiteON = true
local text = "ON"

OnTick(function(myHero)
	for i,minion in pairs(minionManager.objects) do
		if GetTeam(minion) == 300 and IsObjectAlive(minion) then
			if GetObjectBaseName(minion) == "SRU_Dragon_Water6.3.1" then
				dragon = minion
			end
			if GetObjectBaseName(minion) == "SRU_Dragon_Air6.1.1" then
				dragon = minion
			end
			if GetObjectBaseName(minion) == "SRU_Dragon_Earth6.4.1" then
				dragon = minion
			end
			if GetObjectBaseName(minion) == "SRU_Dragon_Fire6.2.1" then
				dragon = minion
			end			
			if GetObjectBaseName(minion) == "SRU_Dragon_Elder6.5.1" then
				dragon = minion
			end											
			if GetObjectName(minion) == "SRU_Red" then
				red = minion
			end
			if GetObjectName(minion) == "SRU_Blue"then
				blue = minion
			end
			if GetObjectName(minion) == "SRU_RiftHerald" then
				herald = minion
			end
			if GetObjectName(minion) == "SRU_Baron" then
				baron = minion
			end
		end
	end
end)

DelayAction(function()
OnDraw(function(myHero)
local origin = GetOrigin(myHero)
local myscreenpos = WorldToScreen(1,origin.x,origin.y,origin.z)
local Ticker = GetTickCount()

if smiteMenu.dontUse:Value() then
	if (global_ticks + 250) < Ticker then
		if smiteON == true then
			text = "OFF"
			smiteON = false
		elseif smiteON == false then
			text = "ON"
			smiteON = true
		end
	global_ticks = Ticker
	end
end

if smiteON == true then
	if CanUseSpell(myHero,useSmite) == READY then
			if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, 750) and smiteMenu.dragon:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(dragon),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(dragon) <= smiteDMG then
					CastTargetSpell(dragon,useSmite)
				end
			end			
			if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, 750) and smiteMenu.dragon:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(dragon),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(dragon) <= smiteDMG then
					CastTargetSpell(dragon,useSmite)
				end
			end			
			if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, 750) and smiteMenu.dragon:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(dragon),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(dragon) <= smiteDMG then
					CastTargetSpell(dragon,useSmite)
				end
			end			
			if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, 750) and smiteMenu.dragon:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(dragon),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(dragon) <= smiteDMG then
					CastTargetSpell(dragon,useSmite)
				end
			end			
			if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, 750) and smiteMenu.dragon:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(dragon),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(dragon) <= smiteDMG then
					CastTargetSpell(dragon,useSmite)
				end
			end
			if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, 750) and smiteMenu.herald:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(herald),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(herald) <= smiteDMG then
					CastTargetSpell(herald,useSmite)
				end
			end
			if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, 750) and smiteMenu.red:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(red),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(red) <= smiteDMG then
					CastTargetSpell(red,useSmite)
				end
			end
			if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, 750) and smiteMenu.blue:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(blue),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(blue) <= smiteDMG then
					CastTargetSpell(blue,useSmite)
				end
			end
			if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, 750) and smiteMenu.baron:Value() then
				if not smiteMenu.drawNOT:Value() then
					DrawCircle(GetOrigin(baron),100,0,155,ARGB(255,55,255,55))
				end
				if GetCurrentHP(baron) <= smiteDMG then
					CastTargetSpell(baron,useSmite)
				end
			end
	end
end
if not smiteMenu.drawNOT:Value() then
	DrawText("Smite: "..text,12,myscreenpos.x-GetHitBox(myHero)/2,myscreenpos.y+10,0xff00ff00)
if smiteON == true and smiteMenu.draw:Value() then
	DrawCircle(origin,600,0,155,ARGB(255,255,255,255))
end
end
end)
end,.010)

OnProcessSpell(function(unit,spell)
if Champ[GetObjectName(myHero)] ~= nil then
	if unit == myHero and spell.name:lower():find("attack") then
		if CanUseSpell(myHero,useSmite) == READY and smiteON == true then
			if GetObjectBaseName(spell.target) == "SRU_Dragon_Water6.3.1" and smiteMenu.dragon:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end			
			if GetObjectBaseName(spell.target) == "SRU_Dragon_Air6.1.1" and smiteMenu.dragon:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end			
			if GetObjectBaseName(spell.target) == "SRU_Dragon_Earth6.4.1" and smiteMenu.dragon:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end			
			if GetObjectBaseName(spell.target) == "SRU_Dragon_Fire6.2.1" and smiteMenu.dragon:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end			
			if GetObjectBaseName(spell.target) == "SRU_Dragon_Elder6.5.1" and smiteMenu.dragon:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end
			if GetObjectName(spell.target) == "SRU_RiftHerald" and smiteMenu.herald:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end
			if GetObjectName(spell.target) == "SRU_Red" and smiteMenu.red:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end
			if GetObjectName(spell.target) == "SRU_Blue" and smiteMenu.blue:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end
			if GetObjectName(spell.target) == "SRU_Baron" and smiteMenu.baron:Value() then
				if GetCurrentHP(spell.target) < smiteDMG + Champ[GetObjectName(myHero)].aaDMG(spell.target) + Champ.lilaJ(spell.target) then
					DelayAction(function()
						CastTargetSpell(spell.target, useSmite)
					end, spell.windUpTime + Champ[GetObjectName(myHero)].extraDelay(spell.target)/1000)
				end
			end
		end
	end
else
	if GetRange(myHero) < 350 then
		if unit == myHero and spell.name:lower():find("attack") then
			if CanUseSpell(myHero,useSmite) == READY and smiteON == true then
				if GetObjectBaseName(spell.target) == "SRU_Dragon_Water6.3.1" and smiteMenu.dragon:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end				
				if GetObjectBaseName(spell.target) == "SRU_Dragon_Air6.1.1" and smiteMenu.dragon:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end				
				if GetObjectBaseName(spell.target) == "SRU_Dragon_Earth6.4.1" and smiteMenu.dragon:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end				
				if GetObjectBaseName(spell.target) == "SRU_Dragon_Fire6.2.1" and smiteMenu.dragon:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end				
				if GetObjectBaseName(spell.target) == "SRU_Dragon_Elder6.5.1" and smiteMenu.dragon:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end
				if GetObjectName(spell.target) == "SRU_RiftHerald" and smiteMenu.herald:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end
				if GetObjectName(spell.target) == "SRU_Red" and smiteMenu.red:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end
				if GetObjectName(spell.target) == "SRU_Blue" and smiteMenu.blue:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end
				if GetObjectName(spell.target) == "SRU_Baron" and smiteMenu.baron:Value() then
					if GetCurrentHP(spell.target) < smiteDMG + CalcDamage(myHero,spell.target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(spell.target) then
						DelayAction(function()
							CastTargetSpell(spell.target, useSmite)
						end, spell.windUpTime)
					end
				end
			end
		end
	end
end
end)

DelayAction(function()
OnTick(function(myHero)

smiteDMG = (({[1]=390,[2]=410,[3]=430,[4]=450,[5]=480,[6]=510,[7]=540,[8]=570,[9]=600,[10]=640,[11]=680,[12]=720,[13]=760,[14]=800,[15]=850,[16]=900,[17]=950,[18]=1000})[GetLevel(myHero)])

if smiteON == true then
	if GetCastName(myHero,useSmite) == "s5_summonersmiteplayerganker" and smiteMenu.ks:Value() then
		for i,enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, 750) and GetCurrentHP(enemy) + GetDmgShield(enemy) <= 20+8*GetLevel(myHero) then
				CastTargetSpell(enemy,useSmite)
			end
		end
	end
if Champ[GetObjectName(myHero)] ~= nil then
if CanUseSpell(myHero,useSmite) ~= READY then

--0-NoSmite v
if Champ[GetObjectName(myHero)][GetCastName(myHero,0)] ~= nil and CanUseSpell(myHero,0) == READY and CanUseSpell(myHero,useSmite) ~= READY and smiteMenu.useQ:Value() then

		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
			end
		end		
		if dragon ~= nil and GetObjectName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
			end
		end
		if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.red:Value() then
			if GetCurrentHP(red) - GetDamagePrediction(red,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(red)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(red) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(red)
			end
		end
		if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.blue:Value() then
			if GetCurrentHP(blue) - GetDamagePrediction(blue,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(blue)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(blue) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(blue)
			end
		end
		if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.herald:Value() then
			if GetCurrentHP(herald) - GetDamagePrediction(herald,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(herald)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(herald) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(herald)
			end
		end
		if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.baron:Value() then
			if GetCurrentHP(baron) - GetDamagePrediction(baron,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(baron)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(baron) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(baron)
			end
		end

end
--1-NoSmite v
if Champ[GetObjectName(myHero)][GetCastName(myHero,1)] ~= nil and CanUseSpell(myHero,1) == READY and CanUseSpell(myHero,useSmite) ~= READY and smiteMenu.useW:Value() then

		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
			end
		end
		if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.red:Value() then
			if GetCurrentHP(red) - GetDamagePrediction(red,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(red)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(red) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(red)
			end
		end
		if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.blue:Value() then
			if GetCurrentHP(blue) - GetDamagePrediction(blue,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(blue)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(blue) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(blue)
			end
		end
		if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.herald:Value() then
			if GetCurrentHP(herald) - GetDamagePrediction(herald,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(herald)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(herald) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(herald)
			end
		end
		if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.baron:Value() then
			if GetCurrentHP(baron) - GetDamagePrediction(baron,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(baron)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(baron) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(baron)
			end
		end

end
--2-NoSmite v
if Champ[GetObjectName(myHero)][GetCastName(myHero,2)] ~= nil and CanUseSpell(myHero,2) == READY and CanUseSpell(myHero,useSmite) ~= READY and smiteMenu.useE:Value() then

		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
			end
		end
		if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.red:Value() then
			if GetCurrentHP(red) - GetDamagePrediction(red,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(red)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(red) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(red)
			end
		end
		if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.blue:Value() then
			if GetCurrentHP(blue) - GetDamagePrediction(blue,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(blue)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(blue) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(blue)
			end
		end
		if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.herald:Value() then
			if GetCurrentHP(herald) - GetDamagePrediction(herald,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(herald)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(herald) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(herald)
			end
		end
		if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.baron:Value() then
			if GetCurrentHP(baron) - GetDamagePrediction(baron,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(baron)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(baron) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(baron)
			end
		end

end
--3-NoSmite v
if Champ[GetObjectName(myHero)][GetCastName(myHero,3)] ~= nil and CanUseSpell(myHero,3) == READY and CanUseSpell(myHero,useSmite) ~= READY and smiteMenu.useR:Value() then

		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
			end
		end
		if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.red:Value() then
			if GetCurrentHP(red) - GetDamagePrediction(red,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(red)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(red) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(red)
			end
		end
		if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.blue:Value() then
			if GetCurrentHP(blue) - GetDamagePrediction(blue,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(blue)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(blue) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(blue)
			end
		end
		if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.herald:Value() then
			if GetCurrentHP(herald) - GetDamagePrediction(herald,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(herald)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(herald) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(herald)
			end
		end
		if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.baron:Value() then
			if GetCurrentHP(baron) - GetDamagePrediction(baron,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(baron)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(baron) then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(baron)
			end
		end

end
	
end
--0-Smite v
if Champ[GetObjectName(myHero)][GetCastName(myHero,0)] ~= nil and CanUseSpell(myHero,0) == READY and CanUseSpell(myHero,useSmite) == READY and smiteMenu.useQ:Value() then

		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(dragon)/1000)
			end
		end
		if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.red:Value() then
			if GetCurrentHP(red) - GetDamagePrediction(red,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(red)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(red) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(red)
				DelayAction(function()
					CastTargetSpell(red,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(red)/1000)
			end
		end
		if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.blue:Value() then
			if GetCurrentHP(blue) - GetDamagePrediction(blue,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(blue)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(blue) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(blue)
				DelayAction(function()
					CastTargetSpell(blue,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(blue)/1000)
			end
		end
		if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.herald:Value() then
			if GetCurrentHP(herald) - GetDamagePrediction(herald,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(herald)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(herald) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(herald)
				DelayAction(function()
					CastTargetSpell(herald,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(herald)/1000)
			end
		end
		if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellRange0) and smiteMenu.baron:Value() then
			if GetCurrentHP(baron) - GetDamagePrediction(baron,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(baron)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDMG0(baron) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellCast0(baron)
				DelayAction(function()
					CastTargetSpell(baron,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,0)].spellDelay0(baron)/1000)
			end
		end

end
--1-Smite v
if Champ[GetObjectName(myHero)][GetCastName(myHero,1)] ~= nil and CanUseSpell(myHero,1) == READY and CanUseSpell(myHero,useSmite) == READY and smiteMenu.useW:Value() then

		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(dragon)/1000)
			end
		end
		if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.red:Value() then
			if GetCurrentHP(red) - GetDamagePrediction(red,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(red)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(red) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(red)
				DelayAction(function()
					CastTargetSpell(red,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(red)/1000)
			end
		end
		if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.blue:Value() then
			if GetCurrentHP(blue) - GetDamagePrediction(blue,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(blue)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(blue) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(blue)
				DelayAction(function()
					CastTargetSpell(blue,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(blue)/1000)
			end
		end
		if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.herald:Value() then
			if GetCurrentHP(herald) - GetDamagePrediction(herald,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(herald)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(herald) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(herald)
				DelayAction(function()
					CastTargetSpell(herald,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(herald)/1000)
			end
		end
		if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellRange1) and smiteMenu.baron:Value() then
			if GetCurrentHP(baron) - GetDamagePrediction(baron,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(baron)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDMG1(baron) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellCast1(baron)
				DelayAction(function()
					CastTargetSpell(baron,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,1)].spellDelay1(baron)/1000)
			end
		end

end
--2-Smite v
if Champ[GetObjectName(myHero)][GetCastName(myHero,2)] ~= nil and CanUseSpell(myHero,2) == READY and CanUseSpell(myHero,useSmite) == READY and smiteMenu.useE:Value() then

		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(dragon)/1000)
			end
		end
		if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.red:Value() then
			if GetCurrentHP(red) - GetDamagePrediction(red,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(red)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(red) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(red)
				DelayAction(function()
					CastTargetSpell(red,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(red)/1000)
			end
		end
		if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.blue:Value() then
			if GetCurrentHP(blue) - GetDamagePrediction(blue,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(blue)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(blue) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(blue)
				DelayAction(function()
					CastTargetSpell(blue,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(blue)/1000)
			end
		end
		if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.herald:Value() then
			if GetCurrentHP(herald) - GetDamagePrediction(herald,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(herald)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(herald) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(herald)
				DelayAction(function()
					CastTargetSpell(herald,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(herald)/1000)
			end
		end
		if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellRange2) and smiteMenu.baron:Value() then
			if GetCurrentHP(baron) - GetDamagePrediction(baron,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(baron)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDMG2(baron) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellCast2(baron)
				DelayAction(function()
					CastTargetSpell(baron,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,2)].spellDelay2(baron)/1000)
			end
		end

end
--3-Smite v
if Champ[GetObjectName(myHero)][GetCastName(myHero,3)] ~= nil and CanUseSpell(myHero,3) == READY and CanUseSpell(myHero,useSmite) == READY and smiteMenu.useR:Value() then

		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Water6.3.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Air6.1.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Earth6.4.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Fire6.2.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)/1000)
			end
		end		
		if dragon ~= nil and GetObjectBaseName(dragon) == "SRU_Dragon_Elder6.5.1" and ValidTarget(dragon, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.dragon:Value() then
			if GetCurrentHP(dragon) - GetDamagePrediction(dragon,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(dragon) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(dragon)
				DelayAction(function()
					CastTargetSpell(dragon,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(dragon)/1000)
			end
		end
		if red ~= nil and GetObjectName(red) == "SRU_Red" and ValidTarget(red, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.red:Value() then
			if GetCurrentHP(red) - GetDamagePrediction(red,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(red)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(red) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(red)
				DelayAction(function()
					CastTargetSpell(red,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(red)/1000)
			end
		end
		if blue ~= nil and GetObjectName(blue) == "SRU_Blue" and ValidTarget(blue, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.blue:Value() then
			if GetCurrentHP(blue) - GetDamagePrediction(blue,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(blue)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(blue) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(blue)
				DelayAction(function()
					CastTargetSpell(blue,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(blue)/1000)
			end
		end
		if herald ~= nil and GetObjectName(herald) == "SRU_RiftHerald" and ValidTarget(herald, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.herald:Value() then
			if GetCurrentHP(herald) - GetDamagePrediction(herald,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(herald)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(herald) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(herald)
				DelayAction(function()
					CastTargetSpell(herald,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(herald)/1000)
			end
		end
		if baron ~= nil and GetObjectName(baron) == "SRU_Baron" and ValidTarget(baron, Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellRange3) and smiteMenu.baron:Value() then
			if GetCurrentHP(baron) - GetDamagePrediction(baron,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(baron)) <= Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDMG3(baron) + smiteDMG then
				Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellCast3(baron)
				DelayAction(function()
					CastTargetSpell(baron,useSmite)
				end,Champ[GetObjectName(myHero)][GetCastName(myHero,3)].spellDelay3(baron)/1000)
			end
		end
	
end
end
end

end)
end,.010)


