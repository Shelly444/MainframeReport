      ******************************************************************
      * Group 4 - Program #4
      * Tyler, Michelle & Dylon
      * 2019-04-13
      *-------------------------
      * This was alot similar to program 3 this time we are just 
      * printing the entire data records and formatting the raw data so
      * its easier to read aswell as display total transaction records
      * for the stores and the returns.
      ******************************************************************
       
       identification division.
       program-id. Program4.

       environment division.
       configuration section.
       file-control.
      ******************************************************************
      ******************************************************************
           
            select input-file
               assign to "../../../data/returns.dat"
               organization is line sequential.

           select report-file
               assign to "../../../data/returnsReport.out"
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
      ******************************************************************
      ******************************************************************

       fd report-file
           data record is report-line
           record contains 120 characters.
      *
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
               value "Group 4 - Final Project - #4".
      *               ----=----1----=----2----=---
           05 filler                     pic x(45)
               value spaces.
      ******************************************************************
      ******************************************************************

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
           05 filler                     pic x(2)
               value spaces.
           05 filler                     pic x(30)
               value "Returns Transaction per Store".
           05 filler                     pic x(7)
               value spaces.
           05 filler                     pic x(10)
               value "Amount".
           05 filler                     pic x(32)
               value spaces.

       01 ws-total-headings-1-2.
           05 filler                     pic x(33)
               value 
               "+-------------------------------+".
           05 filler                     pic x(4)
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

       01 ws-detail-headings-1.
           05 filler                     pic x(5)
               value 
               "Rec#".
           05 filler                     pic x(1)
               value spaces.
           05 filler                     pic x(8)
               value 
               "Amount".
           05 filler                     pic x(6)
               value 
               "P-Type".
           05 filler                     pic x(1)
               value spaces.
           05 filler                     pic x(6)
               value 
               "Store#".
           05 filler                     pic x(5)
               value spaces.
           
           05 filler                     pic x(10)
               value 
               "Inovice".
           05 filler                     pic x(4)
               value spaces.

           05 filler                     pic x(10)
               value 
               "Sku Number".

           05 filler                     pic x(11)
               value spaces.

           05 filler                     pic x(9)
               value 
               "Tax".
      ******************************************************************
      ******************************************************************



       01 ws-detail-headings-2.
           05 filler                     pic x(4)
               value 
               "+--+".
           05 filler                     pic x(2)
               value spaces.
           05 filler                     pic x(6)
               value 
               "+----+".
           05 filler                     pic x(3)
               value spaces.
           05 filler                     pic x(4)
               value 
               "+--+".
           05 filler                     pic x(3)
               value spaces.
           05 filler                     pic x(4)
               value 
               "+--+".
           05 filler                     pic x(5)
               value spaces.
           05 filler                     pic x(9)
               value 
               "+-------+".
           05 filler                     pic x(4)
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
           05 filler                     pic x.
           05 ws-prt-trans-code          pic x.
           05 filler                     pic x.
           05 ws-prt-trans-amount        pic $$,$$9.99.
           05 filler                     pic x(4)
               value spaces.
           05 ws-prt-payment-type        pic xx.
           05 filler                     pic x(5)
               value spaces.
           05 ws-prt-store-number        pic 99.
           05 filler                     pic x(6)
               value spaces.
           05 ws-prt-invoice-number      pic x(9).
           05 filler                     pic x(4)
               value spaces.
           05 ws-prt-sku-number          pic x(15).
           05 filler                     pic x(4)
               value spaces.
           05 ws-det-tax                 pic $$,$$9.99.
           05 filler                     pic x(40).
      ******************************************************************
      ******************************************************************


           01 total-line-15.
           05 filler                        pic x(49)
               value "Return Transaction Records Total Store 1: ".
           05 ws-total-return-transaction-total-1    pic z9
               value 0.
       01 total-line-16.
           05 filler                        pic x(49)
               value "Return Transaction Records Total Store 2: ".
           05 ws-total-return-transaction-total-2    pic z9
               value 0.
       01 total-line-17.
           05 filler                        pic x(49)
               value "Return Transaction Records Total Store 3: ".
           05 ws-total-return-transaction-total-3    pic z9
               value 0.
       01 total-line-18.
           05 filler                        pic x(49)
               value "Return Transaction Records Total Store 4: ".
           05 ws-total-return-transaction-total-4    pic z9
               value 0.
       01 total-line-19.
           05 filler                        pic x(49)
               value "Return Transaction Records Total Store 5: ".
           05 ws-total-return-transaction-total-5    pic z9
               value 0.
       01 total-line-20.
           05 filler                        pic x(49)
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
           05 filler                        pic x(39)
               value "Total R: ".
           05 ws-total-r-total              pic 99
               value 0.
       01 total-line-28.
           05 filler                        pic x(30)
               value "Total R Amount: ".
           05 ws-total-r-amount-total              pic $$,$$$,$$9.99
               value 0.
           01 total-line-29.
           05 filler                        pic x(30)
               value "Total Tax Amount: ".
           05 ws-det-total-tax              pic $$,$$$,$$9.99
               value 0.
      ******************************************************************
      ******************************************************************

       77 ws-return-record-count        pic 999
           value 0.
       77 ws-total-transaction-ammount-r          pic 9(8)v99
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

       77 ws-lines-per-page              pic 99 
           value 21.
       77 ws-page-count                  pic 99 
           value 0.
       77 ws-line-count                  pic 99 
           value 0.
        77 ws-tax-cnst              pic 9v99
           value 0.13.
       77 ws-tax-total              pic 9(8)v99
           value 0.
       77 ws-tax-temp              pic 9(8)v99
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
           write report-line from ws-star-line.
           write report-line from ws-detail-headings-1
               after advancing 1 line.
            write report-line from ws-detail-headings-2.
           perform 100-process-pages
               varying ws-page-count from 1 by 1
               until   ws-eof-flag = 'y'.
      *
           perform 500-print-totals.
      *
      ******************************************************************
      ******************************************************************
      *
      * Process data
      *
           close report-file, 
                 input-file.
      *
           stop run.

       100-process-pages.

            perform 300-main-logic
           varying ws-line-count from 1 by 1
                   until ws-line-count >= ws-lines-per-page 
                       or ws-eof-flag = 'y'.
               move 0 to ws-line-count.

       300-main-logic.
      ******************************************************************
      ******************************************************************


           add 1 to ws-return-record-count.
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-r.
                if input-store-number equals 01 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-1-r
                    add 1 to ws-total-transaction-count-1-r
                end-if.
                if input-store-number equals 02 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-2-r
                    add 1 to ws-total-transaction-count-2-r
                end-if.
                if input-store-number equals 03 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-3-r
                    add 1 to ws-total-transaction-count-3-r
                end-if.
                if input-store-number equals 04 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-4-r
                    add 1 to ws-total-transaction-count-4-r
                end-if.
                if input-store-number equals 05 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-5-r
                    add 1 to ws-total-transaction-count-5-r
                end-if.
                if input-store-number equals 12 then
                    add input-transaction-ammount to
                    ws-total-transaction-ammount-12-r
                    add 1 to ws-total-transaction-count-12-r
                end-if.


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

           move ws-total-transaction-ammount-r to 
           ws-total-r-amount-total.

           move ws-return-record-count to ws-total-r-total.

      ******************************************************************
      ******************************************************************


           move ws-tax-total to ws-det-total-tax.
           write report-line from ws-star-line.
           write report-line from ws-star-line.
           write report-line from ws-total-headings-3.
           write report-line from ws-total-headings-3-2.


           write report-line from total-line-15.

           write report-line from total-line-16.

           write report-line from total-line-17.

           write report-line from total-line-18.

           write report-line from total-line-19.

           write report-line from total-line-20.

           write report-line from ws-star-line.
           write report-line from ws-star-line.
           write report-line from ws-total-headings-1.
           write report-line from ws-total-headings-1-2.

           write report-line from total-line-21.

           write report-line from total-line-22.

           write report-line from total-line-23.

           write report-line from total-line-24.

           write report-line from total-line-25.

           write report-line from total-line-26.

           write report-line from ws-star-line.
           write report-line from ws-star-line.
           write report-line from ws-total-headings-6.
           write report-line from ws-total-headings-6-2.


           write report-line from total-line-27.

           write report-line from total-line-28.

           write report-line from total-line-29.

      ******************************************************************
      ******************************************************************

       end program Program4.