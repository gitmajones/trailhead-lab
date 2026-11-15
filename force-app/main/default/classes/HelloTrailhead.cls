public with sharing class HelloTrailhead {
    /**
     * Zwraca powitanie dla podanego imienia.
     * Pokazuje: metody statyczne, String.isBlank, trim, konkatenację.
     */
    public static String greet(String name) {
        if (String.isBlank(name)) {
            return 'Cześć, nieznajomy!';
        }
        return 'Cześć, ' + name.trim() + '! Witaj w Salesforce.';
    }

    /**
     * Liczy wszystkie konta w orgu.
     * Pokazuje: SOQL z COUNT() i bezpośrednie przypisanie do Integer.
     */
    public static Integer countAccounts() {
        return [SELECT COUNT() FROM Account];
    }
}
