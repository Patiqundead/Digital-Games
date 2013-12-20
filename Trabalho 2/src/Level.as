package  
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class Level extends FlxGroup {
		//mapa
		[Embed(source="../assets/map/mapCSV_map_sky.csv", mimeType="application/octet-stream")] public var skyCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_mapBackground.csv", mimeType="application/octet-stream")] public var mapBackgroundCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_tileset.csv", mimeType="application/octet-stream")] public var tilesetCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_waterLava.csv", mimeType="application/octet-stream")] public var waterLavaCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_bordas.csv", mimeType="application/octet-stream")] public var bordasCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_miscellaneous.csv", mimeType="application/octet-stream")] public var miscellaneousCSV: Class;
		//objetos
		[Embed(source="../assets/map/mapCSV_map_bronzeCoin.csv", mimeType="application/octet-stream")] public var bronzeCoinCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_silverCoin.csv", mimeType="application/octet-stream")] public var silverCoinCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_goldCoin.csv", mimeType="application/octet-stream")] public var goldCoinCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_blueGem.csv", mimeType="application/octet-stream")] public var blueGemCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_redGem.csv", mimeType="application/octet-stream")] public var redGemCSV: Class;
		[Embed(source="../assets/map/mapCSV_map_greenGem.csv", mimeType="application/octet-stream")] public var greenGemCSV: Class;
		
		//imagens
		[Embed(source = "../assets/map/bg.png")] public var skyPNG: Class;
		[Embed(source = "../assets/map/tileset - platform.png")] public var tilesetPNG: Class;
		[Embed(source = "../assets/map/coinBronze.png")] public var bronzeCoinPNG: Class;
		[Embed(source = "../assets/map/coinSilver.png")] public var silverCoinPNG: Class;
		[Embed(source = "../assets/map/coinGold.png")] public var goldCoinPNG: Class;
		[Embed(source = "../assets/map/gemBlue.png")] public var blueGemPNG: Class;
		[Embed(source = "../assets/map/gemRed.png")] public var redGemPNG: Class;
		[Embed(source = "../assets/map/gemGreen.png")] public var greenGemPNG: Class;
		
		//input
		[Embed(source = "../assets/objects/inputs.png")] private var inputPNG: Class;
		
		//sounds
		//[Embed(source = "../assets/sounds/fx/doorFX-Slide464.mp3")] private var doorFX: Class;
		
		public var sky: FlxTilemap;
		public var mapBackground: FlxTilemap;
		public var tileset: FlxTilemap;
		public var waterLava: FlxTilemap;
		public var bordas: FlxTilemap;
		public var miscellaneous: FlxTilemap;
		
		public var bronzeCoins: FlxGroup;
		public var silverCoins: FlxGroup;
		public var goldCoins: FlxGroup;
		public var blueGems: FlxGroup;
		public var redGems: FlxGroup;
		public var greenGems: FlxGroup;
		
		public var width: Number;
		public var height: Number;
		public var allBronzeCoin:Number;
		public var allSilverCoin:Number;
		public var allGoldCoin:Number;
		public var allGems:Number;
		
		public var input: FlxSprite;
		
		public function Level() {
			super();
			
			sky = new FlxTilemap();
			sky.loadMap(new skyCSV, skyPNG, 100, 100);
			sky.setTileProperties(1, FlxObject.NONE, null, null, 4);
			sky.scrollFactor.x = 0.95;
			
			mapBackground = new FlxTilemap();
			mapBackground.loadMap(new mapBackgroundCSV, tilesetPNG, 70, 70);
			mapBackground.setTileProperties(12, FlxObject.ANY, null, null, 0);
			mapBackground.setTileProperties(64, FlxObject.NONE, null, null, 0);
			
			width = mapBackground.width;
			height = mapBackground.height;
			
			tileset = new FlxTilemap();
			tileset.loadMap(new tilesetCSV, tilesetPNG, 70, 70);
			tileset.setTileProperties(1, FlxObject.ANY, null, null, 99);
			
			waterLava = new FlxTilemap();
			waterLava.loadMap(new waterLavaCSV, tilesetPNG, 70, 70);
			waterLava.setTileProperties(24, FlxObject.NONE, hitWaterLava, null, 6);
			
			bordas = new FlxTilemap();
			bordas.loadMap(new bordasCSV, tilesetPNG, 70, 70);
			bordas.setTileProperties(1, FlxObject.NONE, null, null, 99);
			
			miscellaneous = new FlxTilemap();
			miscellaneous.loadMap(new miscellaneousCSV, tilesetPNG, 70, 70);
			miscellaneous.setTileProperties(1, FlxObject.NONE, null, null, 60);
			miscellaneous.setTileProperties(61, FlxObject.ANY, null, null, 0);
			miscellaneous.setTileProperties(62, FlxObject.ANY, null, null, 0);
			
			Registry.map = miscellaneous;
			Registry.levelExit = new FlxPoint((98*70), (24*70));
			
			allBronzeCoin = 0;
			allSilverCoin = 0;
			allGoldCoin = 0;
			allGems = 0;
			
			input = new FlxSprite(150, 2200, inputPNG);
			
			add(sky);
			add(mapBackground);
			add(tileset);
			add(miscellaneous);
			add(waterLava);
			add(bordas);
			add(input);
			
			parseBronzeCoin();
			parseSilverCoin();
			parseGoldCoin();
			parseRedGem();
			parseBlueGem();
			parseGreenGem();
		}
		
		public function openExit():void {
			//FlxG.play(doorFX, 1, false, true);
			miscellaneous.setTile(98, 23, 50, true);
			miscellaneous.setTile(98, 24, 60, true);
		}
		
		private function hitWaterLava(tile :FlxTile, object :FlxObject):void {
			if (object is Player) {
				(object as Player).restart();
				(object as Player).flicker(1);
				FlxG.scores[30]--;
			}
		}
		
		private function parseGreenGem(): void {
			var greenGemMap: FlxTilemap = new FlxTilemap();
			
			greenGemMap.loadMap(new greenGemCSV, greenGemPNG, 70, 70);
			
			greenGems = new FlxGroup();
			
			for (var ty: int = 0; ty < greenGemMap.heightInTiles; ty++) {
				for (var tx: int = 0; tx < greenGemMap.widthInTiles; tx++) {
					if (greenGemMap.getTile(tx, ty) == 1) {
						greenGems.add(new GreenGem(tx, ty));
						allGems++;
					}
				}
			}
		}
		
		private function parseBlueGem(): void {
			var blueGemMap: FlxTilemap = new FlxTilemap();
			
			blueGemMap.loadMap(new blueGemCSV, blueGemPNG, 70, 70);
			
			blueGems = new FlxGroup();
			
			for (var ty: int = 0; ty < blueGemMap.heightInTiles; ty++) {
				for (var tx: int = 0; tx < blueGemMap.widthInTiles; tx++) {
					if (blueGemMap.getTile(tx, ty) == 1) {
						blueGems.add(new BlueGem(tx, ty));
						allGems++;
					}
				}
			}
		}
		
		private function parseRedGem(): void {
			var redGemMap: FlxTilemap = new FlxTilemap();
			
			redGemMap.loadMap(new redGemCSV, redGemPNG, 70, 70);
			
			redGems = new FlxGroup();
			
			for (var ty: int = 0; ty < redGemMap.heightInTiles; ty++) {
				for (var tx: int = 0; tx < redGemMap.widthInTiles; tx++) {
					if (redGemMap.getTile(tx, ty) == 1) {
						redGems.add(new RedGem(tx, ty));
						allGems++;
					}
				}
			}
		}
		
		private function parseGoldCoin(): void {
			var goldCoinMap: FlxTilemap = new FlxTilemap();
			
			goldCoinMap.loadMap(new goldCoinCSV, goldCoinPNG, 70, 70);
			
			goldCoins = new FlxGroup();
			
			for (var ty: int = 0; ty < goldCoinMap.heightInTiles; ty++) {
				for (var tx: int = 0; tx < goldCoinMap.widthInTiles; tx++) {
					if (goldCoinMap.getTile(tx, ty) == 1) {
						goldCoins.add(new GoldCoin(tx, ty));
						allGoldCoin++;
					}
				}
			}
		}
		
		private function parseSilverCoin(): void {
			var silverCoinMap: FlxTilemap = new FlxTilemap();
			
			silverCoinMap.loadMap(new silverCoinCSV, silverCoinPNG, 70, 70);
			
			silverCoins = new FlxGroup();
			
			for (var ty: int = 0; ty < silverCoinMap.heightInTiles; ty++) {
				for (var tx: int = 0; tx < silverCoinMap.widthInTiles; tx++) {
					if (silverCoinMap.getTile(tx, ty) == 1) {
						silverCoins.add(new SilverCoin(tx, ty));
						allSilverCoin++;
					}
				}
			}
		}
		
		private function parseBronzeCoin(): void {
			var bronzeCoinMap: FlxTilemap = new FlxTilemap();
			
			bronzeCoinMap.loadMap(new bronzeCoinCSV, bronzeCoinPNG, 70, 70);
			
			bronzeCoins = new FlxGroup();
			
			for (var ty: int = 0; ty < bronzeCoinMap.heightInTiles; ty++) {
				for (var tx: int = 0; tx < bronzeCoinMap.widthInTiles; tx++) {
					if (bronzeCoinMap.getTile(tx, ty) == 1) {
						bronzeCoins.add(new BronzeCoin(tx, ty));
						allBronzeCoin++;
					}
				}
			}
		}
	}
}