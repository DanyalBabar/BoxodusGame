package 
{
	import flash.display.MovieClip;

	public class Collision
	{

		public function Collision()
		{
			// constructor code
		}

		//Gravity effect on player and moving boxes
		public function isFreeFall(mc:MovieClip, ground: MovieClip, boxes: Array, platforms:Array):Boolean
		{
			
			var result:Boolean = true;
			var yTest:Number = mc.y+mc.height/2;
			var xTest:Array=new Array();
			
			xTest.push(mc.x);
			xTest.push(mc.x + mc.width / 2-4);
			xTest.push(mc.x - mc.width / 2+4);

			for (var i:int=0; i<xTest.length; i++)
			{
				//Test target against the ground
				if (ground.hitTestPoint(xTest[i],yTest,true))
				{
					result = false;
				}
				//Test target against box tops
				for (var j:int = 0; j<boxes.length; j++)
				{
					if (boxes[j].hitTestPoint(xTest[i],yTest,true))
					{
						if (boxes[j] != mc)
						{
							result = false;
						}
					}
				}
				//Test target against platform tops
				for (var k:int = 0; k<platforms.length; k++)
				{
					if (platforms[k].hitTestPoint(xTest[i],yTest,true))
					{
						result = false;
					}
				}
			}
			return result;
		}
		//Checks if player contacts the exit door
		public function isExit(player:MovieClip, exit:MovieClip):Boolean
		{
			var result:Boolean = false;
			if(player.hitTestObject(exit)&&(player.x>=exit.x-30)&&(player.x<=exit.x+30)&&(player.y>=exit.y+50))
			{
				result = true;
			}

			return result;
		}

		//Checks target against the lower left side of a box
		public function isLeftCollision1(mc:MovieClip, box:MovieClip):Boolean
		{
			var result:Boolean = false;
			if (mc.hitTestObject(box)&&(mc.y >= box.y-20)&&(mc.x>box.x))
			{
				result = true;
			}
			return result;
		}
		//Checks target against the higher left side of a box
		public function isLeftCollision2(mc:MovieClip, box:MovieClip):Boolean
		{
			var result:Boolean = false;
			if ((mc.hitTestObject(box)&&(mc.y <= box.y-20)&&(mc.y >= box.y-100)&&(mc.x>box.x+45)))
			{
				result = true;
			}
			return result;
		}
		
		//Checks target against entire left side of the box
		public function isLeftCollision3(mc:MovieClip, box:MovieClip):Boolean
		{
			var result:Boolean = false;
			if ((mc.hitTestObject(box)&&(mc.y <= box.y+100)&&(mc.y >= box.y-100)&&(mc.x>box.x)))
			{
				result = true;
				
			}
			return result;
		}
		
		//Collision for checking boxes against platforms.
		public function isLeftCollision4(box:MovieClip, platform:MovieClip):Boolean
		{
			var result:Boolean = false;
			//Check left side of box with right side of the platform, with a 2 unit margin of error.
			if(box.hitTestPoint(platform.x+45, platform.y-43,true)||box.hitTestPoint(platform.x+45, platform.y+43,true))
			{
				result = true;
			}
			return result;
		}
		
		//Checks target against the lower right side of a box
		public function isRightCollision1(mc:MovieClip, box:MovieClip):Boolean
		{
			var result:Boolean = false;
			// Player hits box and player low and to left of box
			if ((mc.hitTestObject(box))&&(mc.y >= box.y-20)&&(mc.x<box.x))
			{
				result = true;
			}
			return result;
		}

		//Checks target against the higher right side of a box
		public function isRightCollision2(mc:MovieClip, box:MovieClip):Boolean
		{
			var result:Boolean = false;
			if ((mc.hitTestObject(box)&&(mc.y <= box.y-20)&&(mc.y >= box.y-100)&&(mc.x<box.x-45)))
			{
				result = true;
			}
			return result;
		}
		
		//Checks target against entire right side of the box
		public function isRightCollision3(mc:MovieClip, box:MovieClip):Boolean
		{
			var result:Boolean = false;
			if ((mc.hitTestObject(box)&&(mc.y <= box.y+100)&&(mc.y >= box.y-100)&&(mc.x<box.x)))
			{
				result = true;
				
			}
			return result;
		}
		public function isRightCollision4(box:MovieClip, platform:MovieClip):Boolean
		{
			var result:Boolean = false;
			//Check right side of box with left side of the platform, with a 2 unit margin of error.
			if(box.hitTestPoint(platform.x-45, platform.y-43,true)||box.hitTestPoint(platform.x-45, platform.y+43,true))
			{
				result = true;
			}
			return result;
		}
		
		//Checks target against the underside of the box
		public function isUnderCollision(mc:MovieClip, box:MovieClip):Boolean
		{
			var result:Boolean = false;
			if((mc.hitTestObject(box)&&(mc.y <= box.y+100)&&(mc.x>=box.x-60)&&(mc.x<=box.x+60)))
			{
				result = true;
			}
			return result;
		}
	}
}