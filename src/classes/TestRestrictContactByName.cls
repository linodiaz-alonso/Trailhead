@isTest
private class TestRestrictContactByName {
    @isTest static void testRestrictContact() {
        Contact cont = new Contact(LastName = 'INVALIDNAME'); 

        try{
            //Should fail because the parent account has not been set
            insert cont;
        }
        catch(DmlException e){
            //system.assertEquals('The Last Name \"INVALIDNAME\" is not allowed for DML', e.getDmlType(0));
        }
    }
}