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

var codenameVersion = Application.current.meta.get('version');

var optionShit:Array<String> = ['Play', 'Options', 'Credits'];
var menuItems:FlxTypedGroup<FlxSprite> = new FlxTypedGroup();

var camZoom:FlxTween;

var confirm:FlxSound;
var cancel:FlxSound;
var shover:FlxSound;

var curSelected:Int = 0;

function create(){
	CoolUtil.playMenuSong();
	Script.staticVariables.set('skipTitleIntro', true);
	FlxG.mouse.visible = false;
    // REMOVE IN V4 -snuts
	if (FlxG.save.data.beatAlibi == null || FlxG.save.data.beatAlibi == false) {
		window.title = "Impostor! Mania - V3 ( Kiiro update )";
	} else {
		window.title = "Impostor! Mania - V3 ( Alibi update )";
	}

	// loads sounds in for no lag when selecting something
	confirm = FlxG.sound.load(Paths.sound('menus/confirm'));
	cancel = FlxG.sound.load(Paths.sound('menus/cancel'));
	shover = FlxG.sound.load(Paths.sound('menus/hover'));

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
	
	tabText = new FunkinText(1005, 725, 0, 'Open the Mods Menu [TAB]');
	tabText.y -= tabText.height+50;
	add(tabText);

	versionShit = new FunkinText(1990, 725, 0, 'Codename Engine - v.'+codenameVersion);
	versionShit.y -= versionShit.height+70;
	add(versionShit);

	modVer = new FunkinText(1035, 725, 0, 'Impostor! Mania - V2');
	modVer.y -= modVer.height+70;
	add(modVer);


	for(i in 0...optionShit.length){
		var menuItem:FunkinSprite = new FunkinSprite(355, 1000);
		menuItem.frames = Paths.getSparrowAtlas('menus/main/Buttonslol');
		menuItem.animation.addByPrefix('idle', optionShit[i] + 'Button', 24, true);
		menuItem.animation.addByPrefix('hover', optionShit[i] + 'Select', 24, true);
		menuItem.ID = i;
		menuItems.add(menuItem);
        menuItem.scale.set(0.75, 0.75);
		menuItem.updateHitbox();
		menuItem.antialiasing = true;

		switch(optionShit[i]){
			case "Play":
				menuItem.setPosition(100, 125);
				menuItem.updateHitbox();
			case "Options":
				menuItem.setPosition(100, 300);
				menuItem.updateHitbox();
			case "Credits":
				menuItem.setPosition(100, 475);
				menuItem.updateHitbox();
		}
	}

	add(menuItems);

	if (FlxG.save.data.menuCrew){
		yellow = new FlxSprite(0, 100);
		yellow.frames = Paths.getSparrowAtlas('menus/main/yellow');
		yellow.animation.addByPrefix('yellownormal', 'yellownormal', 24, true);
		yellow.animation.addByPrefix('yellowdies', 'yellowdies', 24, false);
		yellow.scale.set(0.6, 0.6);
		yellow.x = 380;
		yellow.y = 620;
		yellow.alpha = 0;
		add(yellow);
	}

	mouseMania = new FlxSprite(0, 0);
	mouseMania.frames = Paths.getSparrowAtlas('ui/mouse');
	mouseMania.animation.addByPrefix('basic', 'mouseBasic', 30, false);
	mouseMania.scale.set(0.35, 0.35);
	add(mouseMania);

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

    if (FlxG.keys.justPressed.SEVEN){
		persistentUpdate = !(persistentDraw = true);
		openSubState(new EditorPicker());
	}

	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = !(persistentDraw = true);
	}

	if (controls.BACK || FlxG.mouse.justPressedRight){
		cancel.play();
	
		FlxTween.tween(FlxG.camera, {zoom: 1.2}, 2, {ease: FlxEase.expoOut});
		
		FlxG.camera.fade(FlxColor.BLACK, 0.5, false);
		new FlxTimer().start(.75, function(tmr:FlxTimer){
			FlxG.switchState(new TitleState());
		});
	}

	if (!selectedSomethin){
		for (i in menuItems.members){
			if (FlxG.mouse.overlaps(i)){
				cursor = "button";

				curSelected = menuItems.members.indexOf(i);
				//shover.play();
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
		case 'Play':
			FlxG.switchState(new ModState('mania/ManiaFreeplayState'));
		case 'Options':
			FlxG.switchState(new OptionsMenu());
		case 'Credits':
			FlxG.switchState(new CreditsMain());
	}
}

function beatHit(curBeat){

	if (FlxG.save.data.menuCrew){
		if(curBeat == 66){
			FlxTween.tween(yellow, {y: 320}, 1, {ease: FlxEase.expoOut});
			FlxTween.tween(yellow, {alpha: 1}, 1, {ease: FlxEase.expoOut});
			yellow.animation.play("yellownormal");
		}
	
		if(curBeat == 70){
			yellow.animation.play("yellowdies");
			new FlxTimer().start(2, function(tmr:FlxTimer){
				FlxTween.tween(yellow, {y: 620}, 1.25, {ease: FlxEase.expoIn});
				FlxTween.tween(yellow, {alpha: 0}, 1.25, {ease: FlxEase.expoIn});
			});
		}
	}
}