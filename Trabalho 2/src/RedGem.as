package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class RedGem extends FlxSprite {
		[Embed(source="../assets/map/gemRed.png")] private var gemRed:Class;
		
		public function RedGem(X:int, Y:int)	{
			super(X * 70, Y * 70, gemRed);
			
			solid = true;
		}
	}
}