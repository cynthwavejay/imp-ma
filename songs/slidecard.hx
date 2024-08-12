import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxTextBorderStyle;

function create(){
    if (FlxG.save.data.trackCredits){
        card = new FlxSprite(-400, 210);
        card.makeGraphic(375, 125, FlxColor.GRAY);
        card.cameras = [camHUD];
        card.alpha = 0.75;
        add(card);
    
        songText = new FlxText(-300, 235, 400, "Track #" + PlayState.SONG.meta.customValues.trackNum + " - " +PlayState.SONG.meta.displayName, 42);
        songText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        songText.cameras = [camHUD];
        add(songText);
    
        composerText = new FlxText(-200, 275, 400, 'Composer: ' + PlayState.SONG.meta.customValues.composer, 32);
        composerText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        composerText.cameras = [camHUD];
        add(composerText);
    
        charterText = new FlxText(-200, 300, 400, 'Charter: ' + PlayState.SONG.meta.customValues.charter, 32);
        charterText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        charterText.cameras = [camHUD];
        add(charterText);
    
        //f1Text = new FlxText(150, 110, 400, 'Press F1', 32);
        //f1Text.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        //f1Text.cameras = [camHUD];
        //f1Text.angle = -90;
        //add(f1Text);
    }
}

function onSongStart(){
    if (FlxG.save.data.trackCredits){
        FlxTween.tween(card, {x: 0}, 1.25, {ease: FlxEase.expoOut});
        FlxTween.tween(songText, {x: 0}, 1.5, {ease: FlxEase.expoOut});
        FlxTween.tween(composerText, {x: 0}, 1.75, {ease: FlxEase.expoOut});
        FlxTween.tween(charterText, {x: 0}, 2, {ease: FlxEase.expoOut});
        new FlxTimer().start(5,function(tmr:FlxTimer)
            {
                FlxTween.tween(songText, {x: -300}, 1.25, {ease: FlxEase.expoIn});
                FlxTween.tween(card, {x: -400}, 2, {ease: FlxEase.expoIn});
                FlxTween.tween(composerText, {x: -200}, 1.5, {ease: FlxEase.expoIn});
                FlxTween.tween(charterText, {x: -200}, 1.75, {ease: FlxEase.expoIn});
            });
    }
}