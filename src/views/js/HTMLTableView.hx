package views.js;

import models.Board;
import models.Position;
import models.Tile;
import js.Dom;
import js.Lib;

/**
 *  This view is to be used with Javascript-based controllers
 */
class HTMLTableView {

    private static var TABLE_ID = "gameBoard";

    private var board : Board;
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
        this.table.setAttribute("id", TABLE_ID);
        this.cells = new Array<Array<HtmlDom>>();

        var tiles : Array<Array<Tile>> = this.board.getTiles();

        // Add all the tiles in the table
        for(row in tiles) {
            var rowArr : Array<HtmlDom> = new Array<HtmlDom>();
            var tr : HtmlDom = Lib.document.createElement("tr");
            for(cell in row) {
                var td : HtmlDom = Lib.document.createElement("td");

                // If there is a entity in the tile, insert its representation
                if(!cell.isEmpty()) {
                    var spanNode : HtmlDom = Lib.document.createElement("span");
                    var color : Array<Int> = cell.getEntity().getColor();
                    var styleString : StringBuf = new StringBuf();
                    styleString.add("color:#");
                    for(component in color) {
                        styleString.add(StringTools.hex(component));
                    }
                    styleString.add(";");
                    spanNode.setAttribute("style", styleString.toString());
                    var textNode : HtmlDom = Lib.document.createTextNode(cell.getEntity().getRepresentation());
                    spanNode.appendChild(textNode);
                    td.appendChild(spanNode);
                }

                tr.appendChild(td);
                rowArr.push(td);
            }

            this.table.appendChild(tr);
            this.cells.push(rowArr);

        }

        // Add table to the container
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
                var spanNode : HtmlDom = Lib.document.createElement("span");
                var textNode : HtmlDom = Lib.document.createTextNode(tiles[y][x].getEntity().getRepresentation());
                var color : Array<Int> = tiles[y][x].getEntity().getColor();
                var styleString : StringBuf = new StringBuf();
                styleString.add("color:#");
                for(component in color) {
                    styleString.add(StringTools.hex(component));
                }
                styleString.add(";");
                spanNode.setAttribute("style", styleString.toString());
                spanNode.appendChild(textNode);
                this.cells[y][x].appendChild(spanNode);
            }

        }
    }

}