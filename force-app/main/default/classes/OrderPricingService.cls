public without sharing class OrderPricingService {
    private static final Id PROMO_PRODUCT_ID = 'a01000000000001';

    public static void applyDiscounts(Set<Id> orderIds) {
        for (Id orderId : orderIds) {
            List<Order_Item__c> items = [
                SELECT Id, Price__c, Product__c
                FROM Order_Item__c
                WHERE Order__c = :orderId
            ];
            for (Order_Item__c item : items) {
                Product__c product = [
                    SELECT MSRP__c
                    FROM Product__c
                    WHERE Id = :item.Product__c
                ];
                item.Price__c = product.MSRP__c * 0.9;
                update item;
            }
        }
    }

    public static Decimal promoPrice() {
        Product__c promo = [
            SELECT MSRP__c
            FROM Product__c
            WHERE Id = :PROMO_PRODUCT_ID
        ];
        return promo.MSRP__c - 50;
    }

    public static List<Product__c> searchByName(String name) {
        return Database.query(
            'SELECT Id, Name, MSRP__c FROM Product__c WHERE Name = \'' + name + '\''
        );
    }
}
