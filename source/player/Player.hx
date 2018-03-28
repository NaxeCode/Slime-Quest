package player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.math.FlxVelocity;
import flixel.util.FlxTimer;
import djFlixel.Controls;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.FlxGamepad;
import player.*;

enum Animations
{
	IDLE;
	MOVE;

	CROUCH_STRT;
	CROUCH_LOOP;
	CROUCH_STOP;

	JUMP_STRT;
	JUMP_LOOP;

	JUMPFALL_STRT;
	JUMPFALL_LOOP;
}
class Player extends FlxSprite
{
    // Physics Related Attributes
	public var _canMove:Bool = true;
	public var _speed:Int = 150;
	public var _dragX:Int = 800;
	public var _jumpPower:Int = 320;
	public var _gravity:Int = 900;
	public var _crouching:Bool = false;
	public var _aim:Int = FlxObject.RIGHT;

	// HP Mechanic related Attributes
    public var HP_Max:Int;
    public var HP_Current:Int;

	// Gun
    public var gun:Gun;

	public var gamepad:FlxGamepad;

	private var playAnimation:Animations = IDLE;

	// Current State
	var state:FlxState;

    public function new(?X:Float=0, ?Y:Float=0, STATE:FlxState)
    {
        super(X, Y);

        initGraphics();
		initAnimation();

		initPhysics();
        initGun();

		debug();
    }

    private function initGraphics():Void
    {
		loadGraphic(AssetPaths.Scalene__png, true, 40, 40);

		set_width(20);
		set_height(31);
		centerOffsets();
		offset.y += 4;

		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
    }

	private function initAnimation():Void
	{
		var frameRate:Int = 10;
		
		animation.add("idle_loop", [0, 1, 2, 3, 4, 5], frameRate, true);

		animation.add("walk_loop", [6, 7, 8, 9, 10, 11, 12, 13], frameRate, true);

		animation.add("jump_start", [14, 15], frameRate, false);
		animation.add("jump_loop", [16, 17, 18], frameRate, true);

		animation.add("jumpFall_start", [19, 20, 21, 22], frameRate, false);
		animation.add("jumpFall_loop", [23, 24], frameRate, true);

		// SHOOTING ANIMATIONS
		//animation.add("idle_shooting_loop", [24, 25, 26, 27, 28, 29], frameRate, true);
		//animation.add("walk_shooting_loop", [30, 31, 32, 33, 34, 35, 36, 37], frameRate, true);

		//animation.add("jump_shooting_start", [38, 39], frameRate, true);
		//animation.add("jump_shooting_loop", [40, 41, 42], frameRate, false);

		//animation.add("jumpFall_shooting_start", [43, 44, 45, 46], frameRate, false);
		//animation.add("jumpFall_shooting_loop", [47, 48], frameRate, true);

		//FlxG.watch.add(animation, "frameIndex");
	}

    private function initPhysics():Void
	{
		handlePhysics();
	}

    private function initGun():Void
	{
		gun = new Gun();
	}

	private function debug():Void
    {
		FlxG.watch.add(this, "velocity");
		FlxG.watch.add(this, "playAnimation");
		FlxG.watch.add(this.animation, "frameIndex");
		//FlxG.watch.add(this, "_crouching");

		//FlxG.watch.add(this, "_speed");
		//FlxG.watch.add(this, "_dragX");
		//FlxG.watch.add(this, "_jumpPower");
		//FlxG.watch.add(this, "_gravity");
    }

    override public function update(elapsed:Float):Void
    {
		handleMovement();
		handlePhysics();
		handleAnimation();
        super.update(elapsed);
    }

    private function handleMovement():Void
	{
		acceleration.x = 0;

		gamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			var value = gamepad.analog.value;
			gamepad.deadZone = 0.35;

			FlxG.watch.addQuick("leftStick", value.LEFT_STICK_X);

			if (value.LEFT_STICK_X < 0)
				move("left");
			if (value.LEFT_STICK_X > 0)
				move("right");
		}
		
		// Left movement
		if (Reg.left_Pressed() && !Reg.right_Pressed() && !Reg.down_Pressed())
			move("left");
		
		// Right movement
		if (Reg.right_Pressed() && !Reg.left_Pressed() && !Reg.down_Pressed())
			move("right");

		// Jumping
		if (Reg.jump_justPressed() && isTouching(FlxObject.FLOOR))
			jump();
		else if (Reg.jump_justReleased())
			jump(true);
		
		// Shooting
		if (Reg.shoot_justPressed())
			gun.shoot(this);
	}

	private function move(direction:String):Void
	{
		var multiFactor:Int = 0;
		
		if (isTouching(FlxObject.FLOOR))
			multiFactor = 5;
		else
			multiFactor = 6;
		
		switch (direction)
		{
			case "left": 
				facing = _aim = FlxObject.LEFT;
				acceleration.x = -maxVelocity.x * multiFactor;
			case "right":
				facing = _aim = FlxObject.RIGHT;
				acceleration.x = maxVelocity.x * multiFactor;
		}
	}

	private function jump(?isArc:Bool = false):Void
	{
		switch (isArc)
		{
			case true: if (velocity.y < -30) velocity.y = -100;
			default: velocity.y -= maxVelocity.y / 1.2;
		}
	}

	// Changes Physics depending if touching ground or not
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
	
	private function handleAnimation():Void
	{
		var direction_x:Int; // negative = left, positive = right
		if (velocity.x > 0)
			direction_x = 1;
		else if (velocity.x < 0)
			direction_x = -1;
		else 
			direction_x = 0;
		
		var direction_y:Int; // negative = up, positive = down
		if (velocity.y > 0)
			direction_y = 1;
		else if (velocity.y < 0)
			direction_y = -1;
		else
			direction_y = 0;

		if (isTouching(FlxObject.FLOOR))
		{
			switch (direction_x)
			{
				case 0: 
					if (!_crouching)
						playAnimation = IDLE;
				
				default: playAnimation = MOVE;
			}
		}
		else
		{
			if (velocity.y < -50)
			{
				playAnimation = JUMP_LOOP;
			}
			if (velocity.y > -30 && velocity.y < 30)
			{
				playAnimation = JUMPFALL_STRT;
			}
			else if (velocity.y > 30 && animation.frameIndex == 22 && animation.finished)
			{
				playAnimation = JUMPFALL_LOOP;
			}
		}

		switch (playAnimation)
		{
			case IDLE: animation.play("idle_loop");
			case MOVE: animation.play("walk_loop");

			case CROUCH_STRT: animation.play("crouch_start");
			case CROUCH_LOOP: animation.play("crouch_loop");
			case CROUCH_STOP: animation.play("crouch_stop");

			case JUMP_STRT: animation.play("jump_start");
			case JUMP_LOOP: animation.play("jump_loop");

			case JUMPFALL_STRT: animation.play("jumpFall_start");
			case JUMPFALL_LOOP: animation.play("jumpFall_loop");
		}
	}
}