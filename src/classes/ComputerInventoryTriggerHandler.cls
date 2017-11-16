public class ComputerInventoryTriggerHandler {
    
    public static void putContactPerson(List<Computer_Inventory__c> computerInventoryList){
        List<Id> idList=new List<Id>();
        for(Computer_Inventory__c computerInventory:computerInventoryList ){
            idList.add(computerInventory.Customer__c);
        }
        
        List<Account> accList = [SELECT Id,
                                 Inventory_Manager__c
                                 FROM Account
                                 WHERE Id IN:idList];
        
        for(Computer_Inventory__c computerInventory:computerInventoryList ){
            for(Account acc:accList){
                if(computerInventory.Customer__c==acc.Id){
                    computerInventory.Contact_Person__c = acc.Inventory_Manager__c;
                }
            }	
        }
    }
    
    public static void accNumberAndTotalAmount(List<Computer_Inventory__c> computerInventoryList){
        List<Id> accIds = new List<Id>();
        List<Account> updateAccList =new List<Account>();
        for(Computer_Inventory__c computerInventory:computerInventoryList ){
            accIds.add(computerInventory.Customer__c);
        }
        List<Account> accList = [SELECT Id, 	
                                 Number_Computer_Inventory_items__c,
                                 Total_amount_of_Computer_Inventory_items__c,
                                 (Select Id, Value__c From Customers__r)
                                 FROM Account
                                 WHERE Id IN:accIds];
        for (Account acc: accList){
            
            acc.Number_Computer_Inventory_items__c=acc.Customers__r.size();
            acc.Total_amount_of_Computer_Inventory_items__c=0;
            for(Computer_Inventory__c compInventory:acc.Customers__r ){
                if(compInventory.Value__c!=null){
                    acc.Total_amount_of_Computer_Inventory_items__c+=compInventory.Value__c;
                }
            }
            updateAccList.add(acc);
        }
        update updateAccList;
    }
    public static void accNumberAndTotalAmountAfterDelete(List<Computer_Inventory__c> computerInventoryList){
        accNumberAndTotalAmount(computerInventoryList);  
    }
}