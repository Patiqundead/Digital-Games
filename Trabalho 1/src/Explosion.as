package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class Explosion extends FlxSprite
	{
		[Embed(source = "../assets/images/explosion48x48.png")] private var explosionPNG: Class;
		private var T_X:int = 48;
		private var T_Y:int = 48;
		
		public function Explosion(theX: int, theY:int) {
			loadGraphic(explosionPNG, true, false, T_X, T_Y, false);
			addAnimation("idle", [7], 1, true);
			addAnimation("boom", [0, 1, 2, 3, 4, 5, 6, 7], 10, false);
			play("idle");
			kill();
		}
		public function boom(theX:int, theY:int):void {
			//reset(theX - width / 2, theY -height / 2);
			reset(theX, theY);
			play("boom", true);
			FlxG.flash();
		}
	}

}