package;

import djFlixel.Controls;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import djFlixel.map.MapTemplate;

class ShadingTest extends FlxState
{
    private var map:MapTemplate;

    private var CAMERA_SPEED:Float = 8;

    override public function create():Void
    {
        super.create();

        map = new MapTemplate();
        add(map.layerBG);
        map.loadLevel("shadingTest");
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        
		// Poll for a joystick, applies automatically if discovered
		// Useful when opening flash on a browser
		Controls.poll();
		
		// -- Scroll the map by key input
		// Checks WASD, ARROW KEYS and JOYSTICK
		if (Controls.pressed(Controls.LEFT)) {
			camera.scroll.x -= CAMERA_SPEED;
		}
		else if (Controls.pressed(Controls.RIGHT)) {
			camera.scroll.x += CAMERA_SPEED;
		}
		
		if (Controls.pressed(Controls.UP)) {
			camera.scroll.y -= CAMERA_SPEED;
		}
		else if (Controls.pressed(Controls.DOWN)) {
			camera.scroll.y += CAMERA_SPEED;
		}
	
    }
}