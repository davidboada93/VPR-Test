@isTest
private class OpportunitySeviceVRPTest {
    
    @testSetup
    static void setup() {
        
        List<Product2> prodTest = new List<Product2>();
        Product2 prodAsia2 = TestDataFactory.createProduct('Asia Product 2', 'Cayman Compliance Services');
        prodAsia2.RegionOfBusiness__c = 'Asia';
        prodTest.add(prodAsia2);
        Product2 product = TestDataFactory.createProduct('Test Product', 'Bank');
        prodTest.add(product);
        insert prodTest;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<PriceBookEntry> pbeTest = new List<PriceBookEntry>();
        pbeTest.add(TestDataFactory.createPriceBookEntry(pricebookId, prodAsia2));
        pbeTest.add(TestDataFactory.createPriceBookEntry(pricebookId, product));
        insert pbeTest;
        
        List<Account> accTest = new List<Account>();
        Account acc = TestDataFactory.createAccount('Test Account');
        accTest.add(acc);
        insert accTest;
        
        List<Contact> testContacts = new List<Contact>();
        Contact contactSP = TestDataFactory.createContact('Contact Sales Person', acc);
        testContacts.add(contactSP);
        insert testContacts;
        
        List<Opportunity> testOpps = new List<Opportunity>();
        Opportunity oppStandard = TestDataFactory.createOpportunityFullyPopulated('Test OppStandard', acc);
        oppStandard.WoodType__c = 'Standard';
        testOpps.add(oppStandard);        
        Opportunity oppRecycled = TestDataFactory.createOpportunityFullyPopulated('Test OppRecycled', acc);
        oppRecycled.WoodType__c = 'Recycled';
        testOpps.add(oppRecycled);
        insert testOpps;

        List<Quote> testQuotes = new List<Quote>();
        Quote quoteStandard = TestDataFactory.createQuote('Test Quote Standard', contactSP, oppStandard);
        quoteStandard.status = 'Accepted';
        testQuotes.add(quoteStandard);
        Quote quoteRecycled = TestDataFactory.createQuote('Test Quote Recycled', contactSP, oppRecycled);
        quoteRecycled.status = 'Accepted';
        testQuotes.add(quoteRecycled);
        insert testQuotes;
        
        List<OpportunityLineItem> testOppProducts = new List<OpportunityLineItem>();
        OpportunityLineItem oliStandard = TestDataFactory.createOppLineItem(oppStandard, pbeTest[0]);
        testOppProducts.add(oliStandard);
        OpportunityLineItem oliRecycled = TestDataFactory.createOppLineItem(oppRecycled, pbeTest[0]);
        testOppProducts.add(oliRecycled);
        insert testOppProducts;

    }
    
    @isTest
    static void testUpdateTotalWooodSalesStandardUpdate() {
        Database.SaveResult updateOpp;
        Opportunity oppToClose = [SELECT Id, WoodType__c, Amount, StageName FROM Opportunity WHERE Name = 'Test OppStandard' LIMIT 1];
        oppToClose.StageName = 'Closed Won';
        
        Test.startTest();
        	updateOpp = Database.update(oppToClose, false);
        Test.stopTest();
        
        Account accToCheck = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        Assert.areEqual(true, updateOpp.getErrors().isEmpty(), 'Expected to not have any errors.');
        Assert.areEqual(accToCheck.TotalSalesStandardWood__c, oppToClose.Amount, 'Expected the Total Sales for Standard Wood to be the same amount as the Standard Wood Opportunity Amount');
    }
    
    @isTest
    static void testUpdateTotalWooodSalesRecycledUpdate() {
        Database.SaveResult updateOpp;
        Opportunity oppToClose = [SELECT Id, WoodType__c, Amount, StageName FROM Opportunity WHERE Name = 'Test OppRecycled' LIMIT 1];
        oppToClose.StageName = 'Closed Won';
        
        Test.startTest();
        	updateOpp = Database.update(oppToClose, false);
        Test.stopTest();
        
        Account accToCheck = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        Assert.areEqual(true, updateOpp.getErrors().isEmpty(), 'Expected to not have any errors.');
        Assert.areEqual(accToCheck.TotalSalesRecycledWood__c, oppToClose.Amount, 'Expected the Total Sales for Standard Wood to be the same amount as the Standard Wood Opportunity Amount');
    }
    
