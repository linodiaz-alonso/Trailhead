trigger ClosedOpportunityTrigger on Opportunity (after update, after insert) {
    
    
    List<Task> taskToInsertList = new List<Task>();
    for (Opportunity opp : Trigger.new){
        if(opp.StageName == 'Closed Won'){
            Task newTask = new Task();
            newTask.Subject = 'Follow Up Test Task';
            newTask.WhatId  = opp.Id;
            taskToInsertList.add(newTask);
        }
    }
    
    if(taskToInsertList.size()!=0){
        insert taskToInsertList;
    }
}