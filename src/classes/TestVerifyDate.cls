@isTest
private class TestVerifyDate {
    @isTest static void testCheckDates() {
        Date dt = Date.today();
        Date dt1= Date.today().addDays(10);
        VerifyDate.CheckDates(dt, dt1);
        //System.assertEquals('Normal', pri);
        dt1= Date.today().addDays(-10);
        VerifyDate.CheckDates(dt, dt1);  
    }
}