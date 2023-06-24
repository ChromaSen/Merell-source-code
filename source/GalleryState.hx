package;
import flixel.util.FlxSave;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import lime.utils.Assets;
import openfl.Lib;
import openfl.utils.Assets as OpenFlAssets;
import flixel.group.FlxSpriteGroup;
#if sys
import sys.FileSystem;
import sys.io.File;
#end
class GalleryState extends MusicBeatState {
   //sorry for what i'm about to do..
    public var gallery:Array<String>=[
        "Merell Bio", 
        "Click-Tick Bio", 
        "Amalgamation Concept",
        "BG Concept",
        "Botsta Night",
        "Merell - Nuclear Smash",
        "Merell Phase 1 Concept",
        "Merell Phase 2 Concepts",
        "Octane Stage Concept Art 1",
        "Octane Stage Concept Art 2",
        "Octane Stage Concept Art 3",
        "R3X Concept",
        "Click-Tick Original 2015 Design",
        "Amalgamation Click-Tick 2017",
        "Amalgamation Click-Tick 2018",
        "Merell 2019 Design",
        "Merell Early 2020 Design",
        "Merell Late 2020 Design",
        "Merell forme de Nuclear Throne",
        "Merell 2020 Redesign - RustyToast",
        "Merell Sketch - Phantom Arcade",
        "Minus Merell - Nevy",
        "Human Merell",
        "B-Sides Merell Concept - d0munit & Edvin",
        "D Sides Merell",
        "Spiraling and Haywire previously Hardwire Storyboards",
        "Whats Pacer",
        "Creature Model - Bandit"
    ];

    public var arrowLeft:Arrow;
    public var arrowRight:Arrow;
    
    public var bg:FlxSprite;
    public var curimage:Int=0;
    public var curarray:Array<FlxSprite>;
    
    public var galleryspr:FlxGroup;
    public var txt:FlxText;
    public var bottom:FlxSprite;
    public var curimagegal:FlxSprite;
    
    public var zoomlvl:Float=1;
    public var till:Float=1;
    public var until:Float=2; 
    public var speed:Float=0.05;
    public var camFollow:FlxObject;
    public var scrolltxt:FlxText;
    override public function create() {
        super.create();

        FlxG.mouse.visible=true;
        camFollow=new FlxObject(0,0,1,1);
    
        bg = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
        bg.setGraphicSize(Std.int(bg.width * 1.175));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);
    
        bottom=new FlxSprite(0,590).makeGraphic(1280,170,FlxColor.BLACK);
        bottom.scale.set(2,1);
        add(bottom);
    
        arrowLeft=new Arrow("left");
        arrowLeft.screenCenter();
        arrowLeft.scrollFactor.set(0,0);
        arrowLeft.x=8;
        add(arrowLeft);
    
        arrowRight=new Arrow("right");
        arrowRight.screenCenter();
        arrowRight.scrollFactor.set(0,0);
        arrowRight.x=FlxG.width-arrowRight.width-8;
        add(arrowRight);
        
