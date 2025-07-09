//coded by chloe
public var camOffset = 15;
public var camNoteHit = true;

function postUpdate(){
    if (FlxG.save.data.cameraDirection){
        if (camNoteHit){
            switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
                case "singLEFT": camFollow.x -= camOffset;
                case "singDOWN": camFollow.y += camOffset;
                case "singUP": camFollow.y -= camOffset;
                case "singRIGHT": camFollow.x += camOffset;
            }
        }
    }
}