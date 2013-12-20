package 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class Main extends FlxGame {
		public function Main() {
			super(800, 600, MenuState, 1);
			//super(400, 300, PlayState, 2);
			forceDebugger = true;
		}	
	}
}