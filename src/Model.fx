import java.lang.*;
import javafx.scene.media.Media;
import javafx.scene.media.MediaPlayer;
import javafx.util.Properties;
import javafx.scene.control.TextBox;
import javafx.scene.text.Font;

public class Model {

    public var boxArray: BoxNode[];
    public var playerBox = TextBox {
                text: "Player"
                selectOnFocus: true
                promptText: "Player"
                font: Font { name: "Courier New" size: 27 }
            };
    public var soundOn = true;
    public var downTime: Number = 45;
    public var timeString: String = "00:00";
    public var pointString: String = "0000000";
    public var points: Integer = 0;
    var addPoints: Integer = 0;
    var running: Boolean = false;
    var secondsRunning: Long = 0;
    var threeMatched: Integer = 0;
    var fourMatched: Integer = 0;
    var fiveMatched: Integer = 0;
    var specialFour: Integer = 0;
    var specialFive: Integer = 0;
    var specialFourPosition: Integer = -1;
    var specialFivePosition: Integer = -1;
    var fourMatchedArray: Integer[] = [-1, -1];
    var fourMatchedTypeArray: Integer[] = [-1, -1];
    var fiveMatchedArray: Integer[] = [-1, -1];
    var firstBox: BoxNode = null;
    var secondBox: BoxNode = null;
    var dummyBox1 = BoxNode {};
    var dummyBox2 = BoxNode {};
    var bool1 = false;
    var bool2 = false;
    var bool3 = false;
    var bool4 = false;
    var bool5 = false;
    var bool6 = false;
    var bool7 = false;
    var fourState: Integer = -1;
    var clickable = true;
    var end = false;
    var highscore: Highscore;
    var props = Properties {};
    var sounds: Media[] = [
                Media { source: "http://gnork.org/blockinvaders/sounds/dropped.wav" },
                Media { source: "http://gnork.org/blockinvaders/sounds/check.wav" },
                Media { source: "http://gnork.org/blockinvaders/sounds/highscore.wav" },
                Media { source: "http://gnork.org/blockinvaders/sounds/denied.wav" },
                Media { source: "http://gnork.org/blockinvaders/sounds/beep.wav" },
                Media { source: "http://gnork.org/blockinvaders/sounds/done.wav" },
                Media { source: "http://gnork.org/blockinvaders/sounds/specialfour.wav" },
                Media { source: "http://gnork.org/blockinvaders/sounds/specialfive.wav" }];
    var media: Media;
    var player: MediaPlayer = MediaPlayer {
                media: bind media
                repeatCount: MediaPlayer.REPEAT_NONE
            };

    public function loadHighscore(): Void {
        var getScore:String = PhpIO.getScore();
        var getArray = getScore.toCharArray();
        var values:String[];
        var counter = 0;;
        var single:StringBuffer = new StringBuffer();
        for(i in [0..getScore.length()-1]){
            if(counter < 60){
                if(getArray[i].toString().contentEquals(" ")){
                    values[counter] = single.toString();
                    single = new StringBuffer();
                    ++counter;
                }
                else{
                    single.append(getArray[i]);
                }
            }
            else{
                break;
            }
        }
        var helpArray: HighscoreItem[];
        for (i in [0..9]) {
            helpArray[i] = HighscoreItem {};
        }
        highscore = Highscore {};
        highscore.setPointScore(helpArray);
        highscore.setTimeScore(helpArray);

        if (values != null) {
            var pointArray: HighscoreItem[];
            var timeArray: HighscoreItem[];
            var foo: Integer = 0;

            for (i in [0..9]) {
                foo = i*3;
                pointArray[i] = HighscoreItem {};
                pointArray[i].setName(values[foo]);
                pointArray[i].setPoints(values[foo+1]);
                pointArray[i].setTime(values[foo+2]);
                foo += 30;
                timeArray[i] = HighscoreItem {};
                timeArray[i].setName(values[foo]);
                timeArray[i].setPoints(values[foo+1]);
                timeArray[i].setTime(values[foo+2]);
            }
            highscore.setPointScore(pointArray);
            highscore.setTimeScore(timeArray);
        }
    }

    public function saveHighscore() {
        var keysAndValues:String = "name=";
        keysAndValues += NameCheck.checker(playerBox.rawText);
        keysAndValues += "&points=";
        keysAndValues += points.toString();
        keysAndValues += "&time=";
        keysAndValues += secondsRunning.toString();
        PhpIO.putScore(keysAndValues);
    }

