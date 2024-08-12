import funkin.backend.utils.DiscordUtil;

function onGameOver() {
	DiscordUtil.changePresence('Got killed :(', PlayState.SONG.meta.displayName + " (" + PlayState.difficulty + ")");
}

function onDiscordPresenceUpdate(e) {
	var data = e.presence;

	if(data.button1Label == null)
		data.button1Label = "Impostor! Mania Twitter";
	if(data.button1Url == null)
		data.button1Url = "https://x.com/ImpostorMania";
}

function onPlayStateUpdate() {
	DiscordUtil.changeSongPresence(
		PlayState.instance.detailsText,
		(PlayState.instance.paused ? "Paused - " : "") + PlayState.SONG.meta.displayName + " (" + PlayState.difficulty + ")",
		PlayState.instance.inst,
		PlayState.instance.getIconRPC()
	);
}

function onMenuLoaded(name:String) {
	// Name is either "Main Menu", "Freeplay", "Title Screen", "Options Menu", "Credits Menu", "Beta Warning", "Update Available Screen", "Update Screen"
		DiscordUtil.changePresenceSince("In the sussy menus", null);
}

function onEditorTreeLoaded(name:String) {
	switch(name) {
		case "Character Editor":
			DiscordUtil.changePresenceSince("Choosing a sus", null);
		case "Chart Editor":
			DiscordUtil.changePresenceSince("Choosing a sus", null);
		case "Stage Editor":
			DiscordUtil.changePresenceSince("Choosing a sus", null);
	}
}

function onEditorLoaded(name:String, editingThing:String) {
	switch(name) {
		case "Character Editor":
			DiscordUtil.changePresenceSince("Editing a sus", editingThing);
		case "Chart Editor":
			DiscordUtil.changePresenceSince("Editing a sus", editingThing);
		case "Stage Editor":
			DiscordUtil.changePresenceSince("Editing a sus", editingThing);
	}
}