;=======================;
;	Advent Wreath VMU	;
;=======================;

;=======================;
;	Include Libraries	;
;=======================;

.include "./lib/sfr.i"

;=======================;
;   Define Variables:   ;
;=======================;
p3_pressed              =       $4      ; 1 Byte
p3_last_input           =       $5      ; 1 Byte
gs_bg_address           =       $7      ; 2 Bytes
gs_anim_counter         =       $9      ; 1 Byte
candle1_xpos            =       $c      ; 1 Byte
candle1_ypos            =       $d      ; 1 Byte
candle1_spr_address     =       $e      ; 2 Bytes
candle2_xpos            =       $1c     ; 1 Byte
candle2_ypos            =       $1d     ; 1 Byte
candle2_spr_address     =       $1e     ; 2 Bytes
candle3_xpos            =       $2c     ; 1 Byte
candle3_ypos            =       $2d     ; 1 Byte
candle3_spr_address     =       $2e     ; 2 Bytes
candle4_xpos            =       $3c     ; 1 Byte
candle4_ypos            =       $3d     ; 1 Byte
candle4_spr_address     =       $3f     ; 2 Bytes
candle5_spr_flags       =       $44     ; 1 Byte
candle_number           =       $43     ; 1 Byte
banner_frame_counter    =       $45     ; 1 Byte
minute_check            =       $48     ; 1 Byte
second_check            =       $49     ; 1 Byte
hour_check              =       $42     ; 1 Byte
frame_counter           =       $50     ; 1 Byte
frame_counter_lighting  =       $53     ; 1 Byte
temp_frame_offset       =       $54     ; 1 Byte
animating_bool          =       $55     ; 1 Byte
scrolling_message_x_pos =       $56     ; 1 Byte
scrolling_message_y_pos =       $57     ; 1 Byte
scrolling_message_spr_addr =    $58     ; 2 Bytes
banner_state            =       $5a     ; 1 Byte
banner_counter          =       $5b     ; 1 Byte

;=======================;
;       Constants       ;
;=======================;
T_BTN_B1				 equ	 5
T_BTN_A1				 equ	 4
T_BTN_RIGHT1             equ     3
T_BTN_LEFT1              equ     2
T_BTN_DOWN1              equ     1
T_BTN_UP1                equ     0

;=======================;
;	Prepare Application	;
;=======================;
    .org	0
	jmpf	start

	.org	$3
	jmp	nop_irq

	.org	$b
	jmp	nop_irq
	
	.org	$13
	jmp	nop_irq

	.org	$1b
	jmp	t1int
	
	.org	$23
	jmp	nop_irq

	.org	$2b
	jmp	nop_irq
	
	.org	$33
	jmp	nop_irq

	.org	$3b
	jmp	nop_irq

	.org	$43
	jmp	nop_irq

	.org	$4b
	clr1	p3int,0
	clr1	p3int,1
nop_irq:
	reti

	.org	$130	
t1int:
	push	ie
	clr1	ie,7
	not1	ext,0
	jmpf	t1int
	pop	ie
	reti

	.org	$1f0

goodbye:	
	not1	ext,0
	jmpf	goodbye


;=======================;
;VMU Application Header ;
;=======================;
.include "GameHeader.i"
; Credits/Thanks:	
	.org	$680
    .byte   "Advent Wreath VM"
    .byte   "Thanks To:      "
    .byte   "Kresna Susila,  "
    .byte   "4 LibPerspective"
    .byte   "Walter Tetzner, "
    .byte   "  For WaterBear,"
    .byte   "Falco Girgis,   "
    .byte   " For ElysianVMU,"
    .byte   "Dmitry Grinberg,"
    .byte   "    For VMU.PDF,"
    .byte   "Marcus Comstedt,"
    .byte   "   For Tetris.S,"
    .byte   "Sebastian Mihai,"
    .byte   "4 RainingSquares"
    .byte   "Tyco, For Chao  "
    .byte   "Editor VMI File,"
    ;.byte   "Trent,          "
    .byte   "Speud, For  VMU "
    .byte   "Tool/DreamExplr,"
    .byte   "RetroOnyx, For  "
    .byte   "  Coder's Cable,"
    .byte   "  And Many More."
    .byte   "And You,        "
    .byte   "    For Playing!"
    .byte   "HBD,+M.!GBRDDRAA"
    
