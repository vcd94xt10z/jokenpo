CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS jogar IMPORTING id_opcao TYPE any.
    METHODS get_escolha_computador RETURNING VALUE(rd_opcao) TYPE string.
endclass.
CLASS lcl_main IMPLEMENTATION.
  METHOD jogar.
    gs_data-escolha_jogador    = id_opcao.
    gs_data-escolha_computador = me->get_escolha_computador( ).

    IF gs_data-escolha_jogador = gs_data-escolha_computador.
      gs_data-resultado = 'Empate'.
      gs_data-placar_empates = gs_data-placar_empates + 1.
      RETURN.
    ENDIF.


    IF ( gs_data-escolha_jogador = 'PEDRA'   AND gs_data-escolha_computador = 'TESOURA' ) OR
       ( gs_data-escolha_jogador = 'PAPEL'   AND gs_data-escolha_computador = 'PEDRA'   ) OR
       ( gs_data-escolha_jogador = 'TESOURA' AND gs_data-escolha_computador = 'PAPEL'   ) .
      gs_data-resultado = 'Você venceu :)'.
      gs_data-placar_vitorias = gs_data-placar_vitorias + 1.
      RETURN.
    ENDIF.

    IF ( gs_data-escolha_computador = 'PEDRA'   AND gs_data-escolha_jogador = 'TESOURA' ) OR
       ( gs_data-escolha_computador = 'PAPEL'   AND gs_data-escolha_jogador = 'PEDRA'   ) OR
       ( gs_data-escolha_computador = 'TESOURA' AND gs_data-escolha_jogador = 'PAPEL'   ) .
      gs_data-resultado = 'Você perdeu :('.
      gs_data-placar_derrotas = gs_data-placar_derrotas + 1.
      RETURN.
    ENDIF.
  ENDMETHOD.
  METHOD get_escolha_computador.
    DATA: ld_number TYPE int4.

    ld_number = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                  min  = 1
                                                  max  = 3 )->get_next( ).

    CASE ld_number.
      WHEN 1. rd_opcao = 'PAPEL'.
      WHEN 2. rd_opcao = 'PEDRA'.
      WHEN 3. rd_opcao = 'TESOURA'.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
