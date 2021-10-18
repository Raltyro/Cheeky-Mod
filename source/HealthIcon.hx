package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	public var defaultWidth:Float = 1;
	public var winningIcon:Bool = false;
	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		switch(char){
			case 'cheeky': 
				frames = Paths.getSparrowAtlas('icons/cheeky_icons');
				animation.addByPrefix('Winning', 'Cheeky_Winning', 24, false);
				animation.addByPrefix('Losing', 'Cheeky_Losing', 24, false);

				animation.play('Winning');
				flipX = isPlayer;

				defaultWidth = 1.5;
				setGraphicSize(Std.int(width / 1.5));
			case 'cheekygun': 
				frames = Paths.getSparrowAtlas('icons/cheekygun_icons');
				animation.addByPrefix('Winning', 'CheekyGun_Winning', 24, false);
				animation.addByPrefix('Losing', 'CheekyGun_Winning', 24, false);

				animation.play('Winning');
				flipX = isPlayer;

				defaultWidth = 1.5;
				setGraphicSize(Std.int(width / 1.5));
			case 'omen': 
				frames = Paths.getSparrowAtlas('icons/omen_icons');
				animation.addByPrefix('Winning', 'Cheeky_Winning', 24, false);
				animation.addByPrefix('Losing', 'Cheeky_Losing', 24, false);

				animation.play('Winning');
				flipX = isPlayer;

				defaultWidth = 1.5;
				setGraphicSize(Std.int(width / 1.5));
			case 'cheekymad' | 'cheeky-Scared': 
				frames = Paths.getSparrowAtlas('icons/cheekymad_icons');
				animation.addByPrefix('Losing', 'CheekyMad_Winning', 24, false);
				animation.addByPrefix('Winning', 'CheekyMad_Neutral', 24, false);

				animation.play('Winning');
				flipX = isPlayer;

				defaultWidth = 1.5;
				setGraphicSize(Std.int(width / 1.5));
			default: 
				loadGraphic(Paths.image('iconGrid'), true, 150, 150);
				animation.add('bf', [0, 1], 0, false, isPlayer);
				animation.add('bf-cool', [0, 1], 0, false, isPlayer);
				animation.add('bf-bob', [26, 27], 0, false, isPlayer);
				animation.add('bf-house', [0, 1], 0, false, isPlayer);
				animation.add('bf-car', [0, 1], 0, false, isPlayer);
				animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
				animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
				animation.add('chonka', [30, 31], 0, false, isPlayer);
				animation.add('spooky', [2, 3], 0, false, isPlayer);
				animation.add('pico', [4, 5], 0, false, isPlayer);
				animation.add('mom', [6, 7], 0, false, isPlayer);
				animation.add('mom-car', [6, 7], 0, false, isPlayer);
				animation.add('tankman', [8, 9], 0, false, isPlayer);
				animation.add('face', [10, 11], 0, false, isPlayer);
				animation.add('ron', [24, 25], 0, false, isPlayer);
				animation.add('dad', [12, 13], 0, false, isPlayer);
				animation.add('senpai', [22, 22], 0, false, isPlayer);
				animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
				animation.add('spirit', [23, 23], 0, false, isPlayer);
				animation.add('bf-old', [14, 15], 0, false, isPlayer);
				animation.add('gf', [16], 0, false, isPlayer);
				animation.add('gf-christmas', [16], 0, false, isPlayer);
				animation.add('gf-pixel', [16], 0, false, isPlayer);
				animation.add('parents-christmas', [17, 18], 0, false, isPlayer);
				animation.add('monster', [19, 20], 0, false, isPlayer);
				animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
				animation.play(char);
		}

		antialiasing = true;


		switch(char)
		{
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
				antialiasing = false;
		}

		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
