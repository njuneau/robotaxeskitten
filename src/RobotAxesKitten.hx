// robotaxeskitten - A reimplementation of the original robotfindskitten by Leonard Richardson
// Copyright (C) 2012  Nicolas Juneau
// Full copyright notice can be found in the project root's "COPYRIGHT" file
//
// This file is part of robotaxeskitten.
//
// robotaxeskitten is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// robotaxeskitten is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with robotaxeskitten.  If not, see <http://www.gnu.org/licenses/>.

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