    function preMatch(box: BoxNode) {
        var toCount = false;
        var match = false;
        var hArray: Integer[];
        var vArray: Integer[];
        var hCount: Integer = 0;
        var vCount: Integer = 0;

        for (i in [0..3]) {
            hArray[i] = -1;
            vArray[i] = -1;
        }

        if (box.getPosition() > 7 and boxArray[box.getPosition() - 8].getType() == box.getType()) {
            vArray[0] = boxArray[box.getPosition() - 8].getPosition();
            vCount++;
        }
        if (vArray[0] != -1) {
            if (boxArray[vArray[0]].getPosition() > 7 and boxArray[boxArray[vArray[0]].getPosition() - 8].getType() == boxArray[vArray[0]].getType()) {
                vArray[1] = boxArray[boxArray[vArray[0]].getPosition() - 8].getPosition();
                vCount++;
            }
        }

        if (box.getPosition() < 56 and boxArray[box.getPosition() + 8].getType() == box.getType()) {
            vArray[2] = boxArray[box.getPosition() + 8].getPosition();
            vCount++;
        }
        if (vArray[2] != -1) {
            if (boxArray[vArray[2]].getPosition() < 56 and boxArray[boxArray[vArray[2]].getPosition() + 8].getType() == boxArray[vArray[2]].getType()) {
                vArray[3] = boxArray[boxArray[vArray[2]].getPosition() + 8].getPosition();
                vCount++;
            }
        }

        if (box.getPosition() mod 8 < 7 and boxArray[box.getPosition() + 1].getType() == box.getType()) {
            hArray[0] = boxArray[box.getPosition() + 1].getPosition();
            hCount++;
        }
        if (hArray[0] != -1) {
            if (boxArray[hArray[0]].getPosition() mod 8 < 7 and boxArray[boxArray[hArray[0]].getPosition() + 1].getType() == boxArray[hArray[0]].getType()) {
                hArray[1] = boxArray[boxArray[hArray[0]].getPosition() + 1].getPosition();
                hCount++;
            }
        }

        if (box.getPosition() mod 8 > 0 and boxArray[box.getPosition() - 1].getType() == box.getType()) {
            hArray[2] = boxArray[box.getPosition() - 1].getPosition();
            hCount++;
        }
        if (hArray[2] != -1) {
            if (boxArray[hArray[2]].getPosition() mod 8 > 0 and boxArray[boxArray[hArray[2]].getPosition() - 1].getType() == boxArray[hArray[2]].getType()) {
                hArray[3] = boxArray[boxArray[hArray[2]].getPosition() - 1].getPosition();
                hCount++;
            }
        }

        if (hCount > 1) {
            match = true;
            for (i in [0..3]) {
                if (hArray[i] != -1) {
                    if (not boxArray[hArray[i]].getCounted()) {
                        boxArray[hArray[i]].setCounted(true);
                    }
                    boxArray[hArray[i]].setMatched(true);
                    boxArray[hArray[i]].colorize();
                }
            }
        }

        if (vCount > 1) {
            match = true;
            for (i in [0..3]) {
                if (vArray[i] != -1) {
                    if (not boxArray[vArray[i]].getCounted()) {
                        boxArray[vArray[i]].setCounted(true);
                    }
                    boxArray[vArray[i]].setMatched(true);
                    boxArray[vArray[i]].colorize();
                }
            }
        }
        if (match) {
            box.setMatched(true);
            box.colorize();
            return true;
        }
        return false;
    }

    public function preInitialize(): Void {

        var foo = true;
        for (i in [0..63]) {
            boxArray[i] = BoxNode {};
            boxArray[i].setModel(this);
            boxArray[i].setPosition(i);
            boxArray[i].setType(Math.random() * 7.0 as Integer);
            boxArray[i].colorize();
        }
        while (foo) {
            foo = false;
            for (i in [0..63]) {
                if (boxArray[i].getMatched()) {
                    boxArray[i] = BoxNode {};
                    boxArray[i].setModel(this);
                    boxArray[i].setPosition(i);
                    boxArray[i].setType(Math.random() * 7.0 as Integer);
                    boxArray[i].colorize();
                }
            }
            for (i in [0..63]) {
                if (preMatch(boxArray[i])) {
                    foo = true;
                }
            }

        }
        end = false;
        downTime = 45;
        firstBox = null;
        secondBox = null;
        threeMatched = 0;
        fourMatched = 0;
        fiveMatched = 0;
        pointString = "0000000";
    }

    public function isNeighbor(box1: BoxNode, box2: BoxNode) {
        var bool = false;
        if ((box1.getPosition() > 7 and box1.getPosition() - 8 == box2.getPosition())
                or (box1.getPosition() mod 8 < 7 and box1.getPosition() + 1 == box2.getPosition())
                or (box1.getPosition() mod 8 > 0 and box1.getPosition() - 1 == box2.getPosition())
                or (box1.getPosition() < 56 and box1.getPosition() + 8 == box2.getPosition())) {
            bool = true;
        }
        return bool;
    }

