public with sharing class ComputerInventoryEditPageController {
    
    public List<WrapperListComputerInventory> wrapperListComputerInventory {
        get;
        set;
    }

    public List <Computer_Inventory__c> listComputerInventory {
        get;
        set;
    }
    public Computer_Inventory__c multCompInventory {
        get;
        set;
    }
    public List <Computer_Inventory__c> multCompInventoryList {
        get;
        set;
    }

    public Computer_Inventory_Line_Item__c multCompInventoryItem {
        get;
        set;
    }
    public List <Computer_Inventory_Line_Item__c> multCompInventoryItemList {
        get;
        set;
    }

    public List<WrapperListComputerInventoryItem> wrapperListComputerInventoryItem {
        get;
        set;
    }

    public List <Computer_Inventory_Line_Item__c> listComputerInventoryItem {
        get;
        set;
    }

    public String computerInventoryID {
        get;
        set;
    }
    public String computerInventoryItemId {
        get;
        set;
    }

    public Boolean visible {
        get;
        set;
    }
    public Boolean show {
        get;
        set;
    }

    public Boolean editStatus {
        get;
        set;
    }

    public Boolean editItemStatus {
        get;
        set;
    }

    public Boolean editRowStatus {
        get;
        set;
    }

    public Boolean newItemStatus {
        get;
        set;
    }

    public Boolean editRowItemStatus {
        get;
        set;
    }

    public Boolean multForm {
        get;
        set;
    }

    public Boolean multItemForm {
        get;
        set;
    }

    public Computer_Inventory__c newCompInventory {
        get;
        set;
    }

    public Computer_Inventory_Line_Item__c newCompInventoryItem {
        get;
        set;
    }

    public Computer_Inventory__c compInventoryDetail {
        get;
        set;
    }

    public Computer_Inventory_Line_Item__c compInventoryItemDetail {
        get;
        set;
    }

    public List<Computer_Inventory__c> editCompInventoryList {
        get;
        set;
    }

    public List<Computer_Inventory_Line_Item__c> editCompInventoryItemList {
        get;
        set;
    }

    public ApexPages.StandardSetController setCon {
        get {
            if (setCon == null) {
                listComputerInventory = [
                        SELECT Id,
                                Name,
                                Value__c,
                                Description__c,
                                Customer__c,
                                Contact_Person__c,
                                Inventory_Number__c
                        FROM Computer_Inventory__c
                ]; 
                setCon = new ApexPages.StandardSetController(listComputerInventory);               
           }
            return setCon;
        }
        set;
    }

     public ComputerInventoryEditPageController( ) {
         listComputerInventory = setCon.getRecords();
          wraplistComputerInventory(); 
     }
    
    public PageReference wraplistComputerInventory() {
        wrapperListComputerInventory = new List<WrapperListComputerInventory>();
        listComputerInventory = [
                        SELECT Id,
                                Name,
                                Value__c,
                                Description__c,
                                Customer__c,
                                Contact_Person__c,
                                Inventory_Number__c
                        FROM Computer_Inventory__c
                		];  
              
        for (Computer_Inventory__c computerInventory : listComputerInventory) {
            wrapperListComputerInventory.add(new WrapperListComputerInventory(computerInventory));
        }
        return null;
    }
  
    public void newCompInventory() {
        newCompInventory = new Computer_Inventory__c();
        visible = true;
    }
    public void cancelNewCompInventory() {
        newCompInventory = null;
        visible = false;

    }

    public void newCompInventoryItem() {
        newCompInventoryItem = new Computer_Inventory_Line_Item__c();
        newCompInventoryItem.ComputerInventoryID__c = computerInventoryID;
        newItemStatus = true;
    }

    public PageReference saveNewCompInventory() {
        if (newCompInventory.Value__c < 0) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Value field needs to be > 0'));
            return null;
        } else if (newCompInventory.Inventory_Number__c < 0) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Iventory Number field needs to be > 0'));
            return null;
        }
        try {
            insert newCompInventory;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        visible = false;
        editRowStatus=false;
        multForm=false;
        newCompInventory = null;
        wraplistComputerInventory();
        return null;
    }

    public PageReference saveNewCompInventoryItem() {
        try {
        insert newCompInventoryItem;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        newItemStatus = false;
        newCompInventoryItem = null;
        wrapperListComputerInventoryItem();
        return null;
    }


    public PageReference computerInventoryDetail() {
        wraplistComputerInventory();
        show = true;
        editItemStatus = false;
        multItemForm=false;
        newItemStatus=false;
        multForm=false;
        visible=false;
        wrapperListComputerInventoryItem = new List<WrapperListComputerInventoryItem>();
        for (Computer_Inventory__c compInventory : listComputerInventory) {
            if (compInventory.Id == computerInventoryID) {
                compInventoryDetail = compInventory;
                wrapperListComputerInventoryItem();
            }
        }
        return null;
    }

    public PageReference editForm() {
        editStatus = true;
        return null;
    }

    public PageReference deleteComputerInventory() {
        show = false;
        delete compInventoryDetail;
        wraplistComputerInventory();
        return null;
    }

    public PageReference saveEditCompInventory() {
        if (compInventoryDetail.Value__c < 0) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Value field needs to be > 0'));
            return null;
        } else if (compInventoryDetail.Inventory_Number__c < 0) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING, 'Iventory Number field needs to be > 0'));
            return null;
        }
        try {
            update compInventoryDetail;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        show = false;
        visible = false;
        editRowStatus=false;
        multForm=false;
        return null;
    }

    public PageReference cancelNewCompInventoryItem() {
        newItemStatus = false;
        newCompInventoryItem = null;
        return null;
    }

    public PageReference cancelEditCompInventory() {
        show = false;
        wraplistComputerInventory();
        return null;
    }

    public void wrapperListComputerInventoryItem() {
        wrapperListComputerInventoryItem = new List<WrapperListComputerInventoryItem>();
        listComputerInventoryItem = [
                SELECT Id,
                        Name,
                        Type__c,
                        Model__c,
                        Serial_Number__c
                FROM Computer_Inventory_Line_Item__c
                WHERE ComputerInventoryID__c = :computerInventoryID
        ];
        for (Computer_Inventory_Line_Item__c computerInventoryItem : listComputerInventoryItem) {
            wrapperListComputerInventoryItem.add(new WrapperListComputerInventoryItem(computerInventoryItem));
        }
    }

    public PageReference deleteSelectedCompInventory() {
        List<Computer_Inventory__c> deleteCompInventoryList = new List<Computer_Inventory__c>();
        for (WrapperListComputerInventory wrapCompInventory : wrapperListComputerInventory) {
            if (wrapCompInventory.selected == true) {
                deleteCompInventoryList.add(wrapCompInventory.computerInventory);
            }
        }
        try {
            delete deleteCompInventoryList;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        show = false;
        wraplistComputerInventory();
        return null;
    }

    public PageReference editSelectedCompInventoryItem() {
        editRowItemStatus = true;
        editCompInventoryItemList = new List<Computer_Inventory_Line_Item__c>();
        for (WrapperListComputerInventoryItem wrapCompInventoryItem : wrapperListComputerInventoryItem) {
            if (wrapCompInventoryItem.selected == true) {
                editCompInventoryItemList.add(wrapCompInventoryItem.computerInventoryItem);
            }
        }
        return null;
    }

    public PageReference computerInventoryDetailItem() {
        
        editItemStatus = true;
        for (Computer_Inventory_Line_Item__c compInventoryItem : listComputerInventoryItem) {
            if (compInventoryItem.Id == computerInventoryItemID) {
                compInventoryItemDetail = compInventoryItem;
            }
        }
        return null;
    }

    public PageReference saveEditCompInventoryItem() {
        editItemStatus = false;
        try {
            update compInventoryItemDetail;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        wrapperListComputerInventoryItem();
        return null;
    }

    public PageReference cancelEditCompInventoryItem() {
        editItemStatus = false;
        wrapperListComputerInventoryItem();
        return null;
    }

    public PageReference deleteComputerInventoryItem() {
        editItemStatus = false;
        try {
            delete compInventoryItemDetail;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        wrapperListComputerInventoryItem();
        return null;
    }

    public PageReference deleteSelectedCompInventoryItem() {
        List<Computer_Inventory_Line_Item__c> deleteCompInventoryItemList = new List<Computer_Inventory_Line_Item__c>();
        for (WrapperListComputerInventoryItem wrapCompInventoryItem : wrapperListComputerInventoryItem) {
            if (wrapCompInventoryItem.selected == true) {
                deleteCompInventoryItemList.add(wrapCompInventoryItem.computerInventoryItem);
            }
        }
        try {
            delete deleteCompInventoryItemList;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        editItemStatus = false;
        wrapperListComputerInventoryItem();
        return null;
    }

    public PageReference editSelectedCompInventory() {
        editRowStatus = true;
        editCompInventoryList = new List<Computer_Inventory__c>();
        for (WrapperListComputerInventory wrapCompInventory : wrapperListComputerInventory) {
            if (wrapCompInventory.selected == true) {
                editCompInventoryList.add(wrapCompInventory.computerInventory);
            }

        }
        return null;
    }

    public PageReference saveEditInventoryList() {
        editRowStatus = false;
        visible = false;
        multForm=false;
        for (Computer_Inventory__c editCompInventory : editCompInventoryList) {
            if (editCompInventory.Value__c < 0) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Value field needs to be > 0'));
                return null;
            } else if (editCompInventory.Inventory_Number__c < 0) {
                System.debug('Inventory_Number__c:' + editCompInventory.Inventory_Number__c);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Iventory Number field needs to be > 0'));
                return null;
            }
        }
        try {
            update editCompInventoryList;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        wraplistComputerInventory();
        editCompInventoryList = null;
        return null;
    }

    public PageReference cancelEditInventoryList() {
        editRowStatus = false;
        show = false;
        editCompInventoryList = null;
        wraplistComputerInventory();
        return null;
    }

    public PageReference saveEditInventoryItemList() {
        editRowItemStatus = false;
        try {
            update editCompInventoryItemList;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        editCompInventoryItemList = null;
        return null;
    }

    public PageReference cancelEditInventoryItemList() {
        editRowItemStatus = false;
        editItemStatus = false;
        editCompInventoryItemList = null;
        return null;
    }

    public PageReference newMultCompInventory() {
        multForm = true;
        multCompInventory = new Computer_Inventory__c();
        multCompInventoryList = new List<Computer_Inventory__c>();
        multCompInventoryList.add(multCompInventory);
        return null;
    }

    public void addNewRowCompInventory() {
        Computer_Inventory__c multCompInventory = new Computer_Inventory__c();
        multCompInventoryList.add(multCompInventory);
    }

    public PageReference saveMultCompInventoryList() {
        try {
            insert multCompInventoryList;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        multForm = false;
        multCompInventoryList = null;
        wrapListComputerInventory();
        return null;
    }

    public PageReference cancelMultCompInventoryForm() {
        multForm = false;
        multCompInventoryList = null;
        wrapListComputerInventory();
        return null;
    }

    public PageReference multCompInventoryItemList() {
        multItemForm = true;
        multCompInventoryItem = new Computer_Inventory_Line_Item__c();
        multCompInventoryItem.ComputerInventoryID__c = computerInventoryID;
        multCompInventoryItemList = new List<Computer_Inventory_Line_Item__c>();
        multCompInventoryItemList.add(multCompInventoryItem);
        return null;
    }

    public void addNewRowCompInventoryItem() {
        Computer_Inventory_Line_Item__c multCompInventoryItem = new Computer_Inventory_Line_Item__c();
        multCompInventoryItem.ComputerInventoryID__c = computerInventoryID;
        multCompInventoryItemList.add(multCompInventoryItem);
    }

    public PageReference saveMultCompInventoryItemList() {
        try {
            insert multCompInventoryItemList;
        } catch (System.DmlException e) {
            System.debug(e.getDmlMessage(0));
        }
        multItemForm = false;
        multCompInventoryItemList = null;
        wrapperListComputerInventoryItem();
        return null;
    }

    public PageReference cancelMultCompInventoryItemForm() {
        multItemForm = false;
        multCompInventoryItemList = null;
        wrapperListComputerInventoryItem();
        return null;
    }

    public class WrapperListComputerInventory {
        public Computer_Inventory__c computerInventory { get; set; }
        public Boolean selected { get; set; }
        public WrapperListComputerInventory(Computer_Inventory__c compInventory) {
            computerInventory = compInventory;
            selected = false;
        }
    }

    public class WrapperListComputerInventoryItem {
        public Computer_Inventory_Line_Item__c computerInventoryItem { get; set; }
        public Boolean selected { get; set; }
        public WrapperListComputerInventoryItem(Computer_Inventory_Line_Item__c compInventoryItem) {
            computerInventoryItem = compInventoryItem;
            selected = false;
        }
    }
}