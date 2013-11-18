package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class GameState extends FlxState
	{
		[Embed(source = "../assets/sounds/SDM_FightingBack.mp3")] private var fightingBackMP3: Class;
		[Embed(source="../assets/sounds/FX-Impact193.mp3")] private var explosionMP3: Class;
		private var player1: Ship;
		private var back1: Background;
		private var asteroidsG: FlxGroup;
		private var asteroidsM: FlxGroup;
		private var asteroidsP: FlxGroup;
		private var asteroidsPP: FlxGroup;
		public var playerBullets: FlxGroup;
		public var vsPlayerBullets: FlxGroup;
		public var vsAsteroidsG: FlxGroup;
		public var vsAsteroidsM: FlxGroup;
		public var vsAsteroidsP: FlxGroup;
		private var asteroidsVivos: int;
		private var auxAstVivos:int;
		public var textVidas: FlxText;
		private var explosion: Explosion;
		public var textLevel: FlxText;
		public var textAstVivos: FlxText;
		public var textMaxLevel: FlxText;
		private var countTemp: int;
		
		private static const NUM_PLAYER_BULLETS: int = 30;
		
		override public function create():void {
			super.create();
			
			if (FlxG.level <= 5) {
				FlxG.playMusic(fightingBackMP3, 1);
				back1 = new Background(1);
			}else if(FlxG.level >= 6){
				FlxG.playMusic(fightingBackMP3, 1);
				back1 = new Background(3);
			}
			countTemp = 0;
			
			auxAstVivos = 1;
			var bullet: Bullet;
			var ast: Asteroid;
			player1 = new Ship(FlxG.width / 2, FlxG.height / 2);
			explosion = new Explosion(0,0);
			player1.health = 3;
			var i:int;
			var a:int;
			var b:int;
			
			asteroidsG = new FlxGroup(FlxG.level + 2);
			for (i = 0; i < asteroidsG.maxSize; i++) {
				a = FlxG.random() * (FlxG.width / 13);
				b = FlxG.random() * (FlxG.height / 13);
				ast = new Asteroid(1, a, b);
				asteroidsG.add(ast);
				ast.reset(a, b);
				a = FlxG.random() * 100;
				a = a % 2;
				b = FlxG.random() * 100;
				b = b % 2;
				
				if (a == 1) {
					ast.velocity.x += ((FlxG.random() * 110)+2);
				}else {
					a = FlxG.random() * 110;
					if (a == 0) a -= 2;
					ast.velocity.x -= a;
				}
				if (b == 1) {
					ast.velocity.y += ((FlxG.random() * 110)+2);
				}else {
					b = FlxG.random() * 110;
					if (b == 0) b -= 2;
					ast.velocity.y -= b;
				}
			}
			
			asteroidsM = new FlxGroup(asteroidsG.maxSize * 2);
			for (i = 0; i < asteroidsM.maxSize; i++) {
				a = FlxG.random() * (FlxG.width / 13);
				b = FlxG.random() * (FlxG.height / 13);
				ast = new Asteroid(2, a, b);
				asteroidsM.add(ast);
			}
			
			asteroidsP = new FlxGroup(asteroidsM.maxSize * 2);
			for (i = 0; i < asteroidsP.maxSize; i++) {
				a = FlxG.random() * (FlxG.width / 13);
				b = FlxG.random() * (FlxG.height / 13);
				ast = new Asteroid(3, a, b);
				asteroidsP.add(ast);
			}
			
			asteroidsVivos = asteroidsG.length;
			
			playerBullets = new FlxGroup(NUM_PLAYER_BULLETS);
			for (i = 0; i < NUM_PLAYER_BULLETS; i++) {
				bullet = new Bullet( -100, -100);
				playerBullets.add(bullet);
			}
			
			vsAsteroidsG = new FlxGroup();
			vsAsteroidsG.add(player1);
			
			vsAsteroidsM = new FlxGroup();
			vsAsteroidsM.add(player1);
			
			vsAsteroidsP = new FlxGroup();
			vsAsteroidsP.add(player1);
			
			vsPlayerBullets = new FlxGroup();
			vsPlayerBullets.add(asteroidsG);
			vsPlayerBullets.add(asteroidsM);
			vsPlayerBullets.add(asteroidsP);
			
			textVidas = new FlxText(10, 10, 400, "Lives", true);
			textLevel = new FlxText(10, 30, 400, "Level = " + FlxG.level, true);
			textAstVivos = new FlxText(10, 50, 400, "Asteroids alive = ", true);
			textMaxLevel = new FlxText(10, 70, 400, "Maximum level reached = ", true);
			
			add(back1);
			add(explosion);
			add(playerBullets);
			add(asteroidsG);
			add(asteroidsM);
			add(asteroidsP);
			add(player1);
			add(textVidas);
			add(textLevel);
			add(textAstVivos);
			add(textMaxLevel);
		}
		
		override public function update():void {
			var i: int;
			var a: int;
			var b: int;
			var ast: Asteroid;
			textVidas.text = "Lifes = " + player1.health;
			textAstVivos.text = "Asteroids alive = " + asteroidsVivos;
			textMaxLevel.text = "Maximum level reached = " + FlxG.scores[0];
			
			if (player1.health <= 0) {
				player1.health = 0;
				FlxG.music.fadeOut(2, true);
				FlxG.fade(0xff000000, 2, newMenuState);
			}
			
			if (FlxG.overlap(playerBullets, vsPlayerBullets, playerHitVsPlayer)) {
				asteroidsVivos--;
				FlxG.play(explosionMP3, 1, false, true);
			}
			countTemp -= FlxG.elapsed;
			
			if (countTemp <= 0) {
				if (FlxG.overlap(asteroidsG, vsAsteroidsG, asteroidHitVsAsteroid)) {
					player1.reset(FlxG.width / 2, FlxG.height / 2);
					player1.health--;
					player1.flicker(3);
					asteroidsVivos--;
					FlxG.play(explosionMP3, 1, false, true);
					countTemp = 180;
				}
				if (FlxG.overlap(asteroidsM, vsAsteroidsM, asteroidHitVsAsteroid)) {
					player1.reset(FlxG.width / 2, FlxG.height / 2);
					player1.health--;
					player1.flicker(3);
					asteroidsVivos--;
					FlxG.play(explosionMP3, 1, false, true);
					countTemp = 180;
				}
				if (FlxG.overlap(asteroidsP, vsAsteroidsP, asteroidHitVsAsteroid)) {
					player1.reset(FlxG.width / 2, FlxG.height / 2);
					player1.health--;
					player1.flicker(3);
					asteroidsVivos--;
					FlxG.play(explosionMP3, 1, false, true);
					countTemp = 180;
				}
			}
			FlxG.log("Tempo = " + countTemp);
			if (player1.health <= 0) {
				player1.health = 0;
				FlxG.music.fadeOut(2, true);
				FlxG.fade(0xff000000, 2, newMenuState);
			}
			
			if (asteroidsVivos == 0 && auxAstVivos == 1) {
				FlxG.level += 1;
				FlxG.score = FlxG.level;
				if(FlxG.scores[0] < FlxG.score){
					FlxG.scores[0] = FlxG.score;
				}
				auxAstVivos = 0;
				FlxG.music.fadeOut(1, true);
				FlxG.fade(0xff000000, 1, newGameLevel);
			}
			super.update();
		}
		
		protected function newMenuState():void {
			FlxG.switchState(new MenuState());
		}
		
		protected function newGameLevel(): void {
			FlxG.switchState(new GameState());
		}
		
		protected function playerHitVsPlayer(e1: FlxObject, e2: FlxObject):void {
			var i: int;
			var u: int;
			var v: int;
			var a: Asteroid = e2 as Asteroid;
			if (a != null) {
				explosion.boom(a.x, a.y);
				if (a.tipo == 1) {
					for (i = 0; i < 2; i++){
						var f :Asteroid = asteroidsM.getFirstAvailable() as Asteroid;
						if (f != null) {
							asteroidsVivos ++;
							f.reset(a.x, a.y);
							
							f.velocity.x = 0;
							f.velocity.y = 0;
							u = FlxG.random() * 100;
							u = u % 2;
							v = FlxG.random() * 100;
							v = v % 2;
							
							if (u == 1) {
								f.velocity.x += ((FlxG.random() * 110)+2);
							}else {
								u = FlxG.random() * 110;
								if (u == 0) u -= 2;
								f.velocity.x -= u;
							}
							if (v == 1) {
								f.velocity.y += ((FlxG.random() * 110)+2);
							}else {
								v = FlxG.random() * 110;
								if (v == 0) v -= 2;
								f.velocity.y -= v;
							}
						}
					}
				}else if (a.tipo == 2) {
					for (i = 0; i < 2; i++){
						var p :Asteroid = asteroidsP.getFirstAvailable() as Asteroid;
						if (p != null) {
							asteroidsVivos ++;
							p.reset(a.x, a.y);
							
							p.velocity.x = 0;
							p.velocity.y = 0;
							u = FlxG.random() * 100;
							u = u % 2;
							v = FlxG.random() * 100;
							v = v % 2;
							
							if (u == 1) {
								p.velocity.x += ((FlxG.random() * 110)+2);
							}else {
								u = FlxG.random() * 110;
								if (u == 0) u -= 2;
								p.velocity.x -= u;
							}
							if (v == 1) {
								p.velocity.y += ((FlxG.random() * 110)+2);
							}else {
								v = FlxG.random() * 110;
								if (v == 0) v -= 2;
								p.velocity.y -= v;
							}
						}
					}
				}
			}
			e1.kill();
			e2.kill();
		}
		
		protected function asteroidHitVsAsteroid(e1: FlxObject, e2: FlxObject):void {
			var i: int;
			var u:int;
			var v:int;
			var a: Asteroid = e1 as Asteroid;
			if (a != null) {
				explosion.boom(a.x, a.y);
				if (a.tipo == 1) {
					for (i = 0; i < 2; i++){
						var f :Asteroid = asteroidsM.getFirstAvailable() as Asteroid;
						if (f != null) {
							asteroidsVivos ++;
							f.reset(a.x, a.y);
							
							f.velocity.x = 0;
							f.velocity.y = 0;
							u = FlxG.random() * 100;
							u = u % 2;
							v = FlxG.random() * 100;
							v = v % 2;
							
							if (u == 1) {
								f.velocity.x += ((FlxG.random() * 110)+2);
							}else {
								u = FlxG.random() * 110;
								if (u == 0) u -= 2;
								f.velocity.x -= u;
							}
							if (v == 1) {
								f.velocity.y += ((FlxG.random() * 110)+2);
							}else {
								v = FlxG.random() * 110;
								if (v == 0) v -= 2;
								f.velocity.y -= v;
							}
						}
					}
				}else if (a.tipo == 2) {
					for (i = 0; i < 2; i++){
						var p :Asteroid = asteroidsP.getFirstAvailable() as Asteroid;
						if (p != null) {
							asteroidsVivos ++;
							p.reset(a.x, a.y);
							
							p.velocity.x = 0;
							p.velocity.y = 0;
							u = FlxG.random() * 100;
							u = u % 2;
							v = FlxG.random() * 100;
							v = v % 2;
							
							if (u == 1) {
								p.velocity.x += ((FlxG.random() * 110)+2);
							}else {
								u = FlxG.random() * 110;
								if (u == 0) u -= 2;
								p.velocity.x -= u;
							}
							if (v == 1) {
								p.velocity.y += ((FlxG.random() * 110)+2);
							}else {
								v = FlxG.random() * 110;
								if (v == 0) v -= 2;
								p.velocity.y -= v;
							}
						}
					}
				}
			}
			e1.kill();
			e2.kill();
		}
	}
}