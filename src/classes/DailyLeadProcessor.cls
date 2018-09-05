global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
        List<Lead> leadsToUpdate = new List<Lead>();
        for(Lead lead : [SELECT Id, Name, LeadSource 
                                FROM Lead 
                                WHERE LeadSource=null
                                LIMIT 200]) {
            lead.LeadSource = 'Dreamforce';
            leadsToUpdate.add(lead);                       
        }
        
        if(leadsToUpdate.size()!=0)
        {
            update leadsToUpdate;
        }
    }
    
}