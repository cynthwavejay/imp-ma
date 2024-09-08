import funkin.game.PlayState;

var self = this;
function update(elpased) {
	if(FlxG.keys.justPressed.SPACE && self.flipX == false){
		self.playAnim("hey", true, 'SING');
	}
}