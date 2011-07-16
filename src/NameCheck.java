public class NameCheck {
    public static String checker(String name){
        char[] charArray = name.toCharArray();
        char[] helpArray;
        int x = 0;
        StringBuffer buffer = new StringBuffer();
        String string;
        for(int i = 0; i < charArray.length; ++i){
            if((charArray[i] >= '0' && charArray[i] <= '9')||(charArray[i] >= 'a' && charArray[i] <= 'z')||(charArray[i] >= 'A' && charArray[i] <= 'Z')){
                buffer.append(charArray[i]);
            }
        }
        if(buffer.length() == 0){
            string = "Player";
        }else if(buffer.length() <= 10){
            string = buffer.toString();
        }else{
            string = buffer.substring(0, 9);
        }
        return string;
    }
}
