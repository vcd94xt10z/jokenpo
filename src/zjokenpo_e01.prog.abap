MODULE pbo_9000 OUTPUT.
  SET PF-STATUS 'S9000'.
  SET TITLEBAR 'T9000'.

  go_papel->callme_in_pbo( ).
  go_pedra->callme_in_pbo( ).
  go_tesoura->callme_in_pbo( ).
ENDMODULE.
MODULE pai_9000 INPUT.
  CASE sy-ucomm.
  WHEN 'PAPEL' OR 'PEDRA' OR 'TESOURA'.
    go_main->jogar( EXPORTING id_opcao = sy-ucomm ).
  WHEN 'BACK' OR 'UP' OR 'CANCEL'.
    LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
