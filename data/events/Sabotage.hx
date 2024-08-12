var color:FlxColor;



function onEvent(realEvent)
{
    if (realEvent.event.name == "Sabotage")
    {
        var dur = realEvent.event.params[0];

        var flash = new FlxSprite();
        flash.cameras = [camHUD];
        flash.loadGraphic("images/gradient.png");
        flash.x = 0;
        flash.y = 0;
        flash.color = FlxColor.RED;
        flash.blend = 0;
        add(flash);
        FlxTween.tween(flash, {alpha: 0}, dur);
    }
}