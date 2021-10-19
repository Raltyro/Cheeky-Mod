package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class BackgroundSprite extends FlxSpriteGroup
{
	var background:FlxSprite;
	public var defaultZoom:Float = 1;
//	var movingElements:FlxTypedGroup<FlxSprite>;
	
	//Week 5
	var santa:FlxSprite;
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var floorthing:FlxSprite;
	var thingy:FlxSprite;
	var backgthing:FlxSprite;
	// Week MUGEN
	public var wallcolors:Array<String> = [
		'#762e80',
		'#1d1870',
		'#96140e',
		'#8f8b1f',
		'#227d4c',
		'#551a8b',

	];
	public var curColor = 0;
	public var wall:FlxSprite;
	public var frontDudes:FlxSprite;
	var fire:FlxSprite;
	var truck:FlxSprite;
	public function new(?DaBackground:String)
	{
		super();
		trace(DaBackground);
		//dirty fix for some weirdass issue i was havin
		if (DaBackground == null){ 	//you probs don't want to remove this
			defaultZoom = 0.9;
			background = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback', 'shared'));
			background.antialiasing = FlxG.save.data.antialasing;
			background.scrollFactor.set(0.9, 0.9);
			background.active = false;
			add(background);

			var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront', 'shared'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
			stageFront.updateHitbox();
			stageFront.antialiasing = FlxG.save.data.antialasing;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);

			var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains', 'shared'));
			stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
			stageCurtains.updateHitbox();
			stageCurtains.antialiasing = FlxG.save.data.antialasing;
			stageCurtains.scrollFactor.set(1.3, 1.3);
			stageCurtains.active = false;

			add(stageCurtains);
		}
		else{
			switch(DaBackground){
				case 'stage': 
					defaultZoom = 0.9;
					background = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback', 'shared'));
					background.antialiasing = FlxG.save.data.antialasing;
					background.scrollFactor.set(0.9, 0.9);
					background.active = false;
					add(background);
	
					var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront', 'shared'));
					stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
					stageFront.updateHitbox();
					stageFront.antialiasing = FlxG.save.data.antialasing;
					stageFront.scrollFactor.set(0.9, 0.9);
					stageFront.active = false;
					add(stageFront);
	
					var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains', 'shared'));
					stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
					stageCurtains.updateHitbox();
					stageCurtains.antialiasing = FlxG.save.data.antialasing;
					stageCurtains.scrollFactor.set(1.3, 1.3);
					stageCurtains.active = false;
	
					add(stageCurtains);
				case 'mugen': 
					defaultZoom = 0.75;
					switch (PlayState.SONG.song.toLowerCase()){
						case 'hard 2 break':
							wall = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
							wall.antialiasing = FlxG.save.data.antialasing;
							wall.setGraphicSize(Std.int(wall.width * 10));
							add(wall);
							FlxTween.color(wall, 1, wall.color, FlxColor.fromString(wallcolors[FlxG.random.int(1, 5)]));

							background = new FlxSprite().loadGraphic(Paths.image('mugen/week1/backgrounds/Hard2Break_Castle', 'shared'));
							background.antialiasing = FlxG.save.data.antialasing;
							background.screenCenter();
							background.setGraphicSize(Std.int(background.width * 1.5));
						//	background.color = FlxColor.fromString('#2d27a1');
							add(background);
						default: 
							background = new FlxSprite().loadGraphic(Paths.image('mugen/week1/backgrounds/MugenCastle', 'shared'));
							background.antialiasing = FlxG.save.data.antialasing;
							background.screenCenter();
							background.setGraphicSize(Std.int(background.width * 1.5));
							add(background);
					}
					switch(PlayState.SONG.song.toLowerCase()){
						case 'toughstone': 
							bottomBoppers = new FlxSprite();
							bottomBoppers.frames = Paths.getSparrowAtlas('mugen/week1/backgrounds/crowd');
							bottomBoppers.animation.addByPrefix('idle', 'crowd', 24, false);
							bottomBoppers.screenCenter();
							bottomBoppers.y += 45;
						//	bottomBoppers.scrollFactor.set(0.9, 0.9);
							bottomBoppers.antialiasing = FlxG.save.data.antialasing;
							bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1.3));
							add(bottomBoppers);
						case 'hard 2 break': // had to do this cause i have a different haxe version
							bottomBoppers = new FlxSprite();
							bottomBoppers.frames = Paths.getSparrowAtlas('mugen/week1/backgrounds/crowd');
							bottomBoppers.animation.addByPrefix('idle', 'crowd', 24, false);
							bottomBoppers.screenCenter();
							bottomBoppers.y += 45;
						//	bottomBoppers.scrollFactor.set(0.9, 0.9);
							bottomBoppers.antialiasing = FlxG.save.data.antialasing;
							bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1.3));
							add(bottomBoppers);
							
							frontDudes = new FlxSprite();
							frontDudes.frames = Paths.getSparrowAtlas('mugen/week1/backgrounds/crowd');
							frontDudes.animation.addByPrefix('idle', 'crowd2', 24, false);
							frontDudes.screenCenter();
							frontDudes.antialiasing = FlxG.save.data.antialasing;
							frontDudes.y += 85;
						//	bottomBoppers.scrollFactor.set(0.9, 0.9);
							frontDudes.setGraphicSize(Std.int(frontDudes.width * 1.3));
						}
				case 'omen': 
					defaultZoom = 0.45;
							background = new FlxSprite().loadGraphic(Paths.image('mugen/OMEN/backgrounds/BadOmen_Sky', 'shared'));
							background.antialiasing = FlxG.save.data.antialasing;
							background.screenCenter();
							background.setGraphicSize(Std.int(background.width * 1.5));
							add(background);

							var dawall:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/OMEN/backgrounds/BadOmen_Wall', 'shared'));
							dawall.antialiasing = FlxG.save.data.antialasing;
							dawall.screenCenter();
							dawall.setGraphicSize(Std.int(dawall.width * 1.5));
							add(dawall);

							var pillars:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/OMEN/backgrounds/BadOmen_Pillars', 'shared'));
							pillars.antialiasing = FlxG.save.data.antialasing;
							pillars.screenCenter();
							pillars.setGraphicSize(Std.int(pillars.width * 1.3));
							add(pillars);
				case 'meat': 
						defaultZoom = 0.65;
					switch(PlayState.SONG.song.toLowerCase()){
						case 'bad eggroll': 
							background = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/MeatPlant_Back_RainySky', 'shared'));
							background.antialiasing = FlxG.save.data.antialasing;
							background.screenCenter();
							background.setGraphicSize(Std.int(background.width * 1.5));
							add(background);
						default: 
							background = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/MeatPlant_Back_Sky', 'shared'));
							background.antialiasing = FlxG.save.data.antialasing;
							background.screenCenter();
							background.setGraphicSize(Std.int(background.width * 1.5));
							add(background);	
						}
						var floor:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/MeatPlant_Floor', 'shared'));
						floor.antialiasing = FlxG.save.data.antialasing;
						floor.screenCenter();
						floor.setGraphicSize(Std.int(floor.width * 1.5));
						add(floor);
						
						truck = new FlxSprite();
						truck.frames = Paths.getSparrowAtlas('mugen/week3/backgrounds/truck_go_brr');
						truck.animation.addByPrefix('idle', 'Moving Truck', 24);
						truck.screenCenter();
						truck.x = 3500; 
						truck.scrollFactor.set();
						truck.animation.play('idle');
						truck.antialiasing = FlxG.save.data.antialasing;
						add(truck);

						var thing:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/MeatPlant_Props', 'shared'));
						thing.antialiasing = FlxG.save.data.antialasing;
						thing.screenCenter();
						thing.setGraphicSize(Std.int(thing.width * 1.25));
						add(thing);
				case 'hell': 
					defaultZoom = 0.65;
					background = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/Pankreas_Back_Sky', 'shared'));
					background.antialiasing = FlxG.save.data.antialasing;
					background.screenCenter();
					background.setGraphicSize(Std.int(background.width * 1.5));
					add(background);

					var backhill:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/Pankreas_Back_Hills', 'shared'));
					backhill.antialiasing = FlxG.save.data.antialasing;
					backhill.screenCenter();
					backhill.setGraphicSize(Std.int(backhill.width * 1.5));
					add(backhill);

					var hills:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/Pankreas_Hills', 'shared'));
					hills.antialiasing = FlxG.save.data.antialasing;
					hills.screenCenter();
					hills.setGraphicSize(Std.int(hills.width * 1.5));
					add(hills);

					var lake:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/Pankreas_Red_River', 'shared'));
					lake.antialiasing = FlxG.save.data.antialasing;
					lake.screenCenter();
					lake.setGraphicSize(Std.int(lake.width * 1.5));
					add(lake);

					var platform:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/Pancreas_Platform', 'shared'));
					platform.antialiasing = FlxG.save.data.antialasing;
					platform.screenCenter();
					platform.setGraphicSize(Std.int(platform.width * 1.5));
					add(platform);

					backgthing = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/MeatPlant_Back_RainySky', 'shared'));
					backgthing.antialiasing = FlxG.save.data.antialasing;
					backgthing.screenCenter();
					backgthing.setGraphicSize(Std.int(backgthing.width * 1.5));
					add(backgthing);

					thingy = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/MeatPlant_Floor', 'shared'));
					thingy.antialiasing = FlxG.save.data.antialasing;
					thingy.screenCenter();
					thingy.setGraphicSize(Std.int(thingy.width * 1.5));
					add(thingy);
					
					floorthing = new FlxSprite().loadGraphic(Paths.image('mugen/week3/backgrounds/MeatPlant_Props', 'shared'));
					floorthing.antialiasing = FlxG.save.data.antialasing;
					floorthing.screenCenter();
					floorthing.setGraphicSize(Std.int(floorthing.width * 1.25));
					add(floorthing);
				case 'house': 
					defaultZoom = 0.675; 
					var guy1:Character = new Character(0, 0, 'cheeky-cool');
					add(guy1);
					var guy2:Character = new Character(0, 0, 'bf-cool');
					add(guy2);
					guy2.visible = false;
					guy1.visible = false;
					//scuffed preloading lmao it's 2 in the morning and i'm tired
					var galaxy:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week2/backgrounds/Galaxy_Back', 'shared'));
					galaxy.antialiasing = FlxG.save.data.antialasing;
					galaxy.screenCenter();
					galaxy.setGraphicSize(Std.int(galaxy.width * 2.15));
					add(galaxy);

					var galaxypillars:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week2/backgrounds/Galaxy_Pillars', 'shared'));
					galaxypillars.antialiasing = FlxG.save.data.antialasing;
					galaxypillars.screenCenter();
					galaxypillars.setGraphicSize(Std.int(galaxy.width * 1.45));
					add(galaxypillars);

					var floor:FlxSprite = new FlxSprite().loadGraphic(Paths.image('mugen/week2/backgrounds/Galaxy_Floor', 'shared'));
					floor.antialiasing = FlxG.save.data.antialasing;
					floor.screenCenter();
					floor.setGraphicSize(Std.int(floor.width * 2.15));
					add(floor);

					background = new FlxSprite().loadGraphic(Paths.image('mugen/week2/backgrounds/cheekyhouse', 'shared'));
					background.antialiasing = FlxG.save.data.antialasing;
					background.screenCenter();
					background.setGraphicSize(Std.int(background.width * 1.5));
					add(background);

					
					fire = new FlxSprite();
					fire.frames = Paths.getSparrowAtlas('mugen/week2/backgrounds/flame');
					fire.animation.addByPrefix('idle', 'finre', 24, false);
					fire.screenCenter();
					fire.x -= 115; 
					fire.y -= 245;
					fire.setGraphicSize(Std.int(fire.width * 1.5));
					fire.scrollFactor.set();
					fire.animation.play('idle');
					add(fire);

				case 'kitchen': 
					defaultZoom = 0.575;
						background = new FlxSprite().loadGraphic(Paths.image('mugen/ron/backgrounds/RON_background_sign', 'shared'));
						background.antialiasing = FlxG.save.data.antialasing;
						background.screenCenter();
						background.setGraphicSize(Std.int(background.width * 1.4));
						background.y += 200;
						background.scrollFactor.set(0.9, 0.9);

						add(background);

						wall = new FlxSprite().loadGraphic(Paths.image('mugen/ron/backgrounds/RON_background_sign_on', 'shared'));
						wall.antialiasing = FlxG.save.data.antialasing;
						wall.screenCenter();
						wall.setGraphicSize(Std.int(wall.width * 1.4));
						wall.y += 200;
						wall.scrollFactor.set(0.9, 0.9);

						add(wall);
						wall.visible = false;

						bottomBoppers = new FlxSprite();
						bottomBoppers.frames = Paths.getSparrowAtlas('mugen/ron/backgrounds/RON_crowd');
						bottomBoppers.animation.addByPrefix('idle', 'crowd', 24, false);
						bottomBoppers.screenCenter();
						bottomBoppers.y += 300;
						bottomBoppers.x += 100;
						bottomBoppers.scrollFactor.set(0.7, 0.7);
						bottomBoppers.antialiasing = FlxG.save.data.antialasing;

						bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1.4));
						add(bottomBoppers);

						frontDudes = new FlxSprite();
						frontDudes.frames = Paths.getSparrowAtlas('mugen/ron/backgrounds/RON_crowd_clappinglaughing');
						frontDudes.animation.addByPrefix('idle', 'crowd', 24, false);
						frontDudes.screenCenter();
						frontDudes.antialiasing = FlxG.save.data.antialasing;
						frontDudes.scrollFactor.set(0.7, 0.7);
						frontDudes.setGraphicSize(Std.int(frontDudes.width * 1.4));
						frontDudes.y += 300;
						frontDudes.x += 100;

						add(frontDudes);
						frontDudes.visible = false;

						var kitchenthingy:FlxSprite;
						kitchenthingy = new FlxSprite().loadGraphic(Paths.image('mugen/ron/backgrounds/RON_stage', 'shared'));
						kitchenthingy.scrollFactor.set();
						kitchenthingy.screenCenter();
						kitchenthingy.antialiasing = FlxG.save.data.antialasing;
						kitchenthingy.setGraphicSize(Std.int(kitchenthingy.width * 1.4));

						add(kitchenthingy);

						var liteth:FlxSprite;
						liteth = new FlxSprite().loadGraphic(Paths.image('mugen/ron/backgrounds/RON_lights', 'shared'));
						liteth.scrollFactor.set(1, 1);
						liteth.screenCenter();
						liteth.antialiasing = FlxG.save.data.antialasing;
						liteth.setGraphicSize(Std.int(kitchenthingy.width * 1.4));
						liteth.y += 265;
						add(liteth);
					}
				}
			}

	override function update(elapsed:Float)
	{
		if(PlayState.SONG.stage == 'meat'){
			truck.x -= 2.5; 
			if (truck.x <= -3500){
				truck.x = 3500;
			}
	 	}
		super.update(elapsed);
	}
	
	public function bop(){
		switch(PlayState.SONG.stage){
			case 'mugen': 
			switch (PlayState.SONG.song.toLowerCase()){
				case 'toughstone' | 'hard 2 break': 
					bottomBoppers.animation.play('idle');
			}
			case 'kitchen': 
				bottomBoppers.animation.play('idle');
				frontDudes.animation.play('idle');
			case 'house': 
				fire.animation.play('idle');
		}
	}
	public function addFrontLayer(){
		switch(PlayState.SONG.stage){
			case 'mugen':
				if (PlayState.SONG.song.toLowerCase() == 'hard 2 break'){
			//		add(frontDudes);
				}
			}
		}
	public function switchbg(idk:Bool){
		switch(PlayState.SONG.stage){
		case 'house':
			background.visible = false;
			fire.visible = false;
		case 'hell': 
			backgthing.visible = false;
			thingy.visible = false;
			floorthing.visible = false;
		case 'kitchen': 
			switch(idk){
				case true: 
					background.visible = false;
					wall.visible = true;
					bottomBoppers.visible = false;
					frontDudes.visible = true;
				case false: 
					background.visible = true;
					wall.visible = false;
					bottomBoppers.visible = true;
					frontDudes.visible = false;
			}
		}
	}
}
