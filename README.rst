Robot Axes Kitten
===============

Description
-----------------

This is a reimplementation of the very famous game "robotfindskitten" by
Leonard Richardson. The goal of the game is pretty simple - you are a robot,
and you must find kitten. But, as you must know, there are a lot of things in
this world that are not kitten. Hence, you must touch the items on the screen to
know if it's kitten or not kitten.

Robot Axes Kitten lets you play in the comfort of your browser. Use the arrow
keys or the WASD keys to move robot.

Building robotaxeskitten
-----------------

You will need the HaXe compiler (http://haxe.org/) in order to compile the
project. Once it is installed, open a terminal in the project's root folder and
run "haxe build.hxml". This should generate the Javascript file. Once
compilation is complete, open "html/index.html" to play the game.

Your very own robot toolbox!
-----------------

You don't like Javascript? The code is written in a way that should ease porting
your robot to many more platforms, thus ensuring kitten finding for centuries to
come.

The entire game's model, like the "board" that contains all the entities such as
the kitten is platform-independent. The game's mechanics and views are contained
in their respective platform-specific packages. For now, since there is only a
Javascript implementation, the only sub-package is "js".

Therefore, should you want to fine-tune your robot or make him find kitten in
the Flash universe, look into the "controllers" and "views" packages.