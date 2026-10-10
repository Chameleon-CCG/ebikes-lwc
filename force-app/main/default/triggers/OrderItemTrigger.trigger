trigger OrderItemTrigger on Order_Item__c (after insert, after update) {
    Order_Item__c item = Trigger.new[0];
    Order__c parent = [SELECT Id, Status__c FROM Order__c WHERE Id = :item.Order__c];
    parent.Status__c = 'Updated';
    update parent;
}
