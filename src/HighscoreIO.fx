import javafx.io.Storage;
import javafx.util.Properties;

public function loadProperties(dataSourceName: String, props: Properties): Boolean {
    def storage: Storage = Storage {
                source: dataSourceName
            };
    if (storage.resource.length > 0 and storage.resource.readable) {
        def streamIn = storage.resource.openInputStream();
        props.load(streamIn);
        streamIn.close();
        return true;
    }
    return false;
}

public function saveProperties(dataSourceName: String, props: Properties): Void {
    def storage: Storage = Storage {
                source: dataSourceName
            };
    def streamOut = storage.resource.openOutputStream(true);
    props.store(streamOut);
    streamOut.flush();
    streamOut.close();
}
