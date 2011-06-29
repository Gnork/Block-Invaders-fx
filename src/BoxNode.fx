import javafx.scene.CustomNode;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.scene.input.MouseEvent;

public class BoxNode extends CustomNode {

    var model: Model;
    var position: Integer;
    var type: Integer = -1;
    var active = false;
    var matched = false;
    var counted = false;
    var toMove = false;
    var moved = false;
    var hMatched = false;
    var vMatched = false;
    var mouseEntered = false;
    var image: Image;
    var imageURL: String on replace {
                image = Image {
                            url: imageURL
                        }
            }

    override function create() {
        ImageView {
            image: bind image
            scaleX: 1
            scaleY: 1
        }
    }

    function onClick() {
        if (type != -1 and model.getClickable()) {
            if (active) {
                model.getFirstBox().setActive(false);
                model.getFirstBox().colorize();
                model.setFirstBox(null);
                model.getSecondBox().setActive(false);
                model.getSecondBox().colorize();
                model.setSecondBox(null);
            } else {
                if (model.getFirstBox() == null) {
                    model.setFirstBox(this);
                    setActive(true);
                    colorize();
                } else if (model.getSecondBox() == null and model.isNeighbor(model.getFirstBox(), this) and model.getFirstBox().getType() != type) {
                    model.setSecondBox(this);
                    setActive(true);
                    colorize();

                    model.setClickable(false);
                    model.setBool1(true);
                } else {
                    model.getFirstBox().setActive(false);
                    model.getFirstBox().colorize();
                    model.setFirstBox(this);
                    setActive(true);
                    colorize();
                }
            }
        }
    }

    init {
        onMousePressed = function(e: MouseEvent): Void {
                    onClick();
                }
        onMouseEntered = function(e: MouseEvent): Void {
                    if (model.getClickable()) {
                        mouseEntered = true;
                        colorize();
                    }
                }
        onMouseExited = function(e: MouseEvent): Void {
                    mouseEntered = false;
                    colorize();
                }
    }

