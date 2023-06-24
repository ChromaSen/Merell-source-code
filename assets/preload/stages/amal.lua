
local xx = 600;
local yy = 500;
local xx2 = 700;
local yy2 = 500;
local ofs = 25;
local followchars = true;
local del = 0;
local del2 = 0;


function onCreate()
setProperty('gfGroup.visible', false);
	makeLuaSprite('sky', 'amalgam/Sky Night', -425, -650);
	setScrollFactor('sky', 0.2, 0.2);
	
	makeLuaSprite('bleachers_back', 'amalgam/Bleachers Amalgam', -170, -340);
	setScrollFactor('bleachers_back', 0.2, 0.2);
	scaleObject('bleachers_back', 0.6, 0.6)
	
	makeLuaSprite('nightlight', 'amalgam/Amalgam Overlay', -170, -200);
	setScrollFactor('nightlight', 0.2, 0.2);
	scaleObject('nightlight', 0.6, 0.6)
	
	makeLuaSprite('bleachers_rail', 'week2BG/Banner Rail Night', -170, -340)
	setScrollFactor('bleachers_rail', 0.2, 0.2)
	scaleObject('bleachers_rail', 0.6, 0.6)
	
	makeLuaSprite('road', 'week2BG/Road', -425, -726)
	setScrollFactor('road', 0.2, 0.2)
	
	makeLuaSprite('bleachers_front', 'week2BG/Bleachers Front', -170, -340)
	setScrollFactor('bleachers_front', 0.2, 0.2)
	scaleObject('bleachers_front', 0.6, 0.6)
	
	makeLuaSprite('grass', 'week2BG/Grass', -425, -700)
	setScrollFactor('grass', 0.8, 0.8)
	
	precacheImage('amalgam/Red_Pulse');
	makeAnimatedLuaSprite('thered', 'amalgam/Red_Pulse', 0, 0);
	addAnimationByPrefix('thered', 'idle', 'Red Pulsing', 24, false);
	setGraphicSize('thered', 1280, 720);
	objectPlayAnimation('thered', 'idle');
	setProperty('thered.alpha', '0');
	setObjectCamera('thered', 'other');


	addLuaSprite('sky', false);
	addLuaSprite('bleachers_back', false);
	addLuaSprite('bleachers_front', false);
	addLuaSprite('bleachers_rail', false);
	addLuaSprite('road', false);
	addLuaSprite('grass', false);
	addLuaSprite('nightlight', false);
	addLuaSprite('thered', true);
	
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
           ofs = 25;
		end
	end
    end
end