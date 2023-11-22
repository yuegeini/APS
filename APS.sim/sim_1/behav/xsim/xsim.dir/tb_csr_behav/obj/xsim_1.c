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
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_10(char*, char *);
extern void execute_11(char*, char *);
extern void execute_13(char*, char *);
extern void execute_34(char*, char *);
extern void execute_35(char*, char *);
extern void execute_36(char*, char *);
extern void execute_37(char*, char *);
extern void execute_38(char*, char *);
extern void execute_39(char*, char *);
extern void execute_47(char*, char *);
extern void execute_48(char*, char *);
extern void svlog_sampling_process_execute(char*, char*, char*);
extern void sequence_expr_m_77dbc00_c6fed84f_2(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_3(char*, char *);
extern void vlog_sv_sequence_execute_0 (char*, char*, char*);
extern void assertion_action_m_77dbc00_c6fed84f_1(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_1(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_5(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_6(char*, char *);
extern void assertion_action_m_77dbc00_c6fed84f_2(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_4(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_8(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_9(char*, char *);
extern void assertion_action_m_77dbc00_c6fed84f_3(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_7(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_11(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_12(char*, char *);
extern void assertion_action_m_77dbc00_c6fed84f_4(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_10(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_14(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_15(char*, char *);
extern void assertion_action_m_77dbc00_c6fed84f_5(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_13(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_17(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_18(char*, char *);
extern void assertion_action_m_77dbc00_c6fed84f_6(char*, char *);
extern void sequence_expr_m_77dbc00_c6fed84f_16(char*, char *);
extern void execute_136(char*, char *);
extern void execute_137(char*, char *);
extern void execute_138(char*, char *);
extern void execute_139(char*, char *);
extern void execute_140(char*, char *);
extern void execute_141(char*, char *);
extern void execute_142(char*, char *);
extern void execute_143(char*, char *);
extern void execute_144(char*, char *);
extern void execute_145(char*, char *);
extern void execute_4(char*, char *);
extern void execute_5(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void vlog_simple_process_execute_0_fast_for_reg(char*, char*, char*);
extern void execute_41(char*, char *);
extern void execute_42(char*, char *);
extern void execute_43(char*, char *);
extern void execute_146(char*, char *);
extern void execute_147(char*, char *);
extern void execute_148(char*, char *);
extern void execute_149(char*, char *);
extern void execute_150(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vlog_transfunc_eventcallback_2state(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[65] = {(funcp)execute_8, (funcp)execute_9, (funcp)execute_10, (funcp)execute_11, (funcp)execute_13, (funcp)execute_34, (funcp)execute_35, (funcp)execute_36, (funcp)execute_37, (funcp)execute_38, (funcp)execute_39, (funcp)execute_47, (funcp)execute_48, (funcp)svlog_sampling_process_execute, (funcp)sequence_expr_m_77dbc00_c6fed84f_2, (funcp)sequence_expr_m_77dbc00_c6fed84f_3, (funcp)vlog_sv_sequence_execute_0 , (funcp)assertion_action_m_77dbc00_c6fed84f_1, (funcp)sequence_expr_m_77dbc00_c6fed84f_1, (funcp)sequence_expr_m_77dbc00_c6fed84f_5, (funcp)sequence_expr_m_77dbc00_c6fed84f_6, (funcp)assertion_action_m_77dbc00_c6fed84f_2, (funcp)sequence_expr_m_77dbc00_c6fed84f_4, (funcp)sequence_expr_m_77dbc00_c6fed84f_8, (funcp)sequence_expr_m_77dbc00_c6fed84f_9, (funcp)assertion_action_m_77dbc00_c6fed84f_3, (funcp)sequence_expr_m_77dbc00_c6fed84f_7, (funcp)sequence_expr_m_77dbc00_c6fed84f_11, (funcp)sequence_expr_m_77dbc00_c6fed84f_12, (funcp)assertion_action_m_77dbc00_c6fed84f_4, (funcp)sequence_expr_m_77dbc00_c6fed84f_10, (funcp)sequence_expr_m_77dbc00_c6fed84f_14, (funcp)sequence_expr_m_77dbc00_c6fed84f_15, (funcp)assertion_action_m_77dbc00_c6fed84f_5, (funcp)sequence_expr_m_77dbc00_c6fed84f_13, (funcp)sequence_expr_m_77dbc00_c6fed84f_17, (funcp)sequence_expr_m_77dbc00_c6fed84f_18, (funcp)assertion_action_m_77dbc00_c6fed84f_6, (funcp)sequence_expr_m_77dbc00_c6fed84f_16, (funcp)execute_136, (funcp)execute_137, (funcp)execute_138, (funcp)execute_139, (funcp)execute_140, (funcp)execute_141, (funcp)execute_142, (funcp)execute_143, (funcp)execute_144, (funcp)execute_145, (funcp)execute_4, (funcp)execute_5, (funcp)execute_6, (funcp)execute_7, (funcp)vlog_simple_process_execute_0_fast_for_reg, (funcp)execute_41, (funcp)execute_42, (funcp)execute_43, (funcp)execute_146, (funcp)execute_147, (funcp)execute_148, (funcp)execute_149, (funcp)execute_150, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_0, (funcp)vlog_transfunc_eventcallback_2state};
const int NumRelocateId= 65;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_csr_behav/xsim.reloc",  (void **)funcTab, 65);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_csr_behav/xsim.reloc");
}

void simulate(char *dp)
{
iki_register_root_pointers(2, 9808, -5,0,9984, -5,0) ; 
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_csr_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
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
    iki_set_sv_type_file_path_name("xsim.dir/tb_csr_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_csr_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb_csr_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
