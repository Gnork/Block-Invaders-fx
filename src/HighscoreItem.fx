
public class HighscoreItem {

    var name: String;
    var points: Integer;
    var time: Long;

    init {
        name = "Spieler";
        points = 0;
        time = 0;
    }

    public function getName(): String {
        return this.name;
    }

    public function setName(name: String): Void {
        this.name = name;
    }

    public function getPoints(): Integer {
        return this.points;
    }

    public function setPoints(points: Integer): Void {
        this.points = points;
    }

    public function getTime(): Long {
        return this.time;
    }

    public function setTime(time: Long): Void {
        this.time = time;
    }

}
