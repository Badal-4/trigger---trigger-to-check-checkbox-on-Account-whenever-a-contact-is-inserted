trigger trg2 on Contact(after Insert,after Update)
{
    Set<Id> accIds = new Set<Id>();
    
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        if(!trigger.new.isEmpty())
        {
            for(Contact con : trigger.new)
            {
                if(con.Accountid != null)
                {
                    accIds.add(con.AccountId);
                }
            }
        }
    }
    if(!accIds.isEmpty())
    {
        List<Account> accList = [Select Id,Test_Checkbox__c,Name  from Account where Id IN : accIds];
        List<Account> acctList = new List<Account>();   
        if(!accList.isEmpty())
        {
            for(Account acc : accList)
            {
                if(acc.Test_Checkbox__c == false)
                {
                    acc.Test_Checkbox__c = true;
                    acctList.add(acc);
                }
            }
        }
        if(!acctList.isEmpty())
        {
            update acctList;
        }
    }
}
