//coded by chloe ( some of it )
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;

var card:FlxSprite;
var songText:FlxText;
var composerText:FlxText;
var charterText:FlxText;

var timeBarBG:FlxSprite;
var timeBar:FlxBar;
var timeTxt:FlxText;

var dadColor = CoolUtil.getColorFromDynamic(dad.xml.get("color"));

function create(){
	//track credit thing
    if (FlxG.save.data.trackCredits){
        card = new FlxSprite(-400, 210);
        card.makeGraphic(375, 125, FlxColor.WHITE);
        card.cameras = [camHUD];
        card.alpha = 0.5;
        add(card);
    
        if (SONG.meta.name == "alibi"){
            songText = new FlxText(-300, 235, 400, "Track #" + PlayState.SONG.meta.customValues.trackNum + " - " +PlayState.SONG.meta.customValues.fakeName, 42);
        }else{
            songText = new FlxText(-300, 235, 400, "Track #" + PlayState.SONG.meta.customValues.trackNum + " - " +PlayState.SONG.meta.displayName, 42);
        }
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
		
		for (i in [card, songText, composerText, charterText]){
			i.color = dadColor;
		}
    
        //f1Text = new FlxText(150, 110, 400, 'Press F1', 32);
        //f1Text.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        //f1Text.cameras = [camHUD];
        //f1Text.angle = -90;
        //add(f1Text);
    }
	
	//timebar
    if (SONG.meta.name == "alibi"){
        timeTxt = new FlxText(42 + (FlxG.width / 2) - 585 , 20, 400, PlayState.SONG.meta.customValues.fakeName.toUpperCase(), 32);
    }else{
	timeTxt = new FlxText(42 + (FlxG.width / 2) - 585 , 20, 400, PlayState.SONG.meta.displayName.toUpperCase(), 32);
    }
    timeTxt.setFormat(Paths.font("vcr.ttf"), 14, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

    timeBarBG = new FlxSprite().loadGraphic(Paths.image('game/timeBar'));
    timeBarBG.antialiasing = false;
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y + (timeTxt.height / 4);

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    switch(SONG.meta.name){
        case "overtaken":
            timeBar.createFilledBar(0xffff0000,0xff29131e);
            timeTxt.color = 0xffff0000;
            timeBarBG.loadGraphic(Paths.image('game/reverseTimeBar'));
        default:
            timeBar.createFilledBar(0xFF2e412e,0xFF44d844);
    }
    timeBar.numDivisions = 1000;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
	
	timeTxt.x += 10;
    timeTxt.y += 5;

	add(timeBarBG);
	add(timeBar);
	add(timeTxt);
    


    for (i in [timeTxt, timeBarBG, timeBar]){
        i.alpha = 0;
        i.cameras = [camHUD];
    }
}

function postCreate(){
    if(SONG.meta.name == "overtaken"){
        songText.color = FlxColor.RED;
        composerText.color = FlxColor.RED;
        charterText.color = FlxColor.RED;
        for (i in [missesTxt, accuracyTxt, scoreTxt]){
            i.color = FlxColor.RED;
        }
    }else{
        songText.color = dadColor;
        composerText.color = dadColor;
        charterText.color = dadColor;
        for (i in [missesTxt, accuracyTxt, scoreTxt]){
            i.color = dadColor;
        }
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
	
	if (timeBar != null){
        for (e in [timeBar, timeBarBG, timeTxt]){
            FlxTween.tween(e, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
        }
    }
}

function update(elapsed){
    if (inst != null && timeBar != null && timeBar.max != inst.length) {
        timeBar.setRange(0, Math.max(1, inst.length));
    }
}