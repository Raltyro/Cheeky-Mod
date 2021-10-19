package;

import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.addons.plugin.FlxMouseControl;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class MainMenuState extends MusicBeatState
{
	var bg:FlxSprite;
	var menuguy:FlxSprite;
	var curSelected:Int = 0;
	var defaultXmen:Float; // i got lazy
	var blackstuff:FlxSprite;
	public var daColors:Array<String> = [
		'#9d69ff',
		'#ff5c5c',
		'#5eff61',
		'#ffff70',
		'#a3fff4',

	];
	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'credits', 'gallery', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay', 'credits', 'gallery', 'options'];
	#end

	var newGaming:FlxText;
	var newGaming2:FlxText;
	var partycheek:FlxSprite;
	public static var firstStart:Bool = true;

	var camFollow:FlxObject;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(-100).loadGraphic(Paths.image('MenuThings/menubg'));
		bg.screenCenter();
		bg.antialiasing = true;
		bg.setGraphicSize(Std.int(bg.width * 1.15));
		bg.scrollFactor.set();
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuguy = new FlxSprite();
		menuguy.frames = Paths.getSparrowAtlas('MenuThings/MenuFunnies');
		menuguy.animation.addByPrefix('gallery', "gallery", 24);
		menuguy.animation.addByPrefix('freeplay', "freeplay", 24);
		menuguy.animation.addByPrefix('credits', "credits", 24);
		menuguy.animation.addByPrefix('story mode', "story mode", 24);
		menuguy.animation.addByPrefix('options', "options", 24);
		menuguy.animation.play('story mode');
		menuguy.scrollFactor.set();
		menuguy.antialiasing = true;
		menuguy.screenCenter();
		FlxTween.tween(menuguy, {y: menuguy.y + 10}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
		FlxTween.tween(menuguy, {x: menuguy.x + 10}, 2, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.15});
		add(menuguy);

		blackstuff = new FlxSprite(-100).loadGraphic(Paths.image('MenuThings/menu_outline'));
		blackstuff.screenCenter();
		blackstuff.antialiasing = true;
		blackstuff.scrollFactor.set();
		blackstuff.x -= 500;
		add(blackstuff);
		FlxTween.tween(blackstuff, {x: blackstuff.x + 500}, 0.75, {ease: FlxEase.backInOut});


		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('MenuThings/FNF_main_menu_assets');

		for (i in 0...optionShit.length)
			{
				var menuItem:FlxSprite = new FlxSprite(-30, FlxG.height * 1.3);
				menuItem.frames = tex;
				menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
				menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
				menuItem.animation.play('idle');
				menuItem.ID = i;
				//menuItem.screenCenter(X);
				menuItems.add(menuItem);
				if (i == 3){
					menuItem.setGraphicSize(Std.int(menuItem.width / 1.1));
				}
				menuItem.alpha = 0;
				menuItem.scrollFactor.x = 0;
				menuItem.scrollFactor.y = 0.5;
				menuItem.antialiasing = true;
				menuItem.y = (i * 160);
				menuItem.x -= 460;
				FlxTween.tween(menuItem, {alpha: 1}, 1.5, {ease: FlxEase.cubeInOut});
				FlxTween.tween(menuItem, {x: menuItem.x + 500}, 1.5, {ease: FlxEase.backInOut});
			}

		firstStart = false;

		FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));
		// NG.core.calls.event.logEvent('swag').send();


		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		changeItem();

		if (FlxG.save.data.beatCorn && !FlxG.save.data.playedOmen){
			FlxG.mouse.visible = true;

			partycheek = new FlxSprite(10, 10).loadGraphic(Paths.image('waiwuwo'));
			partycheek.screenCenter();
			partycheek.y -= 200;
			partycheek.x += 500;
			partycheek.scrollFactor.set();
			add(partycheek);
		}


		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		if(FlxG.save.data.beatCorn && !FlxG.save.data.playedOmen){
			if (FlxG.mouse.overlaps(partycheek))
				{
					if(FlxG.mouse.justPressed){
						FlxG.save.data.playedOmen = true;
						PlayState.SONG = Song.loadFromJson(Highscore.formatSong('bad omen', 1), 'bad omen');
						PlayState.isStoryMode = false;
						PlayState.storyDifficulty = 1;
						LoadingState.loadAndSwitchState(new PlayState());
					}
				}
		}
		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
				

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									FlxTween.tween(blackstuff, {x: blackstuff.x - 650}, 1.15, {ease: FlxEase.backInOut});
									spr.kill();
								}
							});
						}
						else
						{
							if (FlxG.save.data.flashing)
							{
								FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
								{
									FlxTween.tween(blackstuff, {x: blackstuff.x - 600}, 1.15, {ease: FlxEase.backInOut});
									goToState();
								});
							}
							else
							{
								new FlxTimer().start(1, function(tmr:FlxTimer)
								{
									FlxTween.tween(blackstuff, {x: blackstuff.x - 600}, 1.15, {ease: FlxEase.backInOut});
									goToState();
								});
							}
						}
					});
				}
		}

		super.update(elapsed);
	}
	
	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'story mode':
				FlxG.switchState(new StoryMenuState());
			case 'freeplay':
				FlxG.switchState(new FreeplayState());
			case 'credits':
				FlxG.switchState(new CreditState());
			case 'gallery':
				FlxG.switchState(new MainMenuState());
			case 'options':
				FlxG.switchState(new OptionsMenu());
		}
	}

	function changeItem(huh:Int = 0)
	{
			curSelected += huh;
			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;

			menuguy.animation.play(optionShit[curSelected]);
			FlxTween.color(bg, 0.1, bg.color, FlxColor.fromString(daColors[curSelected]));
			FlxG.camera.zoom = 1;
			FlxTween.tween(FlxG.camera, {zoom: 1.05}, 0.3, {ease: FlxEase.quadOut, type: BACKWARD});
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);

			}

			spr.updateHitbox();
		});
	}
}