package views.js;

import models.Board;
import models.Entity;
import models.Position;
import models.Tile;
import js.Dom;
import js.Lib;
import haxe.Timer;

/**
 *  This view is to be used with Javascript-based controllers
 */
class HTMLTableView {

    private static var TABLE_ID = "gameBoard";
    private static var MESSAGE_ID = "gameMessage";
    private static var WIN_TABLE_ID = "winBoard";
    private static var ENDING_APPROACH_SPEED = 1000;

    private var board : Board;
    private var messageArea : HtmlDom;
    private var table : HtmlDom;
    private var containerElement : HtmlDom;
    private var cells : Array<Array<HtmlDom>>;
    private var endingApproachTimer : Timer;

    /**
     * Creates a new HTML table view. Specify the model board to render
     * and an HTML element to put the message and board in.
     */
    public function new(board : Board, containerElement : HtmlDom) {
        this.board = board;
        this.containerElement = containerElement;

        this.table = Lib.document.createElement("table");
        this.messageArea = Lib.document.createElement("p");

        this.messageArea.setAttribute("id", MESSAGE_ID);
        this.table.setAttribute("id", TABLE_ID);

        this.cells = new Array<Array<HtmlDom>>();

        var tiles : Array<Array<Tile>> = this.board.getTiles();

        // Add all the tiles in the table
        for(row in tiles) {
            var rowArr : Array<HtmlDom> = new Array<HtmlDom>();
            var tr : HtmlDom = Lib.document.createElement("tr");
            for(tile in row) {
                var td : HtmlDom = Lib.document.createElement("td");

                // If there is a entity in the tile, insert its representation
                if(!tile.isEmpty()) {
                    this.drawCell(td, tile.getEntity());
                }

                tr.appendChild(td);
                rowArr.push(td);
            }

            this.table.appendChild(tr);
            this.cells.push(rowArr);
        }
    }

    /**
     * Shows the welcome message
     */
    public function showWelcome() : Void {
        this.containerElement.appendChild(this.messageArea);
        var welcome : String = "By the illustrious Leonard Richardson (C) 1997, 2000\nWritten originally for the Nerth Pork robotfindskitten contest\n\nIn this game, you are robot (#). Your job is to find kitten. This task\nis complicated by the existence of various things which are not kitten.\nRobot must touch items to determine if they are kitten or not. The game\nends when robotfindskitten.\n\nPress any key to start.";

        for(line in welcome.split("\n")) {
            this.messageArea.appendChild(Lib.document.createTextNode(line));
            this.messageArea.appendChild(Lib.document.createElement("br"));
        }
    }

    /**
     * Renders the table view in the given element
     */
    public function showGameBoard() : Void {
        // Add table to the container
        this.containerElement.appendChild(this.table);
    }

    /**
     * Clear all elements from the page
     */
    public function clear() : Void {
        while(this.containerElement.childNodes.length > 0) {
            this.containerElement.removeChild(this.containerElement.childNodes[0]);
        }

    }

    /**
     * Clears the cell at the given position
     */
    public function clearCellAt(position : Position) : Void {
        var x : Int = position.getX();
        var y : Int = position.getY();

        // Clear the cell
        if(x >= 0 && x < this.cells[0].length && y >= 0 && y < cells.length) {
            this.cells[y][x].removeChild(this.cells[y][x].childNodes[0]);
        }
    }

    /**
     * Draws the cell at a specific position
     */
    public function drawCellAt(position : Position) : Void {
        var x : Int = position.getX();
        var y : Int = position.getY();

        // Redraw the cell
        if(x >= 0 && x < this.cells[0].length && y >= 0 && y < cells.length) {
            var tiles : Array<Array<Tile>> = this.board.getTiles();
            if(!tiles[y][x].isEmpty()) {
                this.drawCell(this.cells[y][x], tiles[y][x].getEntity());
            }

        }
    }

