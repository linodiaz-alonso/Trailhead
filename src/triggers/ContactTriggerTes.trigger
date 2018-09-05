trigger ContactTriggerTes on Contact (after insert, after update, before insert, before update) {
    if (trigger.isBefore && trigger.isInsert) {
        ContactHandler.isLastCheckbox(trigger.new);
    } 
}