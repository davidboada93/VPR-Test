public class OpportunityServiceVRP {

    public static void updateTotalWooodSales(Map<Id, Opportunity> newItems, Map<Id, Opportunity> oldItems) {
        Boolean isUpdate = (oldItems != null && newItems != null);
        Boolean isDeleted = (newItems == null);
        Map<Id, Account> accsToProcess = new Map<Id, Account>();
        Set<Id> accIds = new Set<Id>();

        // Identify the Accounts whose totals need to be updated
        for (Opportunity opp : (isDeleted ? oldItems.values() : newItems.values())) {
            if ((isUpdate && (opp.StageName != oldItems.get(opp.Id).StageName) && opp.StageName == 'Closed Won' && opp.WoodType__c != null) ||
                (isDeleted && oldItems.get(opp.Id).StageName == 'Closed Won' && oldItems.get(opp.Id).WoodType__c != null)) {
                    accIds.add(opp.AccountId);
            }
        }

        // Bulk query to get all closed won opportunities for the accounts in question
        List<AggregateResult> groupedResults = [
            SELECT AccountId, SUM(Amount) sumAmount, WoodType__c
            FROM Opportunity
            WHERE AccountId IN :accIds AND StageName = 'Closed Won'
            GROUP BY AccountId, WoodType__c
        ];

        // Initialize maps to hold sums for each account and wood type
        Map<Id, Decimal> standardWoodSums = new Map<Id, Decimal>();
        Map<Id, Decimal> recycledWoodSums = new Map<Id, Decimal>();

        // Process the query results to calculate the totals for each account
        for (AggregateResult ar : groupedResults) {
            Id accountId = (Id) ar.get('AccountId');
            Decimal sumAmount = (Decimal) ar.get('sumAmount');
            String woodType = (String) ar.get('WoodType__c');

            if (woodType == 'Standard') {
                standardWoodSums.put(accountId, sumAmount);
            } else if (woodType == 'Recycled') {
                recycledWoodSums.put(accountId, sumAmount);
            }
        }

        // Prepare the Account records to update their totals
        for (Id accId : accIds) {
            Account acc = new Account(Id = accId);

            // Set the totals for standard wood and recycled wood; default to 0 if no entries
            acc.TotalSalesStandardWood__c = standardWoodSums.containsKey(accId) ? standardWoodSums.get(accId) : 0;
            acc.TotalSalesRecycledWood__c = recycledWoodSums.containsKey(accId) ? recycledWoodSums.get(accId) : 0;

            accsToProcess.put(accId, acc);
        }

        // Update the Account records
        if (!accsToProcess.isEmpty()) {
            update accsToProcess.values();
        }
    }
}