    @isTest
    static void testUpdateTotalWooodSalesStandardDelete() {
        Database.DeleteResult deleteOpp;
        Account accToCheckBefore = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        Opportunity oppToClose = [SELECT Id, WoodType__c, Amount, StageName FROM Opportunity WHERE Name = 'Test OppStandard' LIMIT 1];
        oppToClose.StageName = 'Closed Won';
        update oppToClose;
        
        Test.startTest();
        	deleteOpp = Database.delete(oppToClose, false);
        Test.stopTest();
        
        Account accToCheckAfter = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        Assert.areEqual(true, deleteOpp.getErrors().isEmpty(), 'Expected to not have any errors.');
        Assert.areEqual(accToCheckAfter.TotalSalesStandardWood__c, accToCheckBefore.TotalSalesStandardWood__c - oppToClose.Amount, 'Expected the Total Sales for Standard Wood to be correctly updated after the Opprotunity is deleted');
    }
    
    @isTest
    static void testUpdateTotalWooodSalesRecycledDelete() {
        Database.DeleteResult deleteOpp;
        Account accToCheckBefore = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        Opportunity oppToClose = [SELECT Id, WoodType__c, Amount, StageName FROM Opportunity WHERE Name = 'Test OppRecycled' LIMIT 1];
        oppToClose.StageName = 'Closed Won';
        update oppToClose;
        
        Test.startTest();
        	deleteOpp = Database.delete(oppToClose, false);
        Test.stopTest();
        
        Account accToCheckAfter = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        Assert.areEqual(true, deleteOpp.getErrors().isEmpty(), 'Expected to not have any errors.');
        Assert.areEqual(accToCheckAfter.TotalSalesRecycledWood__c, accToCheckBefore.TotalSalesRecycledWood__c - oppToClose.Amount, 'Expected the Total Sales for Standard Wood to be correctly updated after the Opprotunity is deleted');
    }

    @isTest
    static void testUpdateTotalWooodSalesUpdateNegative() {
        Database.SaveResult updateOpp;
        Opportunity oppToClose = [SELECT Id, WoodType__c, Amount, StageName FROM Opportunity WHERE Name = 'Test OppStandard' LIMIT 1];
        oppToClose.WoodType__c = null;
        oppToClose.StageName = 'Closed Won';
        
        Test.startTest();
        	updateOpp = Database.update(oppToClose, false);
        Test.stopTest();
        
        Account accToCheck = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        Assert.areEqual(true, updateOpp.getErrors().isEmpty(), 'Expected to not have any errors.');
        Assert.areEqual(accToCheck.TotalSalesStandardWood__c, null, 'Expected the Total Sales for Standard Wood to not have changed');
    }
    
    @isTest
    static void testUpdateTotalWooodSalesDeleteNegative() {
        Database.DeleteResult deleteOpp;
        Account accToCheckBefore = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        Opportunity oppToClose = [SELECT Id, WoodType__c, Amount, StageName FROM Opportunity WHERE Name = 'Test OppStandard' LIMIT 1];
        oppToClose.WoodType__c = null;
        oppToClose.StageName = 'Closed Won';
        update oppToClose;
        
        Test.startTest();
        	deleteOpp = Database.delete(oppToClose, false);
        Test.stopTest();
        
        Account accToCheckAfter = [SELECT Id, TotalSalesRecycledWood__c, TotalSalesStandardWood__c FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        Assert.areEqual(true, deleteOpp.getErrors().isEmpty(), 'Expected to not have any errors.');
        Assert.areEqual(accToCheckAfter.TotalSalesStandardWood__c, null, 'Expected the Total Sales for Standard Wood to not have changed');
    }

}
