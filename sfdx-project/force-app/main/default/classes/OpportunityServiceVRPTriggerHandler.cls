public class OpportunityServiceVRPTriggerHandler implements ITriggerHandler {
    public OpportunityServiceVRPTriggerHandler() { 
    }
    
    public void onBeforeInsert(List<SObject> newItems) {
    }
    
    public void onBeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
    }
    
    public void onBeforeDelete(Map<Id, SObject> deletedOpportunitySplits) {
    }
    
    public void onAfterInsert(Map<Id, SObject> newItems) {
    }
    
    public void onAfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        OpportunityServiceVRP.updateTotalWooodSales((Map<Id, Opportunity>)newItems, (Map<Id, Opportunity>)oldItems);
        
    }
    
    public void onAfterDelete(Map<Id, SObject> deletedOpportunities) {
        OpportunityServiceVRP.updateTotalWooodSales(null, (Map<Id, Opportunity>)deletedOpportunities);
        
    }
    
    public void onAfterUnDelete(Map<Id, SObject> newItems) {
    }
}