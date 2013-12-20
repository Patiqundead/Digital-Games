package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class Player extends FlxSprite {
		[Embed(source = "../assets/player/android.png")] private var androidPNG: Class;
		private var level: Level = new Level();
		public var rpx: Number;
		public var rpy: Number;
		
		public function Player(px:Number, py:Number) {
			loadGraphic(androidPNG, true, false, 50, 70, false);
			addAnimation("idle", [0, 1, 2], 10, false);
			addAnimation("move", [3, 4, 5], 20, false);
			addAnimation("jump", [6], 20, false);
			addAnimation("jumpRight", [7], 20, false);
			addAnimation("jumpLeft", [8], 20, false);
			
			rpx = x = px;
			rpy = y = py;
			
			acceleration.y = 300;
		}
		override public function update():void {
			if(FlxG.scores[40] == 1){
				velocity.x = 0;
				if ((FlxG.keys.justPressed("SPACE") || FlxG.keys.pressed("UP")) && isTouching(FLOOR)) {
					velocity.y = -300;
				}
				
				if (FlxG.keys.pressed("RIGHT")) {
					velocity.x = 150;
				}
				
				if (FlxG.keys.pressed("LEFT")) {
					velocity.x = -150;
				}
				
				if (!isTouching(FLOOR) && FlxG.keys.pressed("RIGHT")) {
					play("jumpRight");
				}else if (!isTouching(FLOOR) && FlxG.keys.pressed("LEFT")) {
					play("jumpLeft");
				}else if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("RIGHT")) {
					play("move");
				}else if (FlxG.keys.pressed("SPACE") || FlxG.keys.pressed("UP")) {
					play("jump");
				}else{
					play("idle");
				}
			}else {
				play("idle");
			}
			super.update();
		}
		public function restart(): void {
			reset(rpx, rpy);
		}
	}
}