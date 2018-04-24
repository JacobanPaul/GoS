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
		if GetCurrentMana(myHero) <= 3  then
				if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
				end
		end
		--if GetCurrentMana(myHero) == 4 and GetDistance(target, myHero) >= 400 then
		--		if EPred.HitChance == 1 then
		--		CastSkillShot(_E, EPred.PredPos)
		--		end
		--end

		
		
	end
end
 

--function Auto()

--			if GetCurrentMana(myHero) == 4 then
		    
			
				
			
--					CastSpell(_Q)
				
---			end
--
--			if GetCurrentMana(myHero) == GetMaxMana(myHero) then
--				CastSpell(_Q)
--			end
		
	
--end
	


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
		
		
			if CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_W) == READY and GetCurrentMana(myHero) <= 3 and not QCast and not ECast then
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
				if CanUseSpell(myHero,_W) == READY  and CanUseSpell(myHero,_Q) ~= READY and GetCurrentMana(myHero) <= 3 then
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
