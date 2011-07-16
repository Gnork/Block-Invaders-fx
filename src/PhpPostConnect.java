
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;

public class PhpPostConnect {

    private URL sitepath;
    private URLConnection con;

    public PhpPostConnect() {
    }

    public PhpPostConnect(URL sitepath) {
        this.sitepath = sitepath;
    }

    public void setSitePath(URL sitepath) {
        this.sitepath = sitepath;
    }

    public URL getSitePath() {
        return this.sitepath;
    }

    public void send(String data) throws IOException {
        if (con == null) {
            con = sitepath.openConnection();
        }
        if (con.getDoOutput() == false) {
            con.setDoOutput(true);
        }
        OutputStream out = con.getOutputStream();
        out.write(data.getBytes());
        out.flush();
    }

    public String read() throws IOException {
        if (con == null) {
            con = sitepath.openConnection();
        }
        InputStream in = con.getInputStream();
        int c = 0;
        StringBuffer incoming = new StringBuffer();
        while (c >= 0) {
            c = in.read();           
            incoming.append((char) c);
        }
        return incoming.toString();
    }
}
