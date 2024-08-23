class ZCL_IMAGE_JKP definition
  public
  create public .

public section.

  types:
    MY_URL(132) type C .
  types:
    MY_CONTAINER_NAME(10) type C .

  data CONTAINER type ref to CL_GUI_CUSTOM_CONTAINER .
  data PICTURE type ref to CL_GUI_PICTURE .
  data INIT type ABAP_BOOL .
  data CONTAINER_NAME type MY_CONTAINER_NAME .
  data URL type MY_URL .
  data IMAGE_NAME type STRING .

  methods CONSTRUCTOR
    importing
      !CONTAINER_NAME type MY_CONTAINER_NAME
      !IMAGE_NAME type STRING .
  methods CALLME_IN_PBO .
  methods LOAD_PIC_FROM_DB
    changing
      !URL type MY_URL .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IMAGE_JKP IMPLEMENTATION.


method CALLME_IN_PBO.
  IF init = abap_true.
    RETURN.
  ENDIF.

*create the custom container
  CREATE OBJECT container
                EXPORTING container_name = me->container_name.
*create the picture control
  CREATE OBJECT picture
                EXPORTING parent = container.

*Request an URL from the data provider by exporting the pic_data.

  CLEAR URL.
  CALL METHOD me->LOAD_PIC_FROM_DB CHANGING URL = URL.

*load picture
  CALL METHOD picture->load_picture_from_url
      EXPORTING url = url.
  init = 'X'.

  CALL METHOD cl_gui_cfw=>flush
       EXCEPTIONS cntl_system_error = 1
                  cntl_error = 2.
  IF sy-subrc <> 0.
*error handling
  ENDIF.

  init = abap_true.
endmethod.


method CONSTRUCTOR.
  me->container_name = container_name.
  me->image_name     = image_name.
endmethod.


  method LOAD_PIC_FROM_DB.
    DATA QUERY_TABLE TYPE STANDARD TABLE OF W3QUERY.
    DATA ls_query TYPE W3QUERY.
    DATA HTML_TABLE TYPE STANDARD TABLE OF W3HTML.
    DATA RETURN_CODE TYPE  W3RETCODE.
    DATA CONTENT_TYPE TYPE  W3CONTTYPE.
    DATA CONTENT_LENGTH TYPE  W3CONTLEN.
    DATA PIC_DATA TYPE STANDARD TABLE OF W3MIME.
    DATA PIC_SIZE TYPE I.



  CLEAR ls_query.
  ls_query-NAME = '_OBJECT_ID'.
  ls_query-VALUE = me->image_name. " ENJOYSAP_LOGO
  APPEND ls_query TO QUERY_TABLE.

##FM_OLDED
  CALL FUNCTION 'WWW_GET_MIME_OBJECT'
       TABLES
            QUERY_STRING        = QUERY_TABLE
            HTML                = HTML_TABLE
            MIME                = PIC_DATA
       CHANGING
            RETURN_CODE         = RETURN_CODE
            CONTENT_TYPE        = CONTENT_TYPE
            CONTENT_LENGTH      = CONTENT_LENGTH
       EXCEPTIONS
            OBJECT_NOT_FOUND    = 1
            PARAMETER_NOT_FOUND = 2
            OTHERS              = 3.
  if sy-subrc = 0.
    PIC_SIZE = CONTENT_LENGTH.
  endif.

CALL FUNCTION 'DP_CREATE_URL'
         EXPORTING
              TYPE     = 'image'
              SUBTYPE  = cndp_sap_tab_unknown
              SIZE     = PIC_SIZE
              lifetime = cndp_lifetime_transaction
         TABLES
              DATA     = PIC_DATA
         CHANGING
              URL      = URL
##FM_SUBRC_OK
         EXCEPTIONS
              others   = 1.
  endmethod.
ENDCLASS.
