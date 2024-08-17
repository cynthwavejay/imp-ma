import funkin.backend.utils.NativeAPI;
import lime.graphics.Image;

static var initialized:Bool = false;

function new() {
    //default settings go under here
    if (FlxG.save.data.windowTrack == null) FlxG.save.data.windowTrack = true;
    if (FlxG.save.data.trackCredits == null) FlxG.save.data.trackCredits = true;
    if (FlxG.save.data.menuCrew == null) FlxG.save.data.menuCrew = true;

//window title goes under here
    window.title = "Impostor! Mania - V2 ( Activator update )";
}
//states go under here
static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "mania/ManiaMenuState",
    FreeplayState => "mania/ManiaFreeplayState",
];
//dont delete anything beyond this line caffie
function preStateSwitch() {
    FlxG.camera.bgColor = 0xFF000000;

    if (!initialized) {
        initialized = true;
    } else
        for (redirectState in redirectStates.keys())
            if (FlxG.game._requestedState is redirectState)
                FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}

function onDestroy()
    FlxG.camera.bgColor = 0xFF000000;