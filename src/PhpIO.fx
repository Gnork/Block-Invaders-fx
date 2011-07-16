import java.io.IOException;
import java.net.URL;
import java.lang.*;

public function getScore(): String {
    var url: URL = new URL("");
    var con: PhpPostConnect = new PhpPostConnect(url);

    var string:String;
    try {
            string = con.read();
    } catch (ex: IOException) {
        ex.printStackTrace();
    }
    return string;
}

public function putScore(string: String): Void {
    var url: URL = new URL("");
    var con: PhpPostConnect = new PhpPostConnect(url);

    try {
        con.send(string);
    } catch (ex: IOException) {
        ex.printStackTrace();
    }

    System.out.println(con.read());
}

