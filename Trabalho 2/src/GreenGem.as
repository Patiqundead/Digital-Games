package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class GreenGem extends FlxSprite {
		[Embed(source="../assets/map/gemGreen.png")] private var gemGreen:Class;
		
		public function GreenGem(X:int, Y:int)	{
			super(X * 70, Y * 70, gemGreen);
			
			solid = true;
		}
	}
}