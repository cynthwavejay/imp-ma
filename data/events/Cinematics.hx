var barTop:FlxSprite;
var barBottom:FlxSprite;
var blackScreen:FlxSprite;
var barTweens:Map<String, FlxTween> = [];
var strumsTweens:Map<String, FlxTween> = [];
var hudTweens:Map<String, FlxTween> = [];

function create(){
    var camCinematics:FlxCamera = new FlxCamera();

    camCinematics.bgColor = 0;

    
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camCinematics, false);
    FlxG.cameras.add(camHUD, false);

    barBottom = new FlxSprite(0, FlxG.height).makeSolid(FlxG.width*2, FlxG.height, FlxColor.BLACK);
    barBottom.cameras = [camCinematics];
    barBottom.screenCenter(FlxAxes.X);
    add(barBottom);

    barTop = new FlxSprite(0, -FlxG.height).makeSolid(FlxG.width*2, FlxG.height, FlxColor.BLACK);
    barTop.cameras = [camCinematics];
    barTop.screenCenter(FlxAxes.X);
    add(barTop);   
}

function onEvent(_) {
    if (_.event.name == "Cinematics") {
        trace('MEOWW');
        if (barTweens.exists("CinematicBarTop")) {
            barTweens.get("CinematicBarTop").cancel();
            barTweens.get("CinematicBarTop").destroy();
            barTweens.remove("CinematicBarTop");
        }
        if (barTweens.exists("CinematicBarBottom")) {
            barTweens.get("CinematicBarBottom").cancel();
            barTweens.get("CinematicBarBottom").destroy();
            barTweens.remove("CinematicBarBottom");
        }

        var tweenEase:FlxEase = switch(_.event.params[1]) {
            case "Linear": FlxEase.linear;
            default: Reflect.field(FlxEase, _.event.params[1].toLowerCase() + _.event.params[2]);
        };
        var amount = Math.min(Math.max(_.event.params[0], 0), 100) / 100;
        var yVal = -FlxG.height + ((FlxG.height / 2) * amount);
        barTweens.set("CinematicBarTop", FlxTween.tween(barTop, {y: yVal}, _.event.params[3], {ease: tweenEase, onComplete: function() {
            barTweens.remove("CinematicBarTop");
        }}));

        var yVal = FlxG.height - ((FlxG.height / 2) * amount);
        barTweens.set("CinematicBarBottom", FlxTween.tween(barBottom, {y: yVal}, _.event.params[3], {ease: tweenEase, onComplete: function() {
            barTweens.remove("CinematicBarBottom");
        }}));
    }
}