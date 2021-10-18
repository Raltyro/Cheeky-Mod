package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

using StringTools;
typedef WeirdData ={
    var name:String;
	var role:String;
    var desc:String;
  }
class CreditState extends MusicBeatState
{
	var credQuote:FlxText;
	var curCred:Int = 0;
	var icon:FlxSprite;
	var arrowThig1:FlxSprite;
	var arrowThig2:FlxSprite;
	var creditData:Array<WeirdData> = [
		{name: "Wizord", role: 'Director, Artist, Animator, Musician', desc:"achoo"},
		{name: "Lexicord", role: 'Co-Director, Programmer', desc:"💀"},
		{name: "Lonestarr", role: 'Musician', desc:"I made cheeky music in a hot boxxed pillow fort"},
		{name: "Voidicus", role: 'Musician', desc:"consume"},
		{name: "Niffirg", role: 'Charter', desc:"Hey guys i'm playing bob vs cheeky at the airport guys what other mods should i play at the airport"},
		{name: "MarshyFlake", role: 'Additional Artist', desc:"call me ;)"},
		{name: "Madbear422", role: 'Animator', desc:"No I will not make your mod"},
		{name: "Wildy", role: 'bob mod', desc:"canon to the racist universe"},
		{name: "Phlox", role: 'bob mod', desc:"you forgot douglas"},
	];

	override public function create():Void
	{
		Conductor.changeBPM(93);

		var background:FlxSprite = new FlxSprite().loadGraphic(Paths.image('MenuThings/menubg'));
		background.antialiasing = true;
		background.screenCenter();
		background.setGraphicSize(Std.int(background.width * 1.65));
		background.color = FlxColor.fromRGB(200, 0, 115);
		add(background);

		icon = new FlxSprite();
		icon.frames = Paths.getSparrowAtlas('DaCrew');
		icon.screenCenter();
		icon.animation.addByPrefix('Lexicord', "Lexicord", 24);
		icon.animation.addByPrefix('Wizord', "Wizord", 24);
		icon.animation.addByPrefix('Niffirg', "Nffirg", 24);
		icon.animation.addByPrefix('Lonestarr', "Lonestar", 24);
		icon.animation.addByPrefix('Marshyflake', "Marshyflake", 24);
		icon.animation.addByPrefix('Madbear422', "Madbear422", 24);
		icon.animation.addByPrefix('Wildy', "Wildy", 24);
		icon.animation.addByPrefix('Phlox', "Phlox", 24);
		icon.animation.addByPrefix('Voidicus', "Voidicus", 24);
		icon.animation.play('Wizord');
		add(icon);

		arrowThig1 = new FlxSprite();
		arrowThig1.frames = Paths.getSparrowAtlas('UI_assets');
		arrowThig1.screenCenter();
		arrowThig1.animation.addByPrefix('left', "arrow left", 24);
		arrowThig1.animation.addByPrefix('press', "arrow push left", 24);
		arrowThig1.x -= 100;
		arrowThig1.animation.play('left');
		add(arrowThig1);

		arrowThig2 = new FlxSprite();
		arrowThig2.frames = Paths.getSparrowAtlas('UI_assets');
		arrowThig2.screenCenter();
		arrowThig2.animation.addByPrefix('right', "arrow right", 24);
		arrowThig2.animation.addByPrefix('press', "arrow push right", 24, false);
		arrowThig2.x += 225;
		arrowThig2.animation.play('right');
		add(arrowThig2);

		credQuote = new FlxText(0, 0, FlxG.width, "hi my name is sans sussy chungus", 24);
		credQuote.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		credQuote.borderColor = FlxColor.BLACK;
		credQuote.borderSize = 3;
		credQuote.borderStyle = FlxTextBorderStyle.OUTLINE;
		credQuote.screenCenter();
		credQuote.y += 275;
		add(credQuote);

		super.create();
	}

	function changeIcon(lol:Int){
		curCred += lol;
		switch(lol){
			case -1: 
				arrowThig1.animation.play('press');
			case 1: 
				arrowThig2.animation.play('press');
		}
		if (curCred < 0){
			curCred = 8;
		}
		if (curCred > 8){
			curCred = 0;
		}
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	}
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		var coolshit = creditData[curCred];
		credQuote.text = coolshit.name + "\n" + coolshit.role + "\n " + coolshit.desc;
		icon.animation.play(coolshit.name);

		if (controls.LEFT_P)
			changeIcon(-1);
		if (controls.RIGHT_P)
			changeIcon(1);

		if (controls.BACK){
			FlxG.switchState(new MainMenuState());
		}
			
	
		super.update(elapsed);
	}
	override function beatHit()
	{
		super.beatHit();

		FlxTween.tween(FlxG.camera, {zoom: 1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
	}
}
