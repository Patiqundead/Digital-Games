package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class GameHUD extends FlxGroup {
		[Embed(source = "../assets/objects/iconBlueGemEmpty.png")] private var iconBlueGemEmpty: Class;
		[Embed(source = "../assets/objects/iconRedGemEmpty.png")] private var iconRedGemEmpty: Class;
		[Embed(source = "../assets/objects/iconGreenGemEmpty.png")] private var iconGreenGemEmpty: Class;
		[Embed(source = "../assets/objects/iconGreenGem.png")] private var iconGreenGem: Class;
		[Embed(source = "../assets/objects/iconRedGem.png")] private var iconRedGem: Class;
		[Embed(source = "../assets/objects/iconBlueGem.png")] private var iconBlueGem: Class;
		
		public var highScore: FlxText;
		public var life: FlxText;
		public var text: FlxText;
		public var iconBlue: FlxSprite;
		public var iconRed: FlxSprite;
		public var iconGreen: FlxSprite;
		
		public function GameHUD() {
			super();
			highScore = new FlxText(FlxG.width-100, 10, FlxG.width - 20, "Score: " + FlxG.score, true);
			highScore.size = 12;
			
			life = new FlxText(FlxG.width-250, 10, 200, "Lifes: " + FlxG.scores[30], true);
			life.size = 12;
			life.alignment = "center";
			
			iconBlue = new FlxSprite(10, 30, iconBlueGemEmpty);
			iconGreen = new FlxSprite(iconBlue.x + 30, 30, iconGreenGemEmpty);
			iconRed = new FlxSprite(iconGreen.x + 30, 30, iconRedGemEmpty);
			
			text = new FlxText(10, 10, 200, "Pick all gems", true);
			text.size = 12;
			
			add(highScore);
			add(life);
			add(iconBlue);
			add(iconGreen);
			add(iconRed);
			add(text);
			
			setAll("scrollFactor", new FlxPoint());
		}
		public function pickBlue(): void {
			iconBlue.loadGraphic(iconBlueGem, false, false, 26, 16, false);
		}
		public function pickGreen(): void {
			iconGreen.loadGraphic(iconGreenGem, false, false, 26, 16, false);
		}
		public function pickRed(): void {
			iconRed.loadGraphic(iconRedGem, false, false, 26, 16, false);
		}
		public function scoreUpdate(): void {
			highScore.text = "Score: " + FlxG.score;
		}
		public function lifeUpdate(): void {
			life.text = "Lifes: " + FlxG.scores[30];
		}
		public function gemsUpdate(): void {
			text.text = "Exit open";
		}
	}
}