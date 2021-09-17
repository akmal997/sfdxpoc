// @isTest
// public class AccountControllerTestRuntimeError {
// TestMethod Static void testfindAccounts()
// {
//     Account Acc1 = new Account(Name ='Acc1', AccountNumber = '9800032');
//     Account Acc2 = new Account(Name ='Acc2', AccountNumber = '9800030');
//     Account Acc3 = new Account(Name ='Acc3', AccountNumber = '9800031');
//     insert Acc1;
//     insert Acc2;
//     insert Acc3;
//     AccountController.findAccounts('Acc1');
//     string searchquery='select id, Name, UserRole.ParentRoleId, ArgosBuyer_in__c  from User where ArgosBuyer_in__c <> null and id !=:currentuserid and isActive = true and Name like :newSearch';
//     List<User> Usr = Database.query(searchquery);
//         //System.debug('searchquery  :'+searchquery);
//     System.debug('Usr :'+Usr);
// }
// }
