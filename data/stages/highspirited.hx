function create(){

    aura.blend = 0;
    overlay.blend = 0;

    FlxTween.tween(airship, {x: airship.x  - 2500}, 150, {ease: FlxEase.linear});


}