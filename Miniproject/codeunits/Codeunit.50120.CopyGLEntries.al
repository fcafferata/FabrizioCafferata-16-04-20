codeunit 50120 "MP Copy G/L Entries"
{
    Permissions = tabledata 17 = r;

    trigger OnRun()
    var

    begin

    end;

    procedure CopyGLEntryToCustomerGLEntry(FromDate: Date; ToDate: Date; CustNo: Code[20])
    var
        GLEntry: Record "G/L Entry";
        GLCustomerEntry: Record "MP G/L Customer Entry";
    begin
        GLEntry.SetRange("Posting Date", FromDate, ToDate);
        GLEntry.SetRange("Source Type", GLEntry."Source Type"::Customer);
        if CustNo <> '' then
            GLEntry.SetRange("Source No.", CustNo);
        if GLEntry.FindSet() then
            repeat
                GLCustomerEntry.Init;
                GLCustomerEntry."Document Type" := GLEntry."Document Type";
                GLCustomerEntry."Document No." := GLEntry."Document No.";
                GLCustomerEntry.Description := GLEntry.Description;
                GLCustomerEntry."Customer No." := GLEntry."Source No.";
                GLCustomerEntry."Source Code" := GLEntry."Source Code";
                GLCustomerEntry."Related G/L Entry No." := GLEntry."Entry No.";
                GLCustomerEntry.Amount := GLEntry.Amount;
                GLCustomerEntry."Posting Date" := GLEntry."Posting Date";
                GLCustomerEntry.Insert(true);
            until GLEntry.Next() = 0;
    end;

    var
        myInt: Integer;
}