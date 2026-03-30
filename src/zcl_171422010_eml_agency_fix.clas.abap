CLASS zcl_171422010_eml_agency_fix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_171422010_eml_agency_fix IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA agencies_upd TYPE TABLE FOR UPDATE /dmo/i_agencytp.
    agencies_upd = VALUE #( ( agencyid = '070035'
                              name = 'Hello New name' ) ).
    MODIFY ENTITIES OF /dmo/i_agencytp
     ENTITY /dmo/agency
     UPDATE FIELDS ( name )
      WITH agencies_upd.

    COMMIT ENTITIES.

    out->write( 'method execution finished' ).
  ENDMETHOD.
ENDCLASS.
