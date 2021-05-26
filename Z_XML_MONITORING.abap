*&---------------------------------------------------------------------*
*& Report  Z_XML_MONITORING
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT z_xml_monitoring.


INCLUDE z_xml_monitoring_top.
INCLUDE z_xml_monitoring_sel.
INCLUDE z_xml_monitoring_imp.

INITIALIZATION.
  SELECT * FROM zxml_monitor_con
    INTO TABLE t_zxml_monitor_con_main.

  CLEAR w_opt_list.
  w_opt_list-name       = 'EQ'.
  w_opt_list-options-eq = 'X'.
  APPEND w_opt_list TO w_restrict-opt_list_tab.

  w_sel-kind            = 'S'.
  w_sel-sg_main         = 'I'.
  w_sel-sg_addy         = ' '.
  w_sel-op_main         = 'EQ'.
  w_sel-op_addy         = 'EQ'.
  w_sel-name            = 'S_IDD'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL1'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL2'.
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL3'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL4'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL5'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL6'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL7'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL8'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL9'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_VAL10'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  w_sel-name            = 'S_EMAIL'.   "Your select-option name
  APPEND w_sel TO w_restrict-ass_tab.
  CALL FUNCTION 'SELECT_OPTIONS_RESTRICT'
    EXPORTING
      restriction = w_restrict.

*--------------------------------------------------------------------*
*  Begin of Modify Selection Screen
*--------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.
  DATA: w_idd LIKE LINE OF s_idd.
  CLEAR: t_zxml_monitor_con_temp.
  IF s_idd[] IS NOT INITIAL.
    LOOP AT t_zxml_monitor_con_main INTO w_zxml_monitor_con
      WHERE track EQ p_track
*      AND idd EQ p_idd.
        AND idd IN s_idd[].
      APPEND w_zxml_monitor_con TO t_zxml_monitor_con_temp.
    ENDLOOP.
  ENDIF.
  LOOP AT SCREEN.
    CASE screen-group1.
      WHEN 'P1D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 1.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc1tx = w_zxml_monitor_con-field.
          p_idd1 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc1tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P1C' OR 'P1V'.
        IF p_doc1tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
          CLEAR: s_val1[].
        ENDIF.
        MODIFY SCREEN.
      WHEN 'P2D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 2.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc2tx = w_zxml_monitor_con-field.
          p_idd2 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc2tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P2C' OR 'P2V'.
        IF p_doc2tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'P3D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 3.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc3tx = w_zxml_monitor_con-field.
          p_idd3 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc3tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P3C' OR 'P3V'.
        IF p_doc3tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'P4D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 4.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc4tx = w_zxml_monitor_con-field.
          p_idd4 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc4tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P4C' OR 'P4V'.
        IF p_doc4tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'P5D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 5.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc5tx = w_zxml_monitor_con-field.
          p_idd5 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc5tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P5C' OR 'P5V'.
        IF p_doc5tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'P6D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 6.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc6tx = w_zxml_monitor_con-field.
          p_idd6 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc6tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P6C' OR 'P6V'.
        IF p_doc6tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'P7D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 7.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc7tx = w_zxml_monitor_con-field.
          p_idd7 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc7tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P7C' OR 'P7V'.
        IF p_doc7tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'P8D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 8.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc8tx = w_zxml_monitor_con-field.
          p_idd8 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc8tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P8C' OR 'P8V'.
        IF p_doc8tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'P9D'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 9.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_doc9tx = w_zxml_monitor_con-field.
          p_idd9 = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_doc9tx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'P9C' OR 'P9V'.
        IF p_doc9tx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'PXD'.
        CLEAR: w_idd, w_zxml_monitor_con.
        READ TABLE s_idd INTO w_idd INDEX 10.
        READ TABLE t_zxml_monitor_con_temp INTO w_zxml_monitor_con
          WITH KEY idd = w_idd-low.
        IF sy-subrc IS INITIAL.
          screen-input = 0.
          p_docxtx = w_zxml_monitor_con-field.
          p_iddx = w_zxml_monitor_con-idd.
          MODIFY SCREEN.
        ELSE.
          CLEAR: p_docxtx.
          screen-active = '0'.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'PXC' OR 'PXV'.
        IF p_docxtx IS NOT INITIAL .
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'EM1'.
        IF p_mailsn EQ abap_true.
          screen-active = '1'.
        ELSE.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.
*--------------------------------------------------------------------*
*  End of Modify Selection Screen
*--------------------------------------------------------------------*

*--------------------------------------------------------------------*
*  Begin of Validation
*--------------------------------------------------------------------*
  AT SELECTION-SCREEN ON BLOCK b1.
    IF p_to_dt - p_frmdt GT 15.
      MESSAGE 'Enter date range of at max 15 days' TYPE 'E'.
    ENDIF.
*--------------------------------------------------------------------*
*  End of validation
*--------------------------------------------------------------------*

*--------------------------------------------------------------------*
*  Main Start
*--------------------------------------------------------------------*
START-OF-SELECTION.
*--------------------------------------------------------------------*
*  Instantiate Singleton class
*--------------------------------------------------------------------*
  o_main = lcl_main=>instantiate( ).
*--------------------------------------------------------------------*
*  Main Method
*--------------------------------------------------------------------*
  o_main->main_method( ).
