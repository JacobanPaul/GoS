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

-- SmiteGod

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
	["Aatrox"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["AatroxE"] = {
				spellSlot2 = 2, 
				spellName2 = "AatroxE", 
				spellRange2 = 650,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast2 = function(target) CastSkillShot(_E,GetOrigin(target)) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,35*GetCastLevel(myHero,_E)+40+GetBonusAP(myHero)*0.6 + GetBonusDmg(myHero)*0.6) end }
        },
    ["Amumu"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["BandageToss"] = {	
				spellSlot0 = 0, 
				spellName0 = "BandageToss", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast0 = function(target) CastSkillShot(_Q, GetOrigin(target)) end, 
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,50*GetCastLevel(myHero,_Q)+30+GetBonusAP(myHero)*0.75) end },
          
			["Tantrum"] = {		
				spellSlot2 = 2, 
				spellName2 = "Tantrum", 
				spellRange2 = 350,
				spellDelay2 = function(target) return 250 - GetLatency() end, 
				spellCast2 = function(target) CastSpell(_E) end, 
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,25*GetCastLevel(myHero,_E)+50 + GetBonusAP(myHero)*0.5) end }
        },
	["Chogath"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["FeralScream"] = {	
				spellSlot1 = 1, 
				spellName1 = "FeralScream", 
				spellRange1 = 700,
				spellDelay1 = function(target) return (GetDistance(myHero,target)/math.huge)*1000 + 500 - GetLatency() end, 
				spellCast1 = function(target) CastSkillShot(_W, GetOrigin(target)) end, 
				spellDMG1 = function(target) return CalcDamage(myHero,target,0,50*GetCastLevel(myHero,_W)+25 + GetBonusAP(myHero)*0.7) end },
          
			["Feast"] = {		
				spellSlot3 = 3, 
				spellName3 = "Feast", 
				spellRange3 = 250+GetHitBox(myHero),
				spellDelay3 = function(target) return 250 - GetLatency() end, 
				spellCast3 = function(target) CastTargetSpell(target,_R) end,
				spellDMG3 = function(target) return 1000 + GetBonusAP(myHero)*0.7 end }
        },
	["Ekko"] = 
        {
            aaDMG = function(target)
				if GetCastLevel(myHero,_W) > 0 then
					if GetCurrentHP(target)/GetMaxHP(target) < 0.3 then
						wDMG = (GetMaxHP(target) - GetCurrentHP(target))*0.05
						if wDMG > 150 then
							wDMG = 150
						end
					else
					wDMG = 0
					end
				else wDMG = 0
				end
				return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),wDMG) end,
			extraDelay = function(target) return 0 end,
			["EkkoQ"] = {	
				spellSlot0 = 0, 
				spellName0 = "EkkoQ", 
				spellRange0 = 700,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast0 = function(target) CastSkillShot(_Q, GetOrigin(target)) end, 
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,15*GetCastLevel(myHero,_Q)+45 + GetBonusAP(myHero)*0.1) end },
          
			["EkkoE"] = {		
				spellSlot2 = 2, 
				spellName2 = "EkkoE", 
				spellRange2 = 600+GetHitBox(myHero),
				spellDelay2 = function(target) return (325/2000)*1000 + 350 - GetLatency() end, 
				spellCast2 = function(target) CastSkillShot(_E,GetOrigin(target)) DelayAction(function() AttackUnit(target) end, (GetDistance(myHero,target)/2000)*1000 ) end,
				spellDMG2 = function(target) 
					if GetCastLevel(myHero,_W) > 0 then
						if GetCurrentHP(target)/GetMaxHP(target) < 0.3 then
							wDMG = (GetMaxHP(target) - GetCurrentHP(target))*0.05
							if wDMG > 150 then
								wDMG = 150
							end
						else
						wDMG = 0
						end
					else wDMG = 0
					end
					return CalcDamage(myHero,target,0,30*GetCastLevel(myHero,_E)+20 + GetBonusAP(myHero)*0.1 + wDMG) end }
        },
	["Elise"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) 
				if GetRange(myHero) < 500 then
					extraDelay = (GetDistance(myHero,target)/500)*1000
				else
					extraDelay = (GetDistance(myHero,target)/1600)*1000
				end
				return extraDelay end,
            ["EliseHumanQ"] = {
				spellSlot0 = 0, 
				spellName0 = "EliseHumanQ", 
				spellRange0 = 700,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) 
				-- It was late :c + Bronze
					if GetBonusAP(myHero) < 100 then
						extraP = 0
					elseif GetBonusAP(myHero) >= 100 and GetBonusAP(myHero) < 200 then
						extraP = 0.03
					elseif GetBonusAP(myHero) >= 200 and GetBonusAP(myHero) < 300 then
						extraP = 0.06
					elseif GetBonusAP(myHero) >= 300 and GetBonusAP(myHero) < 400 then
						extraP = 0.09
					elseif GetBonusAP(myHero) >= 400 and GetBonusAP(myHero) < 500 then
						extraP = 0.12
					elseif GetBonusAP(myHero) >= 500 and GetBonusAP(myHero) < 600 then
						extraP = 0.15
					elseif GetBonusAP(myHero) >= 600 and GetBonusAP(myHero) < 700 then
						extraP = 0.18
					elseif GetBonusAP(myHero) >= 700 and GetBonusAP(myHero) < 800 then
						extraP = 0.21
					elseif GetBonusAP(myHero) >= 800 and GetBonusAP(myHero) < 900 then
						extraP = 0.24
					end
					hQDMG = CalcDamage(myHero,target,0,35*GetCastLevel(myHero,_Q)+5+(GetCurrentHP(target)*(0.04+extraP)))
					if hQDMG > CalcDamage(myHero,target,0,60*GetCastLevel(myHero,_Q) + 55) then
						hQDMG = CalcDamage(myHero,target,0,60*GetCastLevel(myHero,_Q) + 55)
					end
					return hQDMG end },
			["EliseSpiderQCast"] = {
				spellSlot0 = 0, 
				spellName0 = "EliseSpiderQCast", 
				spellRange0 = 525,
				spellDelay0 = function(target) return ((GetDistance(myHero,target)-GetHitBox(target))/3000)*1000 + 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target)
				-- It was late :c + Bronze
					if GetBonusAP(myHero) < 100 then
						extraP = 0
					elseif GetBonusAP(myHero) >= 100 and GetBonusAP(myHero) < 200 then
						extraP = 0.03
					elseif GetBonusAP(myHero) >= 200 and GetBonusAP(myHero) < 300 then
						extraP = 0.06
					elseif GetBonusAP(myHero) >= 300 and GetBonusAP(myHero) < 400 then
						extraP = 0.09
					elseif GetBonusAP(myHero) >= 400 and GetBonusAP(myHero) < 500 then
						extraP = 0.12
					elseif GetBonusAP(myHero) >= 500 and GetBonusAP(myHero) < 600 then
						extraP = 0.15
					elseif GetBonusAP(myHero) >= 600 and GetBonusAP(myHero) < 700 then
						extraP = 0.18
					elseif GetBonusAP(myHero) >= 700 and GetBonusAP(myHero) < 800 then
						extraP = 0.21
					elseif GetBonusAP(myHero) >= 800 and GetBonusAP(myHero) < 900 then
						extraP = 0.24
					end
					sQDMG = CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_Q)+20+((GetMaxHP(target) - GetCurrentHP(target))*(0.08+extraP)))
					if sQDMG > CalcDamage(myHero,target,0,65*GetCastLevel(myHero,_Q)+70) then
						sQDMG = CalcDamage(myHero,target,0,65*GetCastLevel(myHero,_Q)+70)
					end
					return sQDMG end },
			["EliseHumanW"] = {
				spellSlot1 = 1, 
				spellName1 = "EliseHumanW", 
				spellRange1 = 600,
				spellDelay1 = function(target) return ((GetDistance(myHero,target)-GetHitBox(target))/1250)*1000 + 250 - GetLatency() end,
				spellCast1 = function(target) CastSkillShot(_W,GetOrigin(target)) end,
				spellDMG1 = function(target) return CalcDamage(myHero,target,0,50*GetCastLevel(myHero,_W)+25 + GetBonusAP(myHero)*0.8) end },
			["EliseSpiderW"] = {
				spellSlot1 = 1, 
				spellName1 = "EliseSpiderW", 
				spellRange1 = 300,
				spellDelay1 = function(target) return 200 - GetLatency() end,
				spellCast1 = function(target) CastSpell(_W) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG1 = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end }
        },
    ["DrMundo"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["InfectedCleaverMissileCast"] = {	
				spellSlot0 = 0, 
				spellName0 = "InfectedCleaverMissileCast", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 200 - GetLatency() end, 
				spellCast0 = function(target) CastSkillShot(_Q, GetOrigin(target)) end, 
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,GetCurrentHP(target)*(({[1]=0.15,[2]=0.18,[3]=0.21,[4]=0.23,[5]=0.25})[GetCastLevel(myHero,_Q)])) end },
          
			["Masochism"] = {		
				spellSlot2 = 2, 
				spellName2 = "Masochism", 
				spellRange2 = 300,
				spellDelay2 = function(target) return 260 - GetLatency() end, 
				spellCast2 = function(target) CastSpell(_E) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,GetMaxHP(myHero)*0.05 + (GetBaseDamage(myHero)+GetBonusDmg(myHero)+(15*GetCastLevel(myHero,_E)+25)),0) end }
        },
	["Diana"] = 
        {
			aaDMG = function(target) 
				if GotBuff(myHero,"dianaarcready") == 1 then
					pasDMG = CalcDamage(myHero,target,0,0.8*GetBonusAP(myHero) +(({[1]=20,[2]=25,[3]=30,[4]=35,[5]=40,[6]=50,[7]=60,[8]=70,[9]=80,[10]=90,[11]=105,[12]=120,[13]=135,[14]=155,[15]=175,[16]=200,[17]=225,[18]=250})[GetLevel(myHero)]))
				
				else
					pasDMG = 0
				end
				return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + pasDMG end,
			extraDelay = function(target) return 0 end,
            ["DianaArc"] = {	
				spellSlot0 = 0, 
				spellName0 = "DianaArc", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 200 - GetLatency() end, 
				spellCast0 = function(target) CastSkillShot(_Q, GetOrigin(target)) end, 
				spellDMG0 = function(target) return CalcDamage(myHero, target, 0, 35*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero)*0.7) end },
          
			["DianaOrbs"] = {		
				spellSlot1 = 1, 
				spellName1 = "DianaOrbs", 
				spellRange1 = 325,
				spellDelay1 = function(target) return 250 - GetLatency() end, 
				spellCast1 = function(target) CastSpell(_W) end,
				spellDMG1 = function(target) return CalcDamage(myHero, target, 0, 12*GetCastLevel(myHero,_W)+10+GetBonusAP(myHero)*0.2) end }
        },
	["Evelynn"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["EvelynnE"] = {
				spellSlot2 = 2, 
				spellName2 = "EvelynnE", 
				spellRange2 = 300,
				spellDelay2 = function(target) return 250 - GetLatency() end,
				spellCast2 = function(target) CastTargetSpell(target,_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,40*GetCastLevel(myHero,_E)+30 + GetBonusAP(myHero) + GetBonusDmg(myHero),0)/2 end }
        },
	["FiddleSticks"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return (GetDistance(myHero,target)/1750)*1000 end,
            ["FiddlesticksDarkWind"] = {
				spellSlot2 = 2, 
				spellName2 = "FiddlesticksDarkWind", 
				spellRange2 = 650,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/1000)*1000 + 250 - GetLatency() end, 
				spellCast2 = function(target) CastTargetSpell(target,_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,30*GetCastLevel(myHero,_E)+67.5+GetBonusAP(myHero)*0.675) end }
        },
	["Fizz"] = 
        {	
---------------------------
--------W-MAGIC-DMG--------
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["FizzPiercingStrike"] = {
				spellSlot0 = 0, 
				spellName0 = "FizzPiercingStrike", 
				spellRange0 = 600,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 200 - GetLatency() end, 
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),15*GetCastLevel(myHero,_Q)-5+GetBonusAP(myHero)*0.35) end }
        },
	["Hecarim"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["HecarimRapidSlash"] = {
				spellSlot0 = 0, 
				spellName0 = "HecarimRapidSlash", 
				spellRange0 = 375,
				spellDelay0 = function(target) return 50 - GetLatency() end, 
				spellCast0 = function(target) CastSpell(_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,35*GetCastLevel(myHero,_Q)+25+GetBonusDmg(myHero)*0.6,0) end }
        },
	["Irelia"] = 
        {	
----------------------------
---------W------------------
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["IreliaGatotsu"] = {
				spellSlot0 = 0, 
				spellName0 = "IreliaGatotsu", 
				spellRange0 = 700,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/3000)*1000 + 50 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,30*GetCastLevel(myHero,_Q)-10 + (GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end },
			["IreliaEquilibriumStrike"] = {
				spellSlot2 = 2, 
				spellName2 = "IreliaEquilibriumStrike", 
				spellRange2 = 350,
				spellDelay2 = function(target) return 500 - GetLatency() end,
				spellCast2 = function(target) CastTargetSpell(target,_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_E)+40+GetBonusAP(myHero)*0.5) end }
        },
	["JarvanIV"] = 
        {			
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["JarvanIVDragonStrike"] = {
				spellSlot0 = 0, 
				spellName0 = "JarvanIVDragonStrike", 
				spellRange0 = 700,
				spellDelay0 = function(target) return 500 - GetLatency() end,
				spellCast0 = function(target) CastSkillShot(_Q,GetOrigin(target)) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,45*GetCastLevel(myHero,_Q)+25 + GetBonusDmg(myHero)*1.2,0) end },
			["JarvanIVDemacianStandard"] = {
				spellSlot2 = 2, 
				spellName2 = "JarvanIVDemacianStandard", 
				spellRange2 = 700,
				spellDelay2 = function(target) return 250 - GetLatency() end,
				spellCast2 = function(target) CastSkillShot(_E,GetOrigin(target)) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,45*GetCastLevel(myHero,_E)+15+GetBonusAP(myHero)*0.8) end }
        },
	["Jax"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["JaxLeapStrike"] = {
				spellSlot0 = 0, 
				spellName0 = "JaxLeapStrike", 
				spellRange0 = 700,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2500)*1000 + 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,40*GetCastLevel(myHero,_Q)+30 + GetBonusAP(myHero)*0.6 + GetBonusDmg(myHero),0) end },
			["JaxEmpowerTwo"] = {
				spellSlot1 = 1, 
				spellName1 = "JaxEmpowerTwo", 
				spellRange1 = 300,
				spellDelay1 = function(target) return 250 - GetLatency() end,
				spellCast1 = function(target) CastSpell(_W) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG1 = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),25*GetCastLevel(myHero,_W)+15 + GetBonusAP(myHero)*0.6) end }
        },
	["LeeSin"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["BlindMonkQOne"] = {
				spellSlot0 = 0, 
				spellName0 = "BlindMonkQOne",
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end,
				spellCast0 = function(target) CastSkillShot(_Q,GetOrigin(target)) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,30*GetCastLevel(myHero,_Q)+20+GetBonusDmg(myHero)*0.9,0) end },
            ["blindmonkqtwo"] = {
				spellSlot0 = 0, 
				spellName0 = "blindmonkqtwo", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/3000)*1000 + 50 - GetLatency() end,
				spellCast0 = function(target) CastSpell(_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,30*GetCastLevel(myHero,_Q)+20+GetBonusDmg(myHero)*0.9 + (GetMaxHP(target) - GetCurrentHP(target))*0.08,0) end },
			["BlindMonkEOne"] = {
				spellSlot2 = 2, 
				spellName2 = "BlindMonkEOne", 
				spellRange2 = 350,
				spellDelay2 = function(target) return 250 - GetLatency() end,
				spellCast2 = function(target) CastSpell(_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,35*GetCastLevel(myHero,_E)+25 + GetBonusDmg(myHero)) end }
        },
	["Malphite"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["SeismicShard"] = {
				spellSlot0 = 0, 
				spellName0 = "SeismicShard",
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/1000)*1000 + 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,50*GetCastLevel(myHero,_Q)+20+GetBonusAP(myHero)*0.6) end },
			["Landslide"] = {
				spellSlot2 = 2, 
				spellName2 = "Landslide", 
				spellRange2 = 350,
				spellDelay2 = function(target) return 250 - GetLatency() end,
				spellCast2 = function(target) CastSpell(_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_E)+20 + GetBonusAP(myHero)*0.2 + GetArmor(myHero)*0.3) end }
        },
	["Kayle"] = 
        {	
			aaDMG = function(target) 
				if GetCastLevel(myHero,_E) > 0 then
					if GotBuff(myHero,"JudicatorRighteousFury") == 0 then
						eBonus = CalcDamage(myHero,target,0,5*GetCastLevel(myHero,_E)+5+GetBonusAP(myHero)*0.15)
					elseif GotBuff(myHero,"JudicatorRighteousFury") == 1 then
						eBonus = CalcDamage(myHero,target,0,10*GetCastLevel(myHero,_E)+10+GetBonusAP(myHero)*0.3)
					end
				end
				return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + eBonus end,
			extraDelay = function(target) return 0 end,
            ["JudicatorReckoning"] = {
				spellSlot0 = 0, 
				spellName0 = "JudicatorReckoning", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/1000)*1000 + 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,50*GetCastLevel(myHero,_Q)+10 + GetBonusAP(myHero)*0.6 + GetBonusDmg(myHero)) end }
        },
	["Nasus"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["NasusQ"] = {
				spellSlot0 = 0, 
				spellName0 = "NasusQ", 
				spellRange0 = 250+GetHitBox(myHero),
				spellDelay0 = function(target) return 260 - GetLatency() end,
				spellCast0 = function(target) CastSpell(_Q) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG0 = function(target) local qStacks = GetBuffData(myHero,"nasusqstacks") return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero))+20*GetCastLevel(myHero,_Q)+10+qStacks.Stacks,0) end },
			["NasusE"] = {
				spellSlot2 = 2, 
				spellName2 = "NasusE", 
				spellRange2 = 650,
				spellDelay2 = function(target) return 250 - GetLatency() end,
				spellCast2 = function(target) CastSkillShot(_E,GetOrigin(target)) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_E)+15+GetBonusAP(myHero)*0.60) end }
        },
    ["Nunu"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["Consume"] = {
				spellSlot0 = 0, 
				spellName0 = "Consume",
				spellRange0 = 250,
				spellDelay0 = function(target) return 200 - GetLatency() end, 
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) return 150*GetCastLevel(myHero,_Q)+250 end },
				
            ["IceBlast"] = {
				spellSlot2 = 2, 
				spellName2 = "IceBlast", 
				spellRange2 = 650,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/1000)*1000 + 250 - GetLatency() end,
				spellCast2 = function(target) CastTargetSpell(target,_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,55*GetCastLevel(myHero,_E)+30 + GetBonusAP(myHero)) end }
        },
	["Nidalee"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) 
				if GetRange(myHero) < 400 then
					extraDelay = (GetDistance(myHero,target)/math.huge)*1000
				else
					extraDelay = (GetDistance(myHero,target)/1750)*1000
				end
				return extraDelay end,
            ["JavelinToss"] = {
				spellSlot0 = 0, 
				spellName0 = "JavelinToss", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/1800)*1000 + 250 - GetLatency() end, 
				spellCast0 = function(target) CastSkillShot(_Q,GetOrigin(target)) end, 
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,25*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero)*0.4) end },
			["Takedown"] = {
				spellSlot0 = 0, 
				spellName0 = "Takedown", 
				spellRange0 = 350,
				spellDelay0 = function(target) return 220 - GetLatency() end, 
				spellCast0 = function(target) CastSpell(_Q) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG0 = function(target)  
					local calc = (1-(GetCurrentHP(target)/GetMaxHP(target)))*2.5
					if calc >= 1.5 then
						calc = 1.5
					end
				return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_R)-30+(GetBaseDamage(myHero)+GetBonusDmg(myHero))*0.75 +GetBonusAP(myHero)*0.36)*calc end },
			["Swipe"] = {
				spellSlot2 = 2, 
				spellName2 = "Swipe", 
				spellRange2 = 400,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/math.huge)*1000 + 250 - GetLatency() end, 
				spellCast2 = function(target) CastSkillShot(_E,GetOrigin(target)) end, 
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_R)+30+GetBonusAP(myHero)*0.45) end },
        },
    ["Nocturne"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["NocturneDuskbringer"] = {
				spellSlot0 = 0, 
				spellName0 = "NocturneDuskbringere", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast0 = function(target) CastSkillShot(_Q,GetOrigin(target)) end, 
				spellDMG0 = function(target) return CalcDamage(myHero,target,45*GetCastLevel(myHero,_Q)+15+GetBonusDmg(myHero)*0.75,0) end },
        },
	["Olaf"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["OlafAxeThrowCast"] = {
				spellSlot0 = 0, 
				spellName0 = "OlafAxeThrowCast", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/1500)*1000 + 250 - GetLatency() end, 
				spellCast0 = function(target) CastSkillShot(_Q,GetOrigin(target)) end, 
				spellDMG0 = function(target) return CalcDamage(myHero,target,45*GetCastLevel(myHero,_Q)+25+GetBonusDmg(myHero),0) end },
            ["OlafRecklessStrike"] = {
				spellSlot2 = 2, 
				spellName2 = "OlafRecklessStrike", 
				spellRange2 = 650,
				spellDelay2 = function(target) return 250 - GetLatency() end, 
				spellCast2 = function(target) CastTargetSpell(target,_E) end, 
				spellDMG2 = function(target) return 45*GetCastLevel(myHero,_E)+25+GetBonusDmg(myHero)*0.4 end },
        },
	["Shaco"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["TwoShivPoison"] = {
				spellSlot2 = 2, 
				spellName2 = "TwoShivPoison", 
				spellRange2 = 700,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/1500)*1000 + 250 - GetLatency() end,
				spellCast2 = function(target) CastTargetSpell(target,_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_E)+10 + GetBonusDmg(myHero) + GetBonusAP(myHero)) end },
        },
	["Shen"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["ShenVorpalStar"] = {
				spellSlot0 = 0, 
				spellName0 = "ShenVorpalStar", 
				spellRange0 = 600,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/1500)*1000 + 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_Q)+20 + GetBonusAP(myHero)*0.6) end },
        },
	["Shyvana"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["ShyvanaDoubleAttack"] = {
				spellSlot0 = 0, 
				spellName0 = "ShyvanaDoubleAttack", 
				spellRange0 = 300,
				spellDelay0 = function(target) return 260 - GetLatency() end, 
				spellCast0 = function(target) CastSpell(_Q) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)) + (GetBaseDamage(myHero)+GetBonusDmg(myHero))*(0.05*GetCastLevel(myHero,_Q)+0.75),0) end },
            ["ShyvanaFireball"] = {
				spellSlot2 = 2, 
				spellName2 = "ShyvanaFireball", 
				spellRange2 = 650,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/1500)*1000 + 250 - GetLatency() end, 
				spellCast2 = function(target) CastSkillShot(_E,GetOrigin(target)) end, 
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_E)+20+GetBonusAP(myHero)*0.6) end },
        },
	["Skarner"] = 
        {			
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["SkarnerVirulentSlash"] = {
				spellSlot0 = 0, 
				spellName0 = "SkarnerVirulentSlash", 
				spellRange0 = 375,
				spellDelay0 = function(target) return 250 - GetLatency() end,
				spellCast0 = function(target) CastSpell(_Q) end,
				spellDMG0 = function(target) 
					if GotBuff(myHero,"SkarnerVirulentSlash") == 1 then
						qExtraDMG = CalcDamage(myHero,target,0,(GetBaseDamage(myHero)+GetBonusDmg(myHero))*(0.02*GetCastLevel(myHero,_Q)+0.3)+GetBonusAP(myHero)*0.3)
					else
						qExtraDMG = 0
					end
					return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero))*(0.03*GetCastLevel(myHero,_Q)+0.3),0) + qExtraDMG end },
        },
	["Trundle"] = 
        {	
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["TrundleTrollSmash"] = {
				spellSlot0 = 0, 
				spellName0 = "TrundleTrollSmash", 
				spellRange0 = 325,
				spellDelay0 = function(target) return 260 - GetLatency() end,
				spellCast0 = function(target) CastSpell(_Q) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,20*GetCastLevel(myHero,_Q)+(GetBaseDamage(myHero)+GetBonusDmg(myHero))*(0.05*GetCastLevel(myHero,_Q)+0.95),0) end },
        },
	["Pantheon"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["PantheonQ"] = {
				spellSlot0 = 0, 
				spellName0 = "PantheonQ", 
				spellRange0 = 650,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/1000)*1000 + 250 - GetLatency() end,  
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) 
					if GetCastLevel(myHero,_E) > 0 then
						if 100*GetCurrentHP(target)/GetMaxHP(target) < 15 then
							crit = 2
						else
							crit = 1
						end
					else
						crit = 1
					end
					PrintChat(CalcDamage(myHero,target,(40*GetCastLevel(myHero,_Q)+25+GetBonusDmg(myHero)*1.4)*crit,0))
					return CalcDamage(myHero,target,(40*GetCastLevel(myHero,_Q)+25+GetBonusDmg(myHero)*1.4)*crit,0) end },
			["PantheonW"] = {
				spellSlot1 = 1, 
				spellName1 = "PantheonW", 
				spellRange1 = 650,
				spellDelay1 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast1 = function(target) CastTargetSpell(target,_W) end,
				spellDMG1 = function(target) return CalcDamage(myHero,target,0,25*GetCastLevel(myHero,_W)+25+GetBonusAP(myHero)) end },
        },
	["Poppy"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["PoppyQ"] = {
				spellSlot0 = 0, 
				spellName0 = "PoppyQ", 
				spellRange0 = 400,
				spellDelay0 = function(target) return 333 - GetLatency() end, 
				spellCast0 = function(target) CastSkillShot(0,GetOrigin(target)) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,28*GetCastLevel(myHero,0)-4+GetMaxHP(target)*0.045,0) end },
            ["PoppyE"] = {
				spellSlot2 = 2, 
				spellName2 = "PoppyE", 
				spellRange2 = 550,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast2 = function(target) CastTargetSpell(target,_E) end, 
				spellDMG2 = function(target) return CalcDamage(myHero,target,20*GetCastLevel(myHero,2)+30+GetBonusDmg(myHero)*0.5,0) end },
        },
	["Renekton"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["RenektonCleave"] = {
				spellSlot0 = 0, 
				spellName0 = "RenektonCleave", 
				spellRange0 = 350,
				spellDelay0 = function(target) return 250 - GetLatency() end, 
				spellCast0 = function(target) CastSpell(_Q) end,
				spellDMG0 = function(target) 
					if GetCurrentMana(myHero) > 49 then
						bonusDMG = 1.5
					else
						bonusDMG = 1
					end
					return CalcDamage(myHero,target,30*GetCastLevel(myHero,_Q)+30+GetBonusDmg(myHero)*0.8,0)*bonusDMG end },
            ["RenektonPreExecute"] = {
				spellSlot1 = 1, 
				spellName1 = "RenektonPreExecute", 
				spellRange1 = 350,
				spellDelay1 = function(target) return 260 - GetLatency() end, 
				spellCast1 = function(target) CastSpell(_W) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG1 = function(target) 
					if GetCurrentMana(myHero) > 49 then
						wDMG = CalcDamage(myHero,target,30*GetCastLevel(myHero,_W)-15+(GetBaseDamage(myHero)+GetBonusDmg(myHero))*2.25,0)
					else
						wDMG = CalcDamage(myHero,target,20*GetCastLevel(myHero,_W)-10+(GetBaseDamage(myHero)+GetBonusDmg(myHero))*1.5,0)
					end
					return wDMG end },
        },
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
	["Khazix"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["KhazixQ"] = {
				spellSlot0 = 0, 
				spellName0 = "KhazixQ", 
				spellRange0 = 350,
				spellDelay0 = function(target) return 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) 
					local tc = EnemiesAround(GetOrigin(target), 450)
					local mc = CountObjectsNearPos(GetOrigin(target), 450, 450, minionManager.objects, JUNGLE)
					local extrac = tc + mc
					if extrac > 1 then
						iso = 1
					elseif extrac == 1 then
						iso = 1.3
					end
					return CalcDamage(myHero,target,25*GetCastLevel(myHero,_Q)+45 + GetBonusDmg(myHero)*1.2,0)*iso end },
			["khazixqlong"] = {
				spellSlot0 = 0, 
				spellName0 = "khazixqlong", 
				spellRange0 = 400,
				spellDelay0 = function(target) return 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) 
					local tc = EnemiesAround(GetOrigin(target), 450)
					local mc = CountObjectsNearPos(GetOrigin(target), 450, 450, minionManager.objects, JUNGLE)
					local extrac = tc + mc
					if extrac > 1 then
						iso = 0.8
						qDMG = CalcDamage(myHero,target,30*GetCastLevel(myHero,_Q)+55 + GetBonusDmg(myHero)*1.50,0)*iso
					elseif extrac == 1 then
						iso = 1.3
						qDMG = CalcDamage(myHero,target,30*GetCastLevel(myHero,_Q)+55 + GetBonusDmg(myHero)*1.50 + GetBonusDmg(myHero),0)*iso
					end
					return qDMG end },
        },
	["MasterYi"] = 
        {
			aaDMG = function(target) 
				if GotBuff(myHero,"wujustylesuperchargedvisual") == 1 then
					trueDMG = (5*GetCastLevel(myHero,_E)+5+(GetBaseDamage(myHero)+GetBonusDmg(myHero))*(0.025*GetCastLevel(myHero,_E)+0.075))
				else
					trueDMG = 0
				end
				PrintChat(trueDMG)
				return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + trueDMG end,
			extraDelay = function(target) return 0 end,
            ["AlphaStrike"] = {
				spellSlot0 = 0, 
				spellName0 = "AlphaStrike", 
				spellRange0 = 650,
				spellDelay0 = function(target) 
					local tc = EnemiesAround(GetOrigin(target), 500)
					local mc = CountObjectsNearPos(GetOrigin(target), 650, 650, minionManager.objects, JUNGLE)
					local extrac = tc + mc
					if extrac >= 4 then
						extrac = 4
					end
					return ((GetDistance(myHero,target)/2000)*extrac)*1000 + 250*extrac - GetLatency() end, 
				spellCast0 = function(target) CastTargetSpell(target,_Q) end, 
				spellDMG0 = function(target) return CalcDamage(myHero,target,60*GetCastLevel(myHero,_Q)+40+GetBonusDmg(myHero),0) end },
            -- ["Meditate"] = {
				-- spellSlot1 = 1, 
				-- spellName1 = "Meditate", 
				-- spellRange1 = 250,
				-- spellDelay1 = function(target) return 450 - GetLatency() end, 
				-- spellCast1 = function(target) CastSpell(_W) DelayAction(function() MoveToXYZ(GetOrigin(myHero)) end, 5) DelayAction(function() AttackUnit(target) end, 10) end,
				-- spellDMG1 = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) + Champ.lilaJ(target) end },
        },
	["Maokai"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["MaokaiTrunkLine"] = {
				spellSlot0 = 0, 
				spellName0 = "MaokaiTrunkLine", 
				spellRange0 = 600,
				spellDelay0 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 370 - GetLatency() end,
				spellCast0 = function(target) CastSkillShot(_Q,GetOrigin(target)) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,45*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero)*0.4) end },
			["MaokaiUnstableGrowth"] = {
				spellSlot1 = 1, 
				spellName1 = "MaokaiUnstableGrowth", 
				spellRange1 = 625,
				spellDelay1 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast1 = function(target) CastTargetSpell(target,_W) end,
				spellDMG1 = function(target) 
					wDMG = CalcDamage(myHero,target,0,GetMaxHP(target)*(0.008*GetCastLevel(myHero,_Q)+0.075))
					if wDMG > CalcDamage(myHero,target,0,230) then
						wDMG = CalcDamage(myHero,target,0,230)
					end
					return wDMG end },
        },
	["MonkeyKing"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["MonkeyKingDoubleAttack"] = {
				spellSlot0 = 0, 
				spellName0 = "MonkeyKingDoubleAttack", 
				spellRange0 = 350,
				spellDelay0 = function(target) return 260 - GetLatency() end, 
				spellCast0 = function(target) CastSpell(_Q) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)) + 30*GetCastLevel(myHero,_Q)+(GetBaseDamage(myHero)+GetBonusDmg(myHero))*0.1,0) end },
			["MonkeyKingNimbus"] = {
				spellSlot2 = 2, 
				spellName2 = "MonkeyKingNimbus", 
				spellRange2 = 650,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast2 = function(target) CastTargetSpell(target,_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,45*GetCastLevel(myHero,_E)+15+GetBonusDmg(myHero)*0.8,0) end },
        },
	["Volibear"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["VolibearW"] = {
				spellSlot1 = 1, 
				spellName1 = "VolibearW", 
				spellRange1 = 450,
				spellDelay1 = function(target) return 250 - GetLatency() end,
				spellCast1 = function(target) CastTargetSpell(target,_W) end,
				spellDMG1 = function(target) return CalcDamage(myHero,target,(45*GetCastLevel(myHero,_W)+35)*(1+0.01*(100-(100*GetCurrentHP(target)/GetMaxHP(target)))),0) end },
			["VolibearE"] = {
				spellSlot2 = 0, 
				spellName2 = "VolibearE", 
				spellRange2 = 450,
				spellDelay2 = function(target) return 250 - GetLatency() end,
				spellCast2 = function(target) CastSpell(_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,45*GetCastLevel(myHero,_E)+15 + GetBonusAP(myHero)*0.6) end },
        },
	["Vi"] = 
        {
--------------------
---------w----------
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["ViE"] = {
				spellSlot2 = 2, 
				spellName2 = "ViE", 
				spellRange2 = 300,
				spellDelay2 = function(target) return 260 - GetLatency() end,
				spellCast2 = function(target) CastSpell(_E) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG2 = function(target) 
					if GotBuff(target,"viwproc") == 2 then
						wDMG = CalcDamage(myHero,target,GetMaxHP(target)*(0.015*GetCastLevel(myHero,_W)+0.025),0)
						if wDMG > CalcDamage(myHero,target,300,0) then
							wDMG = CalcDamage(myHero,target,300,0)
						end
					else
						wDMG = 0
					end
					return CalcDamage(myHero,target,15*GetCastLevel(myHero,_E)-10+(GetBaseDamage(myHero)+GetBonusDmg(myHero))*1.15+GetBonusAP(myHero)*0.7,0) + wDMG end }
        },
    ["Warwick"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["HungeringStrike"] = {
				spellSlot0 = 0, 
				spellName0 = "HungeringStrike", 
				spellRange0 = 400,
				spellDelay0 = function(target) return 250 - GetLatency() end,
				spellCast0 = function(target) CastTargetSpell(target,_Q) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,50*GetCastLevel(myHero,_Q)+25 + GetBonusAP(myHero)) end }
        },
	["XinZhao"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["XenZhaoComboTarget"] = {
				spellSlot0 = 0, 
				spellName0 = "XenZhaoComboTarget", 
				spellRange0 = 300,
				spellDelay0 = function(target) return 200 - GetLatency() end,
				spellCast0 = function(target) CastSpell(_Q) DelayAction(function() AttackUnit(target) end, 10) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero))+(15*GetCastLevel(myHero,_Q)+(GetBaseDamage(myHero)+GetBonusDmg(myHero))*0.2),0) end },
			["XenZhaoSweep"] = {
				spellSlot2 = 2, 
				spellName2 = "XenZhaoSweep", 
				spellRange2 = 650,
				spellDelay2 = function(target) return (GetDistance(myHero,target)/2000)*1000 + 250 - GetLatency() end, 
				spellCast2 = function(target) CastTargetSpell(target,_E) end,
				spellDMG2 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_Q)+30 + GetBonusAP(myHero)*0.6) end },
        },
	["Zac"] = 
        {
			aaDMG = function(target) return CalcDamage(myHero,target,(GetBaseDamage(myHero)+GetBonusDmg(myHero)),0) end,
			extraDelay = function(target) return 0 end,
            ["ZacQ"] = {
				spellSlot0 = 0, 
				spellName0 = "ZacQ", 
				spellRange0 = 550,
				spellDelay0 = function(target) return 250 - GetLatency() end,
				spellCast0 = function(target) CastSkillShot(_Q,GetOrigin(target)) end,
				spellDMG0 = function(target) return CalcDamage(myHero,target,0,40*GetCastLevel(myHero,_Q)+30 + GetBonusAP(myHero)*0.5) end },
			["ZacW"] = {
				spellSlot1 = 1, 
				spellName1 = "ZacW", 
				spellRange1 = 350,
				spellDelay1 = function(target) return 100 - GetLatency() end, 
				spellCast1 = function(target) CastSpell(_W) end,
				spellDMG1 = function(target) 
					wDMG = CalcDamage(myHero,target,0,(GetMaxHP(target)*(0.03*GetCastLevel(myHero,_W)+0.01)))
					if wDMG > 180 then
						wDMG = CalcDamage(myHero,target,0,180)
					end
					return wDMG end },
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


