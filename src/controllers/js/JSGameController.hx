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

package controllers.js;

import models.Board;
import models.Position;
import models.Tile;
import models.NKI;
import models.Kitten;
import models.DefaultEntityFactory;

import views.js.HTMLTableView;
import js.Lib;
import js.Dom;

/**
 * This is the JavaScript-based game controller.
 */
#if js
  @:native("controller_hx.js.JSGameController")
#end
class JSGameController {
    private static var BOARD_WIDTH : Int = 40;
    private static var BOARD_HEIGHT : Int = 40;

    private static var KEY_UP : Int = 38;
    private static var KEY_LEFT : Int = 37;
    private static var KEY_DOWN : Int = 40;
    private static var KEY_RIGHT : Int = 39;

    private static var KEY_W : Int = 87;
    private static var KEY_A : Int = 65;
    private static var KEY_S : Int = 83;
    private static var KEY_D : Int = 68;

    private var gameZoneID : String;
    private var board : Board;
    private var view : HTMLTableView;
    private var robotPosition : Position;
    private var playedOnce : Bool;


    /**
     * Creates a new game of robotfindskitten controlled by JavaScript
     */
    public function new(gameZoneID : String) {
        this.gameZoneID = gameZoneID;
        this.playedOnce = false;
    }

    /**
     * Initialises the game, putting the board in the specified game zone (
     * an HTML element ID)
     */
    public function init() : Void {
        var self : JSGameController = this;
        // On window load, start the game
        Lib.window.onload = function(event : Event) : Void {
            self.start();
        };
    }

    /**
     * Initialises the game (called by start after onLoad event)
     */
    private function start() {
        // Create a new board
        this.board = new Board(BOARD_WIDTH, BOARD_HEIGHT, new DefaultEntityFactory(BOARD_WIDTH * 3));
        this.robotPosition = this.board.getRobotPosition();

        // Render table in body
        this.view = new HTMLTableView(this.board, Lib.document.getElementById(this.gameZoneID));

        if(!this.playedOnce) {
            this.view.showWelcome();

            var self : JSGameController = this;
            // Add keypress event
            Lib.document.onkeydown = function(event : Event) : Void {
                self.showGameBoard();
                event.stopPropagation();
            }
        } else {
            this.view.showWelcome();
            this.showGameBoard();
        }

    }

    /**
     * Make the game board show up and put the key events in place
     */
    private function showGameBoard() : Void {
        this.view.showMessage(String.fromCharCode(160));
        this.view.showGameBoard();

        var self : JSGameController = this;
        // Add keypress events
        Lib.document.onkeydown = function(event : Event) : Void {
            switch(event.keyCode) {
                case KEY_UP, KEY_W:
                    self.moveUp();
                case KEY_LEFT, KEY_A:
                    self.moveLeft();
                case KEY_DOWN, KEY_S:
                    self.moveDown();
                case KEY_RIGHT, KEY_D:
                    self.moveRight();
            }
            event.stopPropagation();
        }
    }

    /**
     * Move the robot up
     */
    private function moveUp() : Void {
        this.moveRobot(0, -1);
    }

    /**
     * Move the robot left
     */
    private function moveLeft() : Void {
        this.moveRobot(-1, 0);
    }

    /**
     * Move the robot down
     */
    private function moveDown() : Void {
        this.moveRobot(0, 1);
    }

    /**
     * Move the robot right
     */
    private function moveRight() : Void {
        this.moveRobot(1, 0);
    }

    /**
     * Moves the robot by the given x and y increments
     */
    private function moveRobot(xIncrement : Int, yIncrement : Int) {
        this.board.moveRobot(xIncrement, yIncrement);
        var newPosition = this.board.getRobotPosition();

        // If the player haven't moved, scan the surroundings.
        if(newPosition.equals(this.robotPosition)) {
            var tentative : Position = new Position(newPosition.getX() + xIncrement, newPosition.getY() + yIncrement);
            var tile : Tile = this.board.getTileAt(tentative);
            // If we haven't hit the borders and that there is an object on the
            // tile, try to determine what it is. A kitten or a NKI?
            if(tile != null) {
                if(!tile.isEmpty()) {
                    switch(Type.getClass(tile.getEntity())) {
                        case NKI:
                            this.view.showMessage((cast(tile.getEntity(), NKI).getDescription()));
                        case Kitten:
                            // Found kitten! Game over!
                            Lib.document.onkeydown = function(event : Event) : Void {};
                            var self : JSGameController = this;
                            this.view.showEnding(newPosition, tentative, function() : Void {
                                self.endGame();
                            });
                    }
                }
            }
        } else {
            // Move the player, refresh the view
            this.view.clearCellAt(this.robotPosition);
            this.robotPosition = newPosition;
            this.view.drawCellAt(this.robotPosition);
        }
    }

    /**
     * Ends the game
     */
    private function endGame() : Void {
        var self : JSGameController = this;
        this.playedOnce = true;

        // restart the game at key stroke
        Lib.document.onkeydown = function(event : Event) : Void {
            self.view.clear();
            self.start();
            event.stopPropagation();
        }
    }

}
