      ******************************************************************
      * Group 4 - Program #3
      * Tyler, Michelle & Dylon
      * 2019-04-13
      *-------------------------
      * The purpose of this program is to take in a set of data records,
      * validate them to see the loss and sales totals fora  set of 
      * stores, aswell as calculate total amounts and loss with 
      * transactions and type records.
      ******************************************************************


       identification division.
       program-id. Program3.

       environment division.
       configuration section.
       file-control.
           
            select input-file
               assign to "../../../data/sandl.dat"
               organization is line sequential.

           select report-file
               assign to "../../../data/salesReport.out"
               organization is line sequential.

       data division.
       file section.

       fd input-file
           data record is input-line
           record contains 36 characters.
      ******************************************************************
      ******************************************************************

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

       fd report-file
           data record is report-line
           record contains 120 characters.
      ******************************************************************
      ******************************************************************
      
       01 report-line                       pic x(120).

       working-storage section.
       01 ws-flags.
           05 ws-eof-flag                pic x
               value "n".
       01 ws-heading1-name-line.
           05 filler                     pic x(5)
               value spaces.
           05 ws-nl-date                 pic 9(6).
           05 filler                     pic x(5)
               value spaces.
           05 ws-nl-time                 pic 9(8).
           05 filler                     pic x(23)
               value spaces.
           05 filler                     pic x(40)
               value "Group 4 - Final Project - #3".
      *               ----=----1----=----2----=---
           05 filler                     pic x(45)
               value spaces.

       01 ws-star-line.
           05 filler                     pic x(60)
               value 
       "************************************************************".
           05 filler                     pic x(23)
               value 
       "***********************".

       01 ws-report-title.
           05 filler                     pic x(17)
               value spaces.
           05 filler                     pic x(32)
               value "Record Totals Report".
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



       01 ws-total-headings-3.
           05 filler                     pic x(3)
               value spaces.
           05 filler                     pic x(32)
               value "Return Transaction Records Total".
           05 filler                     pic x(13)
               value spaces.
           05 filler                     pic x(9)
               value "REC#".
           05 filler                     pic x(32)
               value spaces.

       01 ws-total-headings-3-2.
           05 filler                     pic x(48)
               value 
               "+----------------------------------------------+".
           05 filler                     pic x(1)
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
           05 filler                     pic x(22)
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
      ******************************************************************
      ******************************************************************

       01 ws-detail-headings-1.
           05 filler                     pic x(1)
               value spaces.

           05 filler                     pic x(9)
               value 
               "Trans-Rec".
           05 filler                     pic x(2)
               value spaces.
           05 filler                     pic x(8)
               value 
               "Amount".
           05 filler                     pic x(3)
               value spaces.
           05 filler                     pic x(6)
               value 
               "P-Type".
           05 filler                     pic x(3)
               value spaces.
           05 filler                     pic x(1)
               value 
               "%".
           05 filler                     pic x(7)
               value spaces.
           05 filler                     pic x(7)
               value 
               "Store #".
           05 filler                     pic x(9)
               value spaces.
           
           05 filler                     pic x(10)
               value 
               "Sku Number".
           05 filler                     pic x(11)
               value spaces.

           05 filler                     pic x(9)
               value 
               "Tax".


       01 ws-detail-headings-2.
           05 filler                     pic x(3)
               value spaces.

           05 filler                     pic x(5)
               value 
               "+---+".
           05 filler                     pic x(2)
               value spaces.
           05 filler                     pic x(10)
               value 
               "+--------+".
           05 filler                     pic x(4)
               value spaces.
           05 filler                     pic x(4)
               value 
               "+--+".
           05 filler                     pic x(3)
               value spaces.
           05 filler                     pic x(4)
               value 
               "+--+".
           05 filler                     pic x(4)
               value spaces.
           05 filler                     pic x(9)
               value 
               "+-------+".
           05 filler                     pic x(5)
               value spaces.
           
           05 filler                     pic x(15)
               value 
               "+-------------+".
           05 filler                     pic x(6)
               value spaces.

           05 filler                     pic x(9)
               value 
               "+------+".
 
      ******************************************************************
      ******************************************************************

           01 ws-detail-line.
           05 filler                     pic x(5)
               value spaces.
           05 ws-prt-trans-code          pic x.
           05 filler                     pic x(5)
               value spaces.
           05 ws-prt-trans-amount        pic $$,$$9.99.
           05 filler                     pic x(5)
               value spaces.
           05 ws-prt-payment-type        pic xx.
           05 filler                     pic x(5)
               value spaces.
           05 ws-prt-store-number        pic 99.
           05 filler                     pic x(5)
               value spaces.
           05 ws-prt-invoice-number      pic x(9).
           05 filler                     pic x(5)
               value spaces.
           05 ws-prt-sku-number          pic x(15).
           05 filler                     pic x(5)
               value spaces.
           05 ws-det-tax                 pic $$,$$9.99.
           05 filler                     pic x(5)
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
           05 filler                        pic x(33)
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
           05 filler                        pic x(32)
               value "Total Tax Amount: ".
           05 ws-det-total-tax              pic $$,$$$,$$9.99
               value 0.
       01 total-line-16.
           05 filler                        pic x(49)
               value 
               "Store Number With The Lowest Transaction Total: ".
           05 ws-det-low-store              pic z9
               value 0.
       01 total-line-17.
           05 filler                        pic x(50)
               value 
               "Store Number With The Highest Transaction Total: ".
           05 ws-det-high-store              pic z9
               value 0.
       01 total-line-30.
           05 filler                        pic x(32)
               value "Total S & L Amount: ".
           05 ws-total-sandl-amount-total           pic $$,$$$,$$9.99
               value 0.
      ******************************************************************
      ******************************************************************


       77 ws-lines-per-page              pic 99 
           value 21.
       77 ws-page-count                  pic 99 
           value 0.
       77 ws-line-count                  pic 99 
           value 0.
       77 ws-s-record-count             pic 999
           value 0.
       77 ws-l-record-count             pic 999
           value 0.
       77 ws-sandl-record-count          pic 999
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
       77 ws-total-transaction-ammount-s          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-l          pic 9(8)v99
       value 0.
       77 ws-total-transaction-ammount-sandl          pic 9(8)v99
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
       77 ws-tax-cnst              pic 9v99
           value 0.13.
       77 ws-tax-total              pic 9(8)v99
           value 0.
       77 ws-tax-temp              pic 9(8)v99
           value 0.
       77 ws-store-totals occurs 6 times pic 9(8)v99.
       77 ws-count                 pic 9
       value 0.
       77 ws-num-of-stores-cnst                 pic 9
       value 6.
       77 ws-lowest-transaction-total              pic 9(8)v99
           value 99999999.99.
       77 ws-lowest-transaction-total-store              pic 99
           value 0.
       77 ws-highest-transaction-total              pic 9(8)v99
           value 0.
       77 ws-highest-transaction-total-store              pic 99
           value 0.
      ******************************************************************
      ******************************************************************

       procedure division.
       000-main.
      * Open files, initial read, output first headings
           open input  input-file, 
                output report-file.
           accept ws-nl-date from date.
           accept ws-nl-time from time.
      *
           read input-file 
               at end move "y" to ws-eof-flag.
      *
           write report-line from ws-heading1-name-line
               after advancing 1 line.
           perform 100-process-pages
               varying ws-page-count from 1 by 1
               until   ws-eof-flag = 'y'.
      ******************************************************************
      ******************************************************************
      *
           perform 500-print-totals.
      *
      *
      * Process data
      *
           close report-file, 
                 input-file.
      *
           stop run.
      ******************************************************************
      ******************************************************************

       100-process-pages.
           perform 200-print-headings.
      *
               perform 300-main-logic 
               varying ws-line-count from 1 by 1
                   until ws-line-count >= ws-lines-per-page 
                       or ws-eof-flag = 'y'.
               move 0 to ws-line-count.
      ******************************************************************
      ******************************************************************
            
       200-print-headings.
           write report-line from ws-star-line
               after advancing 1 line.
            write report-line from ws-detail-headings-1.
           write report-line from ws-detail-headings-2.
       300-main-logic.
      ******************************************************************
      ******************************************************************


            add 1 to ws-sandl-record-count.
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
                end-if.
      ******************************************************************
      ******************************************************************

           compute ws-tax-temp = input-transaction-ammount * 
           ws-tax-cnst.
           add ws-tax-temp to ws-tax-total.
           move ws-tax-temp to ws-det-tax.

           move input-transaction-code to ws-prt-trans-code.
           move input-transaction-ammount to ws-prt-trans-amount.
           move input-store-number to ws-prt-store-number.
           move input-payment-type to ws-prt-payment-type.
           move input-invoice-number to ws-prt-invoice-number.
           move input-sku-code to ws-prt-sku-number.
       
           write report-line from ws-detail-line.
           read input-file 
               at end move "y" to ws-eof-flag.

      ******************************************************************
      ******************************************************************

       500-print-totals.
           compute ws-total-transaction-ammount-sandl = 
           ws-total-transaction-ammount-l +
           ws-total-transaction-ammount-s.
           move ws-total-transaction-ammount-sandl to 
           ws-total-sandl-amount-total.
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
           move ws-total-transaction-ammount-s to 
           ws-total-s-amount-total.
            move ws-total-transaction-ammount-l to 
           ws-total-l-amount-total.

           move ws-tax-total to ws-det-total-tax.

      ******************************************************************
      ******************************************************************

           move ws-total-transaction-ammount-1 to 
           ws-store-totals(1).
           move ws-total-transaction-ammount-2 to 
           ws-store-totals(2).
           move ws-total-transaction-ammount-3 to 
           ws-store-totals(3).
           move ws-total-transaction-ammount-4 to 
           ws-store-totals(4).
           move ws-total-transaction-ammount-5 to 
          ws-store-totals(5).
           move ws-total-transaction-ammount-12 to 
           ws-store-totals(6).
      ******************************************************************
      ******************************************************************

            perform
           varying ws-count
           from 1 by 1
           until ws-count > ws-num-of-stores-cnst
                
           if ws-lowest-transaction-total > ws-store-totals(ws-count)    
           then
               move ws-store-totals(ws-count) to 
               ws-lowest-transaction-total
               move ws-count to ws-lowest-transaction-total-store
               if ws-count equals 6 then
               move 12 to ws-lowest-transaction-total-store
           end-if
               
           end-if

           if ws-highest-transaction-total < ws-store-totals(ws-count)  
           then
               move ws-store-totals(ws-count) to 
               ws-highest-transaction-total
               move ws-count to ws-highest-transaction-total-store
               if ws-count equals 6 then
               move 12 to ws-highest-transaction-total-store
           end-if
               
           end-if

            end-perform.
      ******************************************************************
      ******************************************************************
          
           move ws-highest-transaction-total-store to ws-det-high-store.
           
           move ws-lowest-transaction-total-store to ws-det-low-store.

           write report-line from ws-star-line.
           write report-line from ws-star-line.
           write report-line from ws-total-headings-5.
           write report-line from ws-total-headings-5-2
               after advancing 1  line.
           
           write report-line from total-line-1.

           write report-line from total-line-2.

           write report-line from total-line-3.

           write report-line from ws-star-line.
           write report-line from ws-star-line.
           write report-line from ws-total-headings-1.
           write report-line from ws-total-headings-1-2.
           write report-line from total-line-5
               after advancing 1 line.

           write report-line from total-line-4.

           write report-line from total-line-6.

           write report-line from total-line-7.

           write report-line from total-line-8.



           write report-line from total-line-9.
           
           write report-line from ws-star-line.
           write report-line from ws-star-line.

           write report-line from ws-total-headings-3.
           write report-line from ws-total-headings-3-2.
           
           write report-line from total-line-16.

           write report-line from total-line-17.

           write report-line from ws-star-line.
           write report-line from ws-star-line.

           write report-line from ws-total-headings-6.
           write report-line from ws-total-headings-6-2.
          

           write report-line from total-line-10.


           write report-line from total-line-11.

          write report-line from total-line-30.

           write report-line from ws-star-line.
           write report-line from ws-star-line.

           write report-line from ws-total-headings-4.
           write report-line from ws-total-headings-4-2.


           write report-line from total-line-12.

           write report-line from total-line-13.

           write report-line from total-line-14.

           write report-line from ws-star-line.
           write report-line from ws-star-line.


           write report-line from total-line-15.

      ******************************************************************
      ******************************************************************

       
       end program Program3.