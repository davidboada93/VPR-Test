public class TestDataFactory {
    
    public static final String ACCOUNT_NAME1 = 'New York Fund Services Ltd.';
    public static final String ACCOUNT_NAME2 = 'London Fund Services Ltd.';
    public static final String ACCOUNT_NAME3 = 'Syndey Fund Services Ltd.';
    public static final String ACCOUNT_NAME4 = 'Hong Kong Fund Services Ltd.';
    public static final String INTERNAL_COMPANY_SOURCE = 'Waystone Compliance Solutions (UK) Ltd';
    public static final String STANDARD_CONTACT_RECORD_TYPE = 'StandardContact';
    

    public static Account createAccount(String name) {        
        Account acc = new Account();
        acc.Name = name;
        acc.Email__c = name.replaceAll( '\\s+', '') + 'test@waystone.com';
        acc.Phone = '(+1)(+23)2458963';
        acc.Region__c = 'EMEA';
        acc.Category__c = 'Administrator';
        acc.Regulator__c = '(FSCA) Financial Sector Conduct Authority';
        acc.BillingCountry = 'Denmark';
        acc.BillingCity = 'Odense';
        acc.BillingStreet = '85 Road';
        acc.BillingPostalCode = '12347';
        acc.AccountType__c = 'Named Account (RM)';        
        return acc;
    }
        
    public static Contact createContact(String lastName, Account relatedAcc) {
        Id contactRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get(STANDARD_CONTACT_RECORD_TYPE).getRecordTypeId();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueOf(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer randomId = Integer.valueOf(Math.rint(Math.random()*1000000));         
        String uniqueName = orgId + dateString + randomId;                  
        Contact contact = new Contact();
        contact.AccountId = relatedAcc.Id;
        contact.LastName = lastName;
        contact.Category__c = 'Administrator';
        contact.Email = uniqueName + '@test' + orgId + '.org';
        contact.FirstName = 'First Name Contact';
        contact.Salutation = 'Mrs.';
        contact.RecordTypeId = contactRecordTypeId;

        return contact;
    }
    
        public static User createUser(String lastName, String profileName, Boolean isSalesRep) {        
        Profile pf = [SELECT Id FROM Profile WHERE Name = :profileName];         
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueOf(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer randomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName = orgId + dateString + randomId; 
        User us = new User(); 
        us.LastName = lastName; 
        us.Email = uniqueName + '@waystone.com';
        us.Username = uniqueName + '@test' + orgId + '.org'; 
        us.EmailEncodingKey = 'ISO-8859-1';
        us.Alias = uniqueName.substring(18, 23); 
        us.TimeZoneSidKey = 'America/Los_Angeles'; 
        us.LocaleSidKey = 'en_US'; 
        us.LanguageLocaleKey = 'en_US'; 
        us.ProfileId = pf.Id;
        us.BDSalesRep__c = isSalesRep;                 
        return us;
    }

    public static Opportunity createOpportunity(String name, Account relatedAcc) {        
        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Active').getRecordTypeId();    
        Opportunity opp = new Opportunity();
        opp.Name = name;
        opp.NoProhibitedJurisdictions__c = true;
        opp.AccountId = relatedAcc.Id;
        opp.StageName = 'Initial Lead';
        opp.Administrator__c = relatedAcc.Id;
        opp.InvestmentManager__c = relatedAcc.Id;
        opp.AMLDelegate__c = relatedAcc.Id;
        opp.Domicile__c = 'Ireland'; 
        opp.Strategy__c = 'ACSF - Fund Finance';
        opp.DMS_Product__c = 'AIFMD (holder)';
        opp.NumberOfContactRoles__c = 1;
        opp.CloseDate = Date.today() + 60;
        opp.LeadSource = 'Internal Referral';
        opp.RecordTypeId = recordTypeId;
        opp.InternalCompanySource__c = TestDataFactory.INTERNAL_COMPANY_SOURCE;
        opp.EntityType__c = 'Trust';
        if (Test.isRunningTest()) {
            opp.Pricebook2Id = Test.getStandardPricebookId();        
        }
        return opp;
    }
    
    public static Opportunity createOpportunityFullyPopulated(String name, Account relatedAcc) {        
        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Active').getRecordTypeId();    
        Opportunity opp = new Opportunity();
        opp.Name = name;
        opp.NoProhibitedJurisdictions__c = true;
        opp.AccountId = relatedAcc.Id;
        opp.StageName = 'Initial Lead';
        opp.DMS_Product__c = 'AIFMD (holder)';
        opp.CloseDate = Date.today() + 60;
        opp.LeadSource = 'Internal Referral';
        opp.RecordTypeId = recordTypeId;
        opp.InternalCompanySource__c = TestDataFactory.INTERNAL_COMPANY_SOURCE;
        opp.KYCAssessmentResult__c = 'Go';
        opp.InvestmentManager__c = relatedAcc.Id;
        opp.AMLDelegate__c = relatedAcc.Id;
        opp.Administrator__c = relatedAcc.Id;
        opp.AumOfEntity__c = 'Less than 500M';
        opp.InvestmentManagerAum__c = 'Less than 500M';
        opp.EntityName__c = 'test entity';
        opp.BusinessForumComments__c = 'test comments';
        opp.EstimatedInvestmentAmount__c = 200;
        opp.ActualInvestmentAmount__c = 200;
        opp.MarketedTo__c = 'Europe';
        opp.NewBusinessForumResultDate__c = Date.newInstance(2021, 12, 9);
        opp.NewBusinessForumResult__c = 'Approved';
        opp.NewBusiness__c = 'Yes';
        opp.NumberOfInvestors__c = 3;
        opp.PortfolioProhibitedInstrumentTypes__c = 'Cannabis'; 
        opp.SalesRepExist__c = true;
        opp.NumberOfContactRoles__c = 1;
        opp.QuoteAccepted__c = true;
        opp.InvestmentManagerRegulator__c = 'Test regulator';
        opp.BoardComposition__c = 'test composition';
        opp.EntityType__c = 'Trust';
        opp.Strategy__c = 'ACSF - Fund Finance';
        opp.Domicile__c = 'Ireland';
        opp.Competitor__c = relatedAcc.Id;
        
        Account internalAccount = null;
        List<Account> accounts =  [SELECT Id FROM Account WHERE Name = 'Internal' LIMIT 1];
        if (!accounts.isEmpty()) {
            internalAccount = accounts[0];
        } else {
            internalAccount = TestDataFactory.createAccount('Internal');
            internalAccount.DMSAccount__c = true;
            insert internalAccount;
        }
        
        Contact internalContact = TestDataFactory.createContact('internal', internalAccount);
        Contact externalContact = TestDataFactory.createContact('external', relatedAcc);
        insert new List<Contact>{internalContact, externalContact};
        
        opp.InternalIntroducer__c = internalContact.Id;
        opp.Introducer__c = externalContact.Id;
        
        Campaign primSourCamp = TestDataFactory.createCampaign('Primary Campaign');
        insert primSourCamp;
        opp.CampaignId = primSourCamp.Id;
        
        if (Test.isRunningTest()) {
            opp.Pricebook2Id = Test.getStandardPricebookId();        
        }
        
        Engagement__c engTest = null;
        try {
            engTest = TestDataFactory.createEngagement('Related Engagement - ' + relatedAcc.Name, relatedAcc);
            insert engTest;
        } catch (Exception e) {
            Id existingAccId = relatedAcc.Id;
            engTest = [SELECT Id FROM Engagement__c WHERE Account__c = :existingAccId LIMIT 1];
        }
        
        opp.Fund__c = engTest.Id;
        
        return opp;
    }

    public static Product2 createProduct(String name, String family) {
        Product2 product = new Product2();
        product.isActive = true;
        product.Name = name;
        product.Family = family;
        product.ProductCode = 'Test Code';        
        return product;
    }
    
    public static PriceBookEntry createPriceBookEntry(Id relatedPBId, Product2 relatedProd) {
        PriceBookEntry pbe = new PriceBookEntry();
        pbe.PriceBook2Id = relatedPBId;
        pbe.Product2Id = relatedProd.Id;
        pbe.UnitPrice = 5.00;
        pbe.IsActive = true;
        return pbe;
    }
           
    public static OpportunityLineItem createOppLineItem(Opportunity relatedOpp, PriceBookEntry relatedPBE) {
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.OpportunityId = relatedOpp.Id; 
        oli.PricebookEntryId = relatedPBE.Id;
        oli.Quantity = 1;
        oli.TotalPrice = 1;
        return oli;
    }

    public static Order createOrder(String status, Account relatedAcc, Id relatedPBId, Opportunity relatedOpp) {                                
        Order order = new Order();
        order.AccountId = relatedAcc.Id;
        order.EffectiveDate = Date.today();
        order.Status = status;
        order.Pricebook2Id = relatedPBId;
        order.OpportunityId = relatedOpp.Id;        
        return order;
    }

    public static OrderItem createOrderProduct(Order relatedOrder, PriceBookEntry relatedPBE, Product2 relatedProd) {
        OrderItem oit = new OrderItem();
        oit.OrderId = relatedOrder.Id;
        oit.UnitPrice = 1;
        oit.PricebookEntryId = relatedPBE.Id; 
        oit.Quantity = 1;
        oit.Product2Id = relatedProd.Id;        
        return oit;
    }
        
}