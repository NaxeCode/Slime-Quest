package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import flash.Lib;

class Main extends Sprite
{
	public function new()
	{

		super();
		
		#if !flash
		stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
		#end
		
		addChild(new FlxGame(384, 216, PrototypeLvl, 1, 60, 60, true, false));

		Reg.setupRegistry();
	}

	private function stage_onKeyDown(event:KeyboardEvent):Void
	{
		switch (event.keyCode)
		{
			case Keyboard.F: FlxG.fullscreen = !FlxG.fullscreen;	
		}
	}
}