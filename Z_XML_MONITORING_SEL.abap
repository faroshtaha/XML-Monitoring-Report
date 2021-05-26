*&---------------------------------------------------------------------*
*&  Include           Z_XML_MONITORING_SEL
*&---------------------------------------------------------------------*

*--------------------------------------------------------------------*
*  Begin of BLOCK1
*--------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-b01.

PARAMETERS: p_track TYPE ztrack OBLIGATORY.

SELECT-OPTIONS: s_idd FOR zxml_monitor_con-idd NO INTERVALS OBLIGATORY.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (31) text-cm1 FOR FIELD p_frmdt.
PARAMETERS: p_frmdt TYPE sy-datum OBLIGATORY.
SELECTION-SCREEN COMMENT 46(2) text-cm2 FOR FIELD p_frmtm.
PARAMETERS: p_frmtm  TYPE sy-uzeit.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (31) text-cm3 FOR FIELD p_to_dt.
PARAMETERS: p_to_dt TYPE sy-datum OBLIGATORY.
SELECTION-SCREEN COMMENT 46(2) text-cm2 FOR FIELD p_to_tm.
PARAMETERS: p_to_tm  TYPE sy-uzeit.
SELECTION-SCREEN END OF LINE.

PARAMETERS: p_all   RADIOBUTTON GROUP rbg0 DEFAULT 'X',
            p_error RADIOBUTTON GROUP rbg0,
            p_pass  RADIOBUTTON GROUP rbg0.

PARAMETERS: p_mailsn AS CHECKBOX USER-COMMAND em1.
SELECT-OPTIONS: s_email FOR v_email NO INTERVALS MODIF ID em1.

SELECTION-SCREEN END OF BLOCK b1 .
*--------------------------------------------------------------------*
*  End of BLOCK1
*--------------------------------------------------------------------*

*--------------------------------------------------------------------*
*  Begin of BLOCK2
*--------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-b02.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p1d.
PARAMETERS: p_idd1   TYPE zidd_number MODIF ID p1d,
            p_doc1tx TYPE zxml_monitor_con-field MODIF ID p1d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm  MODIF ID p1c.
SELECT-OPTIONS: s_val1 FOR v_val MODIF ID p1v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p2d.
PARAMETERS: p_idd2   TYPE zidd_number MODIF ID p2d,
            p_doc2tx TYPE zxml_monitor_con-field MODIF ID p2d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID p2c.
SELECT-OPTIONS: s_val2 FOR v_val MODIF ID p2v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p3d.
PARAMETERS: p_idd3   TYPE zidd_number MODIF ID p3d,
            p_doc3tx TYPE zxml_monitor_con-field MODIF ID p3d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID p3c.
SELECT-OPTIONS: s_val3 FOR v_val MODIF ID p3v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p4d.
PARAMETERS: p_idd4   TYPE zidd_number MODIF ID p4d,
            p_doc4tx TYPE zxml_monitor_con-field MODIF ID p4d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID p4c.
SELECT-OPTIONS: s_val4 FOR v_val MODIF ID p4v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p5d.
PARAMETERS: p_idd5   TYPE zidd_number MODIF ID p5d,
            p_doc5tx TYPE zxml_monitor_con-field MODIF ID p5d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID p5c.
SELECT-OPTIONS: s_val5 FOR v_val MODIF ID p5v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p6d.
PARAMETERS: p_idd6   TYPE zidd_number MODIF ID p6d,
            p_doc6tx TYPE zxml_monitor_con-field MODIF ID p6d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID p6c.
SELECT-OPTIONS: s_val6 FOR v_val MODIF ID p6v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p7d.
PARAMETERS: p_idd7   TYPE zidd_number MODIF ID p7d,
            p_doc7tx TYPE zxml_monitor_con-field MODIF ID p7d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID p7c.
SELECT-OPTIONS: s_val7 FOR v_val MODIF ID p7v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p8d.
PARAMETERS: p_idd8   TYPE zidd_number MODIF ID p8d,
            p_doc8tx TYPE zxml_monitor_con-field MODIF ID p8d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID p8c.
SELECT-OPTIONS: s_val8 FOR v_val MODIF ID p8v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID p9d.
PARAMETERS: p_idd9   TYPE zidd_number MODIF ID p9d,
            p_doc9tx TYPE zxml_monitor_con-field MODIF ID p9d.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID p9c.
SELECT-OPTIONS: s_val9 FOR v_val MODIF ID p9v NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (3) text-cm5  MODIF ID pxd.
PARAMETERS: p_iddx   TYPE zidd_number MODIF ID pxd,
            p_docxtx TYPE zxml_monitor_con-field MODIF ID pxd.
SELECTION-SCREEN COMMENT 46(15) text-cm4 FOR FIELD p_frmtm MODIF ID pxc.
SELECT-OPTIONS: s_val10 FOR v_val MODIF ID pxv NO INTERVALS.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b2 .
*--------------------------------------------------------------------*
*  Begin of BLOCK2
*--------------------------------------------------------------------*
