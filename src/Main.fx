import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.layout.Tile;
import javafx.scene.paint.Color;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import javafx.scene.layout.VBox;
import javafx.geometry.Insets;
import javafx.scene.layout.HBox;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.input.MouseEvent;
import javafx.scene.Group;
import javafx.scene.shape.Rectangle;

var showCredits = false;
var showMainMenu = true;
var showGame = false;
var showQuestion = false;
var showHighScore = false;
var showGameOver = false;
var showThree = false;
var showTwo = false;
var showOne = false;
var preGame = false;
var isFont = false;
var initialized = true;
var model = Model {};
var textArray: Text[];
var blink = true;
var logo1 = ImageNode { type: 1 };
var logo2 = ImageNode { type: 2 };
var logo3 = ImageNode { type: 3 };

logo1.colorize();
logo2.colorize();
logo3.colorize();
var pixelFont: Font = Font {
            name: "Courier New"
            size: 24
        }

createTextArray();
model.preInitialize();
model.loadHighscore();

Stage {
    title: "ThreeMatch"
    resizable: false
    height: 50 * 8 + 35 + 78 + 32
    width: 50 * 8 + 35 + 150 + 10
    var creditsMenu = Scene {
                fill: Color.BLACK
                content: [
                    VBox {
                        padding: Insets {
                            top: 50
                            left: 40
                        }
                        spacing: 30
                        content: [
                            Text {
                                content: "Block Invaders fx"
                                fill: Color.WHITE
                                stroke: Color.WHITE
                                strokeWidth: 0
                                font: Font { name: "Courier New" size: 36 }
                            }
                            VBox {
                                padding: Insets {
                                    top: 40
                                }

                                spacing: 20
                                content: [
                                    Text {
                                        content: "Author: Christoph Jansen"
                                        fill: Color.WHITE
                                        stroke: Color.WHITE
                                        strokeWidth: 0
                                        font: Font { name: "Arial" size: 24 }
                                    }
                                    Text {
                                        content: "Projektbetreuer: Christian Bettinger"
                                        fill: Color.WHITE
                                        stroke: Color.WHITE
                                        strokeWidth: 0
                                        font: Font { name: "Arial" size: 24 }
                                    }
                                ]
                            }
                            VBox {
                                content: [
                                    Text {
                                        content: "Das Spiel ist im Rahmen des Medienprojekts"
                                        fill: Color.WHITE
                                        stroke: Color.WHITE
                                        strokeWidth: 0
                                        font: Font { name: "Arial" size: 16 }
                                    }
                                    Text {
                                        content: "der Fachhochschule Trier im SS2011 entstanden."
                                        fill: Color.WHITE
                                        stroke: Color.WHITE
                                        strokeWidth: 0
                                        font: Font { name: "Arial" size: 16 }
                                    }
                                ]
                            }
                            VBox {
                                padding: Insets {
                                    top: 100
                                }

                                content: [
                                    Text {
                                        content: "Menu"
                                        fill: Color.RED
                                        stroke: Color.RED
                                        strokeWidth: 0
                                        font: Font { name: "Courier New" size: 27 }
                                        onMousePressed: function(e: MouseEvent): Void {
                                            showMainMenu = true;
                                            showCredits = false;
                                        }
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    var gameOver = Scene {
                fill: Color.BLACK
                content: [
                    VBox {
                        spacing: 40
                        padding: Insets {
                            top: 30
                        }
                        content: [
                            logo3,
                            VBox {
                                spacing: 30
                                padding: Insets {
                                    left: 120
                                    top: 0
                                }
                                content: [
                                    HBox {
                                        padding: Insets {
                                            right: 203
                                        }

                                        spacing: 10
                                        content: [
                                            Text {
                                                content: "Name:"
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 27 }
                                            }
                                            model.playerBox
                                        ]
                                    }
                                    HBox {
                                        spacing: 10
                                        content: [
                                            Text {
                                                content: "Points:"
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 27 }
                                            }
                                            Text {
                                                content: bind model.points.toString()
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 27 }
                                            }
                                        ]
                                    }
                                    HBox {
                                        spacing: 10
                                        content: [
                                            Text {
                                                content: "Time:"
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 27 }
                                            }
                                            Text {
                                                content: bind model.timeString
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 27 }
                                            }
                                        ]
                                    }
                                ]
                            }
                            VBox {
                                padding: Insets {
                                    top: 20
                                    left: 120
                                }

                                content: [
                                    Text {
                                        content: "Next"
                                        fill: Color.RED
                                        stroke: Color.RED
                                        strokeWidth: 0
                                        font: Font { name: "Courier New" size: 36 }
                                        onMousePressed: function(e: MouseEvent): Void {
                                            model.saveHighscore();
                                            updateTextArray();
                                            showGame = false;
                                            showMainMenu = false;
                                            showHighScore = true;
                                            showGameOver = false;
                                        }
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    var game = Scene {
                fill: Color.BLACK
                content: [
                    HBox {
                        content: [
                            VBox {
                                content: [
                                    VBox {
                                        padding: Insets {
                                            top: 14
                                            left: 155
                                        }
                                        content: [

                                            Text {
                                                content: bind model.pointString
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 36 }
                                            }
                                        ]
                                    }
                                    Tile {
                                        content: bind model.boxArray
                                        columns: 8
                                        rows: 8
                                        hgap: 5
                                        vgap: 5
                                        padding: Insets {
                                            top: 14
                                            left: 15
                                        }
                                    }
                                ]
                            }
                            VBox {
                                spacing: 20
                                width: 80
                                padding: Insets {
                                    top: 20
                                    left: 15
                                    bottom: 10
                                }
                                content: [
                                    VBox {
                                        padding: Insets {
                                            top: 10
                                            left: 33
                                        }
                                        content: [
                                            Group {
                                                content: [
                                                    Rectangle {
                                                        height: 190
                                                        width: 40
                                                        fill: Color.BLACK
                                                        stroke: Color.WHITE
                                                        strokeWidth: 5
                                                    }
                                                    Rectangle {
                                                        x: 5
                                                        y: bind 5 + (180 - model.downTime * 3)
                                                        height: bind model.downTime * 3
                                                        width: 30
                                                        fill: Color.LIME
                                                    }
                                                ]
                                            }
                                        ]
                                    }
                                    VBox {
                                        spacing: 10
                                        content: [
                                            Text {
                                                content: "Time:"
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 21 }
                                            }
                                            Text {
                                                content: bind model.timeString
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 21 }
                                            }
                                        ]
                                    }
                                    VBox {
                                        spacing: 10
                                        content: [
                                            Text {
                                                content: "Points:"
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 21 }
                                            }
                                            Text {
                                                content: bind model.points.toString()
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 21 }
                                            }
                                        ]
                                    }
                                    Text {
                                        content: "Exit"
                                        fill: Color.RED
                                        stroke: Color.RED
                                        strokeWidth: 0
                                        font: Font { name: "Courier New" size: 27 }
                                        onMousePressed: function(e: MouseEvent): Void {
                                            if (model.getClickable()) {
                                                finish();
                                            }
                                        }
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    var mainMenu = Scene {
                fill: Color.BLACK
                content: [
                    VBox {
                        padding: Insets {
                            top: 30
                        }
                        content: [
                            logo1,
                            VBox {
                                spacing: 30
                                padding: Insets {
                                    left: 120
                                    top: 0
                                }
                                content: [
                                    HBox {
                                        spacing: 10
                                        content: [
                                            Text {
                                                content: "Start Game"
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 36 }
                                                onMousePressed: function(e: MouseEvent): Void {
                                                    model.setBool1(true);
                                                    preGame = true;
                                                }
                                            }
                                            Rectangle {
                                                translateX: 0
                                                width: 3, height: 38
                                                fill: Color.WHITE
                                                visible: bind blink
                                            }
                                        ]
                                    }
                                    Text {
                                        content: "Highscore"
                                        fill: Color.WHITE
                                        stroke: Color.WHITE
                                        strokeWidth: 0
                                        font: Font { name: "Courier New" size: 36 }
                                        onMousePressed: function(e: MouseEvent): Void {
                                            updateTextArray();
                                            showGame = false;
                                            showMainMenu = false;
                                            showHighScore = true;
                                            showGameOver = false;
                                        }
                                    }
                                    Text {
                                        content: "Credits"
                                        fill: Color.WHITE
                                        stroke: Color.WHITE
                                        strokeWidth: 0
                                        font: Font { name: "Courier New" size: 36 }
                                        onMousePressed: function(e: MouseEvent): Void {
                                            showMainMenu = false;
                                            showCredits = true
                                        }
                                    }
                                    HBox {
                                        spacing: 20
                                        content: [
                                            Text {
                                                translateY: 4
                                                content: "Sound"
                                                fill: Color.WHITE
                                                stroke: Color.WHITE
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 36 }
                                                onMousePressed: function(e: MouseEvent): Void {
                                                    model.soundOn = not model.soundOn;
                                                }
                                            }
                                            Group {
                                                onMousePressed: function(e: MouseEvent): Void {
                                                    model.soundOn = not model.soundOn;
                                                }

                                                content: [
                                                    Rectangle {
                                                        x: 0, y: -23
                                                        width: 26, height: 26
                                                        fill: Color.BLACK
                                                        strokeWidth: 3
                                                        stroke: Color.WHITE
                                                    }
                                                    Text {
                                                        content: "x"
                                                        font: Font { name: "Courier New" size: 44 }
                                                        strokeWidth: 0
                                                        fill: bind if (model.soundOn) then Color.RED else Color.BLACK
                                                        stroke: bind if (model.soundOn) then Color.RED else Color.BLACK
                                                    }
                                                ]
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    var question = Scene {
                fill: Color.BLACK
                content: [
                    VBox {
                        spacing: 40,
                        padding: Insets {
                            top: 200,
                            left: 185
                        }

                        content: [
                            Text {
                                content: "Are you sure?"
                                fill: Color.WHITE
                                stroke: Color.WHITE
                                strokeWidth: 0
                                font: Font { name: "Courier New" size: 27 }
                            }
                            HBox {
                                padding: Insets {
                                    left: 35
                                },
                                spacing: 50,
                                content: [
                                    Text {
                                        content: "Yes"
                                        fill: Color.WHITE
                                        stroke: Color.WHITE
                                        strokeWidth: 0
                                        font: Font { name: "Courier New" size: 27 }
                                        onMousePressed: function(e: MouseEvent): Void {
                                            model.resetHighscore();
                                            updateTextArray();
                                            showQuestion = false;
                                            showHighScore = true;
                                        }
                                    }
                                    Text {
                                        content: "No"
                                        fill: Color.WHITE
                                        stroke: Color.WHITE
                                        strokeWidth: 0
                                        font: Font { name: "Courier New" size: 27 }
                                        onMousePressed: function(e: MouseEvent): Void {
                                            showQuestion = false;
                                            showHighScore = true;
                                        }
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    var highscore = Scene {
                fill: Color.BLACK
                content: [
                    VBox {
                        padding: Insets {
                            top: 20
                        }
                        content: [
                            logo2,
                            VBox {
                                spacing: 30
                                padding: Insets {
                                    left: 35
                                    top: 10
                                }
                                content: [

                                    HBox {
                                        spacing: 30
                                        content: [
                                            VBox {
                                                spacing: 20
                                                content: [
                                                    Text {
                                                        content: "Points"
                                                        fill: Color.WHITE
                                                        stroke: Color.WHITE
                                                        strokeWidth: 0
                                                        font: pixelFont
                                                    }
                                                    HBox {
                                                        spacing: 5
                                                        content: [
                                                            HBox {
                                                                content: [

                                                                    VBox {
                                                                        spacing: 10
                                                                        content: [
                                                                            for (i in [0..9]) {
                                                                                textArray[i + 60]
                                                                            }
                                                                        ]
                                                                    }
                                                                    VBox {
                                                                        spacing: 10
                                                                        content: [
                                                                            for (i in [0..9]) {
                                                                                textArray[i]
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            }
                                                            VBox {
                                                                spacing: 10
                                                                content: [
                                                                    for (i in [0..9]) {
                                                                        textArray[i + 10]
                                                                    }
                                                                ]
                                                            }
                                                            VBox {
                                                                spacing: 10
                                                                content: [
                                                                    for (i in [0..9]) {
                                                                        textArray[i + 20]
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                            VBox {
                                                spacing: 20
                                                content: [
                                                    Text {
                                                        content: "Time"
                                                        fill: Color.WHITE
                                                        stroke: Color.WHITE
                                                        strokeWidth: 0
                                                        font: pixelFont
                                                    }
                                                    HBox {
                                                        spacing: 10
                                                        content: [
                                                            HBox {
                                                                content: [

                                                                    VBox {
                                                                        spacing: 10
                                                                        content: [
                                                                            for (i in [0..9]) {
                                                                                textArray[i + 70]
                                                                            }
                                                                        ]
                                                                    }
                                                                    VBox {
                                                                        spacing: 10
                                                                        content: [
                                                                            for (i in [0..9]) {
                                                                                textArray[i + 30]
                                                                            }
                                                                        ]
                                                                    }
                                                                ]
                                                            }
                                                            VBox {
                                                                spacing: 10
                                                                content: [
                                                                    for (i in [0..9]) {
                                                                        textArray[i + 40]
                                                                    }
                                                                ]
                                                            }
                                                            VBox {
                                                                spacing: 10
                                                                content: [
                                                                    for (i in [0..9]) {
                                                                        textArray[i + 50]
                                                                    }
                                                                ]
                                                            }
                                                        ]
                                                    }
                                                ]
                                            }
                                        ]
                                    }
                                    HBox {
                                        spacing: 30
                                        content: [
                                            Text {
                                                content: "Menu"
                                                fill: Color.RED
                                                stroke: Color.RED
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 27 }
                                                onMousePressed: function(e: MouseEvent): Void {
                                                    showGame = false;
                                                    showMainMenu = true;
                                                    showHighScore = false;
                                                    showGameOver = false;
                                                }
                                            }
                                            Text {
                                                content: "Reset"
                                                fill: Color.RED
                                                stroke: Color.RED
                                                strokeWidth: 0
                                                font: Font { name: "Courier New" size: 27 }
                                                onMousePressed: function(e: MouseEvent): Void {
                                                    showHighScore = false;
                                                    showQuestion = true;
                                                }
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    var three = Scene {
                fill: Color.BLACK
                content: [
                    HBox {
                        padding: Insets {
                            top: 220
                            left: 142
                        }

                        content: [
                            Group {
                                content: [
                                    Rectangle {
                                        fill: Color.WHITE
                                        width: 300
                                        height: 10
                                    }
                                    Rectangle {
                                        fill: Color.RED
                                        stroke: Color.WHITE
                                        strokeWidth: 5
                                        width: 40
                                        height: 40
                                        translateY: -15
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    var two = Scene {
                fill: Color.BLACK
                content: [
                    HBox {
                        padding: Insets {
                            top: 220
                            left: 142
                        }

                        content: [
                            Group {
                                content: [
                                    Rectangle {
                                        fill: Color.WHITE
                                        width: 300
                                        height: 10
                                    }
                                    Rectangle {
                                        fill: Color.YELLOW
                                        stroke: Color.WHITE
                                        strokeWidth: 5
                                        width: 40
                                        height: 40
                                        translateY: -15
                                        translateX: 130
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    var one = Scene {
                fill: Color.BLACK
                content: [
                    HBox {
                        padding: Insets {
                            top: 220
                            left: 142
                        }

                        content: [
                            Group {
                                content: [
                                    Rectangle {
                                        fill: Color.WHITE
                                        width: 300
                                        height: 10
                                    }
                                    Rectangle {
                                        fill: Color.LIME
                                        stroke: Color.WHITE
                                        strokeWidth: 5
                                        width: 40
                                        height: 40
                                        translateY: -15
                                        translateX: 260
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
    scene: bind if (showMainMenu) then mainMenu else if (showHighScore) then highscore else if (showGameOver) then gameOver else if (showThree) then three else if (showTwo) then two else if (showOne) then one else if (showCredits) then creditsMenu else if (showQuestion) then question else game
}

Timeline {
    repeatCount: Timeline.INDEFINITE
    keyFrames: [KeyFrame {
            time: 20ms
            action: function() {
                if (showGameOver and not initialized) {
                    model.preInitialize();
                    initialized = true;
                } else if (showMainMenu) {
                    blinkyBill();
                }

                if (preGame) {
                    pre();
                } else if (model.getRunning()) {
                    go();
                }
            }
        }]
}.play();
var millis = 15;
var timer = millis;
var match = false;
var counter = 0;
var blinkCount = 15;

function blinkyBill() {
    if (blinkCount > 0) {
        --blinkCount;
    } else {
        blinkCount = 20;
        blink = not blink;
    }
}

function go() {
    if (model.getBool1()) {
        if (timer > 0) {
            timer--;
        } else {
            model.change();

            timer = millis;
            model.setBool1(false);
            model.setBool2(true);
        }
    }
    if (model.getBool2()) {
        if (timer > 0) {
            timer--;
        } else {
            var foo = false;
            var bar = false;
            if (model.getFirstBox().getType() == 7 and not (model.getSecondBox().getType() == 7)) {
                model.getFirstBox().setMatched(true);
                if (model.soundOn) {
                    model.setMedia(null);
                    model.setMedia(model.getSounds()[7]);
                    model.getPlayer().play();
                }
                for (i in [0..63]) {
                    if (model.boxArray[i].getType() == model.getSecondBox().getType() mod 8) {
                        model.boxArray[i].setMatched(true);
                        model.boxArray[i].colorize();
                        model.setSpecialFive(model.getSpecialFive() + 1);
                    }
                }
            } else if (model.getSecondBox().getType() == 7 and not (model.getFirstBox().getType() == 7)) {
                model.getSecondBox().setMatched(true);
                if (model.soundOn) {
                    model.setMedia(null);
                    model.setMedia(model.getSounds()[7]);
                    model.getPlayer().play();
                }
                for (i in [0..63]) {
                    if (model.boxArray[i].getType() == model.getFirstBox().getType() mod 8) {
                        model.boxArray[i].setMatched(true);
                        model.boxArray[i].colorize();
                        model.setSpecialFive(model.getSpecialFive() + 1);
                    }
                }
            } else {
                foo = model.threeMatch(model.getFirstBox());
                bar = model.threeMatch(model.getSecondBox());
            }
            if ((foo or bar or model.getSecondBox().getType() == 7 or model.getFirstBox().getType() == 7) and not (model.getSecondBox().getType() == 7 and model.getFirstBox().getType() == 7)) {
                model.setBool4(true);

                if (model.soundOn and model.getSpecialFourPosition() == -1 and model.getSecondBox().getType() != 7 and model.getFirstBox().getType() != 7) {
                    model.setMedia(null);
                    model.setMedia(model.getSounds()[1]);
                    model.getPlayer().play();
                }
            } else {
                model.change();
                if (model.soundOn) {
                    model.setMedia(null);
                    model.setMedia(model.getSounds()[3]);
                    model.getPlayer().play();
                }
            }
            timer = millis;
            model.setBool2(false);
            if (model.getSpecialFourPosition() == -1) {
                model.setBool3(true);
            } else {
                model.setFourState(1);
            }
        }
    }
    if (model.getFourState() == 1) {
        if (timer > 0) {
            --timer;
        } else {
            if (model.soundOn) {
                model.setMedia(null);
                model.setMedia(model.getSounds()[6]);
                model.getPlayer().play();
            }
            if (model.getSpecialFourPosition() > 7 and model.getSpecialFourPosition() mod 8 > 0) {
                model.boxArray[model.getSpecialFourPosition() - 9] = BoxNode {};
                model.boxArray[model.getSpecialFourPosition() - 9].colorize();
            }
            timer = 3;
            model.setFourState(2);
        }
    } else if (model.getFourState() == 2) {
        if (timer > 0) {
            --timer;
        } else {
            if (model.getSpecialFourPosition() > 7) {
                model.boxArray[model.getSpecialFourPosition() - 8] = BoxNode {};
                model.boxArray[model.getSpecialFourPosition() - 8].colorize();
            }
            timer = 3;
            model.setFourState(3);
        }
    } else if (model.getFourState() == 3) {
        if (timer > 0) {
            --timer;
        } else {
            if (model.getSpecialFourPosition() > 7 and model.getSpecialFourPosition() mod 8 < 7) {
                model.boxArray[model.getSpecialFourPosition() - 7] = BoxNode {};
                model.boxArray[model.getSpecialFourPosition() - 7].colorize();
            }
            timer = 3;
            model.setFourState(4);
        }
    } else if (model.getFourState() == 4) {
        if (timer > 0) {
            --timer;
        } else {
            if (model.getSpecialFourPosition() mod 8 < 7) {
                model.boxArray[model.getSpecialFourPosition() + 1] = BoxNode {};
                model.boxArray[model.getSpecialFourPosition() + 1].colorize();
            }
            timer = 3;
            model.setFourState(5);
        }
    } else if (model.getFourState() == 5) {
        if (timer > 0) {
            --timer;
        } else {
            if (model.getSpecialFourPosition() < 56 and model.getSpecialFourPosition() mod 8 < 7) {
                model.boxArray[model.getSpecialFourPosition() + 9] = BoxNode {};
                model.boxArray[model.getSpecialFourPosition() + 9].colorize();
            }
            timer = 3;
            model.setFourState(6);
        }
    } else if (model.getFourState() == 6) {
        if (timer > 0) {
            --timer;
        } else {
            if (model.getSpecialFourPosition() < 56) {
                model.boxArray[model.getSpecialFourPosition() + 8] = BoxNode {};
                model.boxArray[model.getSpecialFourPosition() + 8].colorize();
            }
            timer = 3;
            model.setFourState(7);
        }
    } else if (model.getFourState() == 7) {
        if (timer > 0) {
            --timer;
        } else {
            if (model.getSpecialFourPosition() < 56 and model.getSpecialFourPosition() mod 8 > 0) {
                model.boxArray[model.getSpecialFourPosition() + 7] = BoxNode {};
                model.boxArray[model.getSpecialFourPosition() + 7].colorize();
            }
            timer = 3;
            model.setFourState(8);
        }
    } else if (model.getFourState() == 8) {
        if (timer > 0) {
            --timer;
        } else {
            if (model.getSpecialFourPosition() mod 8 > 0) {
                model.boxArray[model.getSpecialFourPosition() - 1] = BoxNode {};
                model.boxArray[model.getSpecialFourPosition() - 1].colorize();
            }
            model.setSpecialFourPosition(-1);
            model.setBool3(true);
            model.setFourState(-1);
            timer = millis;
        }
    }
    if (model.getBool3()) {
        if (timer > 0) {
            timer--;
        } else {
            if (model.getBool4()) {
                model.deleteMatch();
                match = true;
                model.setBool4(false);
            }
            if (model.getFirstBox() != null) {
                model.getFirstBox().setActive(false);
                model.getFirstBox().setMatched(false);
                model.getFirstBox().colorize();
            }
            if (model.getSecondBox() != null) {
                model.getSecondBox().setActive(false);
                model.getFirstBox().setMatched(false);
                model.getSecondBox().colorize();
            }
            model.setFirstBox(null);
            model.setSecondBox(null);

            timer = millis;
            if ((model.getFourMatchedArray()[0] != -1) or (model.getFiveMatchedArray()[0] != -1)) {
                model.setBool7(true);
                model.setBool3(false);
            } else {
                model.setBool3(false);
                model.setBool5(true);
            }

        }
    }
    if (model.getBool7()) {
        if (model.getFourMatchedArray()[0] != -1) {
            model.boxArray[model.getFourMatchedArray()[0]] = BoxNode {};
            model.boxArray[model.getFourMatchedArray()[0]].setModel(model);
            model.boxArray[model.getFourMatchedArray()[0]].setPosition(model.getFourMatchedArray()[0]);
            model.boxArray[model.getFourMatchedArray()[0]].setType(model.getFourMatchedTypeArray()[0] + 8);
            model.boxArray[model.getFourMatchedArray()[0]].colorize();
        }
        if (model.getFourMatchedArray()[1] != -1) {
            model.boxArray[model.getFourMatchedArray()[1]] = BoxNode {};
            model.boxArray[model.getFourMatchedArray()[1]].setModel(model);
            model.boxArray[model.getFourMatchedArray()[1]].setPosition(model.getFourMatchedArray()[1]);
            model.boxArray[model.getFourMatchedArray()[1]].setType(model.getFourMatchedTypeArray()[1] + 8);
            model.boxArray[model.getFourMatchedArray()[1]].colorize();
        }
        if (model.getFiveMatchedArray()[0] != -1) {
            model.boxArray[model.getFiveMatchedArray()[0]] = BoxNode {};
            model.boxArray[model.getFiveMatchedArray()[0]].setModel(model);
            model.boxArray[model.getFiveMatchedArray()[0]].setPosition(model.getFiveMatchedArray()[0]);
            model.boxArray[model.getFiveMatchedArray()[0]].setType(7);
            model.boxArray[model.getFiveMatchedArray()[0]].colorize();
        }
        if (model.getFiveMatchedArray()[1] != -1) {
            model.boxArray[model.getFiveMatchedArray()[1]] = BoxNode {};
            model.boxArray[model.getFiveMatchedArray()[1]].setModel(model);
            model.boxArray[model.getFiveMatchedArray()[1]].setPosition(model.getFiveMatchedArray()[1]);
            model.boxArray[model.getFiveMatchedArray()[1]].setType(7);
            model.boxArray[model.getFiveMatchedArray()[1]].colorize();
        }

        model.setFourMatchedArray([-1, -1]);
        model.setFiveMatchedArray([-1, -1]);
        model.setBool7(false);
        model.setBool5(true);
    }
    if (model.getBool5()) {
        if (timer > 0) {
            timer--;
        } else {
            if (not model.fillMatch()) {
                model.setBool5(false);
                model.setBool6(true);
                timer = millis;

                if (match) {
                    if (model.soundOn) {
                        model.setMedia(null);
                        model.setMedia(model.getSounds()[0]);
                        model.getPlayer().play();
                    }
                }
                match = false;

            } else {
                timer = 3;
            }
        }
    }
    if (model.getBool6()) {
        if (timer > 0) {
            timer--;
        } else {
            var rematched = false;
            var totalMatched = false;
            for (i in [0..63]) {
                rematched = model.threeMatch(model.getBoxArray()[i]);
                if (rematched) {
                    totalMatched = true;
                    model.getBoxArray()[i].setMatched(true);
                    model.getBoxArray()[i].colorize();
                }
            }
            if (totalMatched) {
                if (model.getSpecialFourPosition() == -1) {
                    model.setBool3(true);
                } else {
                    model.setFourState(1);
                }
                model.setBool4(true);

                if (model.soundOn) {
                    model.setMedia(null);
                    model.setMedia(model.getSounds()[1]);
                    model.getPlayer().play();
                }
            } else {
                model.setClickable(true);
                model.calcPT();
            }
            model.setBool6(false);
            timer = millis;
        }
    }
    updateTime();
}

function updateTime() {
    if (++counter == 50) {
        counter = 0;
        model.addTime();
        if (model.decreaseDownTime()) {
            model.setEnd(true);
        }
        if (model.getEnd()
                and not model.getBool1()
                and not model.getBool2()
                and not model.getBool3()
                and not model.getBool4()
                and not model.getBool5()
                and not model.getBool6()) {
            finish();
        }
    }
}

function pre() {
    if (model.getBool1()) {
        showThree = true;
        showGame = false;
        showMainMenu = false;
        showHighScore = false;
        showGameOver = false;

        model.setBool1(false);
        model.setBool5(true);
    }
    if (model.getBool5()) {
        if (timer > 0) {
            timer--;
        } else {
            if (model.soundOn) {
                model.setMedia(null);
                model.setMedia(model.getSounds()[4]);
                model.getPlayer().play();
            }

            timer = 50;
            model.setBool5(false);
            model.setBool2(true);
        }
    }
    if (model.getBool2()) {
        if (timer > 0) {
            timer--;
        } else {
            showThree = false;
            showTwo = true;
            if (model.soundOn) {
                model.setMedia(null);
                model.setMedia(model.getSounds()[4]);
                model.getPlayer().play();
            }

            timer = 50;
            model.setBool2(false);
            model.setBool3(true);
        }
    }
    if (model.getBool3()) {
        if (timer > 0) {
            timer--;
        } else {
            showTwo = false;
            showOne = true;
            if (model.soundOn) {
                model.setMedia(null);
                model.setMedia(model.getSounds()[4]);
                model.getPlayer().play();
            }

            timer = 50;
            model.setBool3(false);
            model.setBool4(true);
        }
    }
    if (model.getBool4()) {
        if (timer > 0) {
            timer--;
        } else {
            showOne = false;
            showGame = true;
            start();
            timer = millis;
            model.setBool4(false);
            preGame = false;
        }
    }
}

function start() {
    if (not initialized) {
        model.preInitialize();
        initialized = true;
    }
    model.timeString = "00:00";
    model.points = 0;
    model.setSecondsRunning(0);
    model.setRunning(true);
}

function finish() {
    model.setRunning(false);
    showHighScore = false;
    showMainMenu = false;
    showGame = false;
    showGameOver = true;
    initialized = false;
    if (model.soundOn) {
        model.setMedia(null);
        model.setMedia(model.getSounds()[5]);
        model.getPlayer().play();
    }
}

function createTextArray() {
    for (i in [0..79]) {
        textArray[i] = Text {
                    fill: Color.WHITE
                    stroke: Color.WHITE
                    strokeWidth: 0
                    font: Font { name: "Arial" size: 14 }
                };
    }
    for (i in [1..10]) {
        var string: String = i.toString();
        string += ".";
        textArray[i + 59].content = string;
        textArray[i + 69].content = string;
    }
}

function updateTextArray() {
    for (i in [0..9]) {
        textArray[i].content = model.getHighscore().getPointScore()[9 - i].getName();
        textArray[i + 10].content = model.getHighscore().getPointScore()[9 - i].getPoints().toString();
        textArray[i + 20].content = model.timeToString(model.getHighscore().getPointScore()[9 - i].getTime());
        textArray[i + 30].content = model.getHighscore().getTimeScore()[9 - i].getName();
        textArray[i + 40].content = model.getHighscore().getTimeScore()[9 - i].getPoints().toString();
        textArray[i + 50].content = model.timeToString(model.getHighscore().getTimeScore()[9 - i].getTime());
    }
}

