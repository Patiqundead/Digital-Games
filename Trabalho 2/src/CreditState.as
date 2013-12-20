package  
{
	import org.flixel.*;

	public class CreditState extends FlxState {
		
		[Embed(source = "../assets/other/background0.png")] private var bgPNG: Class;
		private var credits: FlxText;
		private var btnBack: FlxButton;
		private var bg: FlxSprite;
		
		public function CreditState() {
			
		}
		
		override public function create():void {
			FlxG.mouse.show();
			
			bg = new FlxSprite(0, 0, bgPNG);
			
			credits = new FlxText(50, FlxG.height, FlxG.width - 100, "Finding at the castle\nVersion 1.00\n\n\nDeveloped by: Patrick de Bastiani\nFederal University of Fronteira Sul\nComputer Science\n\n\nGoal:\nCreate a platform game\n\n\nAssets:\nwww.opengameart.org/\nwww.kenney.nl/\n\n\nSounds:\nwww.opengameart.org/\nwww.soundfx-free.com/\nwww.freestockmusic.com/\n");
			credits.alignment = "center";
			credits.color = 0xffffff;
			credits.size = 14;
			credits.velocity.y = -18;
			
			btnBack = new FlxButton(FlxG.width - 200, FlxG.height * 0.90, "Back", goBack);
			
			add(bg);
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
		
		private function goBack(): void {
			FlxG.fade(0xff000000, 2, changeState);
		}
		
		private function changeState():void {
			FlxG.switchState(new MenuState);
		}
	}
}