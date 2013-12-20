package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class MenuState extends FlxState {
		
		public var menuText: FlxText;
		public var btnNewGame: FlxButton;
		public var btnCredit: FlxButton;
		private var level: Level;
		private var player: Player;
		private var stateAnim: Number;
		public var version: FlxText;
		
		override public function create():void {
			FlxG.mouse.show();
			
			stateAnim = 1;
			FlxG.score = 0;
			FlxG.scores[40] = 0;
			
			player = new Player(450, 2300);
			level = new Level();
			player.visible = false;
			
			menuText = new FlxText(-200, 2100, FlxG.width, "Finding at the castle", true);
			menuText.alignment = "center";
			menuText.size = 20;
			
			btnNewGame = new FlxButton(700, 2500, "New Game", playState);
			btnCredit = new FlxButton(btnNewGame.x, btnNewGame.y + 25, "Credits", creditState);
			version = new FlxText(btnCredit.x, btnCredit.y + 25, 200, "Version 1.00", true);
			
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
			FlxG.camera.setBounds(0, 0, level.width, level.height);
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
			
			add(level);
			add(player);
			add(menuText);
			add(btnNewGame);
			add(btnCredit);
			add(version);
		}
		
		override public function update():void {
			FlxG.collide(player, level);
			if (menuText.x <= -200) {
				stateAnim = 1;
			}else if (menuText.x >= 300) {
				stateAnim = 0;
			}
			
			if (stateAnim == 1) {
				menuText.velocity.x = 10;
			}else{
				menuText.velocity.x = -10;
			}
			super.update();
		}
		
		public function playState(): void {
			FlxG.fade(0xff000000, 2, newPlayState);
		}
		public function newPlayState(): void {
			FlxG.switchState(new PlayState);
		}
		
		public function creditState(): void {
			FlxG.fade(0xff000000, 2, newCreditState);
		}
		public function newCreditState(): void {
			FlxG.switchState(new CreditState);
		}
	}
}