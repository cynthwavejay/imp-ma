//a windw shit for the fakery
function postCreate(){
    window.title = "Track " + PlayState.SONG.meta.customValues.trackNum + " - " + PlayState.SONG.meta.customValues.fakeName + " - " + PlayState.SONG.meta.customValues.composer;
}

function stepHit(curStep){
    if (curStep = 1280){
        if (FlxG.save.data.windowTrack){
            window.title = "Track " + PlayState.SONG.meta.customValues.trackNum + " - " + PlayState.SONG.meta.displayName + " - " + PlayState.SONG.meta.customValues.composer;
        }
    }
}

function onSongEnd() {
    FlxG.save.data.beatAlibi = true;
    FlxG.save.flush();
}