package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class GameState extends FlxState
	{
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
		
		private static const NUM_PLAYER_BULLETS: int = 30;
		
		override public function create():void 
		{
			//FlxG.level = 1;
			auxAstVivos = 1;
			super.create();
			var bullet: Bullet;
			var ast: Asteroid;
			player1 = new Ship(FlxG.width / 2, FlxG.height / 2);
			back1 = new Background(1);
			explosion = new Explosion(0,0);
			player1.health = 3;
			var i:int;
			var a:int;
			var b:int;
			FlxG.log("Level =" + FlxG.level);
			
			asteroidsG = new FlxGroup(FlxG.level + 2);
			FlxG.log("Tamanho do grupo de asteroids G: " + asteroidsG.maxSize);
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
					ast.velocity.x += FlxG.random() * 100;
				}else {
					ast.velocity.x -= FlxG.random() * 100;
				}
				if (b == 1) {
					ast.velocity.y += FlxG.random() * 100;
				}else {
					ast.velocity.y -= FlxG.random() * 100;
				}
			}
			
			asteroidsM = new FlxGroup(asteroidsG.maxSize * 2);
			FlxG.log("Tamanho do grupo de asteroids M: " + asteroidsM.maxSize);
			for (i = 0; i < asteroidsM.maxSize; i++) {
				a = FlxG.random() * (FlxG.width / 13);
				b = FlxG.random() * (FlxG.height / 13);
				ast = new Asteroid(2, a, b);
				asteroidsM.add(ast);
			}
			
			asteroidsP = new FlxGroup(asteroidsM.maxSize * 2);
			FlxG.log("Tamanho do grupo de asteroids P: " + asteroidsP.maxSize);
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
			
			textVidas = new FlxText(10, 10, 400, "Vidas", true);
			
			add(back1);
			add(explosion);
			add(playerBullets);
			add(asteroidsG);
			add(asteroidsM);
			add(asteroidsP);
			add(player1);
			add(textVidas);
			
			FlxG.log("Adicionou player");
		}
		
		override public function update():void {
			var i: int;
			var a: int;
			var b: int;
			var ast: Asteroid;
			textVidas.text = "Vidas = " + player1.health;
			
			if (player1.health <= 0) {
				player1.health = 0;
				FlxG.fade(0xff000000, 2, newMenuState);
			}
			
			if (FlxG.overlap(playerBullets, vsPlayerBullets, playerHitVsPlayer)) {
				asteroidsVivos--;
			}
			if (FlxG.overlap(asteroidsG, vsAsteroidsG, asteroidHitVsAsteroid)) {
				player1.reset(FlxG.width / 2, FlxG.height / 2);
				player1.health--;
				player1.flicker(1);
				asteroidsVivos--;
			}
			if (FlxG.overlap(asteroidsM, vsAsteroidsM, asteroidHitVsAsteroid)) {
				player1.reset(FlxG.width / 2, FlxG.height / 2);
				player1.health--;
				player1.flicker(1);
				asteroidsVivos--;
			}
			if (FlxG.overlap(asteroidsP, vsAsteroidsP, asteroidHitVsAsteroid)) {
				player1.reset(FlxG.width / 2, FlxG.height / 2);
				player1.health--;
				player1.flicker(1);
				asteroidsVivos--;
			}
			if (player1.health <= 0) {
				player1.health = 0;
				FlxG.fade(0xff000000, 2, newMenuState);
			}
			if (asteroidsVivos == 0 && auxAstVivos == 1) {
				FlxG.level += 1;
				auxAstVivos = 0;
				FlxG.log("Level =" + FlxG.level);
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
				FlxG.log("player hit vsPlayer");
				explosion.boom(a.x, a.y);
				if (a.tipo == 1) {
					FlxG.log("Asteroid morto tipo G");
					for (i = 0; i < 2; i++){
						var f :Asteroid = asteroidsM.getFirstAvailable() as Asteroid;
						if (f != null) {
							FlxG.log("Tem asteroid M pra pegar -> I = " + (i + 1));
							asteroidsVivos ++;
							f.reset(a.x, a.y);
							
							f.velocity.x = 0;
							f.velocity.y = 0;
							u = FlxG.random() * 100;
							u = u % 2;
							v = FlxG.random() * 100;
							v = v % 2;
							
							if (u == 1) {
								f.velocity.x += FlxG.random() * 100;
							}else {
								f.velocity.x -= FlxG.random() * 100;
							}
							if (v == 1) {
								f.velocity.y += FlxG.random() * 100;
							}else {
								f.velocity.y -= FlxG.random() * 100;
							}
						}
					}
				}else if (a.tipo == 2) {
					FlxG.log("Asteroid morto tipo M");
					for (i = 0; i < 2; i++){
						var p :Asteroid = asteroidsP.getFirstAvailable() as Asteroid;
						if (p != null) {
							FlxG.log("Tem asteroid M pra pegar -> I = " + (i + 1));
							asteroidsVivos ++;
							p.reset(a.x, a.y);
							
							p.velocity.x = 0;
							p.velocity.y = 0;
							u = FlxG.random() * 100;
							u = u % 2;
							v = FlxG.random() * 100;
							v = v % 2;
							
							if (u == 1) {
								p.velocity.x += FlxG.random() * 100;
							}else {
								p.velocity.x -= FlxG.random() * 100;
							}
							if (v == 1) {
								p.velocity.y += FlxG.random() * 100;
							}else {
								p.velocity.y -= FlxG.random() * 100;
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
				FlxG.log("Asteroid hit vsAsteroid");
				explosion.boom(a.x, a.y);
				if (a.tipo == 1) {
					FlxG.log("Asteroid morto tipo G");
					for (i = 0; i < 2; i++){
						var f :Asteroid = asteroidsM.getFirstAvailable() as Asteroid;
						if (f != null) {
							FlxG.log("Tem asteroid M pra pegar -> I = " + (i + 1));
							asteroidsVivos ++;
							f.reset(a.x, a.y);
							
							f.velocity.x = 0;
							f.velocity.y = 0;
							u = FlxG.random() * 100;
							u = u % 2;
							v = FlxG.random() * 100;
							v = v % 2;
							
							if (u == 1) {
								f.velocity.x += FlxG.random() * 100;
							}else {
								f.velocity.x -= FlxG.random() * 100;
							}
							if (v == 1) {
								f.velocity.y += FlxG.random() * 100;
							}else {
								f.velocity.y -= FlxG.random() * 100;
							}
						}
					}
				}else if (a.tipo == 2) {
					FlxG.log("Asteroid morto tipo M");
					for (i = 0; i < 2; i++){
						var p :Asteroid = asteroidsP.getFirstAvailable() as Asteroid;
						if (p != null) {
							FlxG.log("Tem asteroid M pra pegar -> I = " + (i + 1));
							asteroidsVivos ++;
							p.reset(a.x, a.y);
							
							p.velocity.x = 0;
							p.velocity.y = 0;
							u = FlxG.random() * 100;
							u = u % 2;
							v = FlxG.random() * 100;
							v = v % 2;
							
							if (u == 1) {
								p.velocity.x += FlxG.random() * 100;
							}else {
								p.velocity.x -= FlxG.random() * 100;
							}
							if (v == 1) {
								p.velocity.y += FlxG.random() * 100;
							}else {
								p.velocity.y -= FlxG.random() * 100;
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