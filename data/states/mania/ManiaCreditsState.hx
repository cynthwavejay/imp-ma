// imports
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxTypedGroup;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;
import flixel.text.FlxTextBorderStyle;
import flixel.math.FlxMath;
import funkin.menus.MainMenuState;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import funkin.backend.scripting.Script;
import lime.app.Application;
import openfl.ui.Mouse;
import flixel.util.FlxAxes;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;


// unreasonably complicated and could be way simpler code LMAOOOO
// gonna figure out how to make this use JSONs instead of a fucking array at some point

var credSel:Int = 0
var creditsStuff:Array<Dynamic> = [ // Name goes here - Sprite file goes here - Description goes here - Role? i think - X and Y offsets here respectively :3
    ['JayLmao', 'FlxColor.RED', 'i got a glock in my rari', 'the hit band one direction', '100', '100']
];

function create(){
    
    var TEMPORARY = new FlxSprite();
    TEMPORARY.loadGraphic("images/menus/main/background.png");
    add(TEMPORARY);

    mouseMania = new FlxSprite(0, 0);
	mouseMania.frames = Paths.getSparrowAtlas('ui/mouse');
	mouseMania.animation.addByPrefix('basic', 'mouseBasic', 30, false);
	mouseMania.scale.set(0.35, 0.35);
	add(mouseMania);

    creditsStuff[credSel][0] = new FlxSprite();
    creditsStuff[credSel][0].makeGraphic(100, 100);
    creditsStuff[credSel][0].x = item[4];
    creditsStuff[credSel][0].y = item[5];
    add(var creditsStuff[credSel][0]);

    
}

function update(){

    mouseMania.x = FlxG.mouse.x - 35;
	mouseMania.y = FlxG.mouse.y - 35;

}