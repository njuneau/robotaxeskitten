package views.js;

import models.Board;
import models.Entity;
import models.Position;
import models.Tile;
import js.Dom;
import js.Lib;

/**
 *  This view is to be used with Javascript-based controllers
 */
class HTMLTableView {

    private static var TABLE_ID = "gameBoard";
    private static var MESSAGE_ID = "gameMessage";

    private var board : Board;
    private var messageArea : HtmlDom;
    private var table : HtmlDom;
    private var cells : Array<Array<HtmlDom>>;

    /**
     * Creates a new HTML table view
     */
    public function new(board : Board) {
        this.board = board;
    }

    /**
     * Renders the table view in the given element
     */
    public function render(containerElement : HtmlDom) {
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

        // Add table to the container
        containerElement.appendChild(this.messageArea);
        containerElement.appendChild(this.table);
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
     * Draws a single table cell in the game board - specify the cell and the
     * entity to draw in it.
     */
    private function drawCell(cell : HtmlDom, entity : Entity) : Void {
        var spanNode : HtmlDom = Lib.document.createElement("span");
        var textNode : HtmlDom = Lib.document.createTextNode(entity.getRepresentation());
        var color : Array<Int> = entity.getColor();
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
        spanNode.setAttribute("style", styleString.toString());
        spanNode.appendChild(textNode);
        cell.appendChild(spanNode);
    }

}