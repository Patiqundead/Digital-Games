package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class GoldCoin extends FlxSprite {
		[Embed(source="../assets/map/coinGold.png")] private var coinGold:Class;
		
		public function GoldCoin(X:int, Y:int)	{
			super(X * 70, Y * 70, coinGold);
			
			solid = true;
		}
	}
}