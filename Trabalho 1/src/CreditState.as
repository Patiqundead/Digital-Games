package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class CreditState extends FlxState
	{
		private var background: Background;
		private var credits	:FlxText;
		private var btnBack :FlxButton;
		
		public function CreditState() { 
		}
		
		override public function create():void {
			FlxG.mouse.show();
			background	= new Background(2);
			
			credits = new FlxText(50, FlxG.height, FlxG.width - 200, "Asteroids\nVersion 1.00\n\n\nDeveloped by: Patrick de Bastiani\nFederal University of Fronteira Sul\nComputer Science\n\n\nGoal:\nCreate a game based on the shooting theme\n\n\nAssets:\nhttp://opengameart.org/\n\n\nSounds:\nhttp://opengameart.org/\nhttp://www.soundfx-free.com/\n");
			credits.alignment = "center";
			credits.color = 0x000000;
			credits.size = 14;
			credits.velocity.y = -18;
			
			btnBack = new FlxButton(FlxG.width - 200, FlxG.height * 0.90, "Voltar", goBack);
			
			add(background);
			add(credits);
			add(btnBack);
		}

		override public function update():void {
			super.update();
			
			if (FlxG.keys.any()) {
				goBack();
			}
			
			if (!credits.onScreen()) {
				credits.y = FlxG.height;
			}
		}
		
		private function goBack() :void {
			FlxG.music.fadeOut(2, true);
			FlxG.fade(0xff000000, 2, changeState);
		}
		
		private function changeState():void {
			FlxG.switchState(new MenuState);
		}
		
	}
}