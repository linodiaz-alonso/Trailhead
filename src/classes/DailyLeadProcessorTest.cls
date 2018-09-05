@isTest
private class DailyLeadProcessorTest {

    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @testSetup 
    static void setup() {
        List<Lead> leads = new List<Lead>();

        // add 100 child accounts
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(LastName='Lead '+i,
                Company='company '+i, Status='Open - Not Contacted'));
        }
        insert leads;
    }
    
    static testmethod void testScheduledJob() {

        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());         
        // Verify the scheduled job has not run yet.

        // Stopping the test will run the job synchronously
        Test.stopTest();
        
        // Now that the scheduled job has executed,
        // check that our tasks were created
        Lead lead = [SELECT Id, LastName,LeadSource FROM Lead LIMIT 1];
        
        System.assertEquals(lead.LeadSource,'Dreamforce' );

    }
}