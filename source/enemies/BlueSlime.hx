package enemies;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class BlueSlime extends BaseEnemy
{
    public function new(?X:Float = 0, ?Y:Float = 0)
    {
        super(X, Y);

        //initPrimitiveGraphics();
		//initAnimation();
    }

    private function initPrimitiveGraphics():Void
    {
        var enimCol = FlxColor.BLUE;
        enimCol.brightness = 0.7;
        makeGraphic(31, 31, enimCol);
    }

    override public function initGraphics():Void
    {
        loadGraphic(AssetPaths.blue_big_slime__png, true, 31, 31);

        //set_width(20);
		set_height(22);
		centerOffsets();
		offset.y += 4;

        setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
    }

    override public function initAnimation():Void
    {
        var frameRate:Int = 10;
		
		animation.add("idle", [0], frameRate, false);
		animation.add("hop_loop", [0, 1, 2, 3, 4, 5, 6, 7, 8], frameRate, true);
		animation.add("hurt", [9, 10, 11], frameRate, false);
		animation.add("die", [12, 13, 14, 15, 16], frameRate, false);
    }

    override public function initPhysics():Void
    {
        _dragX = Std.int(_dragX / 2);
    }

    override public function update(elapsed:Float):Void
    {
        if (_enemyActive)
            animateAI(elapsed);
        
        super.update(elapsed);
    }


    var jumpAutoTick:Float = 0;
    private function animateAI(elapsed:Float):Void
    {
        
        if (!isTouching(FlxObject.FLOOR))
            return;
        
        var timing:Float = 1;

        if (jumpAutoTick <= timing)
			jumpAutoTick += elapsed;
        
        animateGraphics(timing);

        if (jumpAutoTick > timing)
		{
            switch (FlxG.random.bool(40))
            {
                case true: facing = FlxObject.LEFT;
                case false: facing = FlxObject.RIGHT;
            }

            velocity.y = -(_jumpPower / 1.1);
            switch (facing)
            {
                case FlxObject.LEFT: velocity.x = -(_jumpPower / 2.7);
                case FlxObject.RIGHT: velocity.x = (_jumpPower / 2.7);
            }

			jumpAutoTick = 0;
		}
    }

    private function animateGraphics(timing:Float = 1):Void
    {
        if (jumpAutoTick > (timing - 0.50))
            animation.play("hop_loop");
        else
            animation.play("idle");
    }
}