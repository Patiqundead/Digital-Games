package  
{
	import org.flashdevelop.utils.TraceLevel;
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class PlayState extends FlxState {
		[Embed(source = "../assets/sounds/fx/coinFX-Slide457.mp3")] private var coinFX: Class;
		[Embed(source = "../assets/sounds/fx/gemFX-Slide458.mp3")] private var gemFX: Class;
		[Embed(source = "../assets/sounds/music/pulsing-intensity.mp3")] private var music: Class;
		
		private var player1: Player;
		private var level1: Level;
		private var gems: int;
		private var hud: GameHUD;
		private var scoreUp: ScoreUp;
		private var doorOpened: Boolean;
		
		public function PlayState() {
			
		}
		
		override public function create():void {
			gems = 0;
			FlxG.score = 0;
			//person life
			FlxG.scores[30] = 2;
			FlxG.scores[40] = 1;
			doorOpened = new Boolean(false);
			
			hud = new GameHUD();
			level1 = new Level();
			player1 = new Player(450, 2300);
			scoreUp = new ScoreUp();
			
			add(level1);
			add(player1);
			add(level1.bronzeCoins);
			add(level1.silverCoins);
			add(level1.goldCoins);
			add(level1.redGems);
			add(level1.greenGems);
			add(level1.blueGems);
			add(hud);
			add(scoreUp);
			
			//	Tell flixel how big our game world is
			FlxG.worldBounds = new FlxRect(0, 0, level1.width, level1.height);
			
			//	Don't let the camera wander off the edges of the map
			FlxG.camera.setBounds(0, 0, level1.width, level1.height);
			
			//	The camera will follow the player
			FlxG.camera.follow(player1, FlxCamera.STYLE_PLATFORMER);
			
			FlxG.playMusic(music, 1);
			super.update();
		}
		
		override public function update():void {
			FlxG.collide(player1, level1);
			
			FlxG.overlap(player1, level1.bronzeCoins, hitCoin);
			FlxG.overlap(player1, level1.silverCoins, hitCoin);
			FlxG.overlap(player1, level1.goldCoins, hitCoin);
			
			FlxG.overlap(player1, level1.redGems, hitGem);
			FlxG.overlap(player1, level1.greenGems, hitGem);
			FlxG.overlap(player1, level1.blueGems, hitGem);
			
			if (player1.x + 50 >= level1.width) {
				player1.x = level1.width - player1.width;
			}
			if (FlxG.scores[30] <= 0) {
				FlxG.scores[30] = 0;
				endGameState();
			}
			if (player1.x > Registry.levelExit.x && player1.y == Registry.levelExit.y && doorOpened){
				player1.exists = false;
				FlxG.fade(0xff000000, 2, endGameState);
			}
			
			hud.lifeUpdate();
			super.update();
		}
		public function endGameState():void {
			FlxG.music.stop();
			FlxG.switchState(new EndGameState);
		}
		
		private function hitCoin(p:FlxObject, coin:FlxObject):void {
			coin.kill();
			if (coin is BronzeCoin) {
				FlxG.score += 100;
				scoreUp.scoreUp(coin.x, coin.y, "100");
			}else if (coin is SilverCoin) {
				FlxG.score += 200;
				scoreUp.scoreUp(coin.x, coin.y, "200");
			}else if (coin is GoldCoin) {
				FlxG.score += 500;
				scoreUp.scoreUp(coin.x, coin.y, "500");
			}else {
				FlxG.log("Erro na contagem da moeda");
			}
			hud.scoreUpdate();
			FlxG.play(coinFX, 1, false, true);
		}
		private function hitGem(p:FlxObject, gem:FlxObject):void {
			gem.kill();
			gems++;
			if (gem is RedGem) {
				hud.pickRed();
				scoreUp.scoreUp(gem.x, gem.y, "Red gem picks");
			}else if (gem is GreenGem) {
				hud.pickGreen();
				scoreUp.scoreUp(gem.x, gem.y, "Green gem picks");
			}else if (gem is BlueGem) {
				hud.pickBlue();
				scoreUp.scoreUp(gem.x, gem.y, "Blue gem picks");
			}else {
				FlxG.log("Erro na contagem de cristais");
			}
			if (gems == level1.allGems) {
				level1.openExit();
				hud.gemsUpdate();
				doorOpened = true;
			}
			FlxG.play(gemFX, 1, false, true);
		}
	}
}