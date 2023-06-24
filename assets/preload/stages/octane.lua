
local xx = 600;
local yy = 500;
local xx2 = 700;
local yy2 = 500;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;


function onCreate()
	makeAnimatedLuaSprite('BG', 'octane/Octane BG', -250, -250);
    scaleObject('BG', 0.8, 0.8);
	addAnimationByPrefix('BG', 'idle', 'BG No Cheer', 24, true);
	objectPlayAnimation('BG', 'idle', 'true');

	addLuaSprite('BG', false);
	
	makeAnimatedLuaSprite('BGS', 'octane/Boost_Power', -250, -250);
    scaleObject('BGS', 1.665, 1.775);
	addAnimationByPrefix('BGS', 'idle', 'Boost BG', 12, true);
	objectPlayAnimation('BGS', 'idle', 'true');
	setProperty('BGS.alpha', 0)

	addLuaSprite('BGS', false);
	
	makeAnimatedLuaSprite('MLeg', 'octane/Merell Leg', 140, 570);
	addAnimationByPrefix('MLeg', 'idle', 'Leg Anim', 24, true);
	scaleObject('MLeg', 1.15, 1.15);
	objectPlayAnimation('MLeg', 'idle', 'true');

	addLuaSprite('MLeg', false);
	
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