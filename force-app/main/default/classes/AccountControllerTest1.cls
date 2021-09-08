@isTest
public class AccountControllerTest1 {
TestMethod Static void testfindAccounts()
{
    Account acc1 = new Account(Name ='acc1', AccountNumber = '9800032');
    Account acc2 = new Account(Name ='acc2', AccountNumber = '9800030');
    Account acc3 = new Account(Name ='acc3', AccountNumber = '9800031');
    insert acc1;
    insert acc2;
    insert acc3;
    AccountController.findAccounts('acc1');
}
}