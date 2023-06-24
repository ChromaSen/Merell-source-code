local allowCountdown = false
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
        startVideo('merell');
        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end

function onCreate()
        setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'merellGameOver');
        setPropertyFromClass('GameOverSubstate', 'endSoundName', 'merellContinue');

end