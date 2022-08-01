;-------------------------------------------------------------------------------
; ROM info
;-------------------------------------------------------------------------------
	.org    $200
    
    .byte   "Advent Wreath    "; 16 byte
	.byte   "Advent Wreath VMU App/Tool."     ; 32 byte
    ; Thanks To Marcus, Sebastian, And Tyro For Header Format!

	.org    $240

	.word   2               ; number of icons (max = 3)
	.word   14              ; animation speed

;-------------------------------------------------------------------------------
; Game Icon Palette Table
;
; Each entry is 16-bit, as such AAAARRRR GGGGBBBB
; where a value of 0xF for alpha means opaque
;-------------------------------------------------------------------------------
	.org    $260

    ;       BG,    FlameY FlameW FlameLB,Purple1,FlameDB,Pink1,BlackWick
	.word   $f114, $ffe0, $ffff, $f8df, $fa0f, $f02f, $ffae, $f000

	;       Purple2,Pink2,Purple3,GreenD,GreenL,Pink3,RedLt,RdDark
    .word   $f60a, $ff8d, $f406, $f051, $f081, $fd7b, $fd00, $f900

;-------------------------------------------------------------------------------
; Game Icon Data
;-------------------------------------------------------------------------------

; This is where the game icons are placed.  Each icon is 512 byte long,
; 32 * 32 pixel, each pixel being represented by 4 bit (one nybble) that
; serve as a pointer into the color palette table.

       .org    $280
       ;      0        5         10        15        20        25        30 
       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00,$10,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00,$10,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$12,$10,$00,$00,$00,$00,$01,$21,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$12,$10,$00,$00,$00,$00,$01,$21,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$03,$00,$00,$00,$00,$00,$00,$30,$00,$00,$00,$00
       .byte $00,$00,$00,$04,$45,$44,$00,$00,$00,$00,$66,$56,$60,$00,$00,$00
       .byte $00,$00,$00,$44,$47,$44,$40,$00,$00,$06,$66,$76,$66,$00,$00,$00
       .byte $00,$00,$00,$84,$44,$44,$80,$00,$00,$09,$66,$66,$69,$00,$00,$00
       .byte $00,$00,$00,$88,$88,$88,$80,$00,$00,$09,$99,$99,$99,$00,$00,$00
       .byte $00,$00,$00,$88,$88,$18,$80,$00,$00,$09,$91,$99,$99,$00,$00,$00
       .byte $00,$00,$00,$a8,$88,$18,$ab,$cc,$cc,$bd,$91,$99,$9d,$00,$00,$00
       .byte $00,$00,$00,$a8,$81,$21,$ac,$cb,$bc,$cd,$12,$19,$9d,$00,$00,$00
       .byte $00,$00,$0b,$aa,$81,$21,$a0,$00,$00,$0d,$12,$19,$dd,$b0,$00,$00
       .byte $00,$0b,$cc,$aa,$aa,$3a,$a0,$00,$00,$0d,$d3,$dd,$dd,$cc,$b0,$00
       .byte $00,$0c,$b0,$0a,$aa,$5a,$00,$00,$00,$00,$d5,$dd,$d0,$0b,$c0,$00
       .byte $0b,$cc,$00,$00,$44,$74,$40,$00,$00,$04,$47,$44,$00,$00,$cc,$b0
       .byte $0c,$b0,$00,$04,$44,$74,$44,$00,$00,$44,$47,$44,$40,$00,$0b,$c0
       .byte $bc,$00,$00,$08,$44,$44,$48,$00,$00,$84,$44,$44,$80,$00,$00,$cb
       .byte $cc,$00,$00,$08,$88,$88,$88,$00,$00,$88,$88,$88,$80,$00,$00,$cc
       .byte $bb,$00,$00,$08,$88,$88,$88,$00,$00,$88,$88,$88,$80,$00,$00,$bb
       .byte $0c,$c0,$00,$08,$88,$88,$88,$00,$00,$88,$88,$88,$80,$00,$0c,$c0
       .byte $0c,$b0,$00,$0a,$88,$88,$8a,$00,$00,$a8,$88,$88,$a0,$00,$0b,$c0
       .byte $0b,$cc,$00,$0a,$a8,$88,$8a,$00,$00,$a8,$88,$8a,$a0,$00,$cc,$b0
       .byte $00,$cc,$bb,$ca,$aa,$88,$aa,$00,$00,$aa,$88,$aa,$ac,$bb,$cc,$00
       .byte $00,$0b,$bc,$cc,$cb,$aa,$aa,$00,$00,$aa,$aa,$bc,$cc,$cb,$b0,$00
       .byte $00,$00,$00,$cc,$bb,$ce,$eb,$cc,$cc,$be,$ec,$bb,$cc,$00,$00,$00
       .byte $00,$00,$00,$00,$0c,$ce,$ee,$ec,$ce,$ee,$e0,$00,$00,$00,$00,$00
       .byte $00,$00,$00,$0e,$0e,$ef,$ee,$fe,$ef,$ee,$fe,$e0,$e0,$00,$00,$00
       .byte $00,$00,$00,$00,$e0,$0e,$ee,$e0,$0e,$ee,$e0,$0e,$00,$00,$00,$00
       .byte $00,$00,$00,$0e,$00,$0e,$ee,$00,$00,$ee,$e0,$00,$e0,$00,$00,$00
       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
        .org    $480
       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00,$10,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$12,$10,$00,$00,$00,$00,$01,$21,$00,$00,$00,$00
       .byte $00,$00,$00,$00,$03,$00,$00,$00,$00,$00,$00,$30,$00,$00,$00,$00
       .byte $00,$00,$00,$04,$45,$44,$00,$00,$00,$00,$66,$56,$60,$00,$00,$00
       .byte $00,$00,$00,$44,$47,$44,$40,$00,$00,$06,$66,$76,$66,$00,$00,$00
       .byte $00,$00,$00,$84,$44,$44,$80,$00,$00,$09,$66,$66,$69,$00,$00,$00
       .byte $00,$00,$00,$88,$88,$88,$80,$00,$00,$09,$99,$99,$99,$00,$00,$00
       .byte $00,$00,$00,$88,$88,$88,$80,$00,$00,$09,$99,$99,$99,$00,$00,$00
       .byte $00,$00,$00,$a8,$88,$88,$ab,$cc,$cc,$bd,$99,$99,$9d,$00,$00,$00
       .byte $00,$00,$00,$a8,$88,$18,$ac,$cb,$bc,$cd,$91,$99,$9d,$00,$00,$00
       .byte $00,$00,$0b,$aa,$81,$21,$a0,$00,$00,$0d,$12,$19,$dd,$b0,$00,$00
       .byte $00,$0b,$cc,$aa,$aa,$3a,$a0,$00,$00,$0d,$d3,$dd,$dd,$cc,$b0,$00
       .byte $00,$0c,$b0,$0a,$aa,$5a,$00,$00,$00,$00,$d5,$dd,$d0,$0b,$c0,$00
       .byte $0b,$cc,$00,$00,$44,$74,$40,$00,$00,$04,$47,$44,$00,$00,$cc,$b0
       .byte $0c,$b0,$00,$04,$44,$74,$44,$00,$00,$44,$47,$44,$40,$00,$0b,$c0
       .byte $bc,$00,$00,$08,$44,$44,$48,$00,$00,$84,$44,$44,$80,$00,$00,$cb
       .byte $cc,$00,$00,$08,$88,$88,$88,$00,$00,$88,$88,$88,$80,$00,$00,$cc
       .byte $bb,$00,$00,$08,$88,$88,$88,$00,$00,$88,$88,$88,$80,$00,$00,$bb
       .byte $0c,$c0,$00,$08,$88,$88,$88,$00,$00,$88,$88,$88,$80,$00,$0c,$c0
       .byte $0c,$b0,$00,$0a,$88,$88,$8a,$00,$00,$a8,$88,$88,$a0,$00,$0b,$c0
       .byte $0b,$cc,$00,$0a,$a8,$88,$8a,$00,$00,$a8,$88,$8a,$a0,$00,$cc,$b0
       .byte $00,$cc,$bb,$ca,$aa,$88,$aa,$00,$00,$aa,$88,$aa,$ac,$bb,$cc,$00
       .byte $00,$0b,$bc,$cc,$cb,$aa,$aa,$00,$00,$aa,$aa,$bc,$cc,$cb,$b0,$00
       .byte $00,$00,$00,$cc,$bb,$ce,$eb,$cc,$cc,$be,$ec,$bb,$cc,$00,$00,$00
       .byte $00,$00,$00,$00,$0c,$ce,$ee,$ec,$ce,$ee,$e0,$00,$00,$00,$00,$00
       .byte $00,$00,$00,$0e,$0e,$ef,$ee,$fe,$ef,$ee,$fe,$e0,$e0,$00,$00,$00
       .byte $00,$00,$00,$00,$e0,$0e,$ee,$e0,$0e,$ee,$e0,$0e,$00,$00,$00,$00
       .byte $00,$00,$00,$0e,$00,$0e,$ee,$00,$00,$ee,$e0,$00,$e0,$00,$00,$00
       .byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00