    public function colorize() {
        if (type == -1) {
            setImageURL("{__DIR__}png/clear.png");
        } else if (type == 0 and matched) {
            setImageURL("{__DIR__}png/button0_extra.png");
        } else if (type == 0 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button0_normal.png");
        } else if (type == 0 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button0_hover.png");
        } else if (type == 0 and active) {
            setImageURL("{__DIR__}png/button0_active.png");
        } else if (type == 1 and matched) {
            setImageURL("{__DIR__}png/button1_extra.png");
        } else if (type == 1 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button1_normal.png");
        } else if (type == 1 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button1_hover.png");
        } else if (type == 1 and active) {
            setImageURL("{__DIR__}png/button1_active.png");
        } else if (type == 2 and matched) {
            setImageURL("{__DIR__}png/button2_extra.png");
        } else if (type == 2 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button2_normal.png");
        } else if (type == 2 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button2_hover.png");
        } else if (type == 2 and active) {
            setImageURL("{__DIR__}png/button2_active.png");
        } else if (type == 3 and matched) {
            setImageURL("{__DIR__}png/button3_extra.png");
        } else if (type == 3 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button3_normal.png");
        } else if (type == 3 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button3_hover.png");
        } else if (type == 3 and active) {
            setImageURL("{__DIR__}png/button3_active.png");
        } else if (type == 4 and matched) {
            setImageURL("{__DIR__}png/button4_extra.png");
        } else if (type == 4 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button4_normal.png");
        } else if (type == 4 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button4_hover.png");
        } else if (type == 4 and active) {
            setImageURL("{__DIR__}png/button4_active.png");
        } else if (type == 5 and matched) {
            setImageURL("{__DIR__}png/button5_extra.png");
        } else if (type == 5 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button5_normal.png");
        } else if (type == 5 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button5_hover.png");
        } else if (type == 5 and active) {
            setImageURL("{__DIR__}png/button5_active.png");
        } else if (type == 6 and matched) {
            setImageURL("{__DIR__}png/button6_extra.png");
        } else if (type == 6 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button6_normal.png");
        } else if (type == 6 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button6_hover.png");
        } else if (type == 6 and active) {
            setImageURL("{__DIR__}png/button6_active.png");
        } else if (type == 8 and matched) {
            setImageURL("{__DIR__}png/button8_extra.png");
        } else if (type == 8 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button8_normal.png");
        } else if (type == 8 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button8_hover.png");
        } else if (type == 8 and active) {
            setImageURL("{__DIR__}png/button8_active.png");
        } else if (type == 9 and matched) {
            setImageURL("{__DIR__}png/button9_extra.png");
        } else if (type == 9 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button9_normal.png");
        } else if (type == 9 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button9_hover.png");
        } else if (type == 9 and active) {
            setImageURL("{__DIR__}png/button9_active.png");
        } else if (type == 10 and matched) {
            setImageURL("{__DIR__}png/button10_extra.png");
        } else if (type == 10 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button10_normal.png");
        } else if (type == 10 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button10_hover.png");
        } else if (type == 10 and active) {
            setImageURL("{__DIR__}png/button10_active.png");
        } else if (type == 11 and matched) {
            setImageURL("{__DIR__}png/button11_extra.png");
        } else if (type == 11 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button11_normal.png");
        } else if (type == 11 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button11_hover.png");
        } else if (type == 11 and active) {
            setImageURL("{__DIR__}png/button11_active.png");
        } else if (type == 12 and matched) {
            setImageURL("{__DIR__}png/button12_extra.png");
        } else if (type == 12 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button12_normal.png");
        } else if (type == 12 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button12_hover.png");
        } else if (type == 12 and active) {
            setImageURL("{__DIR__}png/button12_active.png");
        } else if (type == 13 and matched) {
            setImageURL("{__DIR__}png/button13_extra.png");
        } else if (type == 13 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button13_normal.png");
        } else if (type == 13 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button13_hover.png");
        } else if (type == 13 and active) {
            setImageURL("{__DIR__}png/button13_active.png");
        } else if (type == 14 and matched) {
            setImageURL("{__DIR__}png/button14_extra.png");
        } else if (type == 14 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button14_normal.png");
        } else if (type == 14 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button14_hover.png");
        } else if (type == 14 and active) {
            setImageURL("{__DIR__}png/button14_active.png");
        } else if (type == 7 and matched) {
            setImageURL("{__DIR__}png/button7_extra.png");
        } else if (type == 7 and not active and not mouseEntered) {
            setImageURL("{__DIR__}png/button7_normal.png");
        } else if (type == 7 and not active and mouseEntered) {
            setImageURL("{__DIR__}png/button7_normal.png");
        } else if (type == 7 and active) {
            setImageURL("{__DIR__}png/button7_active.png");
        }
    }

    public function getModel(): Model {
        return model;
    }

    public function setModel(model: Model) {
        this.model = model;
    }

    public function setImageURL(imageURL: String) {
        this.imageURL = imageURL;
    }

    public function getPosition(): Integer {
        return position;
    }

    public function setPosition(position: Integer) {
        this.position = position;
    }

    public function getType(): Integer {
        return type;
    }

    public function setType(type: Integer) {
        this.type = type;
    }

    public function getActive(): Boolean {
        return active;
    }

    public function setActive(active: Boolean) {
        this.active = active;
    }

    public function getMatched(): Boolean {
        return matched;
    }

    public function setMatched(matched: Boolean) {
        this.matched = matched;
    }

    public function getToMove(): Boolean {
        return toMove;
    }

    public function setToMove(toMove: Boolean) {
        this.toMove = toMove;
    }

    public function getMoved(): Boolean {
        return moved;
    }

    public function setMoved(moved: Boolean) {
        this.moved = moved;
    }

    public function getCounted(): Boolean {
        return counted;
    }

    public function setCounted(counted: Boolean) {
        this.counted = counted;
    }

    public function getVMatched(): Boolean {
        return vMatched;
    }

    public function setVMatched(vMatched: Boolean) {
        this.vMatched = vMatched;
    }

    public function getHMatched(): Boolean {
        return hMatched;
    }

    public function setHMatched(hMatched: Boolean) {
        this.hMatched = hMatched;
    }

}

