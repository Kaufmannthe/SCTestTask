public with sharing class ContactManagerController {

    private List<Contact> contactList;
    private Integer totalRecs = 0;
    private Integer index = 0;
    private Integer blockSize = 10;

    public ContactManagerController() {
        totalRecs = [SELECT COUNT() FROM Contact];
        System.debug(totalRecs);
    }

    public List<Contact> getContacts() {
        List<Contact> contactList = Database.query('SELECT Name, Email, Level__c, Account.Name, Owner.Id, CreatedById, CreatedDate ' +
                'FROM Contact ' +
                'LIMIT:blockSize ' +
                'OFFSET:index');
        return contactList;
    }
//<----------------------------------------------->Sorting
    private String sortDirection = 'ASC';
    private String sortExp = 'name';

    public String sortExpression {
        get {
            return sortExp;
        }
        set {
            if (value == sortExp) {
                sortDirection = (sortDirection == 'ASC') ? 'DESC' : 'ASC';
            } else {
                sortDirection = 'ASC';
            }
            sortExp = value;
        }
    }

    public String getSortDirection() {
        if (sortExpression == null || sortExpression == '') {
            return 'ASC';
        } else {
            return sortDirection;
        }
    }

    public void setSortDirection(String value) {
        sortDirection = value;
    }

    public PageReference ViewData()  {
        String sortFullExp = sortExpression + ' ' + sortDirection;
        /*contactList = Database.query('SELECT Name, Email, Level__c, Account.Name, Owner.Id, CreatedById, CreatedDate' +
                ' FROM Contact ORDER BY ' + sortFullExp + ' ' +
                'LIMIT:blockSize ' +
                'OFFSET:index');*/
        return null;
    }
    //<-------------------------------------------------->Pagination


    public void beginning() {
        index = 0;
    }
    public void previous() {
        index = index - blockSize;
    }
    public void next() {
        index = index + blockSize;
    }
    public void end() {
        index = index - Math.mod(totalRecs, blockSize);
    }

    public Boolean getprev() {
        if (index == 0) {
            return true;
        } else {
            return false;
        }
    }
    public Boolean getnxt() {
        if ((index + blockSize) > totalRecs) {
            return true;
        } else {
            return false;
        }
    }
}