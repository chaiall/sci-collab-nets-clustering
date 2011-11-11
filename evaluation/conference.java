import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

/**
 * @author ley
 */
public class conference {
    private static Map conferenceMap = new HashMap(6000);
    
    private String name;
    private int count;
    private int numberId;

    public conference(String n) {
        name = n;
        count = 0;
        conference t = (conference)conferenceMap.put(name,this);
        if( t == null )
        {
                numberId = numberOfConferences();
        }
    }
    
    public void increment() {
        count++;
    }
    
    public String getName() {
        return name;
    }
    
    public int getNumberId() {
        return numberId;
    }
    
    public int getCount() {
        return count;
    }
    
    
    static public Iterator iterator() {
        return conferenceMap.values().iterator();
    }
    
    static public conference searchConference(String name) {
        return (conference) conferenceMap.get(name);
    }
    
    static public int numberOfConferences() {
        return conferenceMap.size();
    }
    
}
