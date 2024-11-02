/**
Implement the method enrollStudents that takes as input a list of strings emails and a string className. The method should enroll all students with the provided emails into a class with the given name by creating apxio__Class_Enrollment__c records.

Note that apxio__Student__c and apxio__Class__c records already exist in the database.

You will be working with the following custom object and field names for this problem:

apxio__Student__c
apxio__Student__c.apxio__Email__c
apxio__Class__c
apxio__Class_Enrollment__c
apxio__Class_Enrollment__c.apxio__Student__c
apxio__Class_Enrollment__c.apxio__Offered_Class__c
 */

public void enrollStudents(List<String> emails, String className) {
   
    List<apxio__Student__c> students=[
        select Id
        from apxio__Student__c
        where apxio__Email__c IN :emails
    ];
   
    apxio__Class__c offeredClass=[
        select Id
        from apxio__Class__c
        where name = :className
        LIMIT 1
    ];
    

    if (offeredClass != null && !students.isEmpty()){
        List<apxio__Class_Enrollment__c> enrollments = new List<apxio__Class_Enrollment__c>();


   for (apxio__Student__c student : students) {
            apxio__Class_Enrollment__c enrollment = new apxio__Class_Enrollment__c(
                apxio__Student__c = student.Id,
                apxio__Offered_Class__c = offeredClass.Id
            );
            enrollments.add(enrollment);
       }

        insert enrollments;
    }

}