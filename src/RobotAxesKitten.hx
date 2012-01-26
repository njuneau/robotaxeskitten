package ;

import models.Board;

/**
 * Robot Axes Kitten is a HaXe implementation of the RobotFindsKitten software
 * (http://robotfindskitten.org/)
 */
class RobotAxesKitten {

    public static var INSTANCE : RobotAxesKitten;
    public static var BOARD_WIDTH : Int = 60;
    public static var BOARD_HEIGHT : Int = 60;

    /**
     * Creates a new game of RobotFindsKitten!
     */
    public function new() {
        var board : Board = new Board(BOARD_WIDTH, BOARD_HEIGHT);
    }

    /**
     * Program entry point
     */
    public static function main() {
        INSTANCE = new RobotAxesKitten();
    }

}