function update(elapsed:Float) {
    if (PlayState.SONG.meta.displayName != "Alibi") {
        return;
    }

    if (curStep < 1280) {
        levelInfo.text = PlayState.SONG.meta.customValues.fakeName;
        return;
    }

    levelInfo.text = PlayState.SONG.meta.displayName;
    
}