package controllers.js;

import models.Board;
import models.Position;
import models.Tile;
import models.Thing;
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

    private var board : Board;
    private var view : HTMLTableView;
    private var robotPosition : Position;

    /**
     * Creates a new game of robotfindskitten controlled by JavaScript
     */
    public function new() {
        this.board = new Board(BOARD_WIDTH, BOARD_HEIGHT, new DefaultEntityFactory(BOARD_WIDTH * 3));
        this.robotPosition = this.board.getRobotPosition();
    }

    /**
     * Starts the game
     */
    public function start() : Void {
        var self : JSGameController = this;
        // On window load, start the game
        Lib.window.onload = function(event : Event) : Void {
            self.init();
        };
    }

    /**
     * Initialises the game (called by start after onLead event)
     */
    private function init() {
        // Render talbe in body
        this.view = new HTMLTableView(board);
        this.view.render(Lib.document.getElementsByTagName("body")[0]);
        var self : JSGameController = this;

        // Add keypress events
        Lib.document.onkeypress = function(event : Event) : Void {
            switch(event.keyCode) {
                case KEY_UP:
                    self.moveUp();
                case KEY_LEFT:
                    self.moveLeft();
                case KEY_DOWN:
                    self.moveDown();
                case KEY_RIGHT:
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
            // tile, try to determine what it is. A kitten or a thing?
            if(tile != null) {
                if(!tile.isEmpty()) {
                    switch(Type.getClass(tile.getEntity())) {
                        case Thing:
                            this.view.showMessage((cast(tile.getEntity(), Thing).getDescription()));
                        case Kitten:
                            this.view.showMessage("Found kitten!");
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

}
