package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = "../assets/sounds/Brave Solders.mp3")] private var braveSoldersMP3: Class;
		private var button1: FlxButton;
		private var button2: FlxButton;
		private var back1: Background;
		private var title: FlxText;
		private var subLine: FlxText;
		
		override public function create():void {
			FlxG.level = 1;
			
			var i: int;
			button1 = new FlxButton((FlxG.width-100), (FlxG.height-180), "new game", goPlayState);
			button2 = new FlxButton((FlxG.width-100), (FlxG.height-150), "credits", goCreditState);
			back1 = new Background(2);
			
			title = new FlxText((FlxG.width-800) / 2, 100, FlxG.width - 10, "ASteroidS!");
			title.alignment = "center";
			title.size = 100;
			title.color = 0xff00b2ee;
			
			subLine = new FlxText(FlxG.width - 80, FlxG.height - 20, FlxG.width, "Version 1.00", true);
			subLine.size = 10;
			subLine.color = 0xff000000;
			subLine.alignment = "left";
			
			FlxG.playMusic(braveSoldersMP3, 0.9);
			
			add(back1);
			add(button1);
			add(button2);
			add(title);
			add(subLine);
			
			FlxG.mouse.show();
			super.create();
		}
		private function goPlayState():void {
			FlxG.music.fadeOut(2, true);
			FlxG.fade(0xff000000, 2, newGame);
		}
		private function newGame(): void {
			FlxG.switchState(new GameState());
		}
		private function goCreditState():void {
			FlxG.music.fadeOut(2, true);
			FlxG.fade(0xff000000, 2, newCredit);
		}
		private function newCredit(): void {
			FlxG.switchState(new CreditState());
		}
		override public function update():void {
			super.update();
		}
	}

}