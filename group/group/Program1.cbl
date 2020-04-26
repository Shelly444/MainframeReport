      ******************************************************************
      * Group 4 - Program #1
      * Tyler, Michelle & Dylon
      * 2019-04-13
      *-------------------------
      * The purpose of this program is to take in a set of data records,
      * validate them to see wheather they are good / bad files. Also 
      * to see what type of error it is. Producing the ErrorReport, 
      * Valid / invalid files.
      ******************************************************************
       identification division.
       program-id. Program1.

       environment division.
       configuration section.
       file-control.
      ******************************************************************
      *
      ******************************************************************
      
            select input-file
               assign to "../../../data/project.dat"
               organization is line sequential.
            
           select valid-file
               assign to "../../../../project2/data/valid.dat"
               organization is line sequential.

           select invalid-file
               assign to "../../../data/invalid.dat"
               organization is line sequential.

           select report-file
               assign to "../../../data/errorReport.out"
               organization is line sequential.
      ******************************************************************
      *
      ******************************************************************
       data division.
       file section.
      * 
       fd input-file
           data record is input-line
           record contains 36 characters.
      *    
       01 input-line.
           05 input-transaction-code             pic x.
               88 input-valid-tcode value "S","L","R".
           05 input-transaction-ammount          pic 9(5)v99.
           05 input-payment-type                 pic xx.
               88 input-valid-type value "CA","CR","DB".
           05 input-store-number                 pic 99.
               88 input-valid-snumber value 1 thru 5,12.
           05 input-invoice-number.
               10 input-invoice-letters-1        pic x.
                   88 input-valid-letters-1 value "A" thru "E".
               10 input-invoice-letters-2        pic x.
                   88 input-valid-letters-2 value "A" thru "E".
               10 input-invoice-dash             pic x.
                   88 input-valid-dash value "-".
               10 input-invoice-numbers          pic 9(6).
                   88 input-valid-inumbers value 100000 thru 900000.
           05 input-sku-code                     pic x(15).

      ******************************************************************
      *
      ******************************************************************
       fd valid-file
           data record is valid-line
           record contains 36 characters.
      *     
       01 valid-line                        pic x(36).
       
       fd invalid-file
           data record is invalid-line
           record contains 36 characters.
      *      
       01 invalid-line                      pic x(36).

       fd report-file
           data record is report-line
           record contains 83 characters.
      *
       01 report-line                       pic x(85).
       working-storage section.
       01 ws-flags.
           05 ws-eof-flag                pic x
               value "n".
      ******************************************************************
      *
      ******************************************************************

       01 ws-total-1.
           05 filler                     pic x(9)
               value "Records: ".
           05 filler                     pic x(23)
               value spaces.
           05 records-tot                pic zz9
               value 0.

      * 
       01 ws-total-2.
           05 filler                     pic x(14)
               value "Good Records: ".
           05 filler                     pic x(18)
               value spaces.
           05 good-records-tot           pic zz9
               value 0.

       01 ws-total-3.
           05 filler                     pic x(21)
               value "Records With Errors: ".
           05 filler                     pic x(11)
               value spaces.
           05 error-records-tot          pic zz9
               value 0.

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
               value "            Final Project".
      *               ----=----1----=----2----=--
           05 filler                     pic x(43)
               value spaces.
      *
       01 ws-star-line.
           05 filler                     pic x(60)
               value 
       "************************************************************".
           05 filler                     pic x(23)
               value 
       "***********************".
       01 ws-heading-title.
           05 filler                     pic x(14)
               value spaces.
           05 filler                     pic x(12)
               value "ERROR REPORT".
           05 filler                     pic x(16)
               value spaces.
           05 filler                     pic x(12)
               value "Page Count: ".
           05 ws-pg-num                  pic z9.
           05 filler                     pic x(29)
               value spaces.
      *
       01 ws-detail-line.
           05 ws-rec-no                  pic zz9.
           05 filler                     pic x(4)
           value spaces.
           05 ws-prt-trans-code          pic x.
           05 filler                     pic x.
           05 ws-prt-trans-amount        pic 9(5)v99.
           05 filler                     pic x.
           05 ws-prt-payment-type        pic xx.
           05 filler                     pic x.
           05 ws-prt-store-number        pic 99.
           05 filler                     pic x.
           05 ws-prt-invoice-number      pic x(9).
           05 filler                     pic x.
           05 ws-prt-sku-number          pic x(15).
           05 filler                     pic x(4)            
               value spaces.
           05 ws-det-error-text          pic x(30).
           05 filler                     pic x(40).
           01 ws-detail-line-2.
           05 filler                     pic x(52).
           05 ws-det-error-text2         pic x(30).
           05 filler                     pic x(44).

       01 ws-column-headings-1.
           05 filler                     pic x(6)
               value "REC #".
           05 filler                     pic x(11)
               value spaces.
           05 filler                     pic x(22)
               value "RAW data (with spaces)".
           05 filler                     pic x(24)
               value spaces.
           05 filler                     pic x(10)
               value "Error Type".
           05 filler                     pic x(32)
               value spaces.

       01 ws-column-headings-2.
           05 filler                     pic x(6)
               value "+---+".
           05 filler                     pic x(1)
               value spaces. 
           05 filler                     pic x(41)
               value 
               "+---------------------------------------+".
           05 filler                     pic x(4)
               value spaces.
           05 filler                     pic x(30)
               value "+----------------------------+".
           05 filler                     pic x(1)
               value spaces.

       01 ws-grand-total-heading-1.
           05 filler                     pic x(6)
               value spaces. 
           05 filler                     pic x(1)
               value "G".
           05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "R".
           05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "A".
           05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "N".
            05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "D".
           05 filler                     pic x(6)
               value spaces. 
           05 filler                     pic x(1)
               value "T".
           05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "O".
           05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "T".
           05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "A".
           05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "L".
           05 filler                     pic x(2)
               value spaces. 
           05 filler                     pic x(1)
               value "S".


       01 ws-grand-total-heading-2.
           05 filler                     pic x(5)
               value spaces.
           05 filler                     pic x(10)
               value 
               "Total Type".
           05 filler                     pic x(13)
               value spaces.
           05 filler                     pic x(12)
               value "Total Amount".

       
       01 ws-grand-total-heading-3.
           05 filler                     pic x(20)
               value 
               "+------------------+".
           05 filler                     pic x(8)
               value spaces.
           05 filler                     pic x(12)
               value "+----------+".
           05 filler                     pic x(1)
               value spaces.
      ******************************************************************
      *
      ******************************************************************
       77 ws-lines-per-page              pic 99 
           value 11.
       77 ws-page-count                  pic 99 
           value 0.
       77 ws-line-count                  pic 99 
           value 0.
       77 ws-valid-record-count          pic 999
           value 0.
       77 ws-invalid-record-count        pic 999
           value 0.
       77 ws-error-text-1-cnst           pic x(30)
           value "*Transaction Code*            ".
       77 ws-error-text-2-cnst           pic x(30)
           value "*Amount Numeric*              ".
       77 ws-error-text-3-cnst           pic x(30)
           value "*Payment Type*                ".
       77 ws-error-text-4-cnst           pic x(30)
           value "*Store Number*                ".
       77 ws-error-text-5-cnst           pic x(30)
           value "*Invoice Number Format*       ".
       77 ws-error-text-6-cnst           pic x(30)
           value "*Invoice Alphabetic*          ".
       77 ws-error-text-7-cnst           pic x(30)
           value "*Invoice Alphabetic Duplicate*".
       77 ws-error-text-8-cnst           pic x(30)
           value "*Invoice Dash*                ".
       77 ws-error-text-9-cnst           pic x(30)
           value "*Invoice Range*               ".
       77 ws-error-text-10-cnst          pic x(30)
           value "*SKU Code*                    ".
      ******************************************************************
      *
      ******************************************************************

       01 ws-error-check.
           05 ws-error-1                    pic x
               value "N".
           05 ws-error-2                    pic x
               value "N".
           05 ws-error-3                    pic x
               value "N".
           05 ws-error-4                    pic x
               value "N".
           05 ws-error-5                    pic x
               value "N".
           05 ws-error-6                    pic x
               value "N".
           05 ws-error-7                    pic x
               value "N".
           05 ws-error-8                    pic x
               value "N".
           05 ws-error-9                    pic x
               value "N".
           05 ws-error-10                    pic x
               value "N".
      *
           77 ws-is-error                   pic x
               value "N".
           77 ws-first-error                pic x
               value "Y".
           77 ws-rec-num                    pic 999
               value 0.
           01 ws-boolean-cnst.
           05 ws-true-cnst                  pic x
               value "Y".
           05 ws-false-cnst                 pic x
               value "N".
      ******************************************************************
      *
      ******************************************************************
       procedure division.
       000-main.
      * Open files, initial read, output first headings
           open input  input-file, 
                output report-file,
                       valid-file,
                       invalid-file.
           accept ws-nl-date from date.
           accept ws-nl-time from time.
      *
           read input-file 
               at end move "y" to ws-eof-flag.
      *
           
           perform 100-process-pages
               varying ws-page-count from 1 by 1
               until   ws-eof-flag = 'y'.
      *
           perform 500-print-totals.
      ******************************************************************
      *
      ******************************************************************
           close report-file, 
                 input-file,
                 valid-file,
                 invalid-file.
      *
           stop run.
       100-process-pages.
      *
               perform 200-print-headings.
      *
               perform 300-main-logic 
                   until ws-line-count >= ws-lines-per-page 
                       or ws-eof-flag = 'y'.
               move 0 to ws-line-count.
      ******************************************************************
      *
      ******************************************************************
       200-print-headings.
           move spaces                   to ws-detail-line.
      *
           if ws-page-count = 0 then
               
               
               add 1 to ws-page-count
               move ws-page-count to ws-pg-num
               
           end-if.
           if ws-page-count = 1 then
               
               
              write report-line from ws-heading1-name-line
               after advancing 1 line
               
           end-if.
      *
           if ws-page-count >= 1 then
               
               write report-line from ws-star-line
                   after advancing 1 line
               move ws-page-count to ws-pg-num
               write report-line from ws-heading-title
                   after advancing 1 line
               write report-line from ws-star-line
                   after advancing 1 line
               write report-line from ws-column-headings-1
                   after advancing 2 lines
               write report-line from ws-column-headings-2
                   after advancing 1 lines
               move spaces               to report-line
               write report-line 
                   after page
               
               move ws-page-count to ws-pg-num
              
           end-if.

      ******************************************************************
      *
      ******************************************************************

       300-main-logic.
           add 1 to ws-rec-num.
       if not input-valid-tcode then
           move ws-true-cnst            to ws-error-1
           move ws-true-cnst            to ws-is-error
       end-if.

       if not input-transaction-ammount is numeric then
          move ws-true-cnst            to ws-error-2
          move ws-true-cnst            to ws-is-error
       end-if.
       
       if not input-valid-type then
           move ws-true-cnst            to ws-error-3
           move ws-true-cnst            to ws-is-error
       end-if.
       
       if not input-valid-snumber then
           move ws-true-cnst            to ws-error-4
           move ws-true-cnst            to ws-is-error
       end-if.
      ******************************************************************
      *
      ******************************************************************
       if input-invoice-letters-1 is not alphabetic or 
       input-invoice-letters-2 is not alphabetic or 
       input-invoice-numbers is not numeric then
           move ws-true-cnst            to ws-error-5
           move ws-true-cnst            to ws-is-error
       end-if.
       if not input-valid-letters-1 or not input-valid-letters-2 then
           move ws-true-cnst            to ws-error-6
           move ws-true-cnst            to ws-is-error
       end-if.
       if input-invoice-letters-1 equals input-invoice-letters-2 then
           move ws-true-cnst            to ws-error-7
           move ws-true-cnst            to ws-is-error
       end-if.
       if not input-valid-dash then
           move ws-true-cnst            to ws-error-8
           move ws-true-cnst            to ws-is-error
       end-if.
       if not input-valid-inumbers then
           move ws-true-cnst            to ws-error-9
           move ws-true-cnst            to ws-is-error
       end-if.
       if input-sku-code equals spaces then
           move ws-true-cnst            to ws-error-10
           move ws-true-cnst            to ws-is-error
       end-if.
      ******************************************************************
      *
      ******************************************************************
           if ws-is-error equals ws-true-cnst
               add 1 to ws-invalid-record-count
               perform 400-output-errors
           else
               move input-line to valid-line
               write valid-line
               add 1 to ws-valid-record-count
           end-if.
      *Read next record
      *
           read input-file 
               at end move "y" to ws-eof-flag.
      ******************************************************************
      * Output
      ******************************************************************
       400-output-errors.
      *
       move input-transaction-code to ws-prt-trans-code.
       move input-transaction-ammount to ws-prt-trans-amount.
       move input-store-number to ws-prt-store-number.
       move input-payment-type to ws-prt-payment-type.
       move input-invoice-number to ws-prt-invoice-number.
       move input-sku-code to ws-prt-sku-number.
       move input-line to invalid-line.
       write invalid-line.
       move ws-rec-num to ws-rec-no.
          
      ******************************************************************
      * If chain checking to see if and what errors apply to each record
      ******************************************************************
       if ws-error-1 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-1-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           end-if
       end-if.
       if ws-error-2 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-2-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-2-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
       if ws-error-3 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-3-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-3-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
       if ws-error-4 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-4-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-4-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
       if ws-error-5 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-5-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-5-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
       if ws-error-6 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-6-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-6-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
       if ws-error-7 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-7-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-7-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
       if ws-error-8 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-8-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-8-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
       if ws-error-9 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-9-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-9-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
       if ws-error-10 equals ws-true-cnst
           if ws-first-error equals ws-true-cnst
               move ws-false-cnst to ws-first-error
               move ws-error-text-10-cnst to ws-det-error-text
               move ws-detail-line to report-line
               write report-line
           else
               move ws-error-text-10-cnst to ws-det-error-text2
               move ws-detail-line-2 to report-line
               write report-line
           end-if
       end-if.
      ******************************************************************
      * Reset all error calculation value variables
      ******************************************************************
           move ws-true-cnst to ws-first-error.
           move ws-false-cnst to ws-is-error.
           move ws-false-cnst to ws-error-1.
           move ws-false-cnst to ws-error-2.
           move ws-false-cnst to ws-error-3.
           move ws-false-cnst to ws-error-4.
           move ws-false-cnst to ws-error-5.
           move ws-false-cnst to ws-error-6.
           move ws-false-cnst to ws-error-7.
           move ws-false-cnst to ws-error-8.
           move ws-false-cnst to ws-error-9.
           move ws-false-cnst to ws-error-10.
           add 1 to ws-line-count.
      ******************************************************************
      * 500-print-totals Holds the totals headings aswell as writes them
      ****************************************************************** 
       500-print-totals.
           write report-line from ws-star-line
                   after advancing 1 line
           write report-line from ws-grand-total-heading-1
                   after advancing 1 line
           write report-line from ws-star-line
                   after advancing 1 line
           write report-line from ws-grand-total-heading-2
                   after advancing 2 lines
           write report-line from ws-grand-total-heading-3
                   after advancing 1 lines
      ******************************************************************
      * Moving totals data to the disiplay varaibles and output at end.
      ******************************************************************
           move ws-rec-num to records-tot.
           move ws-valid-record-count to good-records-tot.
           move ws-invalid-record-count to error-records-tot.
           move spaces to report-line.
           write report-line.
           move ws-total-1 to report-line.
           write report-line.
           move ws-total-2 to report-line.
           write report-line.
           move ws-total-3 to report-line.
           write report-line.
      ******************************************************************
      * End of Group 4 - Program #1
      ******************************************************************
       end program Program1.