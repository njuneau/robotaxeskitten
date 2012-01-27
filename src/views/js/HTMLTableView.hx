package views.js;

import models.Board;
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
                    var textNode : HtmlDom = Lib.document.createTextNode(cell.getEntity().getRepresentation());
                    spanNode.appendChild(textNode);
                    td.appendChild(spanNode);
                    rowArr.push(td);
                }

                tr.appendChild(td);
                this.cells.push(rowArr);
            }
            this.table.appendChild(tr);
        }

        // Add table to the container
        containerElement.appendChild(this.table);
    }

}