package ;

import controllers.js.JSGameController;

/**
 * Robot Axes Kitten is a HaXe implementation of the RobotFindsKitten software
 * (http://robotfindskitten.org/)
 */
class RobotAxesKitten {

    private static var INSTANCE : RobotAxesKitten;
    private static var GAME_ZONE_ID : String = "gameZone";

    private var gameController : JSGameController;

    /**
     * Creates a new game of RobotFindsKitten!
     */
    public function new() {
        // Create the game and start it.
        this.gameController = new JSGameController(GAME_ZONE_ID);
        this.gameController.init();
    }

    /**
     * Program entry point
     */
    public static function main() {
        RobotAxesKitten.INSTANCE = new RobotAxesKitten();
    }

}