;=======================;
; Main program
;=======================;
start:
; Initialize Variables
    mov #0, frame_counter
    mov #0, candle5_spr_flags
    mov #<Candle_Unlit_Top, acc
    st candle1_spr_address
    st candle3_spr_address
    mov #<Candle_Unlit_Bottom_Left, acc
    st candle2_spr_address
    st candle4_spr_address
    mov #>Candle_Unlit_Top, acc
    st candle1_spr_address+1
    st candle3_spr_address+1
    mov #>Candle_Unlit_Bottom_Right, acc
    st candle2_spr_address+1
    st candle4_spr_address+1
    mov #0, candle1_xpos
    mov #0, candle1_ypos
    mov #8, candle2_xpos
    mov #16, candle2_ypos
    mov #16, candle3_xpos
    mov #0, candle3_ypos
    mov #24, candle4_xpos
    mov #16, candle4_ypos
    mov #0, frame_counter_lighting
    mov #0, animating_bool
    mov #1, candle_number
    mov #40, scrolling_message_x_pos
    mov #0, scrolling_message_y_pos
    mov #<Happy_Advent_Banner_Happy, acc
    st scrolling_message_spr_addr
    mov #>Happy_Advent_Banner_Happy, acc
    st scrolling_message_spr_addr+1
    mov #0, banner_frame_counter
    mov #0, banner_state
    mov #0, banner_counter

Main_Loop:
;=======================;
; Handle Input
;=======================;
    ld	p3
	bp	acc, T_BTN_B1, .Not_B
    ld  candle_number
    sub #5
    bp  acc, 7, .keep_lighting
    ; bn  candle_number, 2, .keep_lighting
    ; bn  candle_number, 1, .keep_lighting
    ;; ret ;; Keeping it all in one file now...
    jmpf Merry_Christmas_Loop
.keep_lighting
    mov #1, animating_bool
    ; Light_Candle
.Not_B

;=======================;
;  Start/Light Candles  ;
;=======================;
    ld  animating_bool
    bnz  .skip_compiler_error_1
    jmpf  .skip_light_anim
.skip_compiler_error_1
.do_light_anim
    Light_Candle
    ; jmpf    .skip_light_anim
.assign_candle1_anim
    ld  candle_number
    sub #1
    bnz .assign_candle2_anim
    ld  b
    st  candle1_spr_address
    ld  c
    st  candle1_spr_address+1
    jmpf    .skip_light_anim
.assign_candle2_anim
    ld  candle_number
    sub #2
    bnz .assign_candle3_anim
    ld  b
    st  candle2_spr_address
    ld  c
    st  candle2_spr_address+1
    jmpf    .skip_light_anim
.assign_candle3_anim
    ld  candle_number
    sub #3
    bnz .assign_candle4_anim
    ld  b
    st  candle3_spr_address
    ld  c
    st  candle3_spr_address+1
    jmpf    .skip_light_anim
.assign_candle4_anim
    ld  candle_number
    sub #4
    bnz .skip_light_anim
    ld  b
    st  candle4_spr_address
    ld  c
    st  candle4_spr_address+1
    jmpf    .skip_light_anim
.skip_light_anim

;=======================;
; Handle Unlit Candles  ;
;=======================;
    bp  candle5_spr_flags, 0, .skip_unlit_candle_1
    mov #<Candle_Unlit_Top, acc
    st candle1_spr_address
    mov #>Candle_Unlit_Top, acc
    st candle1_spr_address+1
.skip_unlit_candle_1
    bp  candle5_spr_flags, 2, .skip_unlit_candle_2
    mov #<Candle_Unlit_Bottom_Left, acc
    st candle2_spr_address
    mov #>Candle_Unlit_Bottom_Left, acc
    st candle2_spr_address+1
.skip_unlit_candle_2
    bp  candle5_spr_flags, 4, .skip_unlit_candle_3
    mov #<Candle_Unlit_Top, acc
    st candle3_spr_address
    mov #>Candle_Unlit_Top, acc
    st candle3_spr_address+1
