report 50120 "MP Import Records"
{
    Caption = 'Import Records';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItemName; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if (DateFrom = 0D) or (DateTo = 0D) then
                    error(Txt001);
            end;

            trigger OnAfterGetRecord()
            var
                CopyGLEntries: Codeunit "MP Copy G/L Entries";
            begin
                CopyGLEntries.CopyGLEntryToCustomerGLEntry(DateFrom, DateTo, CustNo);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(DateFrom; DateFrom)
                    {
                        ApplicationArea = All;
                        Caption = 'Date From';
                    }
                    field(DateTo; DateTo)
                    {
                        ApplicationArea = All;
                        Caption = 'Date To';
                    }
                    field(CustNo; CustNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer No. Filter';
                        TableRelation = Customer;
                    }
                }
            }
        }
    }

    var
        DateFrom: Date;
        DateTo: Date;
        CustNo: Code[20];
        Txt001: Label 'You must specify a valid date range for this process.';
}