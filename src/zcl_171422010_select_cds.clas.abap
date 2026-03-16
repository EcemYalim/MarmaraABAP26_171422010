CLASS zcl_171422010_select_cds DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
        get_result_from_cds
            IMPORTING carrier_id TYPE /dmo/carrier_id
                      connection_id TYPE /dmo/connection_id

            EXPORTING airport_from_id TYPE /dmo/airport_from_id
                      airport_to_id TYPE /dmo/airport_to_id
                      carrier_name TYPE /dmo/carrier_name

            RAISING cx_abap_invalid_value.
ENDCLASS.



CLASS zcl_171422010_select_cds IMPLEMENTATION.

  METHOD get_result_from_cds.
    SELECT SINGLE
        FROM /DMO/I_Connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
        WHERE AirlineID = @carrier_id
        AND ConnectionID = @connection_id
        INTO ( @airport_from_id, @airport_to_id , @carrier_name ).

       IF sy-subrc <> 0.
       RAISE EXCEPTION TYPE cx_abap_invalid_value.
       ENDIF.

       ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id TYPE /dmo/airport_to_id.
    DATA carrier_name TYPE /dmo/carrier_name.

    carrier_id = 'XX'.
    connection_id = '059'.

    TRY.
        get_result_from_cds( EXPORTING carrier_id = carrier_id
                                       connection_id = connection_id
                             IMPORTING airport_from_id = airport_from_id
                                       airport_to_id = airport_to_id
                                       carrier_name = carrier_name ).
        out->write(
        |Airport From ID is: { airport_from_id } & Airport To ID is: | &&
        |{ airport_to_id } & Carrier Name is: { carrier_name }| ).

        CATCH cx_abap_invalid_value.
            out->write( 'Selection Returned no results!' ).
        ENDTRY.

  ENDMETHOD.
ENDCLASS.
