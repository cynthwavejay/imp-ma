function onEvent(realEvent)
{
    if (realEvent.event.name == "Set Cam Zoom") {
        defaultCamZoom = realEvent.event.params[0];
    }
}