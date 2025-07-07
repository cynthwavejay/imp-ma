var snapPos:Bool = false;

function onEvent(e){
    var params:Array = e.event.params;

    if (e.event.name == "Snap Cam Pos")
    {
        if (params[0]){
            trace("event happened params 0 true");
            snapPos = true;
        } else if (!params[0]) {
            trace("event happened params 0 false");
            snapPos = false;
        }
    }
}

function postUpdate(){
    if (snapPos){
        FlxG.camera.snapToTarget();
    }
}