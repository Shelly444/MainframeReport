      ******************************************************************
      * Group 4 - Program #2
      * Tyler, Michelle & Dylon
      * 2019-04-13
      *-------------------------
      * 
      * 
      * 
      * 
      ******************************************************************

       identification division.
       program-id. Program2.

       environment division.
       configuration section.
       file-control.
           
            select input-file
               assign to "../../../data/valid.dat"
               organization is line sequential.
            
           select sandl-file
               assign to "../../../../project3/data/sandl.dat"
               organization is line sequential.

           select return-file
               assign to "../../../../program4/data/returns.dat"
               organization is line sequential.

           select report-file
               assign to "../../../data/totalReport.out"
               organization is line sequential.
      ******************************************************************
      ******************************************************************
      *
       data division.
       file section.
      *
       fd input-file
           data record is input-line
           record contains 36 characters.
      *    
       01 input-line.
           05 input-transaction-code             pic x.
               88 input-valid-scode value "S".
               88 input-valid-lcode value "L".
               88 input-valid-rcode value "R".
           05 input-transaction-ammount          pic 9(5)v99.
           05 input-payment-type                 pic xx.
               88 input-valid-CA value "CA".
               88 input-valid-CR value "CR".
               88 input-valid-DB value "DB".
           05 input-store-number                 pic 99.
           05 input-invoice-number               pic x(9).
           05 input-sku-code                     pic x(15).
      ******************************************************************
      ******************************************************************

      *
       fd sandl-file
           data record is sandl-line
           record contains 36 characters.
      *     
       01 sandl-line                        pic x(36).
       
       fd return-file
           data record is return-line
           record contains 36 characters.
      *      
       01 return-line                      pic x(36).

       fd report-file
           data record is report-line
           record contains 120 characters.
      *
       01 report-line                       pic x(120).
       working-storage section.

       01 ws-flags.
           05 ws-eof-flag                   pic x
               value "n".

       01 ws-star-line.
           05 filler                     pic x(60)
               value 
       "************************************************************".
       01 ws-report-title.
           05 filler                     pic x(17)
               value spaces.
           05 filler                     pic x(32)
               value "Record Totals Report".
       01 ws-report-title-2.
           05 filler                     pic x(14)
               value spaces.
           05 filler                     pic x(35)
               value "Transaction-type Percentages".
       01 ws-report-title-3.
           05 filler                     pic x(15)
               value spaces.
           05 filler                     pic x(49)
               value 
               "Returns & Transactions Amount".
       01 ws-report-title-4.
           05 filler                     pic x(15)
               value spaces.
           05 filler                     pic x(47)
               value "Transactions & Returns Totals".

       01 ws-report-title-5.
           05 filler                     pic x(25)
               value spaces.
           05 filler                     pic x(47)
               value "Grand Total".
       01 ws-report-title-6.
           05 filler                     pic x(15)
               value spaces.
           05 filler                     pic x(49)
               value 
               "S&L Amounts Per Store".

      ******************************************************************
      ******************************************************************


       01 ws-total-headings-1.
           05 filler                     pic x(6)
               value spaces.
           05 filler                     pic x(22)
               value "S&L Toatl per Store".
           05 filler                     pic x(11)
               value spaces.
           05 filler                     pic x(10)
               value "Amount".
           05 filler                     pic x(32)
               value spaces.

       01 ws-total-headings-1-2.
           05 filler                     pic x(32)
               value 
               "+------------------------------+".
           05 filler                     pic x(5)
               value spaces.
           05 filler                     pic x(10)
               value "+--------+".

       01 ws-total-headings-2.
           05 filler                     pic x(6)
               value spaces.
           05 filler                     pic x(22)
               value "Return Total per Store".
           05 filler                     pic x(11)
               value spaces.
           05 filler                     pic x(17)
               value "Amount".
           05 filler                     pic x(32)
               value spaces.

       01 ws-total-headings-2-2.
           05 filler                     pic x(32)
               value 
               "+------------------------------+".
           05 filler                     pic x(6)
               value spaces.
           05 filler                     pic x(9)
               value "+-------+".

       01 ws-total-headings-3.
           05 filler                     pic x(3)
               value spaces.
           05 filler                     pic x(32)
               value "Return Transaction Records Total".
           05 filler                     pic x(12)
               value spaces.
           05 filler                     pic x(9)
               value "REC#".
           05 filler                     pic x(32)
               value spaces.

       01 ws-total-headings-3-2.
           05 filler                     pic x(41)
               value 
               "+---------------------------------------+".
           05 filler                     pic x(7)
               value spaces.
           05 filler                     pic x(3)
               value "+-+".

       01 ws-total-headings-4.
           05 filler                     pic x(6)
               value spaces.
           05 filler                     pic x(22)
               value "Transaction Type".
           05 filler                     pic x(5)
               value spaces.
           05 filler                     pic x(10)
               value "Percent".


       01 ws-total-headings-4-2.
           05 filler                     pic x(31)
               value 
               "+-----------------------------+".
           05 filler                     pic x(2)
               value spaces.
           05 filler                     pic x(7)
               value "+----+".

       01 ws-total-headings-5.
           05 filler                     pic x(4)
               value spaces.
           05 filler                     pic x(12)
               value "Record Type".
           05 filler                     pic x(26)
               value spaces.
           05 filler                     pic x(4)
               value "REC#".


       01 ws-total-headings-5-2.
           05 filler                     pic x(19)
               value 
               "+-----------------+".
           05 filler                     pic x(2)
               value spaces.
           05 filler                     pic x(5)
               value "+---+".
       01 ws-total-headings-6.
           05 filler                     pic x(4)
               value spaces.
           05 filler                     pic x(10)
               value "Total Type".
           05 filler                     pic x(23)
               value spaces.
           05 filler                     pic x(9)
               value "Amount".
           05 filler                     pic x(32)
               value spaces.

       01 ws-total-headings-6-2.
           05 filler                     pic x(19)
               value 
               "+-----------------+".
           05 filler                     pic x(16)
               value spaces.
           05 filler                     pic x(11)
               value "+--------+".

       


       01 ws-heading1-name-line.
           05 filler                     pic x(5)
               value spaces.
           05 ws-nl-date                 pic 9(6).
           05 filler                     pic x(5)
               value spaces.
           05 ws-nl-time                 pic 9(8).
           05 filler                     pic x(7)
               value spaces.
           05 filler                     pic x(20)
               value "Group 4 - Program 2".
      *               ----=----1----=----2----=--
           05 filler                     pic x(43)
               value spaces.
       

      ******************************************************************
      ******************************************************************


       01 total-line-1.
           05 filler                        pic x(42)
               value "S & L Record Total: ".
           05 ws-total-sl-total             pic 99
               value 0.
       01 total-line-2.
           05 filler                        pic x(42)
               value "S Record Total: ".
           05 ws-total-s-total              pic 99
               value 0.
       01 total-line-3.
           05 filler                        pic x(42)
               value "L Record Total: ".
           05 ws-total-l-total              pic 99
               value 0.
       01 total-line-4.
           05 filler                        pic x(34)
               value "S & L Transaction Total Store 1: ".
           05 ws-total-transaction-total-1    pic $$,$$$,$$9.99
               value 0.
       01 total-line-5.
           05 filler                        pic x(34)
               value "S & L Transaction Total Store 2: ".
           05 ws-total-transaction-total-2    pic $$,$$$,$$9.99
               value 0.
       01 total-line-6.
           05 filler                        pic x(34)
               value "S & L Transaction Total Store 3: ".
           05 ws-total-transaction-total-3    pic $$,$$$,$$9.99
               value 0.
       01 total-line-7.
           05 filler                        pic x(34)
               value "S & L Transaction Total Store 4: ".
           05 ws-total-transaction-total-4    pic $$,$$$,$$9.99
               value 0.
       01 total-line-8.
           05 filler                        pic x(34)
               value "S & L Transaction Total Store 5: ".
           05 ws-total-transaction-total-5    pic $$,$$$,$$9.99
               value 0.
       01 total-line-9.
           05 filler                        pic x(34)
               value "S & L Transaction Total Store 12: ".
           05 ws-total-transaction-total-12    pic $$,$$$,$$9.99
               value 0.
       01 total-line-10.
           05 filler                        pic x(32)
               value "Total S Amount: ".
           05 ws-total-s-amount-total              pic $$,$$$,$$9.99
               value 0.
       01 total-line-11.
           05 filler                        pic x(32)
               value "Total L Amount: ".
           05 ws-total-l-amount-total              pic $$,$$$,$$9.99
               value 0.
       01 total-line-30.
           05 filler                        pic x(32)
               value "Total S & L Amount: ".
           05 ws-total-sandl-amount-total           pic $$,$$$,$$9.99
               value 0.
       01 total-line-12.
           05 filler                        pic x(34)
               value "Percentage Transactions Credit: %".
           05 ws-percentage-trans-cr-total     pic 99.99
               value 0.
       01 total-line-13.
           05 filler                        pic x(34)
               value "Percentage Transactions Debit:  %".
           05 ws-percentage-trans-db-total     pic 99.99
               value 0.
       01 total-line-14.
           05 filler                        pic x(34)
               value "Percentage Transactions Cash:   %".
           05 ws-percentage-trans-ca-total     pic 99.99
               value 0.
       01 total-line-15.
           05 filler                        pic x(48)
               value "Return Transaction Records Total Store 1: ".
           05 ws-total-return-transaction-total-1    pic z9
               value 0.
       01 total-line-16.
           05 filler                        pic x(48)
               value "Return Transaction Records Total Store 2: ".
           05 ws-total-return-transaction-total-2    pic z9
               value 0.
       01 total-line-17.
           05 filler                        pic x(48)
               value "Return Transaction Records Total Store 3: ".
           05 ws-total-return-transaction-total-3    pic z9
               value 0.
       01 total-line-18.
           05 filler                        pic x(48)
               value "Return Transaction Records Total Store 4: ".
           05 ws-total-return-transaction-total-4    pic z9
               value 0.
       01 total-line-19.
           05 filler                        pic x(48)
               value "Return Transaction Records Total Store 5: ".
           05 ws-total-return-transaction-total-5    pic z9
               value 0.
       01 total-line-20.
           05 filler                        pic x(48)
               value "Return Transaction Records Total Store 12: ".
           05 ws-total-return-transaction-total-12    pic z9
               value 0.
       01 total-line-21.
           05 filler                        pic x(34)
               value "Return Transaction Total Store 1: ".
           05 ws-total-return-transaction-amount-1    pic $$,$$$,$$9.99
               value 0.
       01 total-line-22.
           05 filler                        pic x(34)
               value "Return Transaction Total Store 2: ".
           05 ws-total-return-transaction-amount-2    pic $$,$$$,$$9.99
               value 0.
       01 total-line-23.
           05 filler                        pic x(34)
               value "Return Transaction Total Store 3: ".
           05 ws-total-return-transaction-amount-3    pic $$,$$$,$$9.99
               value 0.
       01 total-line-24.
           05 filler                        pic x(34)
               value "Return Transaction Total Store 4: ".
           05 ws-total-return-transaction-amount-4    pic $$,$$$,$$9.99
               value 0.
       01 total-line-25.
           05 filler                        pic x(34)
               value "Return Transaction Total Store 5: ".
           05 ws-total-return-transaction-amount-5    pic $$,$$$,$$9.99
               value 0.
       01 total-line-26.
           05 filler                        pic x(34)
               value "Return Transaction Total Store 12: ".
           05 ws-total-return-transaction-amount-12    pic $$,$$$,$$9.99
               value 0.
       01 total-line-27.
           05 filler                        pic x(42)
               value "Total R: ".
           05 ws-total-r-total              pic 99
               value 0.
       01 total-line-28.
           05 filler                        pic x(32)
               value "Total R Amount: ".
           05 ws-total-r-amount-total              pic $$,$$$,$$9.99
               value 0.
       01 total-line-29.
           05 filler                        pic x(20)
               value "Grand Total Amount: ".
           05 ws-grand-total                pic $$,$$$,$$9.99
               value 0.
      ******************************************************************

       77 ws-sandl-record-count          pic 999
           value 0.
       77 ws-return-record-count        pic 999
           value 0.
       77 ws-s-record-count             pic 999
           value 0.
       77 ws-l-record-count             pic 999
           value 0.
       77 ws-total-record-count         pic 999
           value 0.
       77 ws-total-CR-count             pic 999
           value 0.
       77 ws-total-CA-count         pic 999
           value 0.
       77 ws-total-DB-count             pic 999
           value 0.
       77 ws-perc-cr-total              pic 999v9999
           value 0.
       77 ws-perc-ca-total              pic 999v9999
           value 0.
       77 ws-perc-db-total              pic 999v9999
           value 0.
      ******************************************************************
      ******************************************************************

       77 ws-total-transaction-ammount-s          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-l          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-sandl          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-r          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-1          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-2          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-3          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-4          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-5          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-12          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-1-r          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-2-r          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-3-r          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-4-r          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-5-r          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-12-r          pic 9(8)v99
       value 0.
       77 ws-total-transaction-count-1-r          pic 99
       value 0.
       77 ws-total-transaction-count-2-r          pic 99
       value 0.
       77 ws-total-transaction-count-3-r          pic 99
       value 0.
       77 ws-total-transaction-count-4-r          pic 99
       value 0.
       77 ws-total-transaction-count-5-r          pic 99
       value 0.
       77 ws-total-transaction-count-12-r          pic 99
       value 0.
      ******************************************************************

       procedure division.
              000-main.
      * Open files, initial read, output first headings
           open input  input-file, 
                output report-file,
                       return-file,
                       sandl-file.
           accept ws-nl-date from date.
           accept ws-nl-time from time.
       
      ******************************************************************
      ****************************************************************** 
      *
           read input-file 
               at end move "y" to ws-eof-flag.
      *
           
           perform 100-process-pages
               until   ws-eof-flag = 'y'.

                  perform 500-print-totals.
      *
      *
      *
      * Process data
      *
           close input-file,
             report-file,
                 return-file,
                 sandl-file.
                 
      *
           stop run.
      ******************************************************************
      ******************************************************************

       100-process-pages.

           add 1 to ws-total-record-count.
           if not input-valid-rcode then
               move input-line to sandl-line
                write sandl-line
               add 1 to ws-sandl-record-count
               if input-valid-lcode
                   add 1 to ws-l-record-count
                   add input-transaction-ammount to
                    ws-total-transaction-ammount-l
               else
                   add 1 to ws-s-record-count
                   add input-transaction-ammount to
                    ws-total-transaction-ammount-s
               end-if
                if input-store-number equals 01 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-1
                end-if
                if input-store-number equals 02 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-2
                end-if
                if input-store-number equals 03 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-3
                end-if
                if input-store-number equals 04 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-4
                end-if
                if input-store-number equals 05 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-5
                end-if
                if input-store-number equals 12 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-12
                end-if
                if input-valid-CA then
                    add 1 to ws-total-CA-count
                else if input-valid-CR
                 add 1 to ws-total-CR-count
                 else
                     add 1 to ws-total-DB-count
                end-if
                
                else
                    move input-line to return-line
                write return-line
                    add 1 to ws-return-record-count
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-r
                if input-store-number equals 01 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-1-r
                    add 1 to ws-total-transaction-count-1-r
                end-if
                if input-store-number equals 02 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-2-r
                    add 1 to ws-total-transaction-count-2-r
                end-if
                if input-store-number equals 03 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-3-r
                    add 1 to ws-total-transaction-count-3-r
                end-if
                if input-store-number equals 04 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-4-r
                    add 1 to ws-total-transaction-count-4-r
                end-if
                if input-store-number equals 05 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-5-r
                    add 1 to ws-total-transaction-count-5-r
                end-if
                if input-store-number equals 12 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-12-r
                    add 1 to ws-total-transaction-count-12-r
                end-if
                
           end-if.



            read input-file 
               at end move "y" to ws-eof-flag.


       500-print-totals.
           move ws-l-record-count to ws-total-l-total.
           move ws-sandl-record-count to ws-total-sl-total.
           move ws-s-record-count to ws-total-s-total.
           move ws-total-transaction-ammount-1 to 
           ws-total-transaction-total-1.
           move ws-total-transaction-ammount-2 to 
           ws-total-transaction-total-2.
           move ws-total-transaction-ammount-3 to 
           ws-total-transaction-total-3.
           move ws-total-transaction-ammount-4 to 
           ws-total-transaction-total-4.
           move ws-total-transaction-ammount-5 to 
           ws-total-transaction-total-5.
           move ws-total-transaction-ammount-12 to 
           ws-total-transaction-total-12.
      ******************************************************************

           compute ws-perc-cr-total rounded = ws-total-CR-count / 
           ws-total-sl-total.
           compute ws-perc-cr-total = ws-perc-cr-total * 100.
           move ws-perc-cr-total to ws-percentage-trans-cr-total.
           compute ws-perc-ca-total rounded = ws-total-CA-count / 
           ws-total-sl-total.
           compute ws-perc-ca-total = ws-perc-ca-total * 100.
           move ws-perc-ca-total to ws-percentage-trans-ca-total.
           compute ws-perc-db-total rounded = ws-total-DB-count / 
           ws-total-sl-total.
           compute ws-perc-db-total = ws-perc-db-total * 100.
           move ws-perc-db-total to ws-percentage-trans-db-total.
           move ws-return-record-count to ws-total-r-total.
           compute ws-total-transaction-ammount-sandl = 
           ws-total-transaction-ammount-l +
           ws-total-transaction-ammount-s.

      ******************************************************************
      * moving amounts and percentages to totals for display
      ******************************************************************

           move ws-total-transaction-ammount-sandl to 
           ws-total-sandl-amount-total.
           move ws-total-transaction-count-1-r to 
           ws-total-return-transaction-total-1.
           move ws-total-transaction-count-2-r to 
           ws-total-return-transaction-total-2.
           move ws-total-transaction-count-3-r to 
           ws-total-return-transaction-total-3.
           move ws-total-transaction-count-4-r to 
           ws-total-return-transaction-total-4.
           move ws-total-transaction-count-5-r to 
           ws-total-return-transaction-total-5.
           move ws-total-transaction-count-12-r to 
           ws-total-return-transaction-total-12.
      ******************************************************************

           move ws-total-transaction-ammount-1-r to 
           ws-total-return-transaction-amount-1.
           move ws-total-transaction-ammount-2-r to 
           ws-total-return-transaction-amount-2.
           move ws-total-transaction-ammount-3-r to 
           ws-total-return-transaction-amount-3.
           move ws-total-transaction-ammount-4-r to 
           ws-total-return-transaction-amount-4.
           move ws-total-transaction-ammount-5-r to 
           ws-total-return-transaction-amount-5.
           move ws-total-transaction-ammount-12-r to 
           ws-total-return-transaction-amount-12.
      ******************************************************************

           move ws-total-transaction-ammount-r to 
           ws-total-r-amount-total.
            move ws-total-transaction-ammount-s to 
           ws-total-s-amount-total.
            move ws-total-transaction-ammount-l to 
           ws-total-l-amount-total.
           compute ws-grand-total =
       ws-total-transaction-ammount-s
           + ws-total-transaction-ammount-l - 
           ws-total-transaction-ammount-r.
      ******************************************************************
      *  Writings of headings and First section
      ******************************************************************

           write report-line from ws-heading1-name-line.

           write report-line from ws-star-line
               after advancing 2 lines.
           write report-line from ws-report-title-6
           write report-line from ws-star-line.

           write report-line from ws-total-headings-1.
           write report-line from ws-total-headings-1-2.

           write report-line from total-line-4
           after advancing 1 line.
           write report-line from total-line-5.

           write report-line from total-line-6.

           write report-line from total-line-7.

           write report-line from total-line-8.

           write report-line from total-line-9.
      ******************************************************************
      *    section 2
      ******************************************************************
           write report-line from ws-star-line
               after advancing 1 line.
           write report-line from ws-report-title-4
           write report-line from ws-star-line.
           write report-line from ws-total-headings-2.
           write report-line from ws-total-headings-2-2.


          write report-line from total-line-21
          after advancing 1 line.
          write report-line from total-line-22.
           
           write report-line from total-line-23.
           write report-line from total-line-24.
           write report-line from total-line-25.

           write report-line from total-line-26.

           write report-line from ws-star-line.
           write report-line from ws-total-headings-3.
           write report-line from ws-total-headings-3-2.


           write report-line from total-line-15.
           write report-line from total-line-16.

           write report-line from total-line-17.

           write report-line from total-line-18.

           write report-line from total-line-19.

           write report-line from total-line-20.

      ******************************************************************
      *     section 3
      ******************************************************************
           write report-line from ws-star-line
               after advancing 1 line.
           write report-line from ws-report-title-2
           write report-line from ws-star-line.

           write report-line from ws-total-headings-4.
           write report-line from ws-total-headings-4-2.


           write report-line from total-line-12
           after advancing 1 line.
           
           write report-line from total-line-13.

           write report-line from total-line-14.
      ******************************************************************
      *     section 4
      ******************************************************************

           write report-line from ws-star-line
               after advancing 1 line.
           write report-line from ws-report-title
           write report-line from ws-star-line.

           write report-line from ws-total-headings-5.
           write report-line from ws-total-headings-5-2.


           write report-line from total-line-1
           after advancing 1 line.
 
           write report-line from total-line-2.

           write report-line from total-line-3.
           write report-line from total-line-27.
      ******************************************************************
      *     section 5
      ******************************************************************

           write report-line from ws-star-line
               after advancing 1 lines.
           write report-line from ws-report-title-3
           write report-line from ws-star-line.


           write report-line from ws-total-headings-6.
           write report-line from ws-total-headings-6-2.


           write report-line from total-line-10
               after advancing 1 line.
           write report-line from total-line-11.
           write report-line from total-line-30.
           write report-line from total-line-28.

      ******************************************************************
      *     section 6
      ******************************************************************

           write report-line from ws-star-line
               after advancing 1 line.
           write report-line from ws-report-title-5.
           write report-line from ws-star-line.
           write report-line from total-line-29.

      ******************************************************************
      *  End program
      ******************************************************************       

       end program Program2.