    /**
     * Shows a message in the message display area. It will clear automatically
     * all other messages.
     */
    public function showMessage(message : String) : Void {
        while(this.messageArea.childNodes.length > 0) {
            this.messageArea.removeChild(this.messageArea.childNodes[0]);
        }
        this.messageArea.appendChild(Lib.document.createTextNode(message));
    }

    /**
     * Shows the ending sequence. Provide the robot's position, the kitten's
     * position and a function callback that will be called after the ending
     * sequence
     */
    public function showEnding(robotPosition : Position, kittenPosition : Position, callBack : Dynamic) : Void {
        // Clear messages
        this.showMessage("");

        // Create ending sequence elements
        var robotSpan : HtmlDom = Lib.document.createElement("span");
        var kittenSpan : HtmlDom = Lib.document.createElement("span");
        var spaceSpan : HtmlDom = Lib.document.createElement("span");

        var robot : Entity = this.board.getTileAt(robotPosition).getEntity();
        var kitten : Entity = this.board.getTileAt(kittenPosition).getEntity();

        // Set color of the robot
        robotSpan.setAttribute("style", this.getColorStyle(robot.getColor()));
        robotSpan.appendChild(Lib.document.createTextNode(robot.getRepresentation()));

        // Set color of the kitten
        kittenSpan.setAttribute("style", this.getColorStyle(kitten.getColor()));
        kittenSpan.appendChild(Lib.document.createTextNode(kitten.getRepresentation()));

        // 3 unbreakable spaces
        var spaceText : String = String.fromCharCode(160) + String.fromCharCode(160) + String.fromCharCode(160);
        spaceSpan.appendChild(Lib.document.createTextNode(spaceText));

        // Append all the spans
        this.messageArea.appendChild(robotSpan);
        this.messageArea.appendChild(spaceSpan);
        this.messageArea.appendChild(kittenSpan);

        var self : HTMLTableView = this;
        this.endingApproachTimer = new Timer(ENDING_APPROACH_SPEED);

        // Make thr robot and kitten reach each other
        this.endingApproachTimer.run = function() : Void {
            var chunks : Array<String>;
            chunks = spaceSpan.childNodes[0].nodeValue.split(String.fromCharCode(160));
            if(chunks.length > 1) {
                // Remove one space from the robot and kitten until they reach
                // other
                chunks.splice(chunks.length - 1, 1);
                spaceSpan.removeChild(spaceSpan.childNodes[0]);
                var newSpaces : StringBuf = new StringBuf();
                var i : Int = 0;
                while(i < chunks.length - 1) {
                    newSpaces.add(String.fromCharCode(160));
                    i++;
                }
                spaceSpan.appendChild(Lib.document.createTextNode(newSpaces.toString()));
            } else {
                // Robot and kitten are together now - clear everything out
                self.finishEnding(callBack);
            }
        }

    }

    /**
     * Finishes the ending sequence, calling the callBack function after it's
     * done.
     */
    private function finishEnding(callBack : Dynamic) {
        this.endingApproachTimer.stop();
        this.showMessage("You found kitten! Way to go, robot!");
        callBack();
    }


    /**
     * Draws a single table cell in the game board - specify the cell and the
     * entity to draw in it.
     */
    private function drawCell(cell : HtmlDom, entity : Entity) : Void {
        var spanNode : HtmlDom = Lib.document.createElement("span");
        var textNode : HtmlDom = Lib.document.createTextNode(entity.getRepresentation());
        spanNode.setAttribute("style", this.getColorStyle(entity.getColor()));
        spanNode.appendChild(textNode);
        cell.appendChild(spanNode);
    }

    /**
     * Returns a CSS color property containing the specified RGB values
     * Example output : color:#FFFFFF;
     */
    private function getColorStyle(color : Array<Int>) : String {
        var styleString : StringBuf = new StringBuf();
        styleString.add("color:#");
        for(component in color) {
            var cmp : String = StringTools.hex(component);
            styleString.add(cmp);
            if(cmp.length == 1) {
                styleString.add("0");
            }
        }
        styleString.add(";");
        return styleString.toString();
    }

}