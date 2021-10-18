package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;
//	var camFollow:FlxObject;

	var weekData:Array<Dynamic> = [
		['Rocky Beats', 'ToughStone', 'Hard 2 Break'],
		['Salami Teachings', 'Devils Jello', 'Bedrock'],
		['Rivals', 'Fnaf Shuffle', 'Bad Eggroll', 'Cornucopia'],
		['Cuisine']
	];
	var curDifficulty:Int = 1;

	public static var weekUnlocked:Array<Bool> = [true, true, false, false];
	var menuguy:FlxSprite;

	var weekNames:Array<String> = [
		"M U G E N",
		"Veszteseg",
		"Mano Meat Solutions",
		"Cooking Show"
	];

	var txtWeekTitle:FlxText;

	var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<FlxSprite>;

	var background:FlxSprite;
	public var daColors:Array<String> = [
		'#9d69ff',
		'#ff5c5c',
		'#5eff61',
		'#ffff70',
		'#a3fff4',
	];
	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	override function create()
	{
		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;
		txtWeekTitle.y += 215;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		background = new FlxSprite().loadGraphic(Paths.image('MenuThings/menubg'));
		background.antialiasing = true;
		background.screenCenter();
		background.scrollFactor.set();
		add(background);
	//	camFollow = new FlxObject(0, 0, 1, 1);
		//add(camFollow);

		menuguy = new FlxSprite();
		menuguy.frames = Paths.getSparrowAtlas('MenuThings/MenuFunnies');
		menuguy.animation.addByPrefix('0', "Week 1", 24);
		menuguy.animation.addByPrefix('1', "Week 2", 24);
		menuguy.animation.addByPrefix('2', "Week 3", 24);
		menuguy.animation.addByPrefix('3', "Week 4", 24);
		menuguy.animation.play('0');
		menuguy.scrollFactor.set();
		menuguy.antialiasing = true;
		menuguy.screenCenter();
		FlxTween.tween(menuguy, {y: menuguy.y + 10}, 2, {ease: FlxEase.quadInOut, type: PINGPONG});
		FlxTween.tween(menuguy, {x: menuguy.x + 10}, 2, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.15});
		add(menuguy);

		var blackstuff:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('MenuThings/upper_checkers'));
		blackstuff.screenCenter();
		blackstuff.antialiasing = true;
		blackstuff.scrollFactor.set();
		add(blackstuff);

		var blackstuff2:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('MenuThings/lower_checkers'));
		blackstuff2.screenCenter();
		blackstuff2.antialiasing = true;
		blackstuff2.scrollFactor.set();
		add(blackstuff2);

		grpWeekText = new FlxTypedGroup<FlxSprite>();
		add(grpWeekText);

		trace("Line 70");
		for (i in 0...weekData.length)
			{
				var weekThing:FlxSprite = new FlxSprite(-30, FlxG.height * 1.3);
				weekThing.frames = Paths.getSparrowAtlas('week_selections');
				weekThing.animation.addByPrefix('idle', "week" + i + " basic", 24);
				weekThing.animation.addByPrefix('selected', "week" + i + " select", 24);
				weekThing.animation.play('idle');
				weekThing.ID = i;
				weekThing.screenCenter(X);
				grpWeekText.add(weekThing);
				weekThing.antialiasing = true;
				weekThing.y = (i * 125);
				weekThing.y += 125;
				weekThing.x += 400;
				weekThing.updateHitbox();
				weekThing.setGraphicSize(Std.int(weekThing.width / 2.25));
			}
		trace("Line 96");

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		trace("Line 124");

		leftArrow = new FlxSprite();
		leftArrow.screenCenter();
		leftArrow.x -= 335;
		leftArrow.y += 260; 
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 130, leftArrow.y);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		changeDifficulty();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 50, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);

		trace("Line 150");

		txtTracklist = new FlxText(FlxG.width * 0.05, background.x + background.height + 100, 0, "Tracks", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFe55777;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		updateText();

		trace("Line 165");

	//	FlxG.camera.follow(camFollow, null, 0.60 * (60 / FlxG.save.data.fpsCap));
		FlxTween.color(background, 0.1, background.color, FlxColor.fromString(daColors[curWeek]));

		super.create();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;

		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.x = scoreText.x - (txtWeekTitle.width + 10);

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = weekUnlocked[curWeek];

		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeWeek(-1);
				}

				if (controls.DOWN_P)
				{
					changeWeek(1);
				}

				if (controls.RIGHT)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
					changeDifficulty(1);
				if (controls.LEFT_P)
					changeDifficulty(-1);
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (weekUnlocked[curWeek])
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxG.camera.flash(FlxColor.WHITE, 2.5);

				stopspamming = true;
			}

			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.isStoryMode = true;
			selectedWeek = true;

			var diffic = "";

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			switch(curWeek){
				case 0: 
					var video:MP4Handler = new MP4Handler();
					video.playMP4(Paths.video('cutscene1'));
					video.finishCallback = function()
						{
							new FlxTimer().start(1, function(tmr:FlxTimer){
								LoadingState.loadAndSwitchState(new PlayState());
							});
					}
				case 2: 
					var video:MP4Handler = new MP4Handler();
					video.playMP4(Paths.video('cutscene4'));
					video.finishCallback = function()
						{
							new FlxTimer().start(1, function(tmr:FlxTimer){
								LoadingState.loadAndSwitchState(new PlayState());
							});
					}	
				default: 
					new FlxTimer().start(1, function(tmr:FlxTimer){
						LoadingState.loadAndSwitchState(new PlayState());
					});
				}	
			}
			else{
				FlxG.camera.shake(0.05, 0.65);
				FlxG.sound.play(Paths.sound('denied'));
				FlxG.camera.flash(FlxColor.RED, 0.85);
			}
		}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = 2;
		if (curDifficulty > 2)
			curDifficulty = 0;

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('easy');
				sprDifficulty.offset.x = 20;
			case 1:
				sprDifficulty.animation.play('normal');
				sprDifficulty.offset.x = 70;
			case 2:
				sprDifficulty.animation.play('hard');
				sprDifficulty.offset.x = 20;
		}

		sprDifficulty.alpha = 0;

		// USING THESE WEIRD VALUES SO THAT IT DOESNT FLOAT UP
		sprDifficulty.y = leftArrow.y - 15;
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {y: leftArrow.y + 15, alpha: 1}, 0.07);
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;


	function changeWeek(huh:Int = 0)
		{
				curWeek += huh;
				if (curWeek >= grpWeekText.length)
					curWeek = 0;
				if (curWeek < 0)
					curWeek = grpWeekText.length - 1;
	
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
				menuguy.animation.play('' + curWeek);
				FlxTween.color(menuguy, 0.1, menuguy.color, FlxColor.fromRGB(255, 255, 255));
			grpWeekText.forEach(function(spr:FlxSprite)
			{
				spr.animation.play('idle');
				if (spr.ID == curWeek){
					spr.animation.play('selected');
				}
				if (spr.ID == curWeek && weekUnlocked[curWeek])
				{
					FlxTween.color(background, 0.1, background.color, FlxColor.fromString(daColors[curWeek]));
				}
				if (!weekUnlocked[curWeek]){
					FlxTween.color(background, 0.1, background.color, FlxColor.fromRGB(150, 150, 150));
					FlxTween.color(menuguy, 0.1, menuguy.color, FlxColor.fromRGB(0, 0, 0));
				}		
			//	spr.updateHitbox();
			});
		}

	function updateText()
	{

		txtTracklist.text = "Tracks\n";
		var stringThing:Array<String> = weekData[curWeek];

		for (i in stringThing)
			txtTracklist.text += "\n" + i;

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		txtTracklist.text += "\n";

		#if !switch
		intendedScore = Highscore.getWeekScore(curWeek, curDifficulty);
		#end
	}
}
