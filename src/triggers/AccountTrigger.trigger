trigger AccountTrigger on Account (before insert, after insert, after update, before update) {
   if(trigger.IsAfter && trigger.IsUpdate) {
       AccountHandler.handleAfterUpdate(trigger.new);
   }
}