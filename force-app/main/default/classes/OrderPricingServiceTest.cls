@isTest
private class OrderPricingServiceTest {
    @isTest
    static void applyDiscounts_runs() {
        Product_Family__c family = new Product_Family__c(Name = 'F', Category__c = 'Mountain');
        insert family;
        Product__c product = new Product__c(
            Name = 'Bike',
            MSRP__c = 1000,
            Category__c = 'Mountain',
            Level__c = 'Beginner',
            Material__c = 'Carbon',
            Product_Family__c = family.Id
        );
        insert product;
        Order__c order = new Order__c(Status__c = 'Draft');
        insert order;
        insert new Order_Item__c(Order__c = order.Id, Product__c = product.Id, Price__c = 1000, Qty_M__c = 1);

        OrderPricingService.applyDiscounts(new Set<Id>{ order.Id });
        OrderPricingService.searchByName('Bike');
    }
}
