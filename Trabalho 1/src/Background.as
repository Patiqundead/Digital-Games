package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class Background extends FlxSprite
	{
		[Embed(source = "../assets/images/space1 - 800x600.png")] private var background1PNG: Class;
		[Embed(source = "../assets/images/space2 - 800x600.png")] private var background2PNG: Class;
		[Embed(source = "../assets/images/space3 - 800x600.png")] private var background3PNG: Class;
		
		public function Background(b:int) {
			if (b == 1) {
				loadGraphic(background1PNG);
			}else if (b == 2) {
				loadGraphic(background2PNG);
			}else if (b == 3) {
				loadGraphic(background3PNG);
			}else {
				makeGraphic(FlxG.width, FlxG.height, 0xffff0000);
			}
		}
		
		override public function update():void {
			super.update();
			
		}
	}

}