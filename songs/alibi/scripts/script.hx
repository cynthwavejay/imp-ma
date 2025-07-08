
function create() {
    strumLines.members[2].visible = false; // hide white's strums
}

function update(elapsed:Float) {
    if (curBeat == 316) { // yellow dies here
        strumLines.members[2].visible = true; // unhide them strums
        strumLines.members[0].visible = false; // hide yellow's strums
    }
}