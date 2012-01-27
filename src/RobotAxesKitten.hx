package ;

import controllers.js.JSGameController;

/**
 * Robot Axes Kitten is a HaXe implementation of the RobotFindsKitten software
 * (http://robotfindskitten.org/)
 */
class RobotAxesKitten {

    public static var INSTANCE : RobotAxesKitten;
    private var gameController : JSGameController;

    /**
     * Creates a new game of RobotFindsKitten!
     */
    public function new() {
        // Create the game and start it.
        this.gameController = new JSGameController();
        this.gameController.start();
    }

    /**
     * Program entry point
     */
    public static function main() {
        INSTANCE = new RobotAxesKitten();
    }

}