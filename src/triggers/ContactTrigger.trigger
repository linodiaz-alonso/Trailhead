trigger ContactTrigger on Contact (before update) {
    
    Map<Id, List<Task>> tasksPerContactsMap = new Map<Id, List<Task>>();
    
    for(Task tsk : [SELECT Id, Subject, ActivityDate
                    FROM Task
                    WHERE WhatId IN: Trigger.newMap.keySet() ]) {
        if(tasksPerContactsMap.containsKey(tsk.WhatId)) {
            tasksPerContactsMap.get(tsk.WhatId).add(tsk);
        } else {
            List<Task> tempList = new List<Task>();
            tempList.add(tsk);
            tasksPerContactsMap.put(tsk.WhatId,tempList);
        }
    }
}