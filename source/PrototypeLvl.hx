package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import enemies.*;
import player.*;

class PrototypeLvl extends BaseLevel
{
	public var level:TiledLevel;

	override public function create():Void
	{
		super.create();

		initPlayer();
		initEnemyGroup();
		initTiledLevel(AssetPaths.prototypeLvl__tmx, this);
		//initUI();
	}

	override public function setProperties():Void
	{
		super.setProperties();
		var bgCol = FlxColor.fromInt(0xFF2F2644);
		FlxG.cameras.bgColor = bgCol;
		FlxG.camera.antialiasing = false;
	}

	override public function initJSON():Void
	{
		
	}

	private function initPlayer():Void
	{
		Reg.player = new Player(0, 0, this);
		FlxG.camera.follow(Reg.player, PLATFORMER, 0.2);
	}

	private function initTiledLevel(levelPath:String, state:BaseLevel):Void
	{
		level = new TiledLevel(levelPath, state);

		// Add backgrounds
		add(level.backgroundLayer);
		
		// Add static images
		add(level.imagesLayer);

		// Add player's gun (see initGun() in Player class)
		add(Reg.player.gun);

		// Add player (see initPlayer())
		add(Reg.player);

		// Add all enemies (See initEnemyGroup())
		add(enemyGroup);
		
		// Load player objects
		add(level.objectsLayer);
		
		// Add foreground tiles after adding level objects, so these tiles render on top of player
		add(level.foregroundTiles);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	override public function handleCollisions():Void
	{
		level.collideWithLevel(enemyGroup);
		FlxG.overlap(enemyGroup, Reg.player, handleEnemyInteraction);
		FlxG.overlap(enemyGroup, Reg.player.gun, handleEnemyShot);
		level.collideWithLevel(Reg.player);
		level.collideWithLevel(Reg.player.gun);
	}

	private function handleEnemyInteraction(enm:BaseEnemy, plr:Player):Void
	{
		/*
		switch (enm.touching)
		{
			case FlxObject.CEILING: plr
			default:		
		}
		*/
	}

	private function handleEnemyShot(enm:BaseEnemy, bllt:FlxObject):Void
	{
		enm.HP_Current--;
		bllt.kill();
	}
}