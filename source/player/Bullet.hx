package player;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class Bullet extends FlxSprite
{
    public var shotAmount:Float = 0.000;
    public var _speed:Int = 350;

    public function new()
    {
        super();
        
        loadGraphic(AssetPaths.bullet__png, true, 9, 9);
        
        setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);

        animation.add("shoot", [0, 1, 2], 15, false);
        animation.add("shoot_end", [3, 4], 15, false);
    }

    override public function update(elapsed:Float):Void
    {
        if (!alive)
		{
			if (animation.finished)
				exists = false;
		}
		else if (touching != 0)
		{
			kill();
		}

        super.update(elapsed);
    }

    override public function kill():Void
	{
		if (!alive)
			return;
		
		velocity.set(0, 0);
		
        /*
		if (isOnScreen())
			FlxG.sound.play("Jump");
        */
		
		alive = false;
		solid = false;
		animation.play("shoot_end");
	}

    public function shoot(Location:FlxPoint, Aim:Int):Void
	{
		//FlxG.sound.play("Shoot");
		
		super.reset(Location.x - width / 2, Location.y - height / 2);
		
		solid = true;
		
		switch (Aim)
		{
			case FlxObject.UP:
				//animation.play("up");
				velocity.y = - _speed;
			case FlxObject.DOWN:
				//animation.play("down");
				velocity.y = _speed;
			case FlxObject.LEFT:
				//animation.play("left");
				velocity.x = - _speed;
			case FlxObject.RIGHT:
				//animation.play("right");
				velocity.x = _speed;
		}
        facing = Aim;
        animation.play("shoot");
	}
}