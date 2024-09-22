public with sharing class AccountContactController {
 // Method to get accounts with pagination
 @AuraEnabled(cacheable=true)
 public static List<Account> getAccounts(Integer pageNumber, Integer pageSize) {
     Integer offset = (pageNumber - 1) * pageSize;
     return [SELECT Id, Name FROM Account ORDER BY Name LIMIT :pageSize OFFSET :offset];
 }

 // Method to get the total account count
 @AuraEnabled(cacheable=true)
 public static Integer getAccountCount() {
     return [SELECT COUNT() FROM Account];
 }

 // Method to get contacts for a specific account with pagination
 @AuraEnabled(cacheable=true)
 public static List<Contact> getContactsByAccount(Id accountId, Integer pageNumber, Integer pageSize) {
     if (accountId == null || pageSize <= 0) {
         return new List<Contact>(); // Return empty list if no ID is provided or invalid page size
     }
     
     Integer offset = (pageNumber - 1) * pageSize;
     return [SELECT Id, Name, Email FROM Contact WHERE AccountId = :accountId ORDER BY Name LIMIT :pageSize OFFSET :offset];
 }

 // Method to get the total contact count for a specific account
 @AuraEnabled(cacheable=true)
 public static Integer getContactCountByAccount(Id accountId) {
     if (accountId == null) {
         return 0; // Return zero if no ID is provided
     }
     return [SELECT COUNT() FROM Contact WHERE AccountId = :accountId];
 }

}