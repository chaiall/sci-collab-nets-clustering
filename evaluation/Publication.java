/*
 * Created on 07.06.2005
 */

import java.util.*;

/**
 * @author ley
 *
 * created first in project xml5_coauthor_graph
 */
public class Publication {
    private static Set ps= new HashSet(650000);
    private static int maxNumberOfAuthors = 0;
    private String key;
    private Person[] authors;   // or editors
    private String conference; //bing edit, the place it published, or journal, book title.

    public Publication(String key, Person[] persons, String conference) {
        this.key = key;
        authors = persons;
        this.conference = conference;
        ps.add(this);
        if (persons.length > maxNumberOfAuthors)
            maxNumberOfAuthors = persons.length;
    }
    
    public static int getNumberOfPublications() {
        return ps.size();
    }
    
    public static int getMaxNumberOfAuthors() {
        return maxNumberOfAuthors;
    }
    
    public Person[] getAuthors() {
        return authors;
    }
    
    static Iterator iterator() {
        return ps.iterator();
    }
}