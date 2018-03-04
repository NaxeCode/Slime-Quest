package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import enemies.*;
import player.*;

class BaseLevel extends FlxState
{
    public var enemyGroup:FlxTypedGroup<BaseEnemy>;

    override public function create():Void
	{
		super.create();

		setProperties();
		initEnemyGroup();
		initHUD();
        initJSON();
	}

    public function setProperties():Void
	{
		var bgCol = FlxColor.GRAY;
		FlxG.cameras.bgColor = bgCol;
	}

    public function initEnemyGroup():Void
	{
		enemyGroup = new FlxTypedGroup<BaseEnemy>();
	}

	public function initHUD():Void
	{

	}

    public function initJSON():Void
	{
		//trace(Reg.JSON.titleText);
	}

    /**
	 *  Adds an Enemy to the current enemyGroup. To be used to read enemy types and add them to the current class
	 *  
	 *  @param   enimType 		Enemy Type you wish to spawn
	 *  @param   X 				X coordinates
	 *  @param   Y 				Y coordinates
	 */
	public function addEnemyType(enimType:String, ?X:Float = 0, ?Y:Float = 0):Void
	{
		var enim:Any;
		switch (enimType)
		{
			case "blueSlime": enim = new BlueSlime(X, Y);
			default: enim = new BaseEnemy(X, Y);
		}
		
		enemyGroup.add(enim);
	}

    override public function update(elapsed:Float):Void
	{
		handleInput();
		super.update(elapsed);

		handleCollisions();
	}

    public function handleInput():Void
	{
		/*
		var reg:Reg;
		if (reg.pause_Pressed())
			openSubState(new PauseMenu());
		
		if (reg.collectionMenu_Pressed())
			openSubState(new CollectionMenu());
		*/
	}

    public function handleCollisions():Void { }
}