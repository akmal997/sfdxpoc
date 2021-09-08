@isTest
public class ContactControllerTest {
    static Testmethod void testContactClass()
    {
        Contact con1 = new Contact(/*Name ='Contact1',*/ Title = 'Testing title 1', Phone = '98098765678' , Email= 'test@email.com', LastName = 'New Contact 1');
        Contact con2 = new Contact(/*Name ='Contact2',*/ Title = 'Testing title 2', Phone = '98098765673' , Email= 'test2@email.com', LastName = 'New Contact 2');
        Contact con3 = new Contact(/*Name ='Contact3',*/ Title = 'Testing title 3', Phone = '98098765674' , Email= 'test3@email.com', LastName = 'New Contact 3');
        insert con1;
        insert con2;
        insert con3;
    
        
        Test.startTest();
            ContactController.getContactList();
            ContactController.findContacts('Contact');
            ContactController.getSingleContact();
        Test.stopTest();
    }

}