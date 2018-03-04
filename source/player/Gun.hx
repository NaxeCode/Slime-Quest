package player;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;
import player.*;

class Gun extends FlxTypedGroup<Bullet>
{
    private var amount:Int = 30;

    public var shotClock:Float = 0;
    public var shotAmount:Float = 0.000;

    public function new()
    {
        super(amount);

        initBullets();

        FlxG.watch.add(this, "shotClock");
        FlxG.watch.add(this, "shotAmount");
    }

    private function initBullets():Void
    {
        for (i in 0...amount)
        {
            var bullet = new Bullet();
            bullet.kill();
            add(bullet);
        }
    }

    override public function update(elapsed:Float):Void
    {
        if (shotClock < 0.35)
            shotClock += (elapsed + shotAmount);

        super.update(elapsed);
    }

    public function shoot(source:Player):Void
    {
        if (shotClock < 0.35)
            return;
        
        var _point = FlxPoint.get(0, 0);
        source.getMidpoint(_point);

        switch (source._crouching)
        {
            case true: _point.y += 6;
            case false: _point.y += 1;
        }
		recycle(Bullet).shoot(_point, source._aim);

        /*
        var shockWaveAmnt:Int = 0;
        switch (source.isTouching(FlxObject.FLOOR))
        {
            case true: shockWaveAmnt = 90;
            case false: shockWaveAmnt = 125;
        }
        switch (source.facing)
        {
            case FlxObject.LEFT: source.velocity.x += shockWaveAmnt;
            case FlxObject.RIGHT: source.velocity.x -= shockWaveAmnt;
        }

        FlxG.camera.shake(0.002, 0.05, null, true, X);
        */

        shotAmount += 0.001;
        shotClock -= shotClock;
    }
}