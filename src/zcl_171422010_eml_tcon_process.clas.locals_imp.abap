CLASS lcl_connection_eml DEFINITION.
  PUBLIC SECTION.

    CLASS-METHODS:
      insert_data,
      read_data,
      update_data,
      delete_data.

ENDCLASS.


CLASS lcl_connection_eml IMPLEMENTATION.

  METHOD insert_data.

    DATA: lt_create TYPE TABLE FOR CREATE zr_tcon_171422010,
          ls_failed TYPE RESPONSE FOR FAILED zr_tcon_171422010.

    lt_create = VALUE #(
      (
        %cid        = 'C1'
        Carrid      = 'LH'
        Connid      = '0400'
        AirportFrom = 'FRA'
        CityFrom    = 'Frankfurt'
        CountryFrom = 'DE'
        AirportTo   = 'JFK'
        CityTo      = 'New York'
        CountryTo   = 'US'
      )
    ).

    MODIFY ENTITIES OF zr_tcon_171422010
      ENTITY ZrTcon171422010
      CREATE FIELDS (
        Carrid
        Connid
        AirportFrom
        CityFrom
        CountryFrom
        AirportTo
        CityTo
        CountryTo
      )
      WITH lt_create
      FAILED ls_failed.

    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ENDIF.

  ENDMETHOD.


  METHOD read_data.

  DATA read_keys TYPE TABLE FOR READ IMPORT zr_tcon_171422010.
  DATA connections TYPE TABLE FOR READ RESULT zr_tcon_171422010.

  read_keys = VALUE #( ( uuid = '2E4B1E2B65EC1FE18B85D6C5C1B605F1' ) ).

  READ ENTITIES OF zr_tcon_171422010
  ENTITY ZrTcon171422010
  ALL FIELDS
  WITH CORRESPONDING #( read_keys )
  RESULT connections.
  ENDMETHOD.


  METHOD update_data.

  DATA lt_update TYPE TABLE FOR UPDATE zr_tcon_171422010.
  SELECT uuid
  FROM ztcon_171422010
  where uuid = '2E4B1E2B65EC1FE18B85D6C5C1B605F1'
  INTO TABLE @DATA(lt_keys)
  UP TO 1 ROWS.

  LOOP AT lt_keys INTO DATA(ls_key).
  lt_update = VALUE #( ( uuid = ls_key-uuid
  CityTo = 'Paris2'
  %control-CityTo = if_abap_behv=>mk-on ) ).
  ENDLOOP.

  MODIFY ENTITIES OF zr_tcon_171422010
  ENTITY ZrTcon171422010
  UPDATE FROM lt_update
  FAILED DATA(ls_failed).
  IF ls_failed IS INITIAL.
  COMMIT ENTITIES.
  ENDIF.

  ENDMETHOD.


  METHOD delete_data.

  DATA lt_delete TYPE TABLE FOR DELETE zr_tcon_171422010.

  lt_delete = VALUE #( ( uuid = '2E4B1E2B65EC1FE18B85D6C5C1B605F1' ) ).

  MODIFY ENTITIES OF zr_tcon_171422010
  ENTITY ZrTcon171422010
  DELETE FROM lt_delete
  FAILED DATA(ls_failed).
  IF lt_delete IS INITIAL.
  COMMIT ENTITIES.
  ENDIF.

  ENDMETHOD.

ENDCLASS.
