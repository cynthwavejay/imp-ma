function create() {
    if (FlxG.save.data.windowTrack){
        window.title = "Track " + PlayState.SONG.meta.customValues.trackNum + " - " + PlayState.SONG.meta.displayName + " - " + PlayState.SONG.meta.customValues.composer;
    }
}

function onSongEnd() {
	if (FlxG.save.data.windowTrack){
	window.title = "Impostor! Mania"
	}
}

function onGameOver() {
	window.title = "Impostor! Mania - GAME OVER"
}