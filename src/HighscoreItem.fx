
public class HighscoreItem {

    var name: String;
    var points: String;
    var time: String;

    init {
        name = "Spieler";
        points = "0";
        time = "0";
    }

    public function getName(): String {
        return this.name;
    }

    public function setName(name: String): Void {
        this.name = name;
    }

    public function getPoints(): String {
        return this.points;
    }

    public function setPoints(points: String): Void {
        this.points = points;
    }

    public function getTime(): String {
        return this.time;
    }

    public function setTime(time: String): Void {
        this.time = time;
    }

}
