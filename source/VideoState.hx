// Raltyro made this

package;

import MusicBeatState;
import lime.app.Application;
import Sys;
import flixel.FlxG;
import haxe.Constraints.Function;
import MP4Handler;
import Controls;
import PlayState;
#if desktop
import Discord.DiscordClient;
#end

class VideoState extends MusicBeatState {
	public var path:String;
	public var time:Float;
	var player:MP4Handler;
	var finishCallback:Void->Void;
	var rawFinishCallback:Void->Void;
	
	public function new(filepath:String,muteMusic:Bool = true,finishFoo:Void->Void = null) {
		super();
		time = 0;
		
		path = filepath;
		rawFinishCallback = finishFoo;
		
		var vol:Float = FlxG.sound.music.volume;
		if (muteMusic) FlxG.sound.music.volume = 0;
		
		finishCallback = function() {
			if (muteMusic) FlxG.sound.music.volume = vol;
			
			if (rawFinishCallback != null) rawFinishCallback();
		};
	}
	
	override function create() {
		super.create();
		
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Cutscene", null);
		#end

		player = new MP4Handler();
		player.playMP4(path);
		player.finishCallback = finishCallback;
	}
	
	override function update(elapsed:Float) {
		super.update(elapsed);
		time += elapsed;
		
		if (((time - 3) > 0) && controls.ACCEPT) player.onVLCComplete();
	}
}