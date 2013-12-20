package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class SilverCoin extends FlxSprite {
		[Embed(source="../assets/map/coinSilver.png")] private var coinSilver:Class;
		
		public function SilverCoin(X:int, Y:int)	{
			super(X * 70, Y * 70, coinSilver);
			
			solid = true;
		}
	}
}