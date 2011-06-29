import javafx.scene.CustomNode;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

public class ImageNode extends CustomNode {

    public var type: Integer;
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

    public function colorize() {
        if (type == 1) {
            imageURL = "{__DIR__}png/blockinvaders_logo.png";
        } else if (type == 2) {
            imageURL = "{__DIR__}png/blockinvaders_highscore.png";
        } else {
            imageURL = "{__DIR__}png/blockinvaders_gameover.png";
        }
    }

}
