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
candle2_xpos            =       $6c     ; 1 Byte
candle2_ypos            =       $6d     ; 1 Byte
candle2_spr_address     =       $6e     ; 2 Bytes
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
current_hour            =       $5c     ; 1 Byte
current_minute          =       $5d     ; 1 Byte
current_second          =       $5e     ; 1 Byte
ticker_timer            =       $5f     ; 1 Byte
current_cursor          =       $62     ; 1 Byte
options_flags           =       $65     ; 1 Byte.  Options_Flags: 0: Options Screen On/Off. 1: Current Cursor. 2: Auto Time Bool. 3: Language_Choice. 4: TimeOfDay_Choice. 5: Auto Time Choice. 
language_sprite_address =       $66     ; 2 Bytes
button_interrupt        =       $68     ; 1 Byte ; If This Isn't 0, Decrement It. If It's Not Zero, Ignore Input Calls.   
timeofday_sprite_address=       $69     ; 2 Bytes
options_graphic_sprite_address =$7b     ; 2 Bytes
current_month           =       $7d     ; 1 Byte
current_day             =       $7e     ; 1 Byte
;=======================;
;       Constants       ;
;=======================;
T_BTN_SLEEP              equ     7
T_BTN_MODE               equ     6
T_BTN_B1				 equ	 5
T_BTN_A1				 equ	 4
T_BTN_RIGHT1             equ     3
T_BTN_LEFT1              equ     2
T_BTN_DOWN1              equ     1
T_BTN_UP1                equ     0

;=======================;
;	Prepare Application	;
;=======================;
    .org	$00
	jmpf	start

	.org	$03
	jmp	nop_irq

	.org	$0b
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

; Via LibPerspective: Trying To Get It To Work On VMU Hardware.
.org    $54B
;Start:
    mov     #$a1, ocr
    mov     #%00001001, mcr
    mov     #$80, vccr
    mov     #$20, acc
    push    acc

    mov     #$ff, p3
    mov     #$80, sp
    mov     #%10000000, ie
    clr1    psw, 3
    clr1    psw, 4
    mov     #$05, acc
    push    acc

    mov     #$80, p1fcr
    clr1    p1,7
    mov     #$80, p1ddr

    ; Disable battery check
    ; clr1    psw, 1
    ; mov     #$ff, $006E
    ; set1    psw, 1

    ; ???
    ret

    ; Initialise the p3_last_input
    mov     #%11111111, p3_last_input

