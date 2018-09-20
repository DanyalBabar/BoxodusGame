package 
{
	import flash.display.MovieClip;

	public class Levels
	{
		//Player starting position
		var playerX:int = 0;
		var playerY:int = 0;

		// Stage elements
		var boxes:Array; //Moving boxes
		var platforms:Array;  //Platforms
		var orbs:Array;  //Orbs
		var exit:MovieClip;  //Exit door
		var player_mc:MovieClip;  //Player avatar

		//Initialize array of stage elements
		public function Levels()
		{
			boxes = new Array();
			platforms = new Array();
			orbs = new Array();
			exit = new Exit();
			player_mc = new Player();
		}
		
		//Set coordinates for elements in each level.
		public function createLevelStage(level:int)
		{
			var temp:MovieClip;
			switch (level)
			{
				//level 1
				case 1 :
					temp = new MovingBox();
					temp.x = 530;
					temp.y = 350;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new MovingBox();
					temp.x = 770;
					temp.y = 560;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new Platform();
					temp.x = 385;
					temp.y = 560;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 475;
					temp.y = 560;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 565;
					temp.y = 560;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 1050;
					temp.y = 500;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1050;
					temp.y = 590;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1050;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Orb();
					temp.x = 230;
					temp.y = 397;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 882;
					temp.y = 582;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 1046;
					temp.y = 390;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 1248;
					temp.y = 548;
					orbs.push(temp);

					exit.x = 1278;
					exit.y = 591;

					playerX = 458;
					playerY = 663;
					break;
				//level 2
				case 2:
					temp = new MovingBox();
					temp.x = 220;
					temp.y = 290;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new MovingBox();
					temp.x = 370;
					temp.y = 545;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new MovingBox();
					temp.x = 570;
					temp.y = 510;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new Platform();
					temp.x = 205;
					temp.y = 450;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 295;
					temp.y = 450;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 280;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 370;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 580;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 790;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 1045;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 1045;
					temp.y = 590;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Orb();
					temp.x = 159;
					temp.y = 230;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 472;
					temp.y = 490;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 902;
					temp.y = 568;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 1146;
					temp.y = 487;
					orbs.push(temp);

					exit.x = 1319;
					exit.y = 591;

					playerX = 280;
					playerY = 575;
					break;
				//level 3
				case 3 :
					temp = new MovingBox();
					temp.x = 175;
					temp.y = 180;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new MovingBox();
					temp.x = 725;
					temp.y = 600;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new Platform();
					temp.x = 115;
					temp.y = 360;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 200;
					temp.y = 360;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 275;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 400;
					temp.y = 295;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 1120;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 1235;
					temp.y = 495;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Platform();
					temp.x = 1325;
					temp.y = 495;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);

					temp = new Orb();
					temp.x = 96;
					temp.y = 236;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 173;
					temp.y = 597;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 562;
					temp.y = 549;
					orbs.push(temp);

					temp = new Orb();
					temp.x = 1277;
					temp.y = 264;
					orbs.push(temp);

					exit.x = 1285;
					exit.y = 320;

					playerX = 400;
					playerY = 190;
					break;
				//Level 4.
				case 4 :
					temp = new MovingBox();
					temp.x = 800;
					temp.y = 300;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new MovingBox();
					temp.x = 1060;
					temp.y = 660;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);
					
					temp = new MovingBox();
					temp.x = 1130;
					temp.y = 300;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);
					
					temp = new Platform();
					temp.x = 110;
					temp.y = 405;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 200;
					temp.y = 405;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					
					temp = new Platform();
					temp.x = 400;
					temp.y = 500;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 400;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 400;
					temp.y = 590;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 490;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 850;
					temp.y = 450;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 970;
					temp.y = 360;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1060;
					temp.y = 450;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1150;
					temp.y = 450;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1330;
					temp.y = 590;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Orb();
					temp.x = 254;
					temp.y = 204;
					orbs.push(temp);
					
					temp = new Orb();
					temp.x = 382;
					temp.y = 424;
					orbs.push(temp);
					
					temp = new Orb();
					temp.x = 1280;
					temp.y = 448;
					orbs.push(temp);
					
					temp = new Orb();
					temp.x = 932;
					temp.y = 666;
					orbs.push(temp);

					exit.x = 144;
					exit.y = 230;
					
					playerX = 950;
					playerY = 200;
					break;
				//Level 5
				case 5 :
					temp = new MovingBox();
					temp.x = 565;
					temp.y = 620;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new MovingBox();
					temp.x = 690;
					temp.y = 320;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);
					
					temp = new MovingBox();
					temp.x = 1025;
					temp.y = 145;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);
					
					temp = new MovingBox();
					temp.x = 1135;
					temp.y = 145;
					temp.width = 90;
					temp.height = 90;
					boxes.push(temp);

					temp = new Platform();
					temp.x = 110;
					temp.y = 520;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 230;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 705;
					temp.y = 465;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 795;
					temp.y = 680;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					
					temp = new Platform();
					temp.x = 820;
					temp.y = 180;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 910;
					temp.y = 270;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1000;
					temp.y = 270;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1090;
					temp.y = 270;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1135;
					temp.y = 545;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Platform();
					temp.x = 1225;
					temp.y = 545;
					temp.width = 90;
					temp.height = 90;
					platforms.push(temp);
					
					temp = new Orb();
					temp.x = 286;
					temp.y = 490;
					orbs.push(temp);
					
					temp = new Orb();
					temp.x = 917;
					temp.y = 552;
					orbs.push(temp);
					
					temp = new Orb();
					temp.x = 984;
					temp.y = 124;
					orbs.push(temp);
					
					temp = new Orb();
					temp.x = 1336;
					temp.y = 274;
					orbs.push(temp);
					
					exit.x = 108;
					exit.y = 349;
					
					playerX = 915;
					playerY = 165;
					break;
			}
		}
	}
}