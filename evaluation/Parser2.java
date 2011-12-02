import java.io.*;
import java.util.*;
import javax.xml.parsers.*;
import org.xml.sax.*;
import org.xml.sax.helpers.*;

public class Parser {
   
   private final int maxAuthorsPerPaper = 200;
   public static int conf_name_to_file = 1;
   public static int conf_author_to_file = 1;
   public static String basepath="E:\\data\\";

   private class ConfigHandler extends DefaultHandler {

        private Locator locator;

        private String Value;
        private String key;
        private String recordTag;
        private String s_conference; //edit bing
        private Person[] persons= new Person[maxAuthorsPerPaper];
        //private conference[] conferences= new conference[10];
        
        private int numberOfPersons = 0;
        //private int numberOfConferences = 0;

        private boolean insidePerson;

        public void setDocumentLocator(Locator locator) {
            this.locator = locator;
        }

        public void startElement(String namespaceURI, String localName,
                String rawName, Attributes atts) throws SAXException {
            String k;
            
            if (insidePerson = (rawName.equals("author") || rawName
                    .equals("editor"))) {
                Value = "";
                return;
            }
            if (insidePerson = (rawName.equals("booktitle") || rawName
                    .equals("journal"))) {
                Value = "";
                return;
            }
            if ((atts.getLength()>0) && ((k = atts.getValue("key"))!=null)) {
                key = k;
                recordTag = rawName;   
            }
            
        }

        public void endElement(String namespaceURI, String localName,
                String rawName) throws SAXException {
            if (rawName.equals("author") || rawName.equals("editor")) {
                //System.out.println("End of author");
            	
                Person p;
                if ((p = Person.searchPerson(Value)) == null) {
                    p = new Person(Value);
                }
                p.increment();
                if (numberOfPersons<maxAuthorsPerPaper)
                    persons[numberOfPersons++] = p;
                return;
            }
            if(rawName.equals("booktitle") || rawName.equals("journal")) {
            	conference c;
            	if((c=conference.searchConference(Value.replaceAll("[0-9]*",""))) == null) {
            		c = new conference(Value.replaceAll("[0-9]*",""));
            	}
            	c.increment();
            	System.out.println("conference");
            	System.out.println(c.getNumberId());
            	
                if(conf_author_to_file==1){
              	  java.io.FileWriter fw;
              	  try {
              		  fw = new  java.io.FileWriter(basepath+"conference_author.txt",true);
              		  java.io.PrintWriter   pw=new   java.io.PrintWriter(fw);  
              		  pw.println("conference");
              		  pw.println(c.getNumberId());
              		  pw.close(); 
              		  fw.close();
              	  } catch (IOException e) {
              		  // TODO Auto-generated catch block
              		  e.printStackTrace();
              	  } 
                }
            	//conference[numberOfConferences++] = c;
            	return;
            }
            if (rawName.equals(recordTag)) {
            	
                //System.out.println("End of paper");
                if (numberOfPersons == 0)
                    return;
                
                Person pa[] = new Person[numberOfPersons];
                //System.out.println();
                System.out.println("author");
                for (int i=0; i<numberOfPersons; i++) {
                    pa[i] = persons[i];
                    System.out.print(persons[i].getNumberId() + " " );
                   if(conf_author_to_file!=1)
                	   persons[i] = null;
                }
                System.out.println();
                System.out.println("-----");//cutting line
                
                if(conf_author_to_file==1){
                	  java.io.FileWriter fw;
                	  try {
                		  fw = new  java.io.FileWriter(basepath+"conference_author.txt",true);
                		  java.io.PrintWriter   pw=new   java.io.PrintWriter(fw);  
                		  pw.println("author");
                          for (int i=0; i<numberOfPersons; i++) {
                              pa[i] = persons[i];
                              pw.print(persons[i].getNumberId() + " " );
                          	  persons[i] = null;
                          }
                		  pw.println();
                		  pw.println("-----");
                		  pw.close(); 
                		  fw.close();
                	  } catch (IOException e) {
                		  // TODO Auto-generated catch block
                		  e.printStackTrace();
                	  } 
                  }
                
                Publication p = new Publication(key,pa,s_conference);
                numberOfPersons = 0;
            }
        }

