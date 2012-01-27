package models;

/**
 * This factory is used to build entities of different kind
 */
class DefaultEntityFactory implements EntityFactory {

    private static var DESCRIPTIONS : Array<String> = [
        "Not a kitten",
        "A pack of gum"
    ];

    private var randomMax : Int;

    /**
     * Creates the default factory. To create random thing, this factory chooses
     * two random numbers between 0 and the given "randomMax" value. If the 2
     * are equal, a thing will be returned (see createRandomThing method)
     */
    public function new(randomMax : Int) {
        this.randomMax = randomMax;
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
     * Creates a new thing
     */
    public function createThing() : Thing {
        var representation : String = String.fromCharCode(33 + Std.random(93));
        var color : Array<Int> = this.toRGB(Std.random(360));
        var description : String = DESCRIPTIONS[Std.random(DESCRIPTIONS.length)];
        return new Thing(representation, color, description);
    }

    /**
     * Randomly create a thing - it may return a thing or not (by returning null)
     */
    public function createRandomThing() : Thing {
        var thing : Thing = null;
        var one : Int = Std.random(Math.floor(this.randomMax));
        var two : Int = Std.random(Math.floor(this.randomMax));
        if(one == two) {
            thing = this.createThing();
        }
        return thing;
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