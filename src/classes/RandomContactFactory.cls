public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numConts, String lastName) {
        List<Contact> contactList = new List<Contact>();
        
        for(Integer i=0;i<numConts;i++) {
            Contact a = new Contact(FirstName='TestContact' + i, LastName = lastName);
            contactList.add(a);
        }
        
        return contactList;
    }
}