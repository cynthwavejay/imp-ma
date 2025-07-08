// event by Snuts! use wherever you want no need to credit me :)

function onEvent(e) {
    var params:Array = e.event.params;
    var strumline = params[1];

    if (params[0] == "Show") {
        strumLines.members[strumline].visible = true;
        //trace("Showing" + params[1]);
    } else if (params[0] == "Hide") {
        strumLines.members[strumline].visible = false;
        //trace("Hiding" + params[1]);
    }
}