.skip_unlit_candle_3
    bp  candle5_spr_flags, 6, .skip_unlit_candle_4
    mov #<Candle_Unlit_Bottom_Right, acc
    st candle4_spr_address
    mov #>Candle_Unlit_Bottom_Right, acc
    st candle4_spr_address+1
.skip_unlit_candle_4

;=======================;
;  Handle Lit Candles   ;
;=======================;
    bn  candle5_spr_flags, 1, .skip_lit_candle_4
    mov #1, b
    call Animate_Candle
    ld b
    st candle1_spr_address
    ld c
    st candle1_spr_address+1
.skip_lit_candle_1
    bn  candle5_spr_flags, 3, .skip_lit_candle_4
    mov #2, b
    call Animate_Candle
    ld b
    st candle2_spr_address
    ld c
    st candle2_spr_address+1
.skip_lit_candle_2
    bn  candle5_spr_flags, 5, .skip_lit_candle_4
    mov #3, b
    call Animate_Candle
    ld b
    st candle3_spr_address
    ld c
    st candle3_spr_address+1
.skip_lit_candle_3
    bn  candle5_spr_flags, 7, .skip_lit_candle_4
    mov #4, b
    call Animate_Candle
    ld b
    st candle4_spr_address
    ld c
    st candle4_spr_address+1
.skip_lit_candle_4


;=======================;
;   Draw BG & Sprites   ;
;=======================;
    P_Draw_Background_Constant Advent_Wreath_BackGround
    P_Draw_Sprite   candle1_spr_address, candle1_xpos, candle1_ypos
    P_Draw_Sprite   candle2_spr_address, candle2_xpos, candle2_ypos
    P_Draw_Sprite   candle3_spr_address, candle3_xpos, candle3_ypos
    P_Draw_Sprite   candle4_spr_address, candle4_xpos, candle4_ypos
    Animate_Banner
    P_Draw_Sprite   scrolling_message_spr_addr, scrolling_message_x_pos, scrolling_message_y_pos
    P_Blit_Screen
    inc frame_counter
    bn  frame_counter, 2, .skip_frame_counter_reset
    mov #0, frame_counter
.skip_frame_counter_reset
    inc banner_frame_counter
    bn  banner_frame_counter, 6, .skip_banner_frame_counter_reset
    mov #0, banner_frame_counter
.skip_banner_frame_counter_reset
    jmpf    Main_Loop

Merry_Christmas_Loop:
    ld	p3
	bp	acc, T_BTN_B1, .Not_B2
    jmpf Main_Loop
.Not_B2
    mov #0, animating_bool
    mov #0, candle_number
    ; mov #0, frame_counter
    not1 frame_counter, 0
    mov #0, candle5_spr_flags
.draw_frame_1
    bp  frame_counter, 0, .draw_frame_2
    P_Draw_Background_Constant MerryChristmas_V1_Frame01
    jmpf    .MC_Loop
.draw_frame_2
    bn  frame_counter, 0, .MC_Loop
    P_Draw_Background_Constant MerryChristmas_V1_Frame02
    ; jmpf    .MC_Loop
.MC_Loop
    P_Blit_Screen
jmpf    Merry_Christmas_Loop

;=======================;
; Macros And Functions  ;
;=======================;
%macro  Light_Candle
    ld  candle_number
    sub #1
    bnz .set_candle_2_as_lighting
    set1 candle5_spr_flags, 0
    jmpf .done_setting_as_lighting
.set_candle_2_as_lighting
    ld  candle_number
    sub #2
    bnz .set_candle_3_as_lighting
    set1 candle5_spr_flags, 2
    jmpf .done_setting_as_lighting
.set_candle_3_as_lighting
    ld  candle_number
    sub #3
    bnz .set_candle_4_as_lighting
    set1 candle5_spr_flags, 4
    jmpf .done_setting_as_lighting
.set_candle_4_as_lighting
    ld  candle_number
    sub #4
    bnz .done_setting_as_lighting
    set1 candle5_spr_flags, 6
.done_setting_as_lighting

.Light_Top_Candle
    bn  candle_number, 0, .Light_Bottom_Candle
.frame0
    ld  frame_counter_lighting
    ; ld  frame_counter
    bnz .frame1
    mov #<Candle_Lighting_Top_0, acc
    st b
    mov #>Candle_Lighting_Top_0, acc
    st c
    jmpf    .done_animating
