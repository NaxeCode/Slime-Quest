/*
 * Default REG class
 * =======================
 * Version: 05-2016
 * ---------------- *
 * 
 * You should copy-paste this file to your new Project and use this as a template.
 * Expand the functions as you like
 * 
 */

package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxSave;
import djFlixel.gapi.ApiEmpty;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyboard;
import enemies.*;
import player.*;

class Reg
{
	public static var VERSION:String = "0.0.8";
	public static var NAME:String = "Slime Quest";
	public static var VOLUME:Float = 0.6;
	public static var MUSIC:Bool = false;

	// Global Player Object
    public static var player:Player;

    // Saved Data
    public static var SlimeSouls:Int = 0;


	// pointer to the first connected gamepad
	public static var gamepad:FlxGamepad;
	// Pointer to the keyboard for quick access
	//static var keys(default, null):FlxKeyboard;
    
    // Menu Keys
    public static function confirm_Pressed():Bool 
	{ 
		return (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.A) || FlxG.keys.justPressed.Z); 
	}
    public static function cancel_Pressed():Bool 
	{ 
		return (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.X) || FlxG.keys.justPressed.X); 
	}
    public static function pause_Pressed():Bool 
	{ 
		return (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.START) || FlxG.keys.justPressed.ESCAPE); 
	}
    public static function collectionMenu_Pressed():Bool 
	{ 
		return (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.Y) || FlxG.keys.justPressed.Q); 
	}

    // Movement Keys
    //public static function left_Pressed():Bool { return FlxG.gamepads.anyPressed(FlxGamepadInputID.DPAD_LEFT); }
    public static function left_Pressed():Bool
	{
		return (FlxG.gamepads.anyPressed(FlxGamepadInputID.DPAD_LEFT) || FlxG.keys.pressed.LEFT); 
	}
    public static function right_Pressed():Bool 
	{ 
		return (FlxG.gamepads.anyPressed(FlxGamepadInputID.DPAD_RIGHT) || FlxG.keys.pressed.RIGHT); 
	}
    public static function up_Pressed():Bool 
	{ 
		return (FlxG.gamepads.anyPressed(FlxGamepadInputID.DPAD_UP) || FlxG.keys.pressed.UP); 
	}
    public static function down_Pressed():Bool 
	{ 
		return (FlxG.gamepads.anyPressed(FlxGamepadInputID.DPAD_DOWN) || FlxG.keys.pressed.DOWN); 
	}

    // Action Keys	
    public static function jump_justPressed():Bool 
	{ 
		return (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.A) || FlxG.keys.justPressed.Z); 
	}
    public static function jump_justReleased():Bool 
	{ 
		return (FlxG.gamepads.anyJustReleased(FlxGamepadInputID.A) || FlxG.keys.justReleased.Z); 
	}
    public static function shoot_justPressed():Bool 
	{ 
		return (FlxG.gamepads.anyJustPressed(FlxGamepadInputID.X) || FlxG.keys.justPressed.X); 
	}
    public static function shoot_justReleased():Bool 
	{ 
		return (FlxG.gamepads.anyJustReleased(FlxGamepadInputID.X) || FlxG.keys.justReleased.X); 
	}

    public static function setupRegistry():Void
    {
		#if debug
		setupDebug();
		#end
    }

	public static function setupDebug():Void
	{
		FlxG.log.redirectTraces = true;
        FlxG.console.registerObject("player", Reg.player);
	}
	
	// -- APIS  ------ 
	#if GAMEJOLT
		// Extend the ApiGameJoltGeneric and set it to api
		// public static var api:ApiGameJolt = new ApiGameJolt();
	#elseif KONG
		// Extend the ApiKongregateGeneric and set it to api
		// public static var api:ApiKongregate = new ApiKongregate();
	#elseif NEWGROUNDS
		// public static var api:ApiNewgrounds = new ApiNewgrounds();
	#else
		public static var api:ApiEmpty = new ApiEmpty();
	#end
}