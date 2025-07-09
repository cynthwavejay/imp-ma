//a windw shit for the fakery


function stepHit(curStep){
    if (curStep = 1280){
        if (FlxG.save.data.windowTrack){
            window.title = "Track " + PlayState.SONG.meta.customValues.trackNum + " - " + PlayState.SONG.meta.displayName + " - " + PlayState.SONG.meta.customValues.composer;
        }
    }
}