        public void characters(char[] ch, int start, int length)
                throws SAXException {
            if (insidePerson)
                Value += new String(ch, start, length);
        }

        private void Message(String mode, SAXParseException exception) {
            System.out.println(mode + " Line: " + exception.getLineNumber()
                    + " URI: " + exception.getSystemId() + "\n" + " Message: "
                    + exception.getMessage());
        }

        public void warning(SAXParseException exception) throws SAXException {

            Message("**Parsing Warning**\n", exception);
            throw new SAXException("Warning encountered");
        }

        public void error(SAXParseException exception) throws SAXException {

            Message("**Parsing Error**\n", exception);
            throw new SAXException("Error encountered");
        }

        public void fatalError(SAXParseException exception) throws SAXException {

            Message("**Parsing Fatal Error**\n", exception);
            throw new SAXException("Fatal Error encountered");
        }
    }

   private void nameLengthStatistics() {
       Iterator i = Person.iterator();
       Person p;
       int l = Person.getMaxNameLength();
       int lengthTable[] = new int[l+1];
       int j;
       
       System.out.println();
       //System.out.println("Name length: Number of persons");
       while (i.hasNext()) {
           p = (Person) i.next();
           lengthTable[p.getName().length()]++;
       }
       for (j=1; j <= l; j++) {
           System.out.print(j + ": " + lengthTable[j]+ "  ");
           if (j%5 == 0)
               System.out.println();
       }
       System.out.println();
   }
   
   private void publicationCountStatistics() {
       Iterator i = Person.iterator();
       Person p;
       int l = Person.getMaxPublCount();
       int countTable[] = new int[l+1];
       int j, n;
       
       System.out.println();
       System.out.println("Number of publications: Number of persons");
       while (i.hasNext()) {
           p = (Person) i.next();
           countTable[p.getCount()]++;
       }
       n = 0;
       for (j=1; j <= l; j++) {
           if (countTable[j] == 0)
               continue;
           n++;
           System.out.print(j + ": " + countTable[j]+ "  ");
           if (n%5 == 0)
               System.out.println();
       }
       System.out.println();
   }
   
   Parser(String uri) {
      try {
             SAXParserFactory parserFactory = SAXParserFactory.newInstance();
             SAXParser parser = parserFactory.newSAXParser();
             ConfigHandler handler = new ConfigHandler();
         parser.getXMLReader().setFeature(
                  "http://xml.org/sax/features/validation", true);
         parser.parse(new File(uri), handler);
      } catch (IOException e) {
         System.out.println("Error reading URI: " + e.getMessage());
      } catch (SAXException e) {
         System.out.println("Error in parsing: " + e.getMessage());
      } catch (ParserConfigurationException e) {
         System.out.println("Error in XML parser configuration: " +
                            e.getMessage());
      }
   }

   public static void main(String[] args) {
	      if(conf_author_to_file==1){
	    	  java.io.FileWriter fw;
	    	  try {
	    		  fw = new  java.io.FileWriter(basepath+"conference_author.txt",false);
	    		  java.io.PrintWriter   pw=new   java.io.PrintWriter(fw);  
	    		  pw.close(); 
	    		  fw.close();
	    	  } catch (IOException e) {
	    		  // TODO Auto-generated catch block
	    		  e.printStackTrace();
	    	  } 
	      }
	   
	   
      if (args.length < 1) {
         System.out.println("Usage: java Parser [input]");
         System.exit(0);
      }
      Parser p = new Parser(args[0]);
      System.out.println("finished!");
      if(conf_name_to_file==1) {
      try{
    	   BufferedWriter conf_name_writer = new BufferedWriter(new FileWriter(new File(basepath+"conference-name.txt")));
    	   
    	   Iterator j = conference.iterator();
    	      conference Conference;
    	      while (j.hasNext()) {
    	          Conference = (conference) j.next();
    	          conf_name_writer.write(Conference.getName());
    	          conf_name_writer.write("\r\n");
    	      }
    	      conf_name_writer.close();
      }catch(Exception e){
    	  
      }
      }             
      
      Iterator j = conference.iterator();
      conference Conference;
      while (j.hasNext()) {
          Conference = (conference) j.next();
          System.out.println(Conference.getName());
      }
      
   }
}


