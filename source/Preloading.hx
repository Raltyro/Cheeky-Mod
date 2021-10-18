package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

using StringTools;

class Preloading extends MusicBeatState
{

    var splash:FlxSprite;
    //var dummy:FlxSprite;
    var loadingText:FlxText;

    var songsCached:Bool = false;
    var songs:Array<String> =   ["Tutorial", 
                                "Bopeebo", "Fresh", "Dadbattle", 
                                "Spookeez", "South", "Monster",
                                "Pico", "Philly", "Blammed", 
                                "Satin-Panties", "High", "Milf", 
                                "Cocoa", "Eggnog", "Winter-Horrorland", 
                                "Senpai", "Roses", "Thorns"];
                                
    //List of character graphics and some other stuff.
    //Just in case it want to do something with it later.
    var charactersCached:Bool = false;
    var characters:Array<String> =   ["BOYFRIEND", "bfCar", "bfChristmas", "bfPixel", "bfPixelsDEAD",
                                    "GF_assets", "gfCar", "gfChristmas", "gfPixel",
                                    "DADDY_DEAREST", "spooky_kids_assets", "Monster_Assets",
                                    "Pico_FNF_assetss", "Mom_Assets", "momCar",
                                    "mom_dad_christmas_assets", "monsterChristmas",
                                    "senpai", "spirit", "senpaiCrazy"];

    var graphicsCached:Bool = false;
    var graphics:Array<String> =    ["shared/images/BONK_splashes", "shared/images/set", "shared/images/go", "shared/images/ready",
                                    "shared/images/good", "shared/images/stagefront", "shared/images/stagecurtains", "shared/images/stageback",
                                    "week2/images/halloween_bg",
                                    "shared/images/bad", "shared/images/shit", "shared/images/sick", "week2/images/void", "week3/images/philly/street", "week3/images/philly/win0", "week3/images/philly/win1", "week3/images/philly/win2", 
                                    "week3/images/philly/win3", "week3/images/philly/win4", "week3/images/philly/behindTrain", "week3/images/philly/city", "week3/images/philly/sky", "week3/images/philly/train",
                                    "week4/images/limo/bgLimo", "week4/images/limo/fastCarLol", "week4/images/limo/limoDancer", "week4/images/limo/LimoStage", "week4/images/limo/limoSunset", "week4/images/limo/limoOverlay",
                                    "week5/images/christmas/bgWalls", "week5/images/christmas/upperBop", "week5/images/christmas/bgEscalator", "week5/images/christmas/christmasTree", "week5/images/christmas/bottomBop", "week5/images/christmas/fgSnow", "week5/images/christmas/santa",
                                    "week5/images/christmas/evilBG", "week5/images/christmas/evilTree", "week5/images/christmas/evilSnow",
                                    "week6/images/weeb/weebSky", "week6/images/weeb/weebSchool", "week6/images/weeb/weebStreet", "week6/images/weeb/weebTreesBack", "week6/images/weeb/weebTrees", "week6/images/weeb/petals", "week6/images/weeb/bgFreaks",
                                    "week6/images/weeb/animatedEvilSchool"];

    var cacheStart:Bool = false;

	override function create()
	{

        FlxG.mouse.visible = false;
        FlxG.sound.muteKeys = null;
//LogoPreload

        splash = new FlxSprite(0, 0);
        splash.frames = Paths.getSparrowAtlas('LogoPreload');
        splash.antialiasing = true;
        splash.animation.addByPrefix('start', 'Start', 24, false);
        splash.animation.addByPrefix('end', 'End', 24, false);
        add(splash);
        splash.updateHitbox();
        splash.screenCenter();
        splash.alpha = 0;
        splash.animation.play("start");
        FlxTween.tween(splash, {alpha: 1}, 1.25, {ease: FlxEase.backInOut});

        loadingText = new FlxText(5, FlxG.height - 30, 0, "", 24);
        loadingText.setFormat("assets/fonts/vcr.ttf", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(loadingText);

        var skiptext:FlxText = new FlxText(0, FlxG.height - 30, 0, "Press Space Bar to Skip Caching", 24);
        skiptext.screenCenter(X);
        skiptext.setFormat("assets/fonts/vcr.ttf", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(skiptext);

        new FlxTimer().start(1.1, function(tmr:FlxTimer)
        {
       //     FlxG.sound.play("assets/sounds/splashSound.ogg");   
        });
        
        super.create();

    }

    override function update(elapsed) 
    {
        if (FlxG.keys.justPressed.SPACE){
            trace('skipped caching');
            FlxG.switchState(new TitleState());
        }
        if(splash.animation.curAnim.finished && splash.animation.curAnim.name == "start" && !cacheStart){
            preload(); 
            cacheStart = true;
        }
        if(splash.animation.curAnim.finished && splash.animation.curAnim.name == "end"){
            FlxG.switchState(new TitleState());
            
        }

        if(songsCached && charactersCached && graphicsCached && !(splash.animation.curAnim.name == "end")){
            
            splash.animation.play("end");
            splash.updateHitbox();
            splash.screenCenter();

            new FlxTimer().start(0.3, function(tmr:FlxTimer)
            {
                loadingText.text = "Done!";
            });

            //FlxG.sound.play("assets/sounds/loadComplete.ogg");
        }
        
        super.update(elapsed);

    }

    function preload(){

        loadingText.text = "Preloading Assets...";

        if(!songsCached){
            sys.thread.Thread.create(() -> {
                preloadMusic();
            });
        }

        if(!charactersCached){
            sys.thread.Thread.create(() -> {
                preloadCharacters();
            });
        }

        if(!graphicsCached){
            sys.thread.Thread.create(() -> {
                preloadGraphics();
            });
        }

    }

    function preloadMusic(){
        for(x in songs){
            FlxG.sound.cache("assets/songs/" + x + "/Inst.ogg");
            trace("Chached " + x);
        }
        FlxG.sound.cache("assets/music/klaskiiLoop.ogg");
        loadingText.text = "Songs cached...";
        songsCached = true;
    }

    function preloadCharacters(){
        for(x in characters){
            ImageCache.add("assets/shared/images/characters" + x + ".png");
            trace("Chached " + x);
        }
        loadingText.text = "Characters cached...";
        charactersCached = true;
    }

    function preloadGraphics(){
        for(x in graphics){
            ImageCache.add("assets/" + x + ".png");
            trace("Chached " + x);
        }
        loadingText.text = "Graphics cached...";
        graphicsCached = true;
    }

}