        curarray=[];
        init();
        scrolltxt=new FlxText(0,0,FlxG.width,"Use your mouse wheel to Zoom in/out");
        scrolltxt.setFormat(Paths.font("tahomabd.ttf"),16,FlxColor.WHITE,CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        scrolltxt.alpha=0.5;
        scrolltxt.setPosition(0,668);
        scrolltxt.scale.set(1.05,1.05);
        txt=new FlxText(0,0,FlxG.width,"Current image: ");
        txt.setFormat(Paths.font("tahomabd.ttf"),32,FlxColor.WHITE,CENTER,FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
        txt.setPosition(0,618);
        txt.scale.set(1.15,1.15);
        add(scrolltxt);
        add(txt);
        add(galleryspr);

        camFollow.screenCenter();
    
        FlxG.camera.follow(camFollow,LOCKON,1.0);
        showcurspr();
    }

    override public function update(elapsed:Float){

        camFollow.setPosition(
            FlxMath.lerp(
                camFollow.x,
                FlxMath.remapToRange(
                    FlxG.mouse.screenX,
                    0,
                    FlxG.width,
                    (FlxG.width/2)+16,
                    (FlxG.width/2)-16
                ),
                3.5*elapsed
            ),
            FlxMath.lerp(
                camFollow.y,
                FlxMath.remapToRange(
                    FlxG.mouse.screenY,
                    0,
                    FlxG.height,
                    (FlxG.height/2)-16,
                    (FlxG.height/2)+16
                ),
                3.5*elapsed
            )
        );
        var wheel:Int=FlxG.mouse.wheel;

        (wheel<0)?zoomOut():
        (wheel>0)?zoomIn():null;
        zoomlvl=(zoomlvl<till)?zoomlvl+speed:(zoomlvl>till)?zoomlvl-speed:zoomlvl;
        zoomlvl=(zoomlvl>until)?until:zoomlvl;
        
        FlxG.camera.zoom=zoomlvl;
    
        if (FlxG.mouse.justPressed){
            for (arr in[arrowLeft,arrowRight]){
                if (overlapHelper(arr)) {
                    arr.playAnim("push");
                    if (arr==arrowRight){
                        curimage++;
                        if(curimage>=curarray.length){
                            curimage=0;
                        }
                        showcurspr();
                    }else if(arr==arrowLeft){
                        curimage--;
                        if (curimage<0){
                            curimage=curarray.length-1;
                        }
                        showcurspr();
                    }
                }else{arr.playAnim("idle");}
                
            }
        }
        
    
        for (arr in[arrowLeft,arrowRight]){
            if (!overlapHelper(arr))
                arr.playAnim("idle");
        }
        if (FlxG.keys.justPressed.ESCAPE){
            MusicBeatState.switchState(new MainMenuState());
        }
        super.update(elapsed);
    }

    public function zoomIn(){
        till=(till<until)?((till+=speed)>until?until:till):till;

    }
    
    public function zoomOut(){
        till=(zoomlvl>1.0)?(till-=speed):till;
    }

    public var gl:FlxSprite;
    public function init(){
        galleryspr=new FlxGroup();
    
        for (i in 0...gallery.length){
            gl=new FlxSprite().loadGraphic(Paths.image("gallery/everything/" + gallery[i]));
            gl.updateHitbox();
            gl.scale.set(0.2,0.2);
            gl.exists=false;
    
            curarray.push(gl);
            galleryspr.add(gl);
        }
    }

    public function showcurspr(){
        if (curimagegal!=null){
            curimagegal.exists=false;
        }
    
        curimage=(curimage+gallery.length)%gallery.length;
    
        curimagegal=cast(galleryspr.members[curimage],FlxSprite);
        curimagegal.exists=true;
        curimagegal.screenCenter();
        

        switch(gallery[curimage]){

            /*
            *scale, x,y
            * 
            */
            case "Merell Bio":
                pos(0.18,-860,-1190);
            case "Click-Tick Bio":
                pos(0.175,-860,-1190);
            case "Amalgamation Concept":
                pos(0.178,-1110,-1190);
            case "BG Concept":
                pos(0.5,-360,-190);
            case "Botsta Night":
                pos(0.5,-60,-190);
            case "Merell - Nuclear Smash":
                pos(0.18,-345.5,-1190);
            case "Merell Phase 1 Concept":
                pos(0.18,-996,-1190);
            case "Merell Phase 2 Concepts":
                pos(0.19,-860,-1200);
            case "Octane Stage Concept Art 1"|"Octane Stage Concept Art 2"|"Octane Stage Concept Art 3":
                pos(0.25,-710,-620);
            case "R3X Concept":
                curimagegal.setPosition(-693,-920);
            case "Click-Tick Original 2015 Design":
                pos(0.25,-360,-670);
            case "Amalgamation Click-Tick 2017":
                pos(0.18,-860,-1190);
            case "Amalgamation Click-Tick 2018":
                curimagegal.setPosition(-860,-1190);
            case "Merell 2019 Design":
                pos(0.25,-110,-670);
            case "Merell Early 2020 Design":
                pos(0.18,-485,-1190);
            case "Merell Late 2020 Design":
                curimagegal.setPosition(-735,-1065);
            case "Merell 2020 Redesign - RustyToast":
                curimagegal.setPosition(-360,-970);
            case "Merell Sketch - Phantom Arcade":
                pos(0.25,-920,-543);
            case "Minus Merell - Nevy":
                pos(0.5,-135,-118);
            case "Human Merell":
                pos(0.25,15,-670);
            case "B-Sides Merell Concept - d0munit & Edvin":
                pos(0.18,-860,-1185);
            case "D Sides Merell":
                pos(0.23,-235,-795);
            case "Spiraling and Haywire previously Hardwire Storyboards":
                pos(0.3,-110,-532.5);
                txt.scale.set(1,1);
            case "Whats Pacer":
                txt.scale.set(1.15,1.15);
                pos(0.23,-360,-670);
        }
    
        txt.text="Current image: " + gallery[curimage];
    }

    public function pos(scale:Float,x:Float,y:Float){
        curimagegal.scale.set(scale,scale);
        curimagegal.setPosition(x,y);
    }
    


    private function overlapHelper(spr:FlxSprite):Bool{
        var screenpos:FlxPoint=spr.getScreenPosition();
        var mousepos:FlxPoint=FlxG.mouse.getScreenPosition(camera);
        return(mousepos.x>=screenpos.x&&mousepos.x<=screenpos.x+spr.width)&&(mousepos.y>=screenpos.y&&mousepos.y<=screenpos.y+spr.height);
    }
}

class Arrow extends FlxSprite{
    public var selection:Int=0;

    override public function new(name:String){
        super();

        frames=Paths.getSparrowAtlas("freeplay_buttons");

        animation.addByIndices("idle",name,[0],"",1,false);
        animation.addByIndices("push",name,[1],"",1,false);

        animation.play("idle");
    }

    private var holdTime:Float=0.0;

    override function update(elapsed:Float){
        super.update(elapsed);
    }

    public function playAnim(name:String){
        if (name=="push")
            holdTime=0.06;

        animation.play(name);
        centerOffsets();
    }
}
