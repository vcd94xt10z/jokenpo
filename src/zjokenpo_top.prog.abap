CONSTANTS gc_papel   TYPE char10 VALUE 'PAPEL'.
CONSTANTS gc_pedra   TYPE char10 VALUE 'PEDRA'.
CONSTANTS gc_tesoura TYPE char10 VALUE 'TESOURA'.

CLASS lcl_main DEFINITION DEFERRED.

TYPES: BEGIN OF gy_data
     , placar_vitorias    TYPE int4
     , placar_empates     TYPE int4
     , placar_derrotas    TYPE int4
     , escolha_jogador    TYPE char10
     , escolha_computador TYPE char10
     , resultado          TYPE char20
     , END OF gy_data.

DATA: go_main    TYPE REF TO lcl_main.
DATA: gs_data    TYPE gy_data.

DATA: go_papel   TYPE REF TO zcl_image_jkp.
DATA: go_pedra   TYPE REF TO zcl_image_jkp.
DATA: go_tesoura TYPE REF TO zcl_image_jkp.
