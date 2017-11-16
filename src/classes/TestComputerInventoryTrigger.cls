@isTest
public class TestComputerInventoryTrigger {
    public static Contact contact1;
    public static Contact contact2;
    public static Account account;
    public static Computer_Inventory__c compInventory1;
    public static Computer_Inventory__c compInventory2;
    
    static void init(){
        contact1 = new Contact(LastName = 'contact1');
        insert contact1;
        contact2 = new Contact(LastName = 'contact2');
        insert contact2; 
        account = new Account(Name = 'Test Account', Inventory_Manager__c = contact1.id, Number_Computer_Inventory_items__c=10);
        insert account;
        compInventory1 = new Computer_Inventory__c(Name = 'Test computer Inventory1',Contact_Person__c=contact2.id, Customer__c=account.id, Value__c=1000);
        compInventory2 = new Computer_Inventory__c(Name = 'Test computer Inventory2',Contact_Person__c=contact2.id, Customer__c=account.id, Value__c=2000);
    }
    
    @isTest static void putContactPerson(){
        init();   
        Test.startTest();
        insert compInventory1;
        insert compInventory2;
        List<Computer_Inventory__c> testCompInventory1 = [SELECT 
                                                          Contact_Person__c 
                                                          FROM Computer_Inventory__c 
                                                          WHERE Id =: compInventory1.id];
        List<Computer_Inventory__c> testCompInventory2 = [SELECT 
                                                          Contact_Person__c 
                                                          FROM Computer_Inventory__c 
                                                          WHERE Id =: compInventory2.id];
        List<Account> testAccount = [SELECT Inventory_Manager__c 
                                     FROM Account 
                                     WHERE Id =: account.id];
        
        System.assertEquals(testCompInventory1.get(0).Contact_Person__c, testAccount.get(0).Inventory_Manager__c);
        System.assertEquals(testCompInventory2.get(0).Contact_Person__c, testAccount.get(0).Inventory_Manager__c);
        Test.stopTest();
    }
    
    @isTest static void checkAccNumberAndTotalAmount(){
        init();
        Test.startTest();
        insert compInventory1;
        insert compInventory2; 
        
        //after Computer_Inventory insert
        List<Account> testAccount = [SELECT Number_Computer_Inventory_items__c, 
                                     Total_amount_of_Computer_Inventory_items__c 
                                     FROM Account 
                                     WHERE Id =: account.id];
        
        System.assertEquals(testAccount.get(0).Number_Computer_Inventory_items__c,2); 
        System.assertEquals(testAccount.get(0).Total_amount_of_Computer_Inventory_items__c,3000);
        
        //after Computer_Inventory update
        List<Computer_Inventory__c> testCompInventory1 = [SELECT Value__c 
                                                          FROM Computer_Inventory__c 
                                                          WHERE Id =: compInventory1.id];
        testCompInventory1.get(0).Value__c=2000;
        update testCompInventory1;
        List<Account> testAccount1 = [SELECT Number_Computer_Inventory_items__c, 
                                      		 Total_amount_of_Computer_Inventory_items__c 
                                      FROM Account 
                                      WHERE Id =: account.id];
        System.assertEquals(testAccount1.get(0).Number_Computer_Inventory_items__c,2); 
        System.assertEquals(testAccount1.get(0).Total_amount_of_Computer_Inventory_items__c,4000);
        
         //after Computer_Inventory delete
        List<Computer_Inventory__c> testCompInventory2 = [SELECT 
                                                          Value__c 
                                                          FROM Computer_Inventory__c 
                                                          WHERE Id =: compInventory1.id];
        delete testCompInventory2;
        List<Account> testAccount2 = [SELECT Number_Computer_Inventory_items__c,
                                             Total_amount_of_Computer_Inventory_items__c
                                      FROM Account
                                      WHERE Id =: account.id];
        System.assertEquals(testAccount2.get(0).Number_Computer_Inventory_items__c,1); 
        System.assertEquals(testAccount2.get(0).Total_amount_of_Computer_Inventory_items__c,2000);
        
        Test.stopTest();
    }   
}