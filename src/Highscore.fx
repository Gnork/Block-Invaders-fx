
public class Highscore {

    var pointScore: HighscoreItem[];
    var timeScore: HighscoreItem[];

    public function getPointScore(): HighscoreItem[] {
        return this.pointScore;
    }

    public function setPointScore(pointScore: HighscoreItem[]): Void {
        this.pointScore = pointScore;
    }

    public function getTimeScore(): HighscoreItem[] {
        return this.timeScore;
    }

    public function setTimeScore(timeScore: HighscoreItem[]): Void {
        this.timeScore = timeScore;
    }

}
