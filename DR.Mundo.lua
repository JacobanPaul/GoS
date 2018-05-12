require('Inspired')
require('IPrediction')


function Mode()
	if _G.IOW_Loaded and IOW:Mode() then
		return IOW:Mode()
	elseif GoSWalkLoaded and GoSWalk.CurrentMode then
		return ({"Combo", "Harass", "LaneClear", "LastHit"})[GoSWalk.CurrentMode+1]
	end
end







OnTick(function(myHero)
	target = GetCurrentTarget()
--	Ferocity = GetCurrentMana(myHero)
	Items1()
	Items2()
	LevelUp()
	
end)



OnDraw(function(myHero)
	for _, enemy in pairs(GetEnemyHeroes()) do
		
			if GetCastName(enemy,SUMMONER_1):lower():find("smite") and SUMMONER_1 or (GetCastName(enemy,SUMMONER_2):lower():find("smite") and SUMMONER_2 or nil) then
				DrawJng = WorldToScreen(1,GetOrigin(myHero).x, GetOrigin(myHero).y, GetOrigin(myHero).z)
				if IsObjectAlive(enemy) then
					if ValidTarget(enemy) then
						if GetDistance(myHero, enemy) > 3000 then
							DrawText("Jungler: Visible", 17, DrawJng.x-45, DrawJng.y+10, 0xff32cd32)
						else
							DrawText("Jungler: Near", 17, DrawJng.x-43, DrawJng.y+10, 0xffff0000)
						end
					else
						DrawText("Jungler: Invisible", 17, DrawJng.x-55, DrawJng.y+10, 0xffffd700)
					end
				else
					DrawText("Jungler: Dead", 17, DrawJng.x-45, DrawJng.y+10, 0xff32cd32)
				end
			end
		
		
	end
end)




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
	
		
		if "DrMundo" == GetObjectName(myHero)  then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		
		end
	
	end  

-- Im The jungler







if "DrMundo" == GetObjectName(myHero) then
	PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>GoS-U<font color='#1E90FF'>] <font color='#00BFFF'>DrMundo loaded successfully!")

	local DrMundoQ = { range = 975, radius = 60, width = 60, speed = 2000, delay = 0.25, type = "line", collision = true, source = myHero, col = {"minion","yasuowall"}}
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
 DrawCircle(pos,DrMundoq.range,1,25,0xff4169e1)

 end





 function useE(target)
	CastSpell(_E)
 
 end

 function useW(target)
	
        CastSpell(_W)
    
	
end


function useQ(target)
	if GetDistance(target) < DrMundoQ.range then
	local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),DrMundoQ.speed,DrMundoQ.delay*1000,DrMundoQ.range,DrMundoQ.width,true,false)
		
				if EPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
				end
	end
end


 function Combo()
	if Mode() == "Combo" then	
			if CanUseSpell(myHero,_E) == READY  then
				if ValidTarget(target, GetRange(myHero)+GetHitBox(myHero)+100) then
					
						useE(target)
				end
			end

			if CanUseSpell(myHero,_Q) == READY   then
				if ValidTarget(target, DrMundoQ.range) then
					useQ(target)
					
				
				end
		
		    end
		
		
			if CanUseSpell(myHero,_W) == READY  then
				if ValidTarget(target,GetHitBox(myHero)+150) then
					useW(target)
				
				end
			end


		if GetItemSlot(myHero, 3142) >= 1 and ValidTarget(target, 1000) then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3142)) == READY then
						CastSpell(GetItemSlot(myHero, 3142))
					end
				end
		
			

			

	end
 end

 function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				
				if CanUseSpell(myHero,_Q) == READY then  
					if ValidTarget(mob, 900) then
						
							CastSkillShot(_Q,GetOrigin(mob)) 
						
					end
				end


				if  CanUseSpell(myHero,_W) == READY  then 
					if ValidTarget(mob, GetHitBox(myHero)+150) then
					
						
						
							useW(mob)
						
						
					end
				end
				
				if CanUseSpell(myHero,_E) == READY then
				     if ValidTarget(mob, 200) then
							 
							useE(mob)
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

				if CanUseSpell(myHero,_E) == READY  then
					if ValidTarget(minion, 200) then
							   
							useE(minion)
				    end
			    end

				
				if CanUseSpell(myHero,_W) == READY  then
					if ValidTarget(minion, 200) then
							useW(minion)
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