.frame1
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #1
    bnz .frame2
    mov #<Candle_Lighting_Top_1, acc
    st b
    mov #>Candle_Lighting_Top_1, acc
    st c
    jmpf    .done_animating
.frame2
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #2
    bnz .frame3
    mov #<Candle_Lighting_Top_2, acc
    st b
    mov #>Candle_Lighting_Top_2, acc
    st c
    jmpf    .done_animating
.frame3
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #3
    bnz .frame4
    mov #<Candle_Lighting_Top_3, acc
    st b
    mov #>Candle_Lighting_Top_3, acc
    st c
    jmpf    .done_animating
.frame4
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #4
    bnz .frame5
    mov #<Candle_Lighting_Top_4, acc
    st b
    mov #>Candle_Lighting_Top_4, acc ; mov #>Candle_Lighting_Top14 acc
    st c
    jmpf    .done_animating
.frame5
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #5
    bnz .skip_compiler_error_2
    jmpf .done_animating
.skip_compiler_error_2
    mov #<Candle_Lighting_Top_5, acc
    st b
    mov #>Candle_Lighting_Top_5, acc
    st c
    jmpf    .done_animating
.Light_Bottom_Candle
    bn  candle_number, 0, .fuck_you
    jmpf .done_animating
    .fuck_you
.frame0_bottom
    ld  frame_counter_lighting
    ; ld  frame_counter
    bnz .frame1_bottom
    bp  candle_number, 2, .frame0_bottom_right
    mov #<Candle_Lighting_Bottom_0, acc
    st b
    mov #>Candle_Lighting_Bottom_0, acc
    st c
    jmpf    .done_animating
.frame0_bottom_right
    mov #<Candle_Lighting_Bottom_Right_0, acc
    st b
    mov #>Candle_Lighting_Bottom_Right_0, acc
    st c
    jmpf    .done_animating
.frame1_bottom
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #1
    bnz .frame2_bottom
    bp  candle_number, 2, .frame1_bottom_right
    mov #<Candle_Lighting_Bottom_1, acc
    st b
    mov #>Candle_Lighting_Bottom_1, acc
    st c
    jmpf    .done_animating
.frame1_bottom_right
    mov #<Candle_Lighting_Bottom_Right_1, acc
    st b
    mov #>Candle_Lighting_Bottom_Right_1, acc
    st c
    jmpf    .done_animating
.frame2_bottom
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #2
    bnz .frame3_bottom
    bp  candle_number, 2, .frame2_bottom_right
    mov #<Candle_Lighting_Bottom_2, acc
    st b
    mov #>Candle_Lighting_Bottom_2, acc
    st c
    jmpf    .done_animating
.frame2_bottom_right
    mov #<Candle_Lighting_Bottom_Right_2, acc
    st b
    mov #>Candle_Lighting_Bottom_Right_2, acc
    st c
    jmpf    .done_animating
.frame3_bottom
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #3
    bnz .frame4_bottom
    bp  candle_number, 2, .frame3_bottom_right
    mov #<Candle_Lighting_Bottom_3, acc
    st b
    mov #>Candle_Lighting_Bottom_3, acc
    st c
    jmpf    .done_animating
.frame3_bottom_right
    mov #<Candle_Lighting_Bottom_Right_3, acc
    st b
    mov #>Candle_Lighting_Bottom_Right_3, acc
    st c
    jmpf    .done_animating
.frame4_bottom
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #4
    bnz .frame5_bottom
    bp  candle_number, 2, .frame4_bottom_right
    mov #<Candle_Lighting_Bottom_4, acc
    st b
    mov #>Candle_Lighting_Bottom_4, acc ; mov #>Candle_Lighting_Bottom14 acc
    st c
    jmpf    .done_animating
.frame4_bottom_right
    mov #<Candle_Lighting_Bottom_Right_4, acc
    st b
    mov #>Candle_Lighting_Bottom_Right_4, acc
    st c
    jmpf    .done_animating
.frame5_bottom
    ld  frame_counter_lighting
    ; ld  frame_counter
    sub #5
    bnz .done_animating
    bp  candle_number, 2, .frame5_bottom_right
    mov #<Candle_Lighting_Bottom_5, acc
    st b
    mov #>Candle_Lighting_Bottom_5, acc
    st c
    jmpf    .done_animating
