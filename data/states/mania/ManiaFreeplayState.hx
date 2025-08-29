// idk if chloe will see this but if she does, hi chloe!!!!

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

var codenameVersion = Application.current.meta.get('version');

var optionShit:Array<String> = ['Red','Green','Alibi','Black'];
var menuItems:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();

var camZoom:FlxTween;

var confirm:FlxSound;
var cancel:FlxSound;
var hover:FlxSound;

var curSelected:Int = 0;

function create(){
	CoolUtil.playMenuSong();
	Script.staticVariables.set('skipTitleIntro', true);
	FlxG.mouse.visible = false;
	// dw i removed it snuts
	

	// loads sounds in for no lag when selecting something
	confirm = FlxG.sound.load(Paths.sound('menus/confirm'));
	cancel = FlxG.sound.load(Paths.sound('menus/cancel'));
	hover = FlxG.sound.load(Paths.sound('menus/hover'));

	var tempBG = new FlxSprite();
	tempBG.loadGraphic("images/menus/main/background.png");
	add(tempBG);

	
	starsBack = new FlxBackdrop(Paths.image('menus/main/stars3'));
	starsBack.scrollFactor.set(.1,.1);
	starsBack.antialiasing = Options.antialiasing;
	starsBack.velocity.set(15, 0);
	add(starsBack);

	starsMid = new FlxBackdrop(Paths.image('menus/main/stars2'));
	starsMid.scrollFactor.set(.1,.1);
	starsMid.antialiasing = Options.antialiasing;
	starsMid.velocity.set(30, 0);
	add(starsMid);

	starsTop = new FlxBackdrop(Paths.image('menus/main/stars1'));
	starsTop.scrollFactor.set(.1,.1);
	starsTop.antialiasing = Options.antialiasing;
	starsTop.velocity.set(45, 0);
	add(starsTop);


	for(i in 0...optionShit.length){
		var menuItem:FunkinSprite = new FunkinSprite(355, 150);
		menuItem.frames = Paths.getSparrowAtlas('menus/freeplay/freeplayButtons');
		menuItem.animation.addByPrefix('idle', optionShit[i] + 'Button', 24, true);
		menuItem.animation.addByPrefix('hover', optionShit[i] + 'Hover', 24, true);
		menuItem.ID = i;
		menuItems.add(menuItem);
        menuItem.scale.set(0.85, 0.85);
		menuItem.updateHitbox();
		menuItem.antialiasing = true;
		menuItem.screenCenter(FlxAxes.XY);

		switch(optionShit[i]){
			case "Red":
				menuItem.setPosition(105, 250);
			case "Green":
				menuItem.setPosition(405, 250);
			case "Alibi":
				menuItem.setPosition(705, 190);
			case "Black":
				menuItem.setPosition(1005, 225);
		}
	}

	add(menuItems);

	mouseMania = new FlxSprite(0, 0);
	mouseMania.frames = Paths.getSparrowAtlas('ui/mouse');
	mouseMania.animation.addByPrefix('basic', 'mouseBasic', 30, false);
	mouseMania.scale.set(0.35, 0.35);
	add(mouseMania);

	mousePH = new FlxSprite();
	mousePH.makeGraphic(5, 5, FlxColor.YELLOW);

	var tablet = new FlxSprite();
	tablet.loadGraphic("images/menus/main/border.png");
	add(tablet);

	updateItems();
}

function selectItem(){
	var option = optionShit[curSelected];

		selectedSomethin = true;
		cursor = "arrow";
		confirm.play();
		
		FlxG.camera.zoom = 1.1;
		FlxTween.tween(FlxG.camera, {zoom: 1}, 2, {ease: FlxEase.expoOut});

		new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				FlxTween.tween(FlxG.camera, {zoom: 2}, 5, {ease: FlxEase.expoOut});
				FlxG.camera.fade(FlxColor.BLACK, 0.5, false);
				new FlxTimer().start(0.5,function(tmr:FlxTimer)
				{
					switchState();
				});
			});
}

var selectedSomethin:Bool = false;
var cursor:String = null;
function update(elapsed){
	cursor = null;
	
	if (FlxG.sound.music.volume < 0.8) FlxG.sound.music.volume += 0.5 * elapsed;

	if (controls.BACK || FlxG.mouse.justPressedRight){
		cancel.play();
	
		FlxTween.tween(FlxG.camera, {zoom: 1.2}, 2, {ease: FlxEase.expoOut});
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false);
		new FlxTimer().start(.75, function(tmr:FlxTimer){
			FlxG.switchState(new ModState('mania/ManiaMenuState'));
		});
	}

	if (!selectedSomethin){
		for (i in menuItems.members){
			if (FlxG.mouse.overlaps(i)){
				cursor = "button";

				curSelected = menuItems.members.indexOf(i);
				//hover.play();
				updateItems();

				if (FlxG.mouse.justPressed)
					selectItem();
			}else
				i.animation.play("idle", true);
		}
	}

	Mouse.cursor = cursor ?? "arrow";

	mouseMania.x = FlxG.mouse.x - 35;
	mouseMania.y = FlxG.mouse.y - 35;
}

function updateItems() {
	menuItems.forEach(function(spr:FunkinSprite) {
		spr.animation.play('idle');
		if (spr.ID == curSelected) {
			spr.animation.play('hover');
		}
	});
}

function switchState() {
	var daChoice:String = optionShit[curSelected];

	switch (daChoice) {
		case 'Red':
			PlayState.loadSong("Sussy-Mania", "Hard", false, false);
			FlxG.switchState(new PlayState());
		case 'Green':
			PlayState.loadSong("Activator", "Hard", false, false);
			FlxG.switchState(new PlayState());
		case 'Alibi':
			PlayState.loadSong("Alibi", "Hard", false, false);
			FlxG.switchState(new PlayState());
		case 'Black':
			FlxG.openURL('https://youtu.be/xrW31tZy848');
	}
}