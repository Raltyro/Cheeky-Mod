package;

import flixel.FlxG;
import MusicBeatState;
import GameOverSubstate;

class AltGameOverState extends MusicBeatState {
	var bfx:Float = 0;
	var bfy:Float = 0;
	var time:Float = 0;
	
	public function new(x:Float, y:Float) {
		super();
		bfx = x;
		bfy = y;
	}
	
	override function create() {
		super.create();
		time = 0;
		
		trace(bfx);
		trace(bfy);
	}
	
	override function update(elapsed:Float) {
		super.update(elapsed);
		time += elapsed;
		
		if (time > .06) {
			persistentUpdate = false;
			persistentDraw = false;
			openSubState(new GameOverSubstate(bfx,bfy));
		}
	}
}