.frame5_bottom_right
    mov #<Candle_Lighting_Bottom_Right_5, acc
    st b
    mov #>Candle_Lighting_Bottom_Right_5, acc
    st c
    jmpf    .done_animating
.done_animating
    inc frame_counter_lighting
    ld  frame_counter_lighting
    sub #6
    bnz .keep_animating
.set_candle_1_as_lit
    ld  candle_number
    sub #1
    bnz .set_candle_2_as_lit
    set1 candle5_spr_flags, 1
    jmpf .inc_candle_number
.set_candle_2_as_lit
    ld  candle_number
    sub #2
    bnz .set_candle_3_as_lit
    set1 candle5_spr_flags, 3
    jmpf .inc_candle_number
.set_candle_3_as_lit
    ld  candle_number
    sub #3
    bnz .set_candle_4_as_lit
    set1 candle5_spr_flags, 5
    jmpf .inc_candle_number
.set_candle_4_as_lit
    ld  candle_number
    sub #4
    bnz .inc_candle_number
    set1 candle5_spr_flags, 7
    jmpf .inc_candle_number
.inc_candle_number
    inc candle_number
    mov #0, frame_counter_lighting
    mov #0, animating_bool
.keep_animating
%end

Animate_Candle:
;=======================;
;     Top Candles       ;
;=======================;
.animate_lit_candle_1
    bn b, 0, .animate_lit_candle_2
    ;ld b
    ;sub #1
    ;bnz .animate_lit_candle_2
.lit_candle_1_frame_0
    ld frame_counter
    bnz .lit_candle_1_frame_1
    mov #<Candle_Lit_Top_0, b
    mov #>Candle_Lit_Top_0, c
    ret
.lit_candle_1_frame_1
    ld frame_counter
    sub #1
    bnz .lit_candle_1_frame_2
    mov #<Candle_Lit_Top_1, b
    mov #>Candle_Lit_Top_1, c
    ret
.lit_candle_1_frame_2
    ld frame_counter
    sub #2
    bnz .lit_candle_1_frame_3
    mov #<Candle_Lit_Top_2, b
    mov #>Candle_Lit_Top_2, c
    ret
.lit_candle_1_frame_3
    ld frame_counter
    sub #3
    bnz .done_animating_candle
    mov #<Candle_Lit_Top_3, b
    mov #>Candle_Lit_Top_3, c
    ret
    
;=======================;
;    Bottom Candles     ;
;=======================;
.animate_lit_candle_2
    bp b, 0, .done_animating_candle
    bp b, 2, .animate_lit_candle_4
.lit_candle_2_frame_0
    ld frame_counter
    bnz .lit_candle_2_frame_1
    mov #<Candle_Lit_Bottom_Left_0, b
    mov #>Candle_Lit_Bottom_Left_0, c
    ret
.lit_candle_2_frame_1
    ld frame_counter
    sub #1
    bnz .lit_candle_2_frame_2
    mov #<Candle_Lit_Bottom_Left_1, b
    mov #>Candle_Lit_Bottom_Left_1, c
    ret
.lit_candle_2_frame_2
    ld frame_counter
    sub #2
    bnz .lit_candle_2_frame_3
    mov #<Candle_Lit_Bottom_Left_2, b
    mov #>Candle_Lit_Bottom_Left_2, c
    ret
.lit_candle_2_frame_3
    ld frame_counter
    sub #3
    bnz .done_animating_candle
    mov #<Candle_Lit_Bottom_Left_3, b
    mov #>Candle_Lit_Bottom_Left_3, c
    ret

.animate_lit_candle_4
.lit_candle_4_frame_0
    ld frame_counter
    bnz .lit_candle_4_frame_1
    mov #<Candle_Lit_Bottom_Right_0, b
    mov #>Candle_Lit_Bottom_Right_0, c
    ret
.lit_candle_4_frame_1
    ld frame_counter
    sub #1
    bnz .lit_candle_4_frame_2
    mov #<Candle_Lit_Bottom_Right_1, b
    mov #>Candle_Lit_Bottom_Right_1, c
    ret
.lit_candle_4_frame_2
    ld frame_counter
    sub #2
    bnz .lit_candle_4_frame_3
    mov #<Candle_Lit_Bottom_Right_2, b
    mov #>Candle_Lit_Bottom_Right_2, c
    ret
