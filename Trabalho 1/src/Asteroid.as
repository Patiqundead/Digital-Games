package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Patrick Junior Molinari De Bastiani
	 */
	public class Asteroid extends FlxSprite
	{
		[Embed(source = "../assets/images/Asteroids_128x128_008.png")] private var astG: Class;
		[Embed(source = "../assets/images/Asteroids_64x64_008.png")] private var astM: Class;
		[Embed(source = "../assets/images/Asteroids_32x32_008.png")] private var astP: Class;
		
		private var T_X_G: int = 128;
		private var T_Y_G: int = 128;
		private var T_X_M: int = 64;
		private var T_Y_M: int = 64;
		private var T_X_P: int = 32;
		private var T_Y_P: int = 32;
		public var tipo: int;
		
		public function Asteroid(tam: int, nX:int, nY:int) {
			var a:int;
			var b:int;
			tipo = tam;
			if (tam == 1) {
				loadGraphic(astG, false, false, T_X_G, T_Y_G, false);
				this.angularVelocity += 500;
			}else if (tam == 2) {
				loadGraphic(astM, false, false, T_X_M, T_Y_M, false);
				this.angularVelocity += 500;
			}else if (tam == 3) {
				loadGraphic(astP, false, false, T_X_P, T_Y_P, false);
				this.angularVelocity += 500;
			}
			this.x = nX;
			this.y = nY;
			kill();
		}
		override public function update(): void {
			if (tipo == 1) {
				if (this.x > FlxG.width) {
					this.x = 1;
				}
				if (this.x + T_X_G < 0) {
					this.x = FlxG.width;
				}
				if (this.y > FlxG.height) {
					this.y = 1;
				}
				if (this.y + T_Y_G < 0) {
					this.y = FlxG.height;
				}
			}
			if (tipo == 2) {
				if (this.x > FlxG.width) {
					this.x = 1;
				}
				if (this.x + T_X_M < 0) {
					this.x = FlxG.width;
				}
				if (this.y > FlxG.height) {
					this.y = 1;
				}
				if (this.y + T_Y_M < 0) {
					this.y = FlxG.height;
				}
			}
			if (tipo == 3) {
				if (this.x > FlxG.width) {
					this.x = 1;
				}
				if (this.x + T_X_P < 0) {
					this.x = FlxG.width;
				}
				if (this.y > FlxG.height) {
					this.y = 1;
				}
				if (this.y + T_Y_P < 0) {
					this.y = FlxG.height;
				}
			}
			super.update();
		}
		
		public function getXTamG(): int {
			return T_X_G;
		}
		public function getYTamG(): int {
			return T_Y_G;
		}
		public function getXTamM(): int {
			return T_X_M;
		}
		public function getYTamM(): int {
			return T_Y_M;
		}
		public function getXTamP(): int {
			return T_X_P;
		}
		public function getYTamP(): int {
			return T_Y_P;
		}
	}
}