start:
    clr1    psw,1
    ld  $1c				; Second System Variables, Via Marcus's Tetris.S
    set1    psw,1
    st  current_minute
    clr1    psw,1
    ld  $1d			; Minute System Variables
    set1    psw,1
    st  current_second
    clr1    psw,1
    ld  $1b;e		; Hour System Variables
    set1    psw,1
    st  current_hour
    clr1    psw,1
    ld  $19 ; Start It As Auto, Then Have It As Auto In The Menu And Let The User Change That Option To Day/Night.
    set1    psw,1		; Month System Variables
    st  current_month
    clr1    psw,1
    ld  $1a			; Day System Variables
    set1    psw,1
    st  current_day
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
    mov #0, ticker_timer
    mov #0, options_flags
    set1    options_flags, 2
    mov #0, button_interrupt
    mov #<Options_Graphic_AutoTime, acc
    st options_graphic_sprite_address
    mov #>Options_Graphic_AutoTime, acc 
    st options_graphic_sprite_address+1
    ; mov #15, candle5_spr_flags
	 
    ; ToDo: Expand This Functionality To Work In Any Year, Using The Calendar/Day Of The Week (It's Currently Doing Just The Dates For 2022.).
.check_internal_time  	 
    ; Read The Hour. If It's <5 P.M. < Here < 6:40 A.M. Or 7 >, Use The NightTime BackGround.
.check_january
    ; Check If It's January:
    ld  current_month
    sub #1
    bnz .check_november_december
    mov #7, candle5_spr_flags
.check_november_december
    ld    current_month
    sub   #11
    bp    acc, 7, .check_internal_time_day
.check_internal_time_candle_1
    ld    current_month
    sub   #12
    bn    acc, 7, .check_internal_time_candle_4
    ld    current_day
    sub   #27
    bp    acc, 7, .check_internal_time_day
    mov   #3, candle5_spr_flags
    jmpf  .check_internal_time_day
.check_internal_time_candle_4
    ld  current_day
    sub #18
    bp  acc, 7, .check_internal_time_candle_3
    mov #31, candle5_spr_flags
    jmpf    .check_internal_time_day
.check_internal_time_candle_3
    ld  current_day
    sub #11
    bp  acc, 7, .check_internal_time_candle_2
    mov #15, candle5_spr_flags
    jmpf    .check_internal_time_day
.check_internal_time_candle_2
    ld  current_day ; ld    current_month
    sub #4
    bp  acc, 7, .check_internal_time_day
    mov #7, candle5_spr_flags

.check_internal_time_day
    ld    current_hour
    sub   #7
    bp    acc, 7, .check_internal_time_night
    ld  current_hour
    sub #17
    bn  acc, 7, .check_internal_time_night
    clr1    options_flags, 5
    callf   assign_graphics_day
    jmpf    .check_internal_time_done
.check_internal_time_night
    set1    options_flags, 5
    callf   assign_graphics_night
.check_internal_time_done  
    callf   assign_graphics_auto

Main_Loop:
;=======================;
; Handle Input
;=======================;
    callf   Get_Input ; Ensure We Can Enter Sleep Mode + Exit App With The Mode Button.
    ld	p3
    bn  acc, T_BTN_UP1, .GoTo_Options
    bn  acc, T_BTN_DOWN1, .GoTo_Options
    bn  acc, T_BTN_LEFT1, .GoTo_Options
    bn  acc, T_BTN_RIGHT1, .GoTo_Options
    jmpf    .GoTo_MainScreen
.GoTo_Options 
    set1    options_flags, 0
    ; mov #3, button_interrupt
.GoTo_MainScreen
	bp	acc, T_BTN_B1, .Not_B
    ld  candle_number
    sub #5
    bp  acc, 7, .keep_lighting
    jmpf Merry_Christmas_Loop
.keep_lighting
    mov #1, animating_bool
.Not_B
    ld  p3
    bp  acc, T_BTN_A1, .Not_A
    ld  candle_number
    sub #5
    bp  acc, 7, .keep_lighting
    jmpf Merry_Christmas_Loop
.Not_A
    bp options_flags, 0, .draw_options_screen
    jmpf    .options_screen_done

;=======================;
;    Options Screen     ;
;=======================;
.draw_options_screen
; Check Button Interrupt/Handle Inputs
    ld  button_interrupt
    bz .skip_button_interrupt_decrement
    dec button_interrupt
.skip_button_interrupt_decrement
; Handle Input
    callf   Get_Input ; Ensure We Can Enter Sleep Mode + Exit App With The Mode Button.
    ld  button_interrupt
    bnz  .check_options_buttons ; .cursor_choice_language    ; Skip Options Input Check If The Interrupt Is Enabled, To Prevent The Cursor From Flying Everywhere
.check_options_up    
    ld  p3
    bp  acc, T_BTN_UP1, .check_options_down
    not1    options_flags, 1
    mov #5, button_interrupt
    jmpf  .check_options_buttons
.check_options_down
    ld  p3
    bp  acc, T_BTN_DOWN1, .check_options_buttons
    mov #5, button_interrupt
    not1    options_flags, 1 
.check_options_buttons
    callf	Get_Input
	mov		#Button_B, acc
	callf	Check_Button_Pressed
	bz		.options_not_b
    clr1    options_flags, 0
    mov     #0, acc
.options_not_b 
    ; callf	Get_Input
    ; mov #Button_A, acc
    ; callf   Check_Button_Pressed
    ; bz  .cursor_choice_language
    ld  p3
    bp  acc, T_BTN_A1, .cursor_choice_language
     mov     #255, acc
    clr1    options_flags, 0
.exit_options
    clr1    options_flags, 0

;-----------------------;
; Cursor Is On "Language" Choice ;
;-----------------------;
.cursor_choice_language
    bn  options_flags, 1, .language_swap_left ; Address Will Be Out Of Range With: ; bp  options_flags, 1, .cursor_choice_time
    jmpf    .cursor_choice_time
.language_swap_left    
    ld  button_interrupt
    bnz .language_swap_done
    ld  p3 ; callf	Get_Input
    bn  acc, T_BTN_LEFT1, .language_swap_right
    mov #5, button_interrupt
    not1    options_flags, 3
.language_swap_right    
    ld  p3 ; callf	Get_Input
    bn  acc, T_BTN_RIGHT1, .language_swap_done
    mov #5, button_interrupt
    not1    options_flags, 3
.language_swap_done

; Draw Top Option (Language, Highlighted)
.draw_highlighted_language_english
    bp  options_flags, 3, .draw_highlighted_language_italian
    mov #<Language_Highlighted_English, language_sprite_address
    mov #>Language_Highlighted_English, language_sprite_address+1
    mov #<Options_Graphic_Text_English, acc
    st options_graphic_sprite_address
    mov #>Options_Graphic_Text_English, acc
    st options_graphic_sprite_address+1
    jmpf    .draw_language_timeauto_english
.draw_highlighted_language_italian
    bn  options_flags, 3, .draw_language_timeauto_english
    mov #<Lingua_Evidenziato_Italiano, language_sprite_address
    mov #>Lingua_Evidenziato_Italiano, language_sprite_address+1
    mov #<Opzioni_Grafici_Testo_Italiano, acc
    st  options_graphic_sprite_address
    mov #>Opzioni_Grafici_Testo_Italiano, acc
    st  options_graphic_sprite_address+1
; Draw Bottom Option (Time Of Day, Not Highlighted)
.draw_language_timeauto_english
    bp  options_flags, 3, .draw_language_timeauto_italian
    bn  options_flags, 2, .draw_language_timeday_english
    mov #<TimeOfDay_Auto, timeofday_sprite_address
    mov #>TimeOfDay_Auto, timeofday_sprite_address+1
    jmpf    .Blit_Options_Screen
.draw_language_timeday_english
    bp  options_flags, 2, .cursor_choice_time
    bp options_flags, 4, .draw_language_timenight_english
    mov #<TimeOfDay_Day, timeofday_sprite_address
    mov #>TimeOfDay_Day, timeofday_sprite_address+1
    jmpf    .Blit_Options_Screen
.draw_language_timenight_english
    bn options_flags, 4, .cursor_choice_time
    mov #<TimeOfDay_Night, timeofday_sprite_address
    mov #>TimeOfDay_Night, timeofday_sprite_address+1
.draw_language_timeauto_italian
    bn  options_flags, 3, .cursor_choice_time
    bn  options_flags, 2, .draw_language_timeday_italian
    mov #<OraDelGiorno_Auto, timeofday_sprite_address
    mov #>OraDelGiorno_Auto, timeofday_sprite_address+1
    jmpf    .blit_options_screen
.draw_language_timeday_italian
    bp options_flags, 2, .cursor_choice_time
    bp  options_flags, 4, .draw_language_timenight_italian
    mov #<OraDelGiorno_Giorno, timeofday_sprite_address
    mov #>OraDelGiorno_Giorno, timeofday_sprite_address+1
    jmpf    .blit_options_screen
.draw_language_timenight_italian
    bn  options_flags, 4, .cursor_choice_time
    mov #<OraDelGiorno_Notte, timeofday_sprite_address
    mov #>OraDelGiorno_Notte, timeofday_sprite_address+1
    jmpf    .blit_options_screen

;-----------------------;
; Cursor Is On "Time Of Day" Option
;-----------------------;
.cursor_choice_time
    bp  options_flags, 1, .check_timeofday_cursor_input
    jmpf    .blit_options_screen
.check_timeofday_cursor_input
    ld  button_interrupt
    bnz .timeofday_swap_done
.timeofday_swap_left
    ld  p3
    bp  acc, T_BTN_LEFT1, .timeofday_swap_right
.timeofday_swap_left_auto
    bn  options_flags, 2, .timeofday_swap_left_day
    set1    options_flags, 4
    clr1    options_flags, 2
    callf assign_graphics_night
    mov #5, button_interrupt
    jmpf    .timeofday_swap_done
.timeofday_swap_left_day
    bp  options_flags, 4, .timeofday_swap_left_night
    clr1    options_flags, 4
    set1    options_flags, 2
    mov #5, button_interrupt
    callf assign_graphics_auto
    jmpf    .timeofday_swap_done
.timeofday_swap_left_night
    bn  options_flags, 4, .timeofday_swap_right
    clr1    options_flags, 4
    clr1    options_flags, 2
    callf assign_graphics_day
    mov #5, button_interrupt
    jmpf    .timeofday_swap_done
.timeofday_swap_right
    ld  p3
    bp  acc, T_BTN_RIGHT1, .timeofday_swap_done
.timeofday_swap_right_auto
    bn  options_flags, 2, .timeofday_swap_right_day
    clr1    options_flags, 4
    clr1    options_flags, 2
    callf assign_graphics_day
    mov #5, button_interrupt
    jmpf    .timeofday_swap_done
.timeofday_swap_right_day
    bp  options_flags, 4, .timeofday_swap_right_night
    set1    options_flags, 4
    clr1    options_flags, 2
    callf assign_graphics_night
    mov #5, button_interrupt
    jmpf    .timeofday_swap_done
.timeofday_swap_right_night
    bn  options_flags, 4, .timeofday_swap_right
    clr1    options_flags, 4
    set1    options_flags, 2
    mov #5, button_interrupt
    callf assign_graphics_auto
    jmpf    .timeofday_swap_done
.timeofday_swap_done

; Draw Bottom Option (Time Of Day BackGround, Highlighted)
.draw_highlighted_timeofday_english_auto
    bp  options_flags, 3, .draw_highlighted_timeofday_italian_auto
    bn  options_flags, 2, .draw_highlighted_timeofday_english_day
    mov #<TimeOfDay_Highlighted_Auto, timeofday_sprite_address
    mov #>TimeOfDay_Highlighted_Auto, timeofday_sprite_address+1
    mov #<Options_Graphic_AutoTime, acc
    st options_graphic_sprite_address
    mov #>Options_Graphic_AutoTime, acc
    st options_graphic_sprite_address+1
    jmpf    .draw_language_english
.draw_highlighted_timeofday_english_day
    bp  options_flags, 4, .draw_highlighted_timeofday_english_night
    mov #<TimeOfDay_Highlighted_Day, timeofday_sprite_address
    mov #>TimeOfDay_Highlighted_Day, timeofday_sprite_address+1
    mov #<Options_Graphic_DayTime, acc
    st options_graphic_sprite_address
    mov #>Options_Graphic_DayTime, acc
    st options_graphic_sprite_address+1
    jmpf    .draw_language_english
.draw_highlighted_timeofday_english_night
    bn  options_flags, 4, .blit_options_screen
    mov #<TimeOfDay_Highlighted_Night, timeofday_sprite_address
    mov #>TimeOfDay_Highlighted_Night, timeofday_sprite_address+1
    mov #<Options_Graphic_NightTime, acc
    st options_graphic_sprite_address
    mov #>Options_Graphic_NightTime, acc
    st options_graphic_sprite_address+1
    jmpf    .draw_language_english
.draw_highlighted_timeofday_italian_auto
    bn  options_flags, 3, .blit_options_screen
    bn  options_flags, 2, .draw_highlighted_timeofday_italian_day
    mov #<OraDelGiorno_Evidenziato_Auto, timeofday_sprite_address
    mov #>OraDelGiorno_Evidenziato_Auto, timeofday_sprite_address+1
    mov #<Options_Graphic_AutoTime, acc
    st options_graphic_sprite_address
    mov #>Options_Graphic_AutoTime, acc
    st options_graphic_sprite_address+1
    jmpf    .draw_language_english
.draw_highlighted_timeofday_italian_day
    bp  options_flags, 4, .draw_highlighted_timeofday_italian_night
    mov #<OraDelGiorno_Evidenziato_Giorno, timeofday_sprite_address
    mov #>OraDelGiorno_Evidenziato_Giorno, timeofday_sprite_address+1
    mov #<Options_Graphic_DayTime, acc
    st options_graphic_sprite_address
    mov #>Options_Graphic_DayTime, acc
    st options_graphic_sprite_address+1
    jmpf    .draw_language_english
.draw_highlighted_timeofday_italian_night
    bn  options_flags, 4, .blit_options_screen
    mov #<OraDelGiorno_Evidenziato_Notte, timeofday_sprite_address
    mov #>OraDelGiorno_Evidenziato_Notte, timeofday_sprite_address+1
    mov #<Options_Graphic_NightTime, acc
    st options_graphic_sprite_address
    mov #>Options_Graphic_NightTime, acc
    st options_graphic_sprite_address+1
    jmpf    .draw_language_english
; Draw Top Option (Language, Not Highlighted)
.draw_language_english
    bp  options_flags, 3, .draw_language_italian
    mov #<Language_English, language_sprite_address
    mov #>Language_English, language_sprite_address+1
    jmpf    .blit_options_screen
.draw_language_italian
    bn  options_flags, 3, .blit_options_screen
    mov #<Lingua_Italiano, language_sprite_address
    mov #>Lingua_Italiano, language_sprite_address+1
.blit_options_screen
    P_Draw_Background_Constant  OptionsScreen_BackGround
    mov #0, b
    mov #0, c
    P_Draw_Sprite   options_graphic_sprite_address, b, c
    mov #0, b
    mov #16, c
    P_Draw_Sprite language_sprite_address, b, c
    mov #0, b
    mov #24, c
    P_Draw_Sprite timeofday_sprite_address, b, c
    P_Blit_Screen
    jmpf    Main_Loop
.options_screen_done

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
.handle_unlit_candles_day
    bp  options_flags, 4, .handle_unlit_candles_night
    bp  candle5_spr_flags, 0, .skip_unlit_candle_1_day
    mov #<Candle_Unlit_Day_Bottom, acc
    st candle1_spr_address
    mov #>Candle_Unlit_Day_Bottom, acc
    st candle1_spr_address+1
.skip_unlit_candle_1_day
    bp  candle5_spr_flags, 2, .skip_unlit_candle_2_day
    mov #<Candle_Unlit_Day_Bottom, acc
    st candle2_spr_address
    mov #>Candle_Unlit_Day_Bottom, acc
    st candle2_spr_address+1
.skip_unlit_candle_2_day
    bp  candle5_spr_flags, 4, .skip_unlit_candle_3_day
    mov #<Candle_Unlit_Day_Top, acc
    st candle3_spr_address
    mov #>Candle_Unlit_Day_Top, acc
    st candle3_spr_address+1
.skip_unlit_candle_3_day
    bp  candle5_spr_flags, 6, .skip_unlit_candle_4_day
    mov #<Candle_Unlit_Day_Top, acc
    st candle4_spr_address
    mov #>Candle_Unlit_Day_Top, acc
    st candle4_spr_address+1
.skip_unlit_candle_4_day
.handle_unlit_candles_night
    bn  options_flags, 4, .skip_unlit_candle_4
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
    callf Animate_Candle
    ld b
    st candle1_spr_address
    ld c
    st candle1_spr_address+1
.skip_lit_candle_1
    bn  candle5_spr_flags, 3, .skip_lit_candle_4
    mov #2, b
    callf Animate_Candle
    ld b
    st candle2_spr_address
    ld c
    st candle2_spr_address+1
.skip_lit_candle_2
    bn  candle5_spr_flags, 5, .skip_lit_candle_4
    mov #3, b
    callf Animate_Candle
    ld b
    st candle3_spr_address
    ld c
    st candle3_spr_address+1
.skip_lit_candle_3
    bn  candle5_spr_flags, 7, .skip_lit_candle_4
    mov #4, b
    callf Animate_Candle
    ld b
    st candle4_spr_address
    ld c
    st candle4_spr_address+1
.skip_lit_candle_4


;=======================;
;   Draw BG & Sprites   ;
;=======================;
.draw_background_day
    bp  options_flags, 4, .draw_background_night
    P_Draw_Background_Constant Advent_Wreath_BackGround_Day ; MPG_TSBG
.draw_background_night
    bn  options_flags, 4, .draw_candle_sprite_animations
    P_Draw_Background_Constant Advent_Wreath_BackGround ; P_Draw_Background_Constant MPG_TSBG ; P_Draw_Background_Constant Advent_Wreath_BackGround
.draw_candle_sprite_animations
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
    mov #$0, T1CNT
    jmpf    Main_Loop

Merry_Christmas_Loop:
    ld	p3
	bp	acc, T_BTN_B1, .Not_B2
    jmpf Main_Loop
.Not_B2
    ld	p3
	bp	acc, T_BTN_A1, .Not_A2
    jmpf Main_Loop
.Not_A2
    mov #0, animating_bool
    mov #0, candle_number
    ; mov #0, frame_counter
    not1 frame_counter, 0
    mov #0, candle5_spr_flags
.draw_frame_1_english
    bp  options_flags, 3, .draw_frame_1_italian
    bp  frame_counter, 0, .draw_frame_2_english
    P_Draw_Background_Constant MerryChristmas_V1_Frame01
    jmpf    .MC_Loop
.draw_frame_2_english
    bn  frame_counter, 0, .MC_Loop
    P_Draw_Background_Constant MerryChristmas_V1_Frame02
    ; jmpf    .MC_Loop
.draw_frame_1_italian
    bn  options_flags, 3, .MC_Loop ; draw_frame_1_italian
    bp  frame_counter, 0, .draw_frame_2_italian
    P_Draw_Background_Constant BuonNatale_1
    jmpf    .MC_Loop
.draw_frame_2_italian
    bn  frame_counter, 0, .MC_Loop
    P_Draw_Background_Constant BuonNatale_2
    ; jmpf    .MC_Loop
.MC_Loop
    callf   Get_Input ; Ensure We Can Enter Sleep Mode + Exit App With The Mode Button.
    P_Blit_Screen
    ; jmpf    start
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

.light_candle_day
    bn  options_flags, 4, .light_top_candle_day
    jmpf    .light_candle_night
.light_top_candle_day
    ld  candle_number
    sub #3
    bz  .frame0_top_day
    sub #1
    bz  .frame0_top_day
    jmpf    .light_bottom_candle_day
.frame0_top_day
    ld  frame_counter_lighting
    bnz .frame1_top_day
    mov #<Candle_Lighting_Day_Top_0, acc
    st  b
    mov #>Candle_Lighting_Day_Top_0, acc
    st  c
    jmpf    .done_animating
.frame1_top_day
    ld  frame_counter_lighting
    sub #1
    bnz .frame2_top_day
    mov #<Candle_Lighting_Day_Top_1, acc
    st  b
    mov #>Candle_Lighting_Day_Top_1, acc
    st  c
    jmpf    .done_animating
.frame2_top_day
    ld  frame_counter_lighting
    sub #2
    bnz .frame3_top_day
    mov #<Candle_Lighting_Day_Top_2, acc
    st  b
    mov #>Candle_Lighting_Day_Top_2, acc
    st  c
    jmpf    .done_animating
.frame3_top_day
    ld  frame_counter_lighting
    sub #3
    bnz .frame4_top_day
    mov #<Candle_Lighting_Day_Top_3, acc
    st  b
    mov #>Candle_Lighting_Day_Top_3, acc
    st  c
    jmpf    .done_animating
.frame4_top_day
    ld  frame_counter_lighting
    sub #4
    bnz .frame5_top_day
    mov #<Candle_Lighting_Day_Top_4, acc
    st  b
    mov #>Candle_Lighting_Day_Top_4, acc
    st  c
    jmpf    .done_animating
.frame5_top_day
    ld  frame_counter_lighting
    sub #5
    bz  .skip_compiler_error_rename_this
    jmpf    .done_animating
.skip_compiler_error_rename_this
    mov #<Candle_Lighting_Day_Top_3, acc
    st  b
    mov #>Candle_Lighting_Day_Top_3, acc
    st  c
    jmpf    .done_animating
.light_bottom_candle_day
.frame0_bottom_day
    ld  frame_counter_lighting
    bnz .frame1_bottom_day
    mov #<Candle_Lighting_Day_Bottom_0, acc
    st  b
    mov #>Candle_Lighting_Day_Bottom_0, acc
    st  c
    jmpf    .done_animating
.frame1_bottom_day
    ld  frame_counter_lighting
    sub #1
    bnz .frame2_bottom_day
    mov #<Candle_Lighting_Day_Bottom_1, acc
    st  b
    mov #>Candle_Lighting_Day_Bottom_1, acc
    st  c
    jmpf    .done_animating
.frame2_bottom_day
    ld  frame_counter_lighting
    sub #2
    bnz .frame3_bottom_day
    mov #<Candle_Lighting_Day_Bottom_2, acc
    st  b
    mov #>Candle_Lighting_Day_Bottom_2, acc
    st  c
    jmpf    .done_animating
.frame3_bottom_day
    ld  frame_counter_lighting
    sub #3
    bnz .frame4_bottom_day
    mov #<Candle_Lighting_Day_Bottom_3, acc
    st  b
    mov #>Candle_Lighting_Day_Bottom_3, acc
    st  c
    jmpf    .done_animating
.frame4_bottom_day
    ld  frame_counter_lighting
    sub #4
    bnz .frame5_bottom_day
    mov #<Candle_Lighting_Day_Bottom_4, acc
    st  b
    mov #>Candle_Lighting_Day_Bottom_4, acc
    st  c
    jmpf    .done_animating
.frame5_bottom_day
    ld  frame_counter_lighting
    sub #5
    bz  .skip_compiler_error_rename_this2
    jmpf    .done_animating
.skip_compiler_error_rename_this2
    mov #<Candle_Lighting_Day_Bottom_4, acc
    st  b
    mov #>Candle_Lighting_Day_Bottom_4, acc
    st  c
    jmpf    .done_animating

.light_candle_night
    bp  options_flags, 4, .Light_Top_Candle
    jmpf    .lighting_candle_done
.Light_Top_Candle
    bn  candle_number, 0, .Light_Bottom_Candle
.frame0
    ld  frame_counter_lighting
    bnz .frame1
    mov #<Candle_Lighting_Top_0, acc
    st b
    mov #>Candle_Lighting_Top_0, acc
    st c
    jmpf    .done_animating
.frame1
    ld  frame_counter_lighting
    sub #1
    bnz .frame2
    mov #<Candle_Lighting_Top_1, acc
    st b
    mov #>Candle_Lighting_Top_1, acc
    st c
    jmpf    .done_animating
.frame2
    ld  frame_counter_lighting
    sub #2
    bnz .frame3
    mov #<Candle_Lighting_Top_2, acc
    st b
    mov #>Candle_Lighting_Top_2, acc
    st c
    jmpf    .done_animating
.frame3
    ld  frame_counter_lighting
    sub #3
    bnz .frame4
    mov #<Candle_Lighting_Top_3, acc
    st b
    mov #>Candle_Lighting_Top_3, acc
    st c
    jmpf    .done_animating
.frame4
    ld  frame_counter_lighting
    sub #4
    bnz .frame5
    mov #<Candle_Lighting_Top_4, acc
    st b
    mov #>Candle_Lighting_Top_4, acc ; mov #>Candle_Lighting_Top14 acc
    st c
    jmpf    .done_animating
.frame5
    ld  frame_counter_lighting
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
    bn  candle_number, 0, .frame0_bottom
    jmpf .done_animating
.frame0_bottom
    ld  frame_counter_lighting
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
.lighting_candle_done
%end

Animate_Candle:
;=======================;
;     Top Candles       ;
;=======================;
.animate_top_candles_day
    bp  options_flags, 4, .animate_top_candles_night
    ld  b
    sub #3
    bn  acc, 7, .animate_lit_candle_1_top_day
    jmpf    .animate_lit_candle_1_frame_0_bottom_day
.animate_lit_candle_1_top_day
.lit_candle_1_frame_0_top_day
    ld frame_counter
    bnz .lit_candle_1_frame_1_top_day
    mov #<Candle_Lit_Day_Top_0, b
    mov #>Candle_Lit_Day_Top_0, c
    ret
.lit_candle_1_frame_1_top_day
    ld frame_counter
    sub #1
    bnz .lit_candle_1_frame_2_top_day
    mov #<Candle_Lit_Day_Top_1, b
    mov #>Candle_Lit_Day_Top_1, c
    ret
.lit_candle_1_frame_2_top_day
    ld frame_counter
    sub #2
    bnz .lit_candle_1_frame_3_top_day
    mov #<Candle_Lit_Day_Top_2, b
    mov #>Candle_Lit_Day_Top_2, c
    ret
.lit_candle_1_frame_3_top_day
    ld frame_counter
    sub #3
    bz  .animate_lit_candle1_frame_3_top_day
    jmpf    .done_animating_candle
.animate_lit_candle1_frame_3_top_day
    mov #<Candle_Lit_Day_Top_3, b
    mov #>Candle_Lit_Day_Top_3, c
    ret

.animate_lit_candle_1_frame_0_bottom_day
    ld frame_counter
    bnz .lit_candle_1_frame_1_bottom_day
    mov #<Candle_Lit_Day_Bottom_0, b
    mov #>Candle_Lit_Day_Bottom_0, c
    ret
.lit_candle_1_frame_1_bottom_day
    ld frame_counter
    sub #1
    bnz .lit_candle_1_frame_2_bottom_day
    mov #<Candle_Lit_Day_Bottom_1, b
    mov #>Candle_Lit_Day_Bottom_1, c
    ret
.lit_candle_1_frame_2_bottom_day
    ld frame_counter
    sub #2
    bnz .lit_candle_1_frame_3_bottom_day
    mov #<Candle_Lit_Day_Bottom_2, b
    mov #>Candle_Lit_Day_Bottom_2, c
    ret
.lit_candle_1_frame_3_bottom_day
    ld frame_counter
    sub #3
    bz  .animate_lit_candle1_frame_3_bottom_day
    jmpf    .done_animating_candle
.animate_lit_candle1_frame_3_bottom_day
    mov #<Candle_Lit_Day_Bottom_3, b
    mov #>Candle_Lit_Day_Bottom_3, c
    ret

.animate_top_candles_night
.animate_lit_candle_1
    bn b, 0, .animate_lit_candle_2
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
    bn  options_flags, 4, .Draw_Happy_English_Day
    jmpf .Draw_Happy_English_Night
.Draw_Happy_English_Day
    bp  options_flags, 3, .Dipinge_Buon_Italiano_Giorno
    ld  banner_state
    bnz .Draw_Advent_English_Day
    mov #<Happy_Advent_Banner_Day_Happy, acc
    st scrolling_message_spr_addr
    mov #>Happy_Advent_Banner_Day_Happy, acc
    st scrolling_message_spr_addr+1
    jmpf .done_drawing_banner
.Draw_Advent_English_Day
    ld  banner_state
    bz  .Dipinge_Buon_Italiano_Giorno
    mov #<Happy_Advent_Banner_Day_Advent, acc
    st scrolling_message_spr_addr
    mov #>Happy_Advent_Banner_Day_Advent, acc
    st scrolling_message_spr_addr+1
.Dipinge_Buon_Italiano_Giorno
    bn  options_flags, 3, .done_drawing_banner
    ld  banner_state
    bnz .Dipinge_Avvento_Italiano_Giorno
    mov #<Buon_Avvento_Striscione_Giorno_Buon, acc
    st scrolling_message_spr_addr
    mov #>Buon_Avvento_Striscione_Giorno_Buon, acc
    st scrolling_message_spr_addr+1
    jmpf .done_drawing_banner
.Dipinge_Avvento_Italiano_Giorno
    bn  options_flags, 3, .done_drawing_banner
    ld  banner_state
    bz .Draw_Happy_English_Night
    mov #<Buon_Avvento_Striscione_Giorno_Avvento, acc
    st scrolling_message_spr_addr
    mov #>Buon_Avvento_Striscione_Giorno_Avvento, acc
    st scrolling_message_spr_addr+1
    jmpf .done_drawing_banner
.Draw_Happy_English_Night
    bp  options_flags, 3, .Dipinge_Buon_Italiano_Notte
    ld  banner_state
    bnz .Draw_Advent_English_Night
    mov #<Happy_Advent_Banner_Happy, acc
    st scrolling_message_spr_addr
    mov #>Happy_Advent_Banner_Happy, acc
    st scrolling_message_spr_addr+1
    jmpf .done_drawing_banner
.Draw_Advent_English_Night
    ld  banner_state
    bz  .Dipinge_Buon_Italiano_Notte
    mov #<Happy_Advent_Banner_Advent, acc
    st scrolling_message_spr_addr
    mov #>Happy_Advent_Banner_Advent, acc
    st scrolling_message_spr_addr+1
.Dipinge_Buon_Italiano_Notte
    bn  options_flags, 3, .done_drawing_banner
    ld  banner_state
    bnz .Dipinge_Avvento_Italiano_Notte
    mov #<Buon_Avvento_Striscione_Notte_Buon, acc
    st scrolling_message_spr_addr
    mov #>Buon_Avvento_Striscione_Notte_Buon, acc
    st scrolling_message_spr_addr+1
    jmpf .done_drawing_banner
.Dipinge_Avvento_Italiano_Notte
    ld  banner_state
    bz  .done_drawing_banner
    mov #<Buon_Avvento_Striscione_Notte_Avvento, acc
    st scrolling_message_spr_addr
    mov #>Buon_Avvento_Striscione_Notte_Avvento, acc
    st scrolling_message_spr_addr+1
.done_drawing_banner
%end

;=======================;
;Swap Day/Night Graphics;
;=======================;
assign_graphics_auto:
.assign_graphics_auto_day
    bp  options_flags, 5, .assign_graphics_auto_night 
    callf   assign_graphics_day
    mov #32, candle1_xpos
    mov #8, candle1_ypos
    mov #16, candle2_xpos
    mov #8, candle2_ypos
    mov #24, candle3_xpos
    mov #0, candle3_ypos
    mov #40, candle4_xpos
    mov #0, candle4_ypos
    mov #0, scrolling_message_x_pos
    clr1    options_flags, 4
.assign_graphics_auto_night
    bn  options_flags, 5, .assign_graphics_auto_done 
    mov #0, candle1_xpos
    mov #0, candle1_ypos
    mov #8, candle2_xpos
    mov #16, candle2_ypos
    mov #16, candle3_xpos
    mov #0, candle3_ypos
    mov #24, candle4_xpos
    mov #16, candle4_ypos
    mov #40, scrolling_message_x_pos
    set1    options_flags, 4
    callf   assign_graphics_night
.assign_graphics_auto_done
    ret

assign_graphics_day:
    ; For Daytime: 
    mov #32, candle1_xpos
    mov #8, candle1_ypos
    mov #16, candle2_xpos
    mov #8, candle2_ypos
    mov #24, candle3_xpos
    mov #0, candle3_ypos
    mov #40, candle4_xpos
    mov #0, candle4_ypos
    mov #0, scrolling_message_x_pos
    clr1    options_flags, 4
    ret

assign_graphics_night:
    ; For Nighttime: 
    mov #0, candle1_xpos
    mov #0, candle1_ypos
    mov #8, candle2_xpos
    mov #16, candle2_ypos
    mov #16, candle3_xpos
    mov #0, candle3_ypos
    mov #24, candle4_xpos
    mov #16, candle4_ypos
    mov #40, scrolling_message_x_pos
    set1    options_flags, 4
    ret

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
    .include        "./img/MGP_TSBG.asm"
    .include        "./img/OptionsScreen_BackGround.asm"
    .include        "./img/Language_Highlighted_English.asm"
    .include        "./img/Lingua_Evidenziato_Italiano.asm"
    .include        "./img/TimeOfDay_Auto.asm"
    .include        "./img/TimeOfDay_Day.asm"
    .include        "./img/TimeOfDay_Night.asm"
    .include        "./img/TimeOfDay_Highlighted_Auto.asm"
    .include        "./img/TimeOfDay_Highlighted_Day.asm"
    .include        "./img/TimeOfDay_Highlighted_Night.asm"
    .include        "./img/OraDelGiorno_Auto.asm"
    .include        "./img/OraDelGiorno_Giorno.asm"
    .include        "./img/OraDelGiorno_Notte.asm"
    .include        "./img/OraDelGiorno_Evidenziato_Auto.asm"
    .include        "./img/OraDelGiorno_Evidenziato_Giorno.asm"
    .include        "./img/OraDelGiorno_Evidenziato_Notte.asm"
    .include        "./img/Language_English.asm"
    .include        "./img/Lingua_Italiano.asm"
    .include        "./img/BuonNatale_1.asm"
    .include        "./img/BuonNatale_2.asm"
    .include        "./img/Candle_Lighting_Day_Top_0.asm"
    .include        "./img/Candle_Lighting_Day_Top_1.asm"
    .include        "./img/Candle_Lighting_Day_Top_2.asm"
    .include        "./img/Candle_Lighting_Day_Top_3.asm"
    .include        "./img/Candle_Lighting_Day_Top_4.asm"
    .include        "./img/Candle_Lighting_Day_Bottom_0.asm"
    .include        "./img/Candle_Lighting_Day_Bottom_1.asm"
    .include        "./img/Candle_Lighting_Day_Bottom_2.asm"
    .include        "./img/Candle_Lighting_Day_Bottom_3.asm"
    .include        "./img/Candle_Lighting_Day_Bottom_4.asm"
    .include        "./img/Candle_Unlit_Day_Top.asm"
    .include        "./img/Candle_Unlit_Day_Bottom.asm"
    .include        "./img/Buon_Avvento_Striscione_Notte_Buon.asm"
    .include        "./img/Buon_Avvento_Striscione_Notte_Avvento.asm"
    .include        "./img/Happy_Advent_Banner_Day_Happy.asm"
    .include        "./img/Happy_Advent_Banner_Day_Advent.asm"
    .include        "./img/Buon_Avvento_Striscione_Giorno_Buon.asm"
    .include        "./img/Buon_Avvento_Striscione_Giorno_Avvento.asm"
    .include        "./img/Candle_Lit_Day_Top_0.asm"
    .include        "./img/Candle_Lit_Day_Top_1.asm"
    .include        "./img/Candle_Lit_Day_Top_2.asm"
    .include        "./img/Candle_Lit_Day_Top_3.asm"
    .include        "./img/Candle_Lit_Day_Bottom_0.asm"
    .include        "./img/Candle_Lit_Day_Bottom_1.asm"
    .include        "./img/Candle_Lit_Day_Bottom_2.asm"
    .include        "./img/Candle_Lit_Day_Bottom_3.asm"
    .include        "./img/Advent_Wreath_BackGround_Day.asm"
    .include        "./img/Options_Graphic_AutoTime.asm"
    .include        "./img/Options_Graphic_DayTime.asm"
    .include        "./img/Options_Graphic_NightTime.asm"
    .include        "./img/Options_Graphic_Text_English.asm"
    .include        "./img/Opzioni_Grafici_Testo_Italiano.asm"
    .include        "./img/Padding_1.asm"
    .include        "./img/Padding_2.asm"
    .include        "./img/Padding_3.asm"
    .include        "./img/Padding_4.asm"

	.cnop	0,$200		; Pad To An Even Number Of Blocks
