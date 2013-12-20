package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class BlueGem extends FlxSprite {
		[Embed(source="../assets/map/gemBlue.png")] private var gemBlue:Class;
		
		public function BlueGem(X:int, Y:int)	{
			super(X * 70, Y * 70, gemBlue);
			
			solid = true;
		}
	}
}