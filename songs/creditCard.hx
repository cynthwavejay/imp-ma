import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxAxes;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

var open = true;
var closed = false;

function create() {

    card = new FlxSprite(0, 210);
	card.makeGraphic(375, 125, FlxColor.GRAY);
    card.cameras = [camHUD];
    card.alpha = 0.75;
    add(card);

    songText = new FlxText(0, 235, 400, PlayState.SONG.meta.displayName, 42);
    songText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songText.cameras = [camHUD];
    add(songText);

    composerText = new FlxText(0, 275, 400, 'Composer: ' + PlayState.SONG.meta.customValues.composer, 32);
    composerText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    composerText.cameras = [camHUD];
    add(composerText);

    charterText = new FlxText(0, 300, 400, 'Composer: ' + PlayState.SONG.meta.customValues.charter, 32);
    charterText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    charterText.cameras = [camHUD];
    add(charterText);

    f1Text = new FlxText(150, 110, 400, 'Press F1', 32);
    f1Text.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    f1Text.cameras = [camHUD];
    f1Text.angle = -90;
    add(f1Text);
    

}

function update(elapsed) {

	if (FlxG.keys.justPressed.F1){
        if (open = true) {
            FlxTween.tween(card, {x: -350}, 1, {ease: FlxEase.expoOut});
            closed = false;
        }
        if (closed = false) {
            FlxTween.tween(card, {x: 0}, 1, {ease: FlxEase.expoOut});
            open = true;
        }
    }

}