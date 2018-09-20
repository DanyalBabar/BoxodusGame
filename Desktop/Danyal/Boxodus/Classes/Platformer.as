package 
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.sensors.Accelerometer;
	import flash.events.MouseEvent;
	import fl.transitions.Transition;

	public class Platformer extends MovieClip
	{
		const MOVE_AVATAR:Number = 0.05;// speed of move
		const FALL_SPEED:Number = 0.5;// speed of fall
		const MAX_LEVELS:int = 5;// Maximum number of levels

		// Timers
		var moveTimer:Timer = new Timer(MOVE_AVATAR);
		var jumpTimer:Timer = new Timer(FALL_SPEED);
		var gravityTimer:Timer = new Timer(FALL_SPEED);
		var poseTimer:Timer = new Timer(1);
		var transitionTimer:Timer = new Timer(1000);

		var i:int = 0;
		var transitionCount:int = 0;
		var jumpDelay:Boolean = false;
		var upwards:Boolean;
		var downwards:Boolean;
		var ogJumpY:Number;
		var boxPush:int = -1;

		var orbsCollected:int;
		var totalOrbs:int;

		var downKeyIsBeingPressed:Boolean;
		var upKeyIsBeingPressed:Boolean;
		var leftKeyIsBeingPressed:Boolean;
		var rightKeyIsBeingPressed:Boolean;

		// Add player to stage
		var player_mc:Player;
		// Add restart button to stage
		var restart_btn:RestartButton;
		// Add ground to stage
		var ground:Ground = new Ground();
		// Collision detection
		var collision:Collision = new Collision();
		// Initialize level
		var level:int = 1;
		var levels:Levels = new Levels();
		var heading:Heading;
		var startButton:StartButton;
		var rulesButton:InstructionsButton;
		var newGameButton:NewGameButton;
		var rulesMenu:RulesMenu;
		var gameOverTitle:GameOverTitle;
		var endText:EndText;
		var closeButton:CloseButton;
		var transition_mc:Transition;
		var firstOver:Boolean = false;
		var boxHit: Boolean = false;
		var newGameStart: Boolean = false;
		//Program start
		public function Platformer()
		{
			transitionTimer.addEventListener(TimerEvent.TIMER, onTransitionTimer);
			setStartMenu();
		}
		//Function to set up main menu.
		public function setStartMenu()
		{
			//Create and set title.
			heading = new Heading();
			heading.x = 720;
			heading.y = 194;
			addChild(heading);

			//Create and set start button.
			startButton = new StartButton();
			startButton.x = 727;
			startButton.y = 397;
			addChild(startButton);

			//Create and set up instruction button.
			rulesButton = new InstructionsButton();
			rulesButton.x = 727;
			rulesButton.y = 550;
			addChild(rulesButton);

			//Add event listeners for buttons.
			startButton.addEventListener(MouseEvent.CLICK, onStart);
			rulesButton.addEventListener(MouseEvent.CLICK, onRules);

		}

		//Function to initialize the transition.
		public function startTransition()
		{
			//Stop all timers as the levels transition.
			moveTimer.stop();
			gravityTimer.stop();
			poseTimer.stop();
			jumpTimer.stop();

			//Add the black screen animation for the transition to the stage.
			transition_mc = new Transition();
			transition_mc.x = 0;
			transition_mc.y = 0;

			//Make the transition animation visible.
			addChild(transition_mc);
			//Start transition timer.
			transitionTimer.start();
		}

		public function onTransitionTimer(event:TimerEvent):void
		{
			//Increment transition every loop; aka switch modes every second.
			transitionCount++;

			//After the first second is over, the screen is all black and the current level
			//clears and sets the next level.
			if (transitionCount == 1)
			{
				if(!newGameStart){
					//Only clear the stage or increment once the first level is over.
					if (firstOver == true)
					{
						clearStage(level);
						level++;
					}
					//Set first over to true after the first level's transition.
					firstOver = true;
					if(level <= MAX_LEVELS)					
						setStage(level);
					else
						gameOver(totalOrbs);
					addChild(transition_mc);
				}
				
				else{
					setStartMenu();
					addChild(transition_mc);
				}
			}
			//The once the transition is over, restart all the timers and set transition counter back to 0.
			if (transitionCount == 2)
			{
				if(!newGameStart){
					transitionTimer.stop();
					transitionCount = 0;
					if(level <= MAX_LEVELS){
						jumpTimer.start();
						moveTimer.start();
						gravityTimer.start();
						poseTimer.start();
					}
					//Remove the transition animation.;
					removeChild(transition_mc);
				}
				
				else{
					transitionTimer.stop();
					transitionCount = 0;
					newGameStart = false;
					removeChild(transition_mc);
				}
			}
		}

		//When the start button is clicked, then start the transition for the first level.
		public function onStart(event:MouseEvent):void
		{
			removeChild(heading);
			removeChild(startButton);
			removeChild(rulesButton);
			startTransition();

		}

		//When the rules button is clicked, create the entire rules screen over the existing screen.
		public function onRules(event:MouseEvent):void
		{
			removeChild(heading);
			removeChild(startButton);
			removeChild(rulesButton);

			rulesMenu = new RulesMenu();
			rulesMenu.x = 56;
			rulesMenu.y = 72;
			addChild(rulesMenu);

			//Create and place the close button for closing the rules screen.
			closeButton = new CloseButton();
			closeButton.x = 1309;
			closeButton.y = 139;
			addChild(closeButton);

			//Add the event listener for the close button.
			closeButton.addEventListener(MouseEvent.CLICK, onClose);
		}

		//Function for the close.
		public function onClose(event:MouseEvent):void
		{
			removeChild(rulesMenu);
			removeChild(closeButton);
			setStartMenu();
		}

		//Builds the level and makes all objects visible.
		public function setStage(level:int)
		{
			restart_btn = new RestartButton();
			restart_btn.x = 1300;
			restart_btn.y = 115;
			restart_btn.width = 134;
			restart_btn.height = 45;
			addChild(restart_btn);
			restart_btn.addEventListener(MouseEvent.CLICK, onRestart);

			//Place the ground.
			ground.x = 718;
			ground.y = 725;
			stage.addChild(ground);

			// Listen for key press and release
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyRelease);

			//restart_btn.addEventListener(MouseEvent.CLICK, onRestart);
			// Create timers
			jumpTimer.addEventListener(TimerEvent.TIMER, onJumpTimer);
			moveTimer.addEventListener(TimerEvent.TIMER, onMoveTimer);
			gravityTimer.addEventListener(TimerEvent.TIMER, onGravity);
			poseTimer.addEventListener(TimerEvent.TIMER, onPoseTimer);

			levels.createLevelStage(level);
			for (var i:int =0; i<levels.boxes.length; i++)
			{
				addChild(levels.boxes[i]);
			}

			for (i =0; i<levels.platforms.length; i++)
			{
				addChild(levels.platforms[i]);
			}

			for (i =0; i<levels.orbs.length; i++)
			{
				addChild(levels.orbs[i]);
			}

			addChild(levels.exit);

			player_mc = new Player();
			player_mc.x = levels.playerX;
			player_mc.y = levels.playerY;
			addChild(player_mc);

			// Set starting pose;
			player_mc.gotoAndStop("stand");
			stage.focus = stage;
		}

		//If the player wishes to restart the level, the level will recreate and set itself.
		public function onRestart(event:MouseEvent):void
		{
			clearStage(level);
			setStage(level);
		}

		//Function for clearing level in preparation for creating next level.
		public function clearStage(level:int)
		{
			var boxCount:int = levels.boxes.length;
			for (var i:int =boxCount-1; i>=0; i--)
			{
				removeChild(levels.boxes[i]);
				levels.boxes.pop();
			}
			var platformCount:int = levels.platforms.length;
			for (i=platformCount-1; i>=0; i--)
			{
				removeChild(levels.platforms[i]);
				levels.platforms.pop();
			}
			var orbCount:int = levels.orbs.length;
			for (i=orbCount-1; i>=0; i--)
			{
				removeChild(levels.orbs[i]);
				levels.orbs.pop();
			}
			removeChild(levels.exit);
			removeChild(player_mc);
			removeChild(restart_btn);
			orbsCollected = 0;
		}

		//Ran when the final level is completed, stops all timers and creates the end screen.
		public function gameOver(orbs:int)
		{
			moveTimer.stop();
			gravityTimer.stop();
			poseTimer.stop();
			jumpTimer.stop();

			gameOverTitle = new GameOverTitle();
			gameOverTitle.x = 360;
			gameOverTitle.y = 194;
			addChild(gameOverTitle);

			endText = new EndText();
			endText.x = 143;
			endText.y = 374;
			addChild(endText);

			newGameButton = new NewGameButton();
			newGameButton.x = 500;
			newGameButton.y = 500;
			addChild(newGameButton);
			newGameButton.addEventListener(MouseEvent.CLICK, onNewGame);

			//Display final orbs collected.;
			endText.orbs_txt.text = (orbs.toString());


		}

		//Resets all l
		public function onNewGame(event:MouseEvent):void
		{
			removeChild(gameOverTitle);
			removeChild(endText);
			removeChild(newGameButton);
			level = 1;
			totalOrbs = 0;
			firstOver = false;
			newGameStart = true;
			startTransition();
			//setStartMenu();
		}

		//Event listners for left and right keystrokes.
		public function onKeyPress(keyboardEvent:KeyboardEvent):void
		{
			if ((keyboardEvent.keyCode == Keyboard.LEFT)&&(!rightKeyIsBeingPressed))
			{
				leftKeyIsBeingPressed = true;
			}
			if ((keyboardEvent.keyCode == Keyboard.RIGHT)&&(!leftKeyIsBeingPressed))
			{
				rightKeyIsBeingPressed = true;
			}
		}

		//
		public function onKeyRelease(keyboardEvent:KeyboardEvent):void
		{
			if ((keyboardEvent.keyCode == Keyboard.LEFT)&&(!rightKeyIsBeingPressed))
			{
				leftKeyIsBeingPressed = false;
				boxPush = -1;

			}
			if ((keyboardEvent.keyCode == Keyboard.RIGHT)&&(!leftKeyIsBeingPressed))
			{
				rightKeyIsBeingPressed = false;
				boxPush = -1;;
			}
			if (keyboardEvent.keyCode == Keyboard.UP)
			{
				if (!(collision.isFreeFall(player_mc,ground,levels.boxes,levels.platforms)))
				{
					onJump();
				}
			}
		}
		
		//Calculates the x-value change for a given movement.
		public function moveSide(xDistance:Number):Number
		{
			var baseSpeed:Number = 2.5;
			return xDistance * baseSpeed;
		}

		//Timer function for detecting movement with player and boxes.
		public function onMoveTimer(event:TimerEvent):void
		{
			boxHit = false;

			for (var i:int = 0; i<levels.boxes.length; i++)
			{
				//Left side.
				if (leftKeyIsBeingPressed)
				{
					//Check for collision between player and any box.
					if (collision.isLeftCollision1(player_mc,levels.boxes[i]))
					{
						//Move player and box left.
						player_mc.x +=  moveSide(-1);
						levels.boxes[i].x +=  moveSide(-1);
						boxPush = i;
						boxHit = true;

						//Check for a second box that is not box[i].
						for (var g: int = 0; g<levels.boxes.length; g++)
						{
							//If the first box hits the second box, or if the player hits the second box.
							if ((collision.isLeftCollision1(levels.boxes[i],levels.boxes[g])) || (collision.isLeftCollision1(player_mc,levels.boxes[g])) 
							&& (g != i))
							{
								//Move the second box left.
								levels.boxes[g].x +=  moveSide(-1);
								
								//Check both boxes against all platforms.
								for (var e: int = 0; e<levels.platforms.length; e++)
								{
									//If either box collides with a platform or if either box reaches either end of the border
									//then move both boxes and the player one movement in the opposite direction
									//to simulate lack of movement.
									if ((collision.isLeftCollision4(levels.boxes[g], levels.platforms[e]))
									||(collision.isLeftCollision4(levels.boxes[i], levels.platforms[e]))
									|| (levels.boxes[i].x >= 1385) || (levels.boxes[g].x >= 1385)
									|| (levels.boxes[i].x <= 95) || (levels.boxes[g].x <= 95))
									{
										levels.boxes[i].x +=  moveSide(1);
										levels.boxes[g].x +=  moveSide(1);
										player_mc.x +=  moveSide(1);
									}

								}
							}
						}
						
						//Re-run the same procedure as "2 boxes vs platforms" but instead with only one box against all platforms.
						for (var r: int = 0; r<levels.platforms.length; r++)
						{
							if (collision.isLeftCollision4(levels.boxes[i],levels.platforms[r])
							|| (levels.boxes[i].x >= 1385) || (levels.boxes[i].x <= 95))
							{
								levels.boxes[i].x +=  moveSide(1);
								player_mc.x +=  moveSide(1);

							}
						}
					}
					//If a collision is detected with the player and boxes, detect it and break from loop.
					else if (collision.isLeftCollision2(player_mc, levels.boxes[i]))
					{
						boxHit = true;
					}

				}
				//If right key is being pressed, complete all same actions as left side, for right side.
				else if (rightKeyIsBeingPressed)
				{
					if (collision.isRightCollision1(player_mc,levels.boxes[i]))
					{
						player_mc.x +=  moveSide(1);
						levels.boxes[i].x +=  moveSide(1);
						boxPush = i;
						boxHit = true;

						for (var s: int = 0; s<levels.boxes.length; s++)
						{
							if ((collision.isRightCollision1(levels.boxes[i],levels.boxes[s])) || (collision.isRightCollision1(player_mc,levels.boxes[s]))
							&& (s != i))
							{
								levels.boxes[s].x +=  moveSide(1);

								for (var t: int = 0; t<levels.platforms.length; t++)
								{
									if ((collision.isRightCollision4(levels.boxes[s], levels.platforms[t]))
									||(collision.isRightCollision4(levels.boxes[i], levels.platforms[t]))
									|| (levels.boxes[i].x >= 1385) || (levels.boxes[s].x >= 1385)
									|| (levels.boxes[i].x <= 95) || (levels.boxes[s].x <= 95))
									{
										levels.boxes[i].x +=  moveSide(-1);
										levels.boxes[s].x +=  moveSide(-1);
										player_mc.x +=  moveSide(-1);
									}
								}
							}
						}

						for (var u: int = 0; u<levels.platforms.length; u++)
						{
							if (collision.isRightCollision4(levels.boxes[i],levels.platforms[u])
							|| (levels.boxes[i].x >= 1385) || (levels.boxes[i].x <= 95))
							{
								levels.boxes[i].x +=  moveSide(-1);
								player_mc.x +=  moveSide(-1);

							}
						}
					}
					else if (collision.isRightCollision2(player_mc, levels.boxes[i]))
					{
						boxHit = true;
					}


				}
				if (boxHit)
				{
					break;
				}
			}
			
			for (var j:int = 0; j<levels.platforms.length; j++)
			{
				if (leftKeyIsBeingPressed)
				{
					if (collision.isLeftCollision3(player_mc,levels.platforms[j]))
					{
						boxHit = true;
					}
				}
				else if (rightKeyIsBeingPressed)
				{
					if (collision.isRightCollision3(player_mc,levels.platforms[j]))
					{
						boxHit = true;
					}
				}

				if (boxHit)
				{
					break;
				}
			}
			//Check all orbs to detect a collision with player and orbs.
			for (var h:int = 0; h<levels.orbs.length; h++)
			{
				if (player_mc.hitTestObject(levels.orbs[h]))
				{
					levels.orbs[h].x = -1000;
					orbsCollected++;
				}
			}
		
			//If the player does not collide with a box, only move player left or right, depending on key pressed.
			if (! boxHit)
			{
				if ((leftKeyIsBeingPressed)&&(player_mc.x>95))
				{
					player_mc.x +=  moveSide(-1);
				}
				else if ((rightKeyIsBeingPressed)&&(player_mc.x<1340))
				{
					player_mc.x +=  moveSide(1);
				}
			}
		}
		
		//Timer for detecting player's actions and changing post accordingly.
		function onPoseTimer(event:TimerEvent):void
		{
			
			//All left-side actions and their positions.
			if (leftKeyIsBeingPressed)
			{
				//If airborne, use the jumping-left pose.
				if (jumpDelay || upwards)
				{
					player_mc.gotoAndStop("jumpleft");
				}
				//If pushing a box, use the push-left pose.
				else if (boxHit)
				{
					player_mc.gotoAndStop("pushleft");
				}
				//If simply walking, use left walk pose.
				else
				{
					player_mc.gotoAndStop("walkleft");
				}

			}
			//If neither left nor right are being pressed, use upright positions.
			if (! leftKeyIsBeingPressed && ! rightKeyIsBeingPressed)
			{
				if (jumpDelay || upwards)
				{
					player_mc.gotoAndStop("jumpstart");
				}
				else
				{
					player_mc.gotoAndStop("stand");
				}

			}
			//Repeat actions for left side on right side, with right side poses.
			if (rightKeyIsBeingPressed)
			{
				if (jumpDelay || upwards)
				{
					player_mc.gotoAndStop("jumpright");
				}
				else if (boxHit)
				{
					player_mc.gotoAndStop("pushright");
				}
				else
				{
					player_mc.gotoAndStop("walkright");
				}
			}
			//If the player collides with the center of the exit, add the orbs collected to the total
			//and start transition for next level, if the player is not on the last level.
			if (collision.isExit(player_mc,levels.exit))
			{
				totalOrbs +=  orbsCollected;
				orbsCollected = 0;
				startTransition();

			}
		}

		//Jump function called by the up key.
		function onJump():void
		{
			//Only allow function contents to run if the jump delay is over.
			if (! jumpDelay)
			{
				//Change pose
				player_mc.gotoAndStop(6);
				//Start 
				jumpDelay = true;
				upwards = true;
				ogJumpY = player_mc.y;
			}
		}
		
		//Timer function for jumping action.
		public function onJumpTimer(event:TimerEvent):void
		{
			//When the player is set to go up, move y value up.
			if ((player_mc.y >= (ogJumpY -150)) && (upwards))
			{
				// On way up
				player_mc.y -=  5;
			}
			
			//Once the player reaches the max relative jump height, set upwards to false
			//and let gravity bring the player down.
			if (player_mc.y <= (ogJumpY - 150))
			{
				// Up movement completed
				upwards = false;
			}
			
			//Check player's top against all platforms and stop upwards if collision detected.
			for (var h:int = 0; h<levels.platforms.length; h++)
			{
				if (collision.isUnderCollision(player_mc,levels.platforms[h]))
				{
					upwards = false;
				}
			}

		}
		
		//Gravity function for player and all moveable boxes.
		public function onGravity(event:TimerEvent):void
		{
			// Fall if not jumping and no collision is detected below.
			if (collision.isFreeFall(player_mc,ground,levels.boxes,levels.platforms))
			{
				//If the player is not moving upwards, drop the player 5 units.
				if (! upwards)
				{
					player_mc.y +=  5;
					jumpDelay = true;
				}


			}
			else
			{
				jumpDelay = false;

			}
			//Check all moveable boxes to see if they are in the air, and if not, move them down 5 units.
			for (var i: int = 0; i < levels.boxes.length; i++)
			{
				if (collision.isFreeFall(levels.boxes[i],ground,levels.boxes,levels.platforms))
				{
					levels.boxes[i].y +=  5;
				}
			}
		}
	}
}