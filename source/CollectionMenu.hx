package;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class CollectionMenu extends FlxSubState
{
    public function new()
    {
        super();

        createText();
    }

    private function createText():Void
    {
        var collection = new FlxText();
        collection.scrollFactor.set(0, 0);
        collection.text = "Sup, collection text should be here";
        collection.setFormat(null, 10);
        collection.screenCenter();
        add(collection);
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
        if (reg.collectionMenu_Pressed())
            close();
        */
    }
}