@IsTest
private class HelloTrailheadTest {
    @IsTest
    static void greetWithName() {
        Test.startTest();
        String result = HelloTrailhead.greet('  Mateusz  ');
        Test.stopTest();

        System.assertEquals('Cześć, Mateusz! Witaj w Salesforce.', result, 'Powitanie powinno przyciąć spacje.');
    }

    @IsTest
    static void greetBlank() {
        System.assertEquals('Cześć, nieznajomy!', HelloTrailhead.greet(''));
        System.assertEquals('Cześć, nieznajomy!', HelloTrailhead.greet(null));
    }

    @IsTest
    static void countAccounts() {
        insert new List<Account>{
            new Account(Name = 'Test Konto A'),
            new Account(Name = 'Test Konto B')
        };

        Test.startTest();
        Integer total = HelloTrailhead.countAccounts();
        Test.stopTest();

        System.assert(total >= 2, 'W orgu powinny być co najmniej 2 konta, jest: ' + total);
    }
}