    public function change() {
        if (firstBox != null and secondBox != null) {
            var firstPos = firstBox.getPosition();
            var secondPos = secondBox.getPosition();

            var activeHelp = boxArray[firstPos];
            var secondHelp = boxArray[secondPos];
            boxArray[firstPos] = dummyBox1;
            boxArray[secondPos] = dummyBox2;
            boxArray[firstPos] = secondHelp;
            boxArray[firstPos].setPosition(firstPos);
            boxArray[secondPos] = activeHelp;
            boxArray[secondPos].setPosition(secondPos);
        }
    }

    public function threeMatch(box: BoxNode) {
        var fourPosition: Integer = -1;
        var toCount = false;
        var match = false;
        var hArray: Integer[];
        var vArray: Integer[];
        var hCount: Integer = 0;
        var vCount: Integer = 0;

        for (i in [0..7]) {
            hArray[i] = -1;
            vArray[i] = -1;
        }

        if (not box.getHMatched() and not box.getVMatched()) {

            if (box.getPosition() > 7 and not boxArray[box.getPosition() - 8].getVMatched()) {
                if (boxArray[box.getPosition() - 8].getType() == box.getType()) {
                    vArray[0] = boxArray[box.getPosition() - 8].getPosition();
                    vCount++;
                } else if (boxArray[box.getPosition() - 8].getType() + 8 == box.getType()) {
                    vArray[0] = boxArray[box.getPosition() - 8].getPosition();
                    fourPosition = box.getPosition();
                    vCount++;
                } else if (boxArray[box.getPosition() - 8].getType() - 8 == box.getType()) {
                    vArray[0] = boxArray[box.getPosition() - 8].getPosition();
                    fourPosition = boxArray[box.getPosition() - 8].getPosition();
                    vCount++;
                }
            }

            if (vArray[0] != -1) {
                if (boxArray[vArray[0]].getPosition() > 7 and not boxArray[boxArray[vArray[0]].getPosition() - 8].getVMatched()) {
                    if (boxArray[boxArray[vArray[0]].getPosition() - 8].getType() == boxArray[vArray[0]].getType()) {
                        vArray[1] = boxArray[boxArray[vArray[0]].getPosition() - 8].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[0]].getPosition() - 8].getType() + 8 == boxArray[vArray[0]].getType()) {
                        vArray[1] = boxArray[boxArray[vArray[0]].getPosition() - 8].getPosition();
                        fourPosition = boxArray[vArray[0]].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[0]].getPosition() - 8].getType() - 8 == boxArray[vArray[0]].getType()) {
                        vArray[1] = boxArray[boxArray[vArray[0]].getPosition() - 8].getPosition();
                        fourPosition = boxArray[vArray[1]].getPosition();
                        vCount++;
                    }
                }
            }

            if (vArray[1] != -1) {
                if (boxArray[vArray[1]].getPosition() > 7 and not boxArray[boxArray[vArray[1]].getPosition() - 8].getVMatched()) {
                    if (boxArray[boxArray[vArray[1]].getPosition() - 8].getType() == boxArray[vArray[1]].getType()) {
                        vArray[4] = boxArray[boxArray[vArray[1]].getPosition() - 8].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[1]].getPosition() - 8].getType() + 8 == boxArray[vArray[1]].getType()) {
                        vArray[4] = boxArray[boxArray[vArray[1]].getPosition() - 8].getPosition();
                        fourPosition = boxArray[vArray[1]].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[1]].getPosition() - 8].getType() - 8 == boxArray[vArray[1]].getType()) {
                        vArray[4] = boxArray[boxArray[vArray[1]].getPosition() - 8].getPosition();
                        fourPosition = boxArray[vArray[4]].getPosition();
                        vCount++;
                    }
                }
            }

            if (vArray[4] != -1) {
                if (boxArray[vArray[4]].getPosition() > 7 and not boxArray[boxArray[vArray[4]].getPosition() - 8].getVMatched()) {
                    if (boxArray[boxArray[vArray[4]].getPosition() - 8].getType() == boxArray[vArray[4]].getType()) {
                        vArray[5] = boxArray[boxArray[vArray[4]].getPosition() - 8].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[4]].getPosition() - 8].getType() + 8 == boxArray[vArray[4]].getType()) {
                        vArray[5] = boxArray[boxArray[vArray[4]].getPosition() - 8].getPosition();
                        fourPosition = boxArray[vArray[4]].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[4]].getPosition() - 8].getType() - 8 == boxArray[vArray[4]].getType()) {
                        vArray[5] = boxArray[boxArray[vArray[4]].getPosition() - 8].getPosition();
                        fourPosition = boxArray[vArray[5]].getPosition();
                        vCount++;
                    }
                }
            }

            if (box.getPosition() < 56 and not boxArray[box.getPosition() + 8].getVMatched() and vCount < 4) {
                if (boxArray[box.getPosition() + 8].getType() == box.getType()) {
                    vArray[2] = boxArray[box.getPosition() + 8].getPosition();
                    vCount++;
                } else if (boxArray[box.getPosition() + 8].getType() + 8 == box.getType()) {
                    vArray[2] = boxArray[box.getPosition() + 8].getPosition();
                    fourPosition = box.getPosition();
                    vCount++;
                } else if (boxArray[box.getPosition() + 8].getType() - 8 == box.getType()) {
                    vArray[2] = boxArray[box.getPosition() + 8].getPosition();
                    fourPosition = boxArray[box.getPosition() + 8].getPosition();
                    vCount++;
                }
            }

            if (vArray[2] != -1) {
                if (boxArray[vArray[2]].getPosition() < 56 and not boxArray[boxArray[vArray[2]].getPosition() + 8].getVMatched() and vCount < 4) {
                    if (boxArray[boxArray[vArray[2]].getPosition() + 8].getType() == boxArray[vArray[2]].getType()) {
                        vArray[3] = boxArray[boxArray[vArray[2]].getPosition() + 8].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[2]].getPosition() + 8].getType() + 8 == boxArray[vArray[2]].getType()) {
                        vArray[3] = boxArray[boxArray[vArray[2]].getPosition() + 8].getPosition();
                        fourPosition = boxArray[vArray[2]].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[2]].getPosition() + 8].getType() - 8 == boxArray[vArray[2]].getType()) {
                        vArray[3] = boxArray[boxArray[vArray[2]].getPosition() + 8].getPosition();
                        fourPosition = boxArray[boxArray[vArray[2]].getPosition() + 8].getPosition();
                        vCount++;
                    }
                }
            }

            if (vArray[3] != -1) {
                if (boxArray[vArray[3]].getPosition() < 56 and not boxArray[boxArray[vArray[3]].getPosition() + 8].getVMatched() and vCount < 4) {
                    if (boxArray[boxArray[vArray[3]].getPosition() + 8].getType() == boxArray[vArray[3]].getType()) {
                        vArray[6] = boxArray[boxArray[vArray[3]].getPosition() + 8].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[3]].getPosition() + 8].getType() + 8 == boxArray[vArray[3]].getType()) {
                        vArray[6] = boxArray[boxArray[vArray[3]].getPosition() + 8].getPosition();
                        fourPosition = boxArray[vArray[3]].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[3]].getPosition() + 8].getType() - 8 == boxArray[vArray[3]].getType()) {
                        vArray[6] = boxArray[boxArray[vArray[3]].getPosition() + 8].getPosition();
                        fourPosition = boxArray[boxArray[vArray[3]].getPosition() + 8].getPosition();
                        vCount++;
                    }
                }
            }

            if (vArray[6] != -1) {
                if (boxArray[vArray[6]].getPosition() < 56 and not boxArray[boxArray[vArray[6]].getPosition() + 8].getVMatched() and vCount < 4) {
                    if (boxArray[boxArray[vArray[6]].getPosition() + 8].getType() == boxArray[vArray[6]].getType()) {
                        vArray[7] = boxArray[boxArray[vArray[6]].getPosition() + 8].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[6]].getPosition() + 8].getType() + 8 == boxArray[vArray[6]].getType()) {
                        vArray[7] = boxArray[boxArray[vArray[6]].getPosition() + 8].getPosition();
                        fourPosition = boxArray[vArray[6]].getPosition();
                        vCount++;
                    } else if (boxArray[boxArray[vArray[6]].getPosition() + 8].getType() - 8 == boxArray[vArray[6]].getType()) {
                        vArray[7] = boxArray[boxArray[vArray[6]].getPosition() + 8].getPosition();
                        fourPosition = boxArray[boxArray[vArray[6]].getPosition() + 8].getPosition();
                        vCount++;
                    }
                }
            }

            if (box.getPosition() mod 8 < 7 and not boxArray[box.getPosition() + 1].getHMatched()) {
                if (boxArray[box.getPosition() + 1].getType() == box.getType()) {
                    hArray[0] = boxArray[box.getPosition() + 1].getPosition();
                    hCount++;
                } else if (boxArray[box.getPosition() + 1].getType() + 8 == box.getType()) {
                    hArray[0] = boxArray[box.getPosition() + 1].getPosition();
                    fourPosition = box.getPosition();
                    hCount++;
                } else if (boxArray[box.getPosition() + 1].getType() - 8 == box.getType()) {
                    hArray[0] = boxArray[box.getPosition() + 1].getPosition();
                    fourPosition = boxArray[box.getPosition() + 1].getPosition();
                    hCount++;
                }
            }

            if (hArray[0] != -1) {
                if (boxArray[hArray[0]].getPosition() mod 8 < 7 and not boxArray[boxArray[hArray[0]].getPosition() + 1].getHMatched()) {
                    if (boxArray[boxArray[hArray[0]].getPosition() + 1].getType() == boxArray[hArray[0]].getType()) {
                        hArray[1] = boxArray[boxArray[hArray[0]].getPosition() + 1].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[0]].getPosition() + 1].getType() + 8 == boxArray[hArray[0]].getType()) {
                        hArray[1] = boxArray[boxArray[hArray[0]].getPosition() + 1].getPosition();
                        fourPosition = boxArray[hArray[0]].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[0]].getPosition() + 1].getType() - 8 == boxArray[hArray[0]].getType()) {
                        hArray[1] = boxArray[boxArray[hArray[0]].getPosition() + 1].getPosition();
                        fourPosition = boxArray[boxArray[hArray[0]].getPosition() + 1].getPosition();
                        hCount++;
                    }
                }
            }

            if (hArray[1] != -1) {
                if (boxArray[hArray[1]].getPosition() mod 8 < 7 and not boxArray[boxArray[hArray[1]].getPosition() + 1].getHMatched()) {
                    if (boxArray[boxArray[hArray[1]].getPosition() + 1].getType() == boxArray[hArray[1]].getType()) {
                        hArray[4] = boxArray[boxArray[hArray[1]].getPosition() + 1].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[1]].getPosition() + 1].getType() + 8 == boxArray[hArray[1]].getType()) {
                        hArray[4] = boxArray[boxArray[hArray[1]].getPosition() + 1].getPosition();
                        fourPosition = boxArray[hArray[1]].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[1]].getPosition() + 1].getType() - 8 == boxArray[hArray[1]].getType()) {
                        hArray[4] = boxArray[boxArray[hArray[1]].getPosition() + 1].getPosition();
                        fourPosition = boxArray[boxArray[hArray[1]].getPosition() + 1].getPosition();
                        hCount++;
                    }
                }
            }

            if (hArray[4] != -1) {
                if (boxArray[hArray[4]].getPosition() mod 8 < 7 and not boxArray[boxArray[hArray[4]].getPosition() + 1].getHMatched()) {
                    if (boxArray[boxArray[hArray[4]].getPosition() + 1].getType() == boxArray[hArray[4]].getType()) {
                        hArray[5] = boxArray[boxArray[hArray[4]].getPosition() + 1].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[4]].getPosition() + 1].getType() + 8 == boxArray[hArray[4]].getType()) {
                        hArray[5] = boxArray[boxArray[hArray[4]].getPosition() + 1].getPosition();
                        fourPosition = boxArray[hArray[4]].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[4]].getPosition() + 1].getType() - 8 == boxArray[hArray[4]].getType()) {
                        hArray[5] = boxArray[boxArray[hArray[4]].getPosition() + 1].getPosition();
                        fourPosition = boxArray[boxArray[hArray[4]].getPosition() + 1].getPosition();
                        hCount++;
                    }
                }
            }

            if (box.getPosition() mod 8 > 0 and not boxArray[box.getPosition() - 1].getHMatched() and hCount < 4) {
                if (boxArray[box.getPosition() - 1].getType() == box.getType()) {
                    hArray[2] = boxArray[box.getPosition() - 1].getPosition();
                    hCount++;
                } else if (boxArray[box.getPosition() - 1].getType() + 8 == box.getType()) {
                    hArray[2] = boxArray[box.getPosition() - 1].getPosition();
                    fourPosition = box.getPosition();
                    hCount++;
                } else if (boxArray[box.getPosition() - 1].getType() - 8 == box.getType()) {
                    hArray[2] = boxArray[box.getPosition() - 1].getPosition();
                    fourPosition = boxArray[box.getPosition() - 1].getPosition();
                    hCount++;
                }
            }

            if (hArray[2] != -1) {
                if (boxArray[hArray[2]].getPosition() mod 8 > 0 and not boxArray[boxArray[hArray[2]].getPosition() - 1].getHMatched() and hCount < 4) {
                    if (boxArray[boxArray[hArray[2]].getPosition() - 1].getType() == boxArray[hArray[2]].getType()) {
                        hArray[3] = boxArray[boxArray[hArray[2]].getPosition() - 1].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[2]].getPosition() - 1].getType() + 8 == boxArray[hArray[2]].getType()) {
                        hArray[3] = boxArray[boxArray[hArray[2]].getPosition() - 1].getPosition();
                        fourPosition = boxArray[hArray[2]].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[2]].getPosition() - 1].getType() - 8 == boxArray[hArray[2]].getType()) {
                        hArray[3] = boxArray[boxArray[hArray[2]].getPosition() - 1].getPosition();
                        fourPosition = boxArray[boxArray[hArray[2]].getPosition() - 1].getPosition();
                        hCount++;
                    }
                }
            }

            if (hArray[3] != -1) {
                if (boxArray[hArray[3]].getPosition() mod 8 > 0 and not boxArray[boxArray[hArray[3]].getPosition() - 1].getHMatched() and hCount < 4) {
                    if (boxArray[boxArray[hArray[3]].getPosition() - 1].getType() == boxArray[hArray[3]].getType()) {
                        hArray[6] = boxArray[boxArray[hArray[3]].getPosition() - 1].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[3]].getPosition() - 1].getType() + 8 == boxArray[hArray[3]].getType()) {
                        hArray[6] = boxArray[boxArray[hArray[3]].getPosition() - 1].getPosition();
                        fourPosition = boxArray[hArray[3]].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[3]].getPosition() - 1].getType() - 8 == boxArray[hArray[3]].getType()) {
                        hArray[6] = boxArray[boxArray[hArray[3]].getPosition() - 1].getPosition();
                        fourPosition = boxArray[boxArray[hArray[3]].getPosition() - 1].getPosition();
                        hCount++;
                    }
                }
            }

            if (hArray[6] != -1) {
                if (boxArray[hArray[6]].getPosition() mod 8 > 0 and not boxArray[boxArray[hArray[6]].getPosition() - 1].getHMatched() and hCount < 4) {
                    if (boxArray[boxArray[hArray[6]].getPosition() - 1].getType() == boxArray[hArray[6]].getType()) {
                        hArray[7] = boxArray[boxArray[hArray[6]].getPosition() - 1].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[6]].getPosition() - 1].getType() + 8 == boxArray[hArray[6]].getType()) {
                        hArray[7] = boxArray[boxArray[hArray[6]].getPosition() - 1].getPosition();
                        fourPosition = boxArray[hArray[6]].getPosition();
                        hCount++;
                    } else if (boxArray[boxArray[hArray[6]].getPosition() - 1].getType() - 8 == boxArray[hArray[6]].getType()) {
                        hArray[7] = boxArray[boxArray[hArray[6]].getPosition() - 1].getPosition();
                        fourPosition = boxArray[boxArray[hArray[6]].getPosition() - 1].getPosition();
                        hCount++;
                    }
                }
            }
        }

        if (hCount > 1) {
            box.setHMatched(true);
            if (fourPosition != -1) {
                specialFourPosition = fourPosition;
                ++specialFour;
            }
            match = true;
            for (i in [0..7]) {
                if (hArray[i] != -1) {
                    if (not boxArray[hArray[i]].getCounted()) {
                        toCount = true;
                        boxArray[hArray[i]].setCounted(true);
                    }
                    boxArray[hArray[i]].setHMatched(true);
                    boxArray[hArray[i]].setMatched(true);
                    boxArray[hArray[i]].colorize();
                }
            }
            if (toCount) {
                toCount = false;
                if (hCount == 4) {
                    ++fiveMatched;
                    if (fiveMatchedArray[0] != -1) {
                        fiveMatchedArray[1] = box.getPosition();
                    } else {
                        fiveMatchedArray[0] = box.getPosition();
                    }
                } else if (hCount == 3) {
                    ++fourMatched;
                    if (fourMatchedArray[0] != -1) {
                        fourMatchedArray[1] = box.getPosition();
                        if (box.getType() > 7) {
                            fourMatchedTypeArray[1] = box.getType() - 8
                        } else {
                            fourMatchedTypeArray[1] = box.getType();
                        }
                    } else {
                        fourMatchedArray[0] = box.getPosition();
                        if (box.getType() > 7) {
                            fourMatchedTypeArray[0] = box.getType() - 8
                        } else {
                            fourMatchedTypeArray[0] = box.getType();
                        }
                    }

                } else {
                    ++threeMatched;
                }
            }
        }

        if (vCount > 1) {
            box.setVMatched(true);
            if (fourPosition != -1) {
                specialFourPosition = fourPosition;
                ++specialFour;
            }
            match = true;
            for (i in [0..7]) {
                if (vArray[i] != -1) {
                    if (not boxArray[vArray[i]].getCounted()) {
                        toCount = true;
                        boxArray[vArray[i]].setCounted(true);
                    }
                    boxArray[vArray[i]].setVMatched(true);
                    boxArray[vArray[i]].setMatched(true);
                    boxArray[vArray[i]].colorize();
                }
            }
            if (toCount) {
                toCount = false;
                if (vCount == 4) {
                    ++fiveMatched;
                    if (fiveMatchedArray[0] != -1) {
                        fiveMatchedArray[1] = box.getPosition();
                    } else {
                        fiveMatchedArray[0] = box.getPosition();
                    }
                } else if (vCount == 3) {
                    ++fourMatched;
                    if (fourMatchedArray[0] != -1) {
                        fourMatchedArray[1] = box.getPosition();
                        if (box.getType() > 7) {
                            fourMatchedTypeArray[1] = box.getType() - 8
                        } else {
                            fourMatchedTypeArray[1] = box.getType();
                        }
                    } else {
                        fourMatchedArray[0] = box.getPosition();
                        if (box.getType() > 7) {
                            fourMatchedTypeArray[0] = box.getType() - 8
                        } else {
                            fourMatchedTypeArray[0] = box.getType();
                        }
                    }
                } else {
                    ++threeMatched;
                }
            }
        }
        if (match) {
            box.setMatched(true);
            box.colorize();
            return true;
        }
        return false;
    }

    public function deleteMatch() {
        for (i in [0..63]) {
            if (boxArray[i].getMatched() == true) {
                boxArray[i] = BoxNode {};
                boxArray[i].colorize();
            }
        }
    }

    public function fillMatch() {
        var somethingToMove = false;
        var i = 63;
        while (i >= 0) {
            if (boxArray[i].getType() == -1) {
                for (j in [0..63]) {
                    if (j mod 8 == i mod 8 and j <= i) {
                        boxArray[i].setToMove(true);
                        somethingToMove = true;
                    }
                }
            }
            i--;
        }
        i = 63;
        if (somethingToMove) {
            while (i >= 0) {
                if (boxArray[i].getToMove()) {
                    if (i > 7) {
                        var help = boxArray[i - 8];
                        boxArray[i - 8] = BoxNode {};
                        boxArray[i - 8].setToMove(true);
                        boxArray[i] = help;
                        boxArray[i].setPosition(i);
                        boxArray[i].setMoved(true);
                    } else {
                        boxArray[i] = BoxNode {};
                        boxArray[i].setModel(this);
                        boxArray[i].setPosition(i);
                        boxArray[i].setType(Math.random() * 7.0 as Integer);
                        boxArray[i].colorize();
                        boxArray[i].setMoved(true);
                    }
                }
                boxArray[i].setToMove(false);
                i--;
            }
            return true;
        }
        return false;
    }

    public function addTime() {
        ++secondsRunning;
        timeString = timeToString(secondsRunning.toString());
    }

    public function decreaseDownTime(): Boolean {
        if (downTime > 0) {
            downTime -= 1;
        } else {
            return true;
        }
        return false;
    }

    public function calcPT() {
        calcPoints();
        calcTime();
        pointString = leadingZeroString(addPoints);
        points += addPoints;
        threeMatched = 0;
        fourMatched = 0;
        fiveMatched = 0;
        specialFour = 0;
        specialFive = 0;
        addPoints = 0;
    }

    function calcPoints() {
        var factor = 0.75 + (threeMatched + fourMatched + fiveMatched + specialFour + specialFive) * 0.25;
        var sum = threeMatched * 100 + fourMatched * 250 + fiveMatched * 750 + 2500 * specialFour + 500 * specialFive;;
        addPoints = (sum * factor) as Integer;
    }

    function calcTime() {
        if (not end) {
            if (addPoints >= 12500) {
                addTimeToDownTime(19);
            } else if (addPoints >= 7500) {
                addTimeToDownTime(16);
            } else if (addPoints >= 4000) {
                addTimeToDownTime(13);
            } else if (addPoints >= 1500) {
                addTimeToDownTime(10);
            } else if (addPoints >= 500) {
                addTimeToDownTime(7);
            } else if (addPoints > 100) {
                addTimeToDownTime(4)
            } else if (addPoints >= 100) {
                addTimeToDownTime(1);
            }
        }
    }

    function addTimeToDownTime(time: Number) {
        if (downTime + time > 60) {
            downTime = 60;
        } else {
            downTime = downTime + time;
        }
    }

    public function leadingZeroString(points: Integer): String {
        var foo0 = points / 1000000;
        var foo1 = (points mod 1000000) / 100000;
        var foo2 = (points mod 100000) / 10000;
        var foo3 = (points mod 10000) / 1000;
        var foo4 = (points mod 1000) / 100;
        var foo5 = (points mod 100) / 10;
        var foo6 = points mod 10;
        var bar: String = "{foo0.toString()}{foo1.toString()}{foo2.toString()}{foo3.toString()}{foo4.toString()}{foo5.toString()}{foo6.toString()}";
        return bar;
    }

    public function timeToString(stringTime: String): String {
        var time = Integer.parseInt(stringTime);
        var secondsString: String = "0";
        var minutesString: String = "0";
        var foo = time mod 60;
        var bar = time / 60;
        if (foo < 10) {
            secondsString = secondsString.concat(foo.toString());
        } else {
            secondsString = foo.toString();
        }
        if (bar < 10) {
            minutesString = minutesString.concat(bar.toString());
        } else {
            minutesString = bar.toString();
        }
        return "{minutesString}:{secondsString}";
    }

    public function getSecondBox(): BoxNode {
        return secondBox;
    }

    public function setSecondBox(secondBox: BoxNode) {
        this.secondBox = secondBox;
    }

    public function getFirstBox(): BoxNode {
        return firstBox;
    }

    public function setFirstBox(firstBox: BoxNode) {
        this.firstBox = firstBox;
    }

    public function getBoxArray(): BoxNode[] {
        return boxArray;
    }

    public function setBoxArray(boxArray: BoxNode[]) {
        this.boxArray = boxArray;
    }

    public function getBool1(): Boolean {
        return bool1;
    }

    public function setBool1(bool1: Boolean) {
        this.bool1 = bool1;
    }

    public function getBool2(): Boolean {
        return bool2;
    }

    public function setBool2(bool2: Boolean) {
        this.bool2 = bool2;
    }

    public function getBool3(): Boolean {
        return bool3;
    }

    public function setBool3(bool3: Boolean) {
        this.bool3 = bool3;
    }

    public function getBool4(): Boolean {
        return bool4;
    }

    public function setBool4(bool4: Boolean) {
        this.bool4 = bool4;
    }

    public function getBool5(): Boolean {
        return bool5;
    }

    public function setBool5(bool5: Boolean) {
        this.bool5 = bool5;
    }

    public function getBool6(): Boolean {
        return bool6;
    }

    public function setBool6(bool6: Boolean) {
        this.bool6 = bool6;
    }

    public function getBool7(): Boolean {
        return bool7;
    }

    public function setBool7(bool7: Boolean) {
        this.bool7 = bool7;
    }

    public function getClickable(): Boolean {
        return clickable;
    }

    public function setClickable(clickable: Boolean) {
        this.clickable = clickable;
    }

    public function getPlayer(): MediaPlayer {
        return player;
    }

    public function getMedia(): Media {
        return media;
    }

    public function setMedia(media: Media) {
        this.media = media;
    }

    public function getSounds(): Media[] {
        return sounds;
    }

    public function setRunning(running: Boolean) {
        this.running = running;
    }

    public function getRunning(): Boolean {
        return running;
    }

    public function setEnd(end: Boolean) {
        this.end = end;
    }

    public function getEnd(): Boolean {
        return end;
    }

    public function setSecondsRunning(secondsRunning: Integer) {
        this.secondsRunning = secondsRunning;
    }

    public function getHighscore(): Highscore {
        return this.highscore;
    }

    public function getFourMatchedArray(): Integer[] {
        return this.fourMatchedArray;
    }

    public function setFourMatchedArray(fourMatchedArray: Integer[]): Void {
        this.fourMatchedArray = fourMatchedArray;
    }

    public function getFourMatchedTypeArray(): Integer[] {
        return this.fourMatchedTypeArray;
    }

    public function setFourMatchedTypeArray(fourMatchedTypeArray: Integer[]): Void {
        this.fourMatchedTypeArray = fourMatchedTypeArray;
    }

    public function getFiveMatchedArray(): Integer[] {
        return this.fiveMatchedArray;
    }

    public function setFiveMatchedArray(fiveMatchedArray: Integer[]): Void {
        this.fiveMatchedArray = fiveMatchedArray;
    }

    public function getFourState(): Integer {
        return this.fourState;
    }

    public function setFourState(fourState: Integer): Void {
        this.fourState = fourState;
    }

    public function getSpecialFourPosition(): Integer {
        return this.specialFourPosition;
    }

    public function setSpecialFourPosition(specialFourPosition: Integer): Void {
        this.specialFourPosition = specialFourPosition;
    }

    public function getSpecialFive(): Integer {
        return this.specialFive;
    }

    public function setSpecialFive(specialFive: Integer): Void {
        this.specialFive = specialFive;
    }
}
