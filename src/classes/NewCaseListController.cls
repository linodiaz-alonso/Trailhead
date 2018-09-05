public with sharing class NewCaseListController {
    private String sortOrder = 'LastName';
    
    public List<Case> getNewCases() {
        
        List<Case> results = Database.query(
            'SELECT Id, CaseNumber ' +
            'FROM Case ' +
            'WHERE Status = \'New\' '
        );
        return results;
    }   
}