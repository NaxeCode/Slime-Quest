package enemies;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxColor;

class BaseEnemy extends FlxSprite
{
    // Physics Related Attributes
	public var _enemyActive:Bool = true;
	public var _speed:Int = 150; // 170
	public var _dragX:Int = 800; // 1500
	public var _jumpPower:Int = 320; // 275
	public var _gravity:Int = 900; // 500

    // HP Mechanic related Attributes
    public var harmful:Bool = true;
    public var HP_Max:Int;
    public var HP_Current:Int;
    
    public function new(?X:Float = 0, ?Y:Float = 0)
    {
        super(X, Y);

        initGraphics();
        initAnimation();
        initPhysics();
    }

    public function initGraphics():Void
    {
        var enimCol = FlxColor.RED;
        enimCol.brightness = 0.7;
        makeGraphic(24, 24, enimCol);
    }

    public function initAnimation():Void
    {
        
    }

    public function initPhysics():Void
    {
        handlePhysics();
    }

    override public function update(elapsed:Float):Void
    {
        handlePhysics();
        handleCollision();
        handleLife();
        super.update(elapsed);
    }

    private function handlePhysics():Void
    {
        acceleration.y = _gravity;
		if (isTouching(FlxObject.FLOOR))
		{
			maxVelocity.set(_speed / 1.2, _jumpPower * 1.5);
			drag.set(_dragX, 0);
		}
		else
		{
			maxVelocity.set(_speed * 1.2, _jumpPower * 1.5);
			drag.set(Std.int(_dragX / 2.6), 0);
		}
    }

    private function handleCollision():Void
    {
        //if (isTouching)
    }

    private function handleLife():Void
    {
        
    }
}