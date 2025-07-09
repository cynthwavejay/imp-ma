function postCreate(){
    if (FlxG.save.data.cameraDirection == true) FlxG.save.data.cameraDirection = null;
}

function destroy(){
    if (FlxG.save.data.cameraDirection == null) FlxG.save.data.cameraDirection = true;
}