/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_37(char*, char *);
extern void execute_38(char*, char *);
extern void execute_39(char*, char *);
extern void execute_52(char*, char *);
extern void execute_54(char*, char *);
extern void execute_56(char*, char *);
extern void execute_57(char*, char *);
extern void execute_58(char*, char *);
extern void execute_77(char*, char *);
extern void execute_78(char*, char *);
extern void svlog_sampling_process_execute(char*, char*, char*);
extern void sequence_expr_m_39bc3187_53c60ad1_2(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_3(char*, char *);
extern void vlog_sv_sequence_execute_0 (char*, char*, char*);
extern void assertion_action_m_39bc3187_53c60ad1_1(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_1(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_5(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_6(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_2(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_4(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_8(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_9(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_3(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_7(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_11(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_12(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_4(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_10(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_13(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_14(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_5(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_16(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_6(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_15(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_18(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_7(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_17(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_20(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_21(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_8(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_19(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_23(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_24(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_9(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_22(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_26(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_10(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_25(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_28(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_29(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_11(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_27(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_31(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_32(char*, char *);
extern void assertion_action_m_39bc3187_53c60ad1_12(char*, char *);
extern void sequence_expr_m_39bc3187_53c60ad1_30(char*, char *);
extern void execute_156(char*, char *);
extern void execute_157(char*, char *);
extern void execute_158(char*, char *);
extern void execute_159(char*, char *);
extern void execute_160(char*, char *);
extern void execute_161(char*, char *);
extern void execute_162(char*, char *);
extern void execute_163(char*, char *);
extern void execute_164(char*, char *);
extern void execute_165(char*, char *);
extern void execute_166(char*, char *);
extern void execute_167(char*, char *);
extern void execute_168(char*, char *);
extern void execute_169(char*, char *);
extern void execute_170(char*, char *);
extern void execute_171(char*, char *);
extern void execute_172(char*, char *);
extern void execute_173(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_10(char*, char *);
extern void execute_11(char*, char *);
extern void execute_12(char*, char *);
extern void execute_13(char*, char *);
extern void execute_14(char*, char *);
extern void execute_63(char*, char *);
extern void execute_64(char*, char *);
extern void vlog_simple_process_execute_0_fast_for_reg(char*, char*, char*);
extern void execute_69(char*, char *);
extern void execute_16(char*, char *);
extern void execute_17(char*, char *);
extern void execute_30(char*, char *);
extern void execute_31(char*, char *);
extern void execute_70(char*, char *);
extern void execute_71(char*, char *);
extern void execute_72(char*, char *);
extern void execute_73(char*, char *);
extern void execute_74(char*, char *);
extern void execute_75(char*, char *);
extern void execute_60(char*, char *);
extern void execute_61(char*, char *);
extern void execute_62(char*, char *);
extern void execute_174(char*, char *);
extern void execute_175(char*, char *);
extern void execute_176(char*, char *);
extern void execute_177(char*, char *);
extern void execute_178(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void vlog_transfunc_eventcallback_2state(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[106] = {(funcp)execute_37, (funcp)execute_38, (funcp)execute_39, (funcp)execute_52, (funcp)execute_54, (funcp)execute_56, (funcp)execute_57, (funcp)execute_58, (funcp)execute_77, (funcp)execute_78, (funcp)svlog_sampling_process_execute, (funcp)sequence_expr_m_39bc3187_53c60ad1_2, (funcp)sequence_expr_m_39bc3187_53c60ad1_3, (funcp)vlog_sv_sequence_execute_0 , (funcp)assertion_action_m_39bc3187_53c60ad1_1, (funcp)sequence_expr_m_39bc3187_53c60ad1_1, (funcp)sequence_expr_m_39bc3187_53c60ad1_5, (funcp)sequence_expr_m_39bc3187_53c60ad1_6, (funcp)assertion_action_m_39bc3187_53c60ad1_2, (funcp)sequence_expr_m_39bc3187_53c60ad1_4, (funcp)sequence_expr_m_39bc3187_53c60ad1_8, (funcp)sequence_expr_m_39bc3187_53c60ad1_9, (funcp)assertion_action_m_39bc3187_53c60ad1_3, (funcp)sequence_expr_m_39bc3187_53c60ad1_7, (funcp)sequence_expr_m_39bc3187_53c60ad1_11, (funcp)sequence_expr_m_39bc3187_53c60ad1_12, (funcp)assertion_action_m_39bc3187_53c60ad1_4, (funcp)sequence_expr_m_39bc3187_53c60ad1_10, (funcp)sequence_expr_m_39bc3187_53c60ad1_13, (funcp)sequence_expr_m_39bc3187_53c60ad1_14, (funcp)assertion_action_m_39bc3187_53c60ad1_5, (funcp)sequence_expr_m_39bc3187_53c60ad1_16, (funcp)assertion_action_m_39bc3187_53c60ad1_6, (funcp)sequence_expr_m_39bc3187_53c60ad1_15, (funcp)sequence_expr_m_39bc3187_53c60ad1_18, (funcp)assertion_action_m_39bc3187_53c60ad1_7, (funcp)sequence_expr_m_39bc3187_53c60ad1_17, (funcp)sequence_expr_m_39bc3187_53c60ad1_20, (funcp)sequence_expr_m_39bc3187_53c60ad1_21, (funcp)assertion_action_m_39bc3187_53c60ad1_8, (funcp)sequence_expr_m_39bc3187_53c60ad1_19, (funcp)sequence_expr_m_39bc3187_53c60ad1_23, (funcp)sequence_expr_m_39bc3187_53c60ad1_24, (funcp)assertion_action_m_39bc3187_53c60ad1_9, (funcp)sequence_expr_m_39bc3187_53c60ad1_22, (funcp)sequence_expr_m_39bc3187_53c60ad1_26, (funcp)assertion_action_m_39bc3187_53c60ad1_10, (funcp)sequence_expr_m_39bc3187_53c60ad1_25, (funcp)sequence_expr_m_39bc3187_53c60ad1_28, (funcp)sequence_expr_m_39bc3187_53c60ad1_29, (funcp)assertion_action_m_39bc3187_53c60ad1_11, (funcp)sequence_expr_m_39bc3187_53c60ad1_27, (funcp)sequence_expr_m_39bc3187_53c60ad1_31, (funcp)sequence_expr_m_39bc3187_53c60ad1_32, (funcp)assertion_action_m_39bc3187_53c60ad1_12, (funcp)sequence_expr_m_39bc3187_53c60ad1_30, (funcp)execute_156, (funcp)execute_157, (funcp)execute_158, (funcp)execute_159, (funcp)execute_160, (funcp)execute_161, (funcp)execute_162, (funcp)execute_163, (funcp)execute_164, (funcp)execute_165, (funcp)execute_166, (funcp)execute_167, (funcp)execute_168, (funcp)execute_169, (funcp)execute_170, (funcp)execute_171, (funcp)execute_172, (funcp)execute_173, (funcp)execute_7, (funcp)execute_8, (funcp)execute_9, (funcp)execute_10, (funcp)execute_11, (funcp)execute_12, (funcp)execute_13, (funcp)execute_14, (funcp)execute_63, (funcp)execute_64, (funcp)vlog_simple_process_execute_0_fast_for_reg, (funcp)execute_69, (funcp)execute_16, (funcp)execute_17, (funcp)execute_30, (funcp)execute_31, (funcp)execute_70, (funcp)execute_71, (funcp)execute_72, (funcp)execute_73, (funcp)execute_74, (funcp)execute_75, (funcp)execute_60, (funcp)execute_61, (funcp)execute_62, (funcp)execute_174, (funcp)execute_175, (funcp)execute_176, (funcp)execute_177, (funcp)execute_178, (funcp)vlog_transfunc_eventcallback, (funcp)vlog_transfunc_eventcallback_2state};
const int NumRelocateId= 106;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_lsu_behav/xsim.reloc",  (void **)funcTab, 106);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_lsu_behav/xsim.reloc");
}

void simulate(char *dp)
{
iki_register_root_pointers(2, 18520, 3,0,0,18696, 4,0,0) ; 
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_lsu_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void subprog_m_39bc3187_53c60ad1_6() ;
void subprog_m_39bc3187_53c60ad1_5() ;
void subprog_m_39bc3187_53c60ad1_4() ;
void subprog_m_39bc3187_53c60ad1_11() ;
void subprog_m_39bc3187_53c60ad1_10() ;
void subprog_m_39bc3187_53c60ad1_9() ;
static char* ng30[] = {(void *)subprog_m_39bc3187_53c60ad1_6, (void *)subprog_m_39bc3187_53c60ad1_5, (void *)subprog_m_39bc3187_53c60ad1_4};
static char* ng40[] = {(void *)subprog_m_39bc3187_53c60ad1_11, (void *)subprog_m_39bc3187_53c60ad1_10, (void *)subprog_m_39bc3187_53c60ad1_9};
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/tb_lsu_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_lsu_behav/xsim.crvsdump");
    iki_svlog_initialize_virtual_tables(2, 3, ng30, 4, ng40);
    void* design_handle = iki_create_design("xsim.dir/tb_lsu_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
