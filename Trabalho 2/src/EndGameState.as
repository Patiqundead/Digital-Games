package  
{
	import adobe.utils.CustomActions;
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class EndGameState extends FlxState {
		private var text: FlxText;
		private var level: Level;
		private var player: Player;
		
		
		public function EndGameState() {
			
		}
		
		override public function create():void {
			FlxG.mouse.show();
			level = new Level();
			player = new Player(450, 2300);
			text = new FlxText(500, 2500, FlxG.width / 2);
			FlxG.scores[40] = 0;
			if (FlxG.scores[30] <= 0) {
				text.text = "You lost!";
			}else {
				text.text = "You won!";
			}
			text.size = 30;
			text.antialiasing = true;
			text.color = 0xffffffff;
			
			add(level);
			add(player);
			add(text);
			
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
			FlxG.camera.setBounds(0, 0, level.width, level.height);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			super.create();
		}
		
		override public function update():void {
			FlxG.collide(player, level);
			text.velocity.y = -10;
			if (text.y <= 2450) {
				FlxG.fade(0xff000000, 1, changeState);
			}
			super.update();
		}
		
		private function changeState():void {
			FlxG.switchState(new MenuState);
		}
	}
}