.lit_candle_4_frame_3
    ld frame_counter
    sub #3
    bnz .done_animating_candle
    mov #<Candle_Lit_Bottom_Right_3, b
    mov #>Candle_Lit_Bottom_Right_3, c
    ret    
.done_animating_candle
    ret

;=======================;
;  Happy Advent Banner  ;
;=======================;
%macro  Animate_Banner
    inc banner_counter
    bp  banner_counter, 5, .update_banner_state
    jmpf .skip_banner_reset
.update_banner_state
    not1 banner_state, 0
    mov #0, banner_counter
.skip_banner_reset
.Draw_Happy
    ld  banner_state
    bnz .Draw_Advent
    mov #<Happy_Advent_Banner_Happy, acc
    st scrolling_message_spr_addr
    mov #>Happy_Advent_Banner_Happy, acc
    st scrolling_message_spr_addr+1
    jmpf .done_drawing_banner
.Draw_Advent
    ld  banner_state
    bz .done_drawing_banner
    mov #<Happy_Advent_Banner_Advent, acc
    st scrolling_message_spr_addr
    mov #>Happy_Advent_Banner_Advent, acc
    st scrolling_message_spr_addr+1
.done_drawing_banner
%end

;=======================;
;  Include Images/Libs  ;
;=======================;
    .include        "./lib/libperspective.asm"
    .include        "./lib/libkcommon.asm"
    .include        "./img/AdventWreath_BackGround.asm"
    .include        "./img/Candle_Unlit_Top.asm"
    .include        "./img/Candle_Unlit_Bottom_Left.asm"
    .include        "./img/Candle_Unlit_Bottom_Right.asm"
    .include        "./img/Candle_Lit_Top_0.asm"
    .include        "./img/Candle_Lit_Top_1.asm"
    .include        "./img/Candle_Lit_Top_2.asm"
    .include        "./img/Candle_Lit_Top_3.asm"
    .include        "./img/Candle_Lit_Bottom_Left_0.asm"
    .include        "./img/Candle_Lit_Bottom_Left_1.asm"
    .include        "./img/Candle_Lit_Bottom_Left_2.asm"
    .include        "./img/Candle_Lit_Bottom_Left_3.asm"
    .include        "./img/Candle_Lit_Bottom_Right_0.asm"
    .include        "./img/Candle_Lit_Bottom_Right_1.asm"
    .include        "./img/Candle_Lit_Bottom_Right_2.asm"
    .include        "./img/Candle_Lit_Bottom_Right_3.asm"
    .include        "./img/Candle_Lighting_Top_0.asm"
    .include        "./img/Candle_Lighting_Top_1.asm"
    .include        "./img/Candle_Lighting_Top_2.asm"
    .include        "./img/Candle_Lighting_Top_3.asm"
    .include        "./img/Candle_Lighting_Top_4.asm"
    .include        "./img/Candle_Lighting_Top_5.asm"
    .include        "./img/Candle_Lighting_Bottom_0.asm"
    .include        "./img/Candle_Lighting_Bottom_1.asm"
    .include        "./img/Candle_Lighting_Bottom_2.asm"
    .include        "./img/Candle_Lighting_Bottom_3.asm"
    .include        "./img/Candle_Lighting_Bottom_4.asm"
    .include        "./img/Candle_Lighting_Bottom_5.asm"
    .include        "./img/Candle_Lighting_Bottom_Right_0.asm"
    .include        "./img/Candle_Lighting_Bottom_Right_1.asm"
    .include        "./img/Candle_Lighting_Bottom_Right_2.asm"
    .include        "./img/Candle_Lighting_Bottom_Right_3.asm"
    .include        "./img/Candle_Lighting_Bottom_Right_4.asm"
    .include        "./img/Candle_Lighting_Bottom_Right_5.asm"
    .include        "./img/Happy_Advent_Banner_Happy.asm"
    .include        "./img/Happy_Advent_Banner_Advent.asm"
    .include        "./img/MerryChristmas_V1_Frame01.asm"
    .include        "./img/MerryChristmas_V1_Frame02.asm"

	.cnop	0,$200		; Pad To An Even Number Of Blocks
