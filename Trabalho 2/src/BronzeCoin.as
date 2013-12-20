package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class BronzeCoin extends FlxSprite {
		[Embed(source="../assets/map/coinBronze.png")] private var coinBronze:Class;
		
		public function BronzeCoin(X:int, Y:int)	{
			super(X * 70, Y * 70, coinBronze);
			
			solid = true;
		}
	}
}