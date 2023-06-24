local allowCountdown = false
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
        startVideo('haywire');
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end

function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'PlayerMerell');
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'clickTickGameOverTheme');
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'CTcontinue');
end