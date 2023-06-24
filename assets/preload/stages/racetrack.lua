local xx = 600;
local yy = 400;
local xx2 = 678;
local yy2 = 500;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;

function onCreate()
	makeLuaSprite('sky', 'week1BG/Sky', -425, -650);
	setScrollFactor('sky', 0.2, 0.2);
	
	makeLuaSprite('bleachers_back', 'week1BG/Bleachers no rail', -170, -340);
	setScrollFactor('bleachers_back', 0.2, 0.2);
	scaleObject('bleachers_back', 0.6, 0.6)
	
	makeLuaSprite('bleachers_rail', 'week1BG/Banner Rail', -170, -340)
	setScrollFactor('bleachers_rail', 0.2, 0.2)
	scaleObject('bleachers_rail', 0.6, 0.6)
	
	makeLuaSprite('road', 'week1BG/Road', -425, -726)
	setScrollFactor('road', 0.2, 0.2)
	
	makeLuaSprite('bleachers_front', 'week1BG/Bleachers Front', -170, -340)
	setScrollFactor('bleachers_front', 0.2, 0.2)
	scaleObject('bleachers_front', 0.6, 0.6)
	
	makeLuaSprite('grass', 'week1BG/Grass', -425, -700)
	setScrollFactor('grass', 0.8, 0.8)


	if not lowQuality then
	makeAnimatedLuaSprite('upperBoppers', 'week1BG/Day Funkers Bop', -102, 140);
	setScrollFactor('upperBoppers', 0.2, 0.2);
	scaleObject('upperBoppers', 0.6, 0.6)
	addAnimationByPrefix('upperBoppers', 'bop', 'Day Funkers bop', 24, true);
	end
	
	if not lowQuality then
	makeAnimatedLuaSprite('CT', 'week1BG/CT Bop', 1200, 100);
	setScrollFactor('CT', 0.2, 0.2);
	scaleObject('CT', 0.6, 0.6)
	addAnimationByPrefix('CT', 'bop', 'CT bop', 24, true);
	end

	addLuaSprite('sky', false);
	addLuaSprite('bleachers_back', false);
	addLuaSprite('CT', false);
	addLuaSprite('upperBoppers', false);
	addLuaSprite('bleachers_front', false);
	addLuaSprite('bleachers_rail', false);
	addLuaSprite('road', false);
	addLuaSprite('grass', false);
	
end

	function onBeatHit()
	objectPlayAnimation('upperBoppers', 'bop', 'true');
	objectPlayAnimation('CT', 'bop', 'true');
	end
	
		function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
	    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
	function onEvent(name,value1,value2)
	if name == 'Play Animation' then 
		
		if value1 == '1' then
           yy2 = 400;
		end
		if value1 == '2' then
		xx = 400;
	end
	if value1 == '3' then
	xx = 600;
	end
	end
	end
	end