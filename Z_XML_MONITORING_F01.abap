*&---------------------------------------------------------------------*
*&  Include           Z_XML_MONITORING_IMP
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*       CLASS lcl_main IMPLEMENTATION
*----------------------------------------------------------------------*
*  This is a singleton class which will act as the driver class. This
*  will orchestrate the program
*----------------------------------------------------------------------*
CLASS lcl_main IMPLEMENTATION.
  METHOD instantiate.
    IF o_driver IS INITIAL.
      CREATE OBJECT o_driver.
    ENDIF.
    rv_instance = o_driver.
  ENDMETHOD.                    "instantiate

  METHOD main_method.
    CREATE OBJECT me->o_report.
    me->o_report->prepare_data( ).
    me->o_report->prepare_out_table( ).
    me->o_report->init_alv( ).
    IF p_mailsn EQ abap_true.
      me->o_report->send_email( ).
    ENDIF.
    me->o_report->o_alv->display( ).
  ENDMETHOD.                    "main_method

  METHOD check_authority.
  ENDMETHOD.                    "check_authority
ENDCLASS.                    "lcl_main IMPLEMENTATION

*----------------------------------------------------------------------*
*       CLASS lcl_report IMPLEMENTATION
*----------------------------------------------------------------------*
*  This class is responsible for fetching, formatting and presenting,
*  the data
*----------------------------------------------------------------------*
CLASS lcl_report IMPLEMENTATION.
  METHOD constructor.
    SELECT  msgstate
            icon_id
            FROM sxmsmstat
            INTO TABLE me->t_msgstat.
  ENDMETHOD.                    "constructor

  METHOD prepare_data.
    DATA: lt_attribute   TYPE sxmsdata_tupel_tab,
          lt_val         TYPE rseloption,
          lt_message_ids TYPE sxmsmsgtab.

    DATA: lw_filter      TYPE sxi_msg_select,
          lw_attribute   TYPE sxmsdata_tupel,
          lw_val         LIKE LINE OF s_val1,
          lw_idd         LIKE LINE OF s_idd,
          lw_email_body  TYPE me->type_email_body.

    lw_filter-exedate = p_frmdt.
    lw_filter-exetime = p_frmtm.
    lw_filter-exe2date = p_to_dt.
    lw_filter-exe2time = p_to_tm.

    IF p_doc1tx IS NOT INITIAL.
      lt_val[] = s_val1[].
      CLEAR: lw_email_body.
      APPEND LINES OF fetch_message_id( iv_idd = p_idd1
                                        iv_doctx = p_doc1tx
                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_doc2tx IS NOT INITIAL.
      lt_val[] = s_val2[].
      CLEAR: lw_email_body.
      APPEND LINES OF fetch_message_id( iv_idd = p_idd2
                                        iv_doctx = p_doc2tx
                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_doc3tx IS NOT INITIAL.
      lt_val[] = s_val3[].
*      APPEND LINES OF fetch_message_id( iv_idd = p_idd3
*                                        iv_doctx = p_doc3tx
*                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_doc4tx IS NOT INITIAL.
      lt_val[] = s_val4[].
*      APPEND LINES OF fetch_message_id( iv_idd = p_idd4
*                                        iv_doctx = p_doc4tx
*                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_doc5tx IS NOT INITIAL.
      lt_val[] = s_val5[].
*      APPEND LINES OF fetch_message_id( iv_idd = p_idd5
*                                        iv_doctx = p_doc5tx
*                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_doc6tx IS NOT INITIAL.
      lt_val[] = s_val6[].
*      APPEND LINES OF fetch_message_id( iv_idd = p_idd6
*                                        iv_doctx = p_doc6tx
*                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_doc7tx IS NOT INITIAL.
      lt_val[] = s_val7[].
*      APPEND LINES OF fetch_message_id( iv_idd = p_idd7
*                                        iv_doctx = p_doc7tx
*                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_doc8tx IS NOT INITIAL.
      lt_val[] = s_val8[].
*      APPEND LINES OF fetch_message_id( iv_idd = p_idd8
*                                        iv_doctx = p_doc8tx
*                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_doc9tx IS NOT INITIAL.
      lt_val[] = s_val9[].
*      APPEND LINES OF fetch_message_id( iv_idd = p_idd9
*                                        iv_doctx = p_doc9tx
*                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    IF p_docxtx IS NOT INITIAL.
      lt_val[] = s_val10[].
*      APPEND LINES OF fetch_message_id( iv_idd = p_iddx
*                                        iv_doctx = p_docxtx
*                                        it_val = lt_val ) TO me->t_message_ids.
    ENDIF.

    SORT me->t_message_ids BY msgguid.
    DELETE ADJACENT DUPLICATES FROM me->t_message_ids COMPARING msgguid.
  ENDMETHOD.                    "prepare_data

  METHOD fetch_message_id.
    DATA: lt_attribute      TYPE sxmsdata_tupel_tab,
          lt_message_id     TYPE sxmsmsgtab.

    DATA: lw_val            LIKE LINE OF it_val,
          lw_message_id     LIKE LINE OF lt_message_id,
          lw_message_id_ret TYPE me->type_msg,
          lw_filter         TYPE sxi_msg_select,
          lw_attribute      TYPE sxmsdata_tupel,
          lw_email_body     TYPE me->type_email_body.

    DATA: lv_count TYPE i.

    lw_filter-exedate = p_frmdt.
    lw_filter-exetime = p_frmtm.
    lw_filter-exe2date = p_to_dt.
    lw_filter-exe2time = p_to_tm.
    LOOP AT it_val INTO lw_val.
      lw_attribute-name = iv_doctx.
      lw_attribute-value = lw_val-low.
      APPEND lw_attribute TO lt_attribute.
      lw_filter-extr_data[] = lt_attribute[].
      CALL FUNCTION 'SXMB_SELECT_MESSAGES_NEW'
        EXPORTING
          im_filter           = lw_filter
          im_number           = 200
        IMPORTING
          ex_msgtab           = lt_message_id
        EXCEPTIONS
          persist_error       = 1
          missing_parameter   = 2
          negative_time_range = 3
          too_many_parameters = 4
          no_timezone         = 5
          OTHERS              = 6.
      IF sy-subrc <> 0.
* Implement suitable error handling here
      ENDIF.

      LOOP AT lt_message_id INTO lw_message_id.
        MOVE-CORRESPONDING lw_message_id TO lw_message_id_ret.
        lw_message_id_ret-idd = iv_idd.
        APPEND lw_message_id_ret TO rt_message_ids.
      ENDLOOP.
      CLEAR: lt_message_id, lt_attribute, lw_attribute, lw_filter-extr_data.
    ENDLOOP.
    IF rt_message_ids IS NOT INITIAL.
      DESCRIBE TABLE rt_message_ids LINES lv_count.
      lw_email_body-count = lv_count.
      lw_email_body-idd = iv_idd.
      lw_email_body-track = p_track.
      APPEND lw_email_body TO me->t_email_body.
    ENDIF.
  ENDMETHOD.                    "fetch_message_id

  METHOD prepare_out_table.
    DATA: lw_output     TYPE me->type_output,
          lw_message_id LIKE LINE OF me->t_message_ids,
          lw_msgstat    TYPE me->type_msgstat.

    CONSTANTS: lc_nozone  TYPE systzonlo  VALUE space,
               lc_success TYPE sxmspmstat VALUE '103'.

    IF p_error EQ abap_true.
      DELETE me->t_message_ids WHERE msgstate EQ lc_success.
    ELSEIF p_pass EQ abap_true.
      DELETE me->t_message_ids WHERE msgstate NE lc_success.
    ENDIF.

    LOOP AT me->t_message_ids INTO lw_message_id.
      MOVE-CORRESPONDING: lw_message_id TO lw_output.
      lw_output-track = p_track.
      READ TABLE me->t_msgstat INTO lw_msgstat
        WITH KEY msgstate = lw_message_id-msgstate.
      IF sy-subrc IS INITIAL.
        lw_output-stats = lw_msgstat-icon_id.
      ENDIF.
      CONVERT TIME STAMP lw_message_id-inittimest
        TIME ZONE sy-zonlo
        INTO DATE lw_output-date
        TIME lw_output-time.

      lw_output-doc_no = get_sap_doc_number( iw_message_id  = lw_message_id ).
      APPEND lw_output TO me->t_output.
    ENDLOOP.
  ENDMETHOD.                    "prepare_out_table

  METHOD get_sap_doc_number.
    DATA: lo_appl_log TYPE REF TO cl_xms_appl_log,
          lo_extr     TYPE REF TO cl_xms_lms_extr_filter.

    DATA: lt_value_tab TYPE sxmsdata_tupel_tab_value_tab.

    DATA: lw_interface TYPE sxi_interface,
          lw_snd_rcv   TYPE sxms_lms_p_s_i,
          lw_value_tab LIKE LINE OF lt_value_tab,
          lw_values    TYPE sxmsdvalue.

    DATA: lv_msg LIKE iw_message_id-msgguid.

    CREATE OBJECT lo_appl_log.
    lo_extr = cl_xms_lms_extr_filter=>get_instance( method = 'B' log = lo_appl_log ).

    IF iw_message_id-pid(2) = 'WS'.
      lw_snd_rcv-snd_party = iw_message_id-ob_party.
      lw_snd_rcv-snd_service = iw_message_id-ob_system.
      lw_snd_rcv-rcv_party = iw_message_id-ib_party.
      lw_snd_rcv-rcv_service = iw_message_id-ib_system.
      IF iw_message_id-pid = cl_soap_persist=>co_xiws_receiver OR
         iw_message_id-pid = cl_soap_persist=>co_xiws_is_receiver OR
         iw_message_id-pid = cl_soap_persist=>co_xiws_shortcut.
        lw_interface-name = iw_message_id-ib_name.
        lw_interface-namespace = iw_message_id-ib_ns.
      ELSE.
        lw_interface-name = iw_message_id-ob_name.
        lw_interface-namespace = iw_message_id-ob_ns.
      ENDIF.
      lv_msg = iw_message_id-parentmsg.
      lt_value_tab = lo_extr->test_ws( msgid = lv_msg
                                       pid = iw_message_id-pid
                                       interface = lw_interface
                                       snd_rcv = lw_snd_rcv ).
      READ TABLE lt_value_tab INTO lw_value_tab INDEX 1.
      IF sy-subrc IS INITIAL.
        READ TABLE lw_value_tab-value_tab INTO lw_values INDEX 1.
        IF sy-subrc IS INITIAL.
          rv_doc_no = lw_values.
        ENDIF.
      ENDIF.
    ELSE.
    ENDIF.
  ENDMETHOD.                    "get_sap_Doc_number

  METHOD init_alv.
    DATA: lo_events TYPE REF TO cl_salv_events_table.
*    TRY.
    cl_salv_table=>factory(
      IMPORTING
        r_salv_table = me->o_alv
      CHANGING
        t_table      = me->t_output ).
*      CATCH cx_salv_msg INTO message.
    " error handling
*    ENDTRY.

    adjust_alv( ).
    lo_events = me->o_alv->get_event( ).
    SET HANDLER me->on_single_click FOR lo_events.

  ENDMETHOD.                    "display_report

  METHOD adjust_alv.
    DATA: lv_lines TYPE i,
          lv_idd   TYPE string.
    DATA: lw_idd LIKE LINE OF s_idd.
    DATA: lo_header    TYPE REF TO cl_salv_form_layout_grid,
          lo_h_label   TYPE REF TO cl_salv_form_label,
          lo_h_flow    TYPE REF TO cl_salv_form_layout_flow,
          lo_columns   TYPE REF TO cl_salv_columns_table,
          lo_column    TYPE REF TO cl_salv_column_table,
          lo_functions TYPE REF TO cl_salv_functions,
          lo_display   TYPE REF TO cl_salv_display_settings.

    CREATE OBJECT lo_header.
    lo_h_label = lo_header->create_label( row = 1 column = 1 ).
    lo_h_label->set_text( 'XML Monitoring' ).

    lo_h_label = lo_header->create_label( row = 3  column = 1 ).
    lo_h_label->set_text( 'Track' ).

    lo_h_flow = lo_header->create_flow( row = 3  column = 2 ).
    lo_h_flow->create_text( text = p_track ).

    lo_h_label = lo_header->create_label( row = 5  column = 1 ).
    lo_h_label->set_text( 'IDD' ).

    CLEAR: lv_idd.
    LOOP AT s_idd INTO lw_idd.
      IF lv_idd IS INITIAL.
        lv_idd = lw_idd-low.
      ELSE.
        CONCATENATE lv_idd lw_idd-low INTO lv_idd SEPARATED BY ', ' RESPECTING BLANKS.
      ENDIF.
    ENDLOOP.

    lo_h_flow = lo_header->create_flow( row = 5  column = 2 ).
    lo_h_flow->create_text( text = lv_idd ).

    lo_h_flow = lo_header->create_flow( row = 7  column = 1 ).
    lo_h_flow->create_text( text = 'Number of Records' ).

    DESCRIBE TABLE me->t_output LINES lv_lines.
    lo_h_flow = lo_header->create_flow( row = 7  column = 2 ).
    lo_h_flow->create_text( text = lv_lines ).



    me->o_alv->set_top_of_list( lo_header ).
*
*    set the top of list using the header for Print.
    me->o_alv->set_top_of_list_print( lo_header ).

    me->o_alv->set_screen_status( pfstatus = 'STANDARD'
                              report = 'SAPLKKBL'
                              set_functions = me->o_alv->c_functions_all ).

    lo_columns = me->o_alv->get_columns( ).
    lo_columns->set_optimize( ).

    lo_column ?= lo_columns->get_column( 'TRACK' ).
    lo_column->set_short_text( 'Track' ).
    lo_column->set_medium_text( 'Functional Track' ).
    lo_column->set_long_text( 'Functional Track' ).

    lo_column ?= lo_columns->get_column( 'IDD' ).
    lo_column->set_short_text( 'IDD' ).
    lo_column->set_medium_text( 'IDD' ).
    lo_column->set_long_text( 'IDD' ).

    lo_column ?= lo_columns->get_column( 'DOC_NO' ).
    lo_column->set_short_text( 'Doc Number' ).
    lo_column->set_medium_text( 'Document Number' ).
    lo_column->set_long_text( 'SAP Document Number' ).

    lo_column ?= lo_columns->get_column( 'STATS' ).
    DATA: lw_ddic TYPE salv_s_ddic_reference.
    lw_ddic-table = 'SXMSMSTAT'.
    lw_ddic-field = 'ICON_ID'.
    lo_column->set_ddic_reference( lw_ddic ).
    lo_column->set_f4( if_salv_c_bool_sap=>true ).
    lo_column->set_short_text( 'Status' ).
    lo_column->set_medium_text( 'Status' ).
    lo_column->set_long_text( 'Status' ).

    lo_column ?= lo_columns->get_column( 'DATE' ).
    lo_column->set_short_text( 'Date' ).
    lo_column->set_medium_text( 'Created On' ).
    lo_column->set_long_text( 'Created On' ).

    lo_column ?= lo_columns->get_column( 'TIME' ).
    lo_column->set_short_text( 'Time' ).
    lo_column->set_medium_text( 'Created At' ).
    lo_column->set_long_text( 'Created At' ).

    lo_column ?= lo_columns->get_column( 'MSGGUID' ).
    lo_column->set_cell_type( value = if_salv_c_cell_type=>hotspot ).

    lo_functions = me->o_alv->get_functions( ).
    lo_functions->set_all( abap_true ).

    lo_display = me->o_alv->get_display_settings( ).
    lo_display->set_striped_pattern( cl_salv_display_settings=>true ).

  ENDMETHOD.                    "adjust_alv

  METHOD on_single_click.
    DATA: lw_output TYPE me->type_output.
    READ TABLE me->t_output INTO lw_output INDEX row.
    SUBMIT rsxmb_display_msg_vers_new
      WITH msgguid = lw_output-msgguid
      WITH version = '000'
      WITH pipeline = 'SENDER'
      WITH kind = 'C'
      WITH msgmandt = sy-mandt
      WITH msgpid = 'SENDER' AND RETURN.
  ENDMETHOD.                    "on_single_click

  METHOD send_email.
    DATA: lt_columns        TYPE salv_t_column_ref,
          lt_binary_content TYPE solix_tab,
          lt_mailtxt        TYPE soli_tab .

    DATA: lw_output    LIKE LINE OF me->t_output,
          lw_mail_text LIKE LINE OF lt_mailtxt,
          lw_recipient LIKE LINE OF s_email,
          lw_columns   LIKE LINE OF lt_columns.

    DATA: lv_string     TYPE string,
          lv_tmp_string TYPE string,
          lv_size       TYPE so_obj_len,
          lv_text       TYPE scrtext_l,
          lv_msg        TYPE string,
          lv_date       TYPE char10,
          lv_time       TYPE char10.

    DATA: lo_document     TYPE REF TO cl_document_bcs,
          lo_send_request TYPE REF TO cl_bcs,
          lo_sender       TYPE REF TO cl_sapuser_bcs,
          lo_recipent     TYPE REF TO if_recipient_bcs,
          lo_columns      TYPE REF TO cl_salv_columns_table.

    CONSTANTS: lc_tab TYPE c VALUE cl_bcs_convert=>gc_tab,
               lc_cr  TYPE c VALUE cl_bcs_convert=>gc_crlf.

*--------------------------------------------------------------------*
*    Begin of "Get column headings"
*--------------------------------------------------------------------*
    lo_columns = me->o_alv->get_columns( ).
    lt_columns = lo_columns->get( ).
    LOOP AT lt_columns INTO lw_columns.
      lv_text = lw_columns-r_column->get_long_text( ).
      IF lv_text NE 'Status'.
        IF lv_string IS INITIAL.
          lv_string = lv_text.
        ELSE.
          CONCATENATE lv_string lv_text
            INTO lv_string SEPARATED BY lc_tab.
        ENDIF.
      ENDIF.
    ENDLOOP.
*    CONCATENATE lv_string lc_cr INTO lv_string.
*--------------------------------------------------------------------*
*    End of "Get column headings"
*--------------------------------------------------------------------*

*--------------------------------------------------------------------*
*    Begin of "Prepre attachment"
*--------------------------------------------------------------------*
    LOOP AT me->t_output INTO lw_output.
      lv_msg = lw_output-msgguid.
      CLEAR: lv_tmp_string.
      WRITE: lw_output-date TO lv_date,
             lw_output-time TO lv_time.

      CONCATENATE lw_output-track
                  lw_output-idd
                  lw_output-doc_no
*                  lw_output-msgguid
                  lv_msg
                  lv_date
                  lv_time
                  lw_output-ob_ns
                  lw_output-ob_name
                  lw_output-ib_ns
                  lw_output-ib_name
                  lw_output-errcat
                  lw_output-errcode
                  lw_output-errlabel
                  INTO lv_tmp_string
                  SEPARATED BY lc_tab.
      CONCATENATE lv_string lv_tmp_string INTO lv_string SEPARATED BY lc_cr.
    ENDLOOP.
    cl_bcs_convert=>string_to_solix(
                                    EXPORTING
                                      iv_string = lv_string
                                      iv_codepage = '4103' "suitable for MS Excel, leave empty
                                      iv_add_bom = 'X' "for other doc types
                                    IMPORTING
                                      et_solix = lt_binary_content
                                      ev_size = lv_size ).
*--------------------------------------------------------------------*
*    End of "Prepre attachment"
*--------------------------------------------------------------------*

    lt_mailtxt = prepare_mail_body( ).

*--------------------------------------------------------------------*
*    Create Document
*--------------------------------------------------------------------*
    lo_send_request = cl_bcs=>create_persistent( ).

    CALL METHOD cl_document_bcs=>create_document
      EXPORTING
        i_type    = 'HTM'
        i_subject = 'XML Monitoring Report'
*       i_length  = l_text_length
        i_text    = lt_mailtxt
      RECEIVING
        result    = lo_document.

*--------------------------------------------------------------------*
*    Set sender
*--------------------------------------------------------------------*
    lo_sender = cl_sapuser_bcs=>create( sy-uname ).
    lo_send_request->set_sender( i_sender = lo_sender ).

    CALL METHOD lo_document->add_attachment(
      i_attachment_type = 'XLS'
      i_attachment_subject = 'XML Monitoring Report'
      i_attachment_size = lv_size
      i_att_content_hex = lt_binary_content ).

    lo_send_request->set_document( lo_document ).

*--------------------------------------------------------------------*
*    Set recipients
*--------------------------------------------------------------------*
    LOOP AT s_email INTO lw_recipient.
      lo_recipent = cl_cam_address_bcs=>create_internet_address( lw_recipient-low ).
      lo_send_request->add_recipient( i_recipient = lo_recipent ).
    ENDLOOP.

*--------------------------------------------------------------------*
*    Send!
*--------------------------------------------------------------------*
    lo_send_request->set_send_immediately( 'X' ).
    lo_send_request->send( ).

    COMMIT WORK AND WAIT.
  ENDMETHOD.                    "send_email

  METHOD prepare_mail_body.
    DATA: lw_mailtxt    TYPE soli,
          lw_email_body LIKE LINE OF me->t_email_body.

    DATA: lv_count TYPE string.

    lw_mailtxt = '<b>Hi, please find attached XML Monitoring report</b>'.
    APPEND lw_mailtxt TO rt_mailtxt.

    lw_mailtxt = '<TABLE BORDER = 1 style="width:50%;">'.
    APPEND lw_mailtxt TO rt_mailtxt.

    CLEAR: lw_mailtxt.
    lw_mailtxt = '<TH>Track</TH>'.
    APPEND lw_mailtxt TO rt_mailtxt.

    CLEAR: lw_mailtxt.
    lw_mailtxt = '<TH>IDD</TH>'.
    APPEND lw_mailtxt TO rt_mailtxt.

    CLEAR: lw_mailtxt.
    lw_mailtxt = '<TH>Count</TH>'.
    APPEND lw_mailtxt TO rt_mailtxt.

    LOOP AT me->t_email_body INTO lw_email_body.
      CONCATENATE '<TR><TD>'
                  lw_email_body-track
                  '</TD>' INTO lw_mailtxt.
      APPEND lw_mailtxt TO rt_mailtxt.

      CONCATENATE '<TD>'
                  lw_email_body-idd
                  '</TD>' INTO lw_mailtxt.
      APPEND lw_mailtxt TO rt_mailtxt.

      lv_count = lw_email_body-count.
      CONCATENATE '<TD>'
                  lv_count
                  '</TD></TR>' INTO lw_mailtxt.
      APPEND lw_mailtxt TO rt_mailtxt.
    ENDLOOP.
    lw_mailtxt = '</TABLE>'.
    APPEND lw_mailtxt TO rt_mailtxt.
  ENDMETHOD.                    "prepare_mail_body
ENDCLASS.                    "lcl_report IMPLEMENTATION
