package;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSubState;
import flixel.util.FlxColor;

class PauseMenu extends FlxSubState
{
    public function new()
    {
        super();

        createText();
    }

    private function createText():Void
    {
        var pause = new FlxText();
        pause.scrollFactor.set(0, 0);
        pause.text = "pause menu";
        pause.setFormat(null, 20);
        pause.screenCenter();
        pause.y -= 50;
        add(pause);
    }

    override public function update(elapsed:Float):Void
    {
        handleInput();
        super.update(elapsed);
    }

    private function handleInput():Void
    {
        /*
        var reg:Reg;
        if (reg.pause_Pressed())
            close();
        */
    }
}