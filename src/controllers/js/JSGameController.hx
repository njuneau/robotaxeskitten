package controllers.js;

import models.Board;
import views.js.HTMLTableView;
import js.Lib;
import js.Dom;

/**
 * This is the JavaScript-based game controller.
 */
class JSGameController {

    private static var KEY_UP : Int = 38;
    private static var KEY_LEFT : Int = 37;
    private static var KEY_DOWN : Int = 40;
    private static var KEY_RIGHT : Int = 39;


    private var board : Board;
    private var view : HTMLTableView;

    /**
     * Creates a new game of robotfindskitten controlled by JavaScript
     */
    public function new() {
        this.board = new Board(60, 60);
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
        }
    }

    /**
     * Move the robot up
     */
    private function moveUp() : Void {
        trace("up");
    }

    /**
     * Move the robot left
     */
    private function moveLeft() : Void {
        trace("left");
    }

    /**
     * Move the robot down
     */
    private function moveDown() : Void {
        trace("down");
    }

    /**
     * Move the robot right
     */
    public function moveRight() : Void {
        trace("right");
    }

}