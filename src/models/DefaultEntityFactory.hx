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

package models;

import haxe.Resource;

/**
 * This factory is used to build entities of different kind
 */
class DefaultEntityFactory implements EntityFactory {

    private static var DESCRIPITIONS_RESOURCES : String = "nkis";
    private static var COMMENT_CHAR = "#";

    private var randomMax : Int;
    private var descriptions : Array<String>;

    /**
     * Creates the default factory. To create random thing, this factory chooses
     * two random numbers between 0 and the given "randomMax" value. If the 2
     * are equal, a thing will be returned (see createRandomThing method)
     */
    public function new(randomMax : Int) {
        this.randomMax = randomMax;

        this.descriptions = new Array<String>();
        var descriptions : Array<String> = Resource.getString(DESCRIPITIONS_RESOURCES).split("\n");

        // Clean comments and descriptions
        for(desc in descriptions) {
            var desc : String = StringTools.ltrim(desc);
            if(desc.charAt(0) != COMMENT_CHAR) {
                this.descriptions.push(desc);
            }
        }
    }

    /**
     * Creates a new kitten
     */
    public function createKitten() : Kitten {
        var representation : String = String.fromCharCode(33 + Std.random(93));
        var color : Array<Int> = this.toRGB(Std.random(360));
        return new Kitten(representation, color);
    }

    /**
     * Creates a new non-kitten item
     */
    public function createNKI() : NKI {
        var representation : String = String.fromCharCode(33 + Std.random(94));
        var color : Array<Int> = this.toRGB(Std.random(360));
        var description : String = this.descriptions[Std.random(this.descriptions.length)];
        return new NKI(representation, color, description);
    }

    /**
     * Randomly create a thing - it may return a thing or not (by returning null)
     */
    public function createRandomNKI() : NKI {
        var nki : NKI = null;
        var one : Int = Std.random(Math.floor(this.randomMax));
        var two : Int = Std.random(Math.floor(this.randomMax));
        if(one == two) {
            nki = this.createNKI();
        }
        return nki;
    }

    /**
     * Returns the RGB components from HSV components
     * Hue is between 0 and 360.
     * Saturation and value between 0 an 1.
     * Algorithm from there : http://fr.wikipedia.org/wiki/Teinte_Saturation_Valeur#Conversion_de_TSV_vers_RVB
     */
    private function toRGB(h : Float) : Array<Int> {
        var rgb : Array<Int>;
        var s : Float = 1;
        var hi : Int = Math.floor(h / 60) % 6;
        var f : Float = h / 60 - hi;

        var v : Float = 1;
        var l : Float = v * (1 - s);
        var m : Float = v * (1 - f * s);
        var n : Float = v * (1 - (1 -f) * s);

        var cv : Int = Math.round(v * 255);
        var cl : Int = Math.round(l * 255);
        var cm : Int = Math.round(m * 255);
        var cn : Int = Math.round(n * 255);

        switch(hi) {
            case 0:
                rgb = [cv, cn, cl];
            case 1:
                rgb = [cm, cv, cl];
            case 2:
                rgb = [cl, cv, cn];
            case 3:
                rgb = [cl, cm, cv];
            case 4:
                rgb = [cn, cl, cv];
            case 5:
                rgb = [cv, cl, cm];
            default:
                rgb = [128, 128, 128];
        }

        return rgb;
    }

}