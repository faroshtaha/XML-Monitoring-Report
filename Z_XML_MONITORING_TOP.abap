*&---------------------------------------------------------------------*
*&  Include           Z_XML_MONITORING_TOP
*&---------------------------------------------------------------------*

TABLES: zxml_monitor_con.

*----------------------------------------------------------------------*
*       CLASS lcl_report DEFINITION
*----------------------------------------------------------------------*
*  This class is responsible for fetching, formatting and presenting,
*  the data
*----------------------------------------------------------------------*
CLASS lcl_report DEFINITION FINAL.
  PUBLIC SECTION.
    TYPES: BEGIN OF type_msg,
             idd TYPE zxml_monitor_con-idd.
            INCLUDE TYPE sxmsmsglst.
    TYPES: END OF type_msg,
           BEGIN OF type_msgstat,
             msgstate TYPE sxmspmstat,
             icon_id  TYPE sxms_stast_icon,
           END OF type_msgstat,

           BEGIN OF type_output,
             stats     TYPE icon_d,
             track     TYPE ztrack,
             idd       TYPE zxml_monitor_con-idd,
             doc_no    TYPE char15,
             msgguid   TYPE sxmsmguid,
             date      TYPE sy-datum,
             time      TYPE sy-uzeit,
             ob_ns     TYPE rm_oifns,
             ob_name   TYPE rm_oifname,
             ib_ns     TYPE rm_iifns,
             ib_name   TYPE rm_iifname,
             errcat	   TYPE sxmserrcat,
             errcode   TYPE sxmserrid,
             errlabel  TYPE sxmserrlabeltxt,
           END OF type_output,
           BEGIN OF type_email_body,
             track TYPE ztrack,
             idd   TYPE zidd_number,
             count TYPE i,
           END OF type_email_body.

    TYPES: type_msg_tt TYPE STANDARD TABLE OF type_msg WITH NON-UNIQUE KEY idd.

    DATA: o_alv TYPE REF TO cl_salv_table.

    METHODS: constructor,

             prepare_data,

             init_alv,

             prepare_out_table,

             adjust_alv,

             on_single_click
               FOR EVENT link_click OF cl_salv_events_table
                 IMPORTING row column,

             send_email,

             prepare_mail_body
               RETURNING value(rt_mailtxt) TYPE soli_tab.

  PRIVATE SECTION.

    DATA: t_message_ids TYPE STANDARD TABLE OF type_msg,
          t_msgstat     TYPE STANDARD TABLE OF type_msgstat,
          t_email_body  TYPE STANDARD TABLE OF type_email_body,
          t_output      TYPE STANDARD TABLE OF type_output,
          w_filter      TYPE sxi_msg_select.

    METHODS: fetch_message_id
               IMPORTING iv_idd   TYPE zxml_monitor_con-idd
                         iv_doctx TYPE zxml_monitor_con-field
                         it_val   TYPE rseloption
               RETURNING value(rt_message_ids) TYPE type_msg_tt ,

             get_sap_doc_number
               IMPORTING iw_message_id TYPE type_msg
               RETURNING value(rv_doc_no) TYPE char15.

ENDCLASS.                    "lcl_report DEFINITION

*----------------------------------------------------------------------*
*       CLASS lcl_main DEFINITION
*----------------------------------------------------------------------*
*  This is a singleton class which will act as the driver class. This
*  will orchestrate the program
*----------------------------------------------------------------------*
CLASS lcl_main DEFINITION
               FINAL
               CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-DATA: o_driver TYPE REF TO lcl_main READ-ONLY.
    CLASS-METHODS: instantiate RETURNING value(rv_instance) TYPE REF TO lcl_main.
    METHODS: main_method,
             check_authority.
  PRIVATE SECTION.
    DATA: o_report TYPE REF TO lcl_report.
ENDCLASS.                    "lcl_main DEFINITION

DATA: t_zxml_monitor_con_main TYPE STANDARD TABLE OF zxml_monitor_con,
      t_zxml_monitor_con_temp TYPE STANDARD TABLE OF zxml_monitor_con,
      w_opt_list              TYPE sscr_opt_list,
      w_sel                   TYPE sscr_ass,
      w_restrict              TYPE sscr_restrict,
      w_zxml_monitor_con      TYPE zxml_monitor_con,
      v_val                   TYPE char10,
      v_email                 TYPE adr6-smtp_addr,
      v_idd                   TYPE ZIDD_NUMBER.

DATA: o_main TYPE REF TO lcl_main.
