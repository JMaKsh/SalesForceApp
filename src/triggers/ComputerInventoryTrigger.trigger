trigger ComputerInventoryTrigger on Computer_Inventory__c (before insert, before update, after insert, after update, after delete) {

    if(Trigger.isBefore){
       ComputerInventoryTriggerHandler.putContactPerson(Trigger.new); 
    }
    if(Trigger.isAfter && !Trigger.isDelete){
        ComputerInventoryTriggerHandler.accNumberAndTotalAmount(Trigger.new);  
    }
    if(Trigger.isDelete){
        ComputerInventoryTriggerHandler.accNumberAndTotalAmountAfterDelete(Trigger.old);  
    }
}