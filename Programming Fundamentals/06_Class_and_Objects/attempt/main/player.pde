class Player 
{

	PVector position = new PVector();
	PVector velocity = new PVector();
	PVector acceleration = new PVector();

	float accelerationMultiplier = 0.75;
	float deaccelerationMultiplier = 0.5;
	float speed = 60.0;

	// Adjust here when adjusting the Jump height! also in Input-file (the float "jumpForce")
	float maxSpeed = 20;

	long time;
	float deltaTime;

	public int ballSize = 20;

	boolean dead;


	void draw() 
	{

		acceleration = input();


		long currentTime = millis();

		
		

		//prepare our acceleration
		
		acceleration.mult(accelerationMultiplier * speed * deltaTime);

		if (acceleration.mag() == 0)
		{
			acceleration.x -= velocity.x * deaccelerationMultiplier;
			
			if (!gravity)
			{
				acceleration.y -= velocity.y * deaccelerationMultiplier;
			}
		}



		//update velocity
		velocity.add(acceleration);
		velocity.limit(maxSpeed);

		PVector move = velocity.copy();

		move.mult(speed * deltaTime);	

		position.add(velocity);

		//draw 
		ellipse(position.x, position.y, ballSize, ballSize);

		
		// update time for next frame.
		time = currentTime;


		

		if (gravity)
		{
			bounce();
			myGravity();
		}
		else 
		{
			wrap();
		}

		println(velocity.y);


		
		
	}

	void wrap()
	{
		if (position.x < 0)
		{
			position.x = width;
		}
		else if (position.x > width)
		{
			position.x = 0;
		}

		// Limit movement on Y axis
		if (position.y <= 0 + (ballSize/2))
		{
			position.y = 0 + (ballSize/2);
		}
		else if (position.y >= height - (ballSize/2))
		{
			position.y = height - (ballSize/2);
		}
	}

	void bounce()
	{
		

		// bounce on sides
		if (position.x < 0 + (ballSize/2) || position.x > width - (ballSize/2))
		{
			velocity.x = velocity.x * -1;
		}

		// bounce on top or bottom
		if (position.y < 0 + (ballSize/2) || position.y > height - (ballSize/2))
		{
			// decrease bounce slightly on every bounce
			velocity.y = velocity.y * -0.75;
		}


		// Boundaries when bouncing - force ball inside window
		if (position.x < 0 + (ballSize/2))
		{
			position.x = 0 + (ballSize/2);
		}
		else if (position.x > width - (ballSize/2))
		{
			position.x = width - (ballSize/2);
		}

		if (position.y < 0 + (ballSize/2))
		{
			position.y = 0 + (ballSize/2);
		}
		else if (position.y > height - (ballSize/2))
		{
			position.y = height - (ballSize/2);
		}
		
	}

	void myGravity()
	{
		if (gravity && position.y < height - (ballSize/2))
		{
			velocity.y += 0.5;
		}
	}
}