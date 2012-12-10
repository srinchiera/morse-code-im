/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x6dd86d03 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Documents and Settings/student/Desktop/lat3-submission/visual2test/visual2/ReceiverTestbench.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static int ng3[] = {100, 0};
static int ng4[] = {2, 0};
static int ng5[] = {3, 0};



static void Always_78_0(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;

LAB0:    t1 = (t0 + 4112U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(78, ng0);
    t2 = (t0 + 4012);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(78, ng0);
    t4 = (t0 + 3128);
    t5 = (t4 + 36U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t3 + 4);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t6);
    t17 = (~(t16));
    *((unsigned int *)t3) = t17;
    *((unsigned int *)t14) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB10;

LAB9:    t22 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t22 & 1U);
    t23 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t23 & 1U);
    t24 = (t0 + 3128);
    xsi_vlogvar_assign_value(t24, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

LAB10:    t18 = *((unsigned int *)t3);
    t19 = *((unsigned int *)t15);
    *((unsigned int *)t3) = (t18 | t19);
    t20 = *((unsigned int *)t14);
    t21 = *((unsigned int *)t15);
    *((unsigned int *)t14) = (t20 | t21);
    goto LAB9;

}

static void Initial_80_1(char *t0)
{
    char t12[8];
    char t13[8];
    char t26[8];
    char *t1;
    char *t2;
    char *t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    int t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    char *t27;

LAB0:    t1 = (t0 + 4256U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(80, ng0);

LAB4:    xsi_set_current_line(82, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3128);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(83, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3220);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(84, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3312);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(85, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3404);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(86, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3496);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(87, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3588);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);
    xsi_set_current_line(90, ng0);
    t2 = (t0 + 4156);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(91, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3220);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(92, ng0);
    t2 = (t0 + 4156);
    xsi_process_wait(t2, 50000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 6260);
    *((int *)t8) = t7;

LAB7:    t9 = (t0 + 6260);
    if (*((int *)t9) > 0)
        goto LAB8;

LAB9:    goto LAB1;

LAB8:    xsi_set_current_line(94, ng0);

LAB10:    xsi_set_current_line(95, ng0);
    t10 = ((char*)((ng1)));
    t11 = (t0 + 3312);
    xsi_vlogvar_assign_value(t11, t10, 0, 0, 1);
    xsi_set_current_line(96, ng0);
    t2 = (t0 + 4156);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB11:    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3312);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(98, ng0);
    t2 = (t0 + 4156);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB12;
    goto LAB1;

LAB12:    xsi_set_current_line(99, ng0);
    t2 = (t0 + 3404);
    t3 = (t2 + 36U);
    t8 = *((char **)t3);
    memset(t13, 0, 8);
    t9 = (t8 + 4);
    t4 = *((unsigned int *)t9);
    t5 = (~(t4));
    t6 = *((unsigned int *)t8);
    t14 = (t6 & t5);
    t15 = (t14 & 1U);
    if (t15 != 0)
        goto LAB13;

LAB14:    if (*((unsigned int *)t9) != 0)
        goto LAB15;

LAB16:    t11 = (t13 + 4);
    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t11);
    t18 = (t16 || t17);
    if (t18 > 0)
        goto LAB17;

LAB18:    t20 = *((unsigned int *)t13);
    t21 = (~(t20));
    t22 = *((unsigned int *)t11);
    t23 = (t21 || t22);
    if (t23 > 0)
        goto LAB19;

LAB20:    if (*((unsigned int *)t11) > 0)
        goto LAB21;

LAB22:    if (*((unsigned int *)t13) > 0)
        goto LAB23;

LAB24:    memcpy(t12, t24, 8);

LAB25:    t25 = (t0 + 3312);
    xsi_vlogvar_assign_value(t25, t12, 0, 0, 1);
    xsi_set_current_line(100, ng0);
    t2 = (t0 + 4156);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB26;
    goto LAB1;

LAB13:    *((unsigned int *)t13) = 1;
    goto LAB16;

LAB15:    t10 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB16;

LAB17:    t19 = ((char*)((ng1)));
    goto LAB18;

LAB19:    t24 = ((char*)((ng2)));
    goto LAB20;

LAB21:    xsi_vlog_unsigned_bit_combine(t12, 32, t19, 32, t24, 32);
    goto LAB25;

LAB23:    memcpy(t12, t19, 8);
    goto LAB25;

LAB26:    xsi_set_current_line(101, ng0);
    t2 = (t0 + 3496);
    t3 = (t2 + 36U);
    t8 = *((char **)t3);
    memset(t13, 0, 8);
    t9 = (t8 + 4);
    t4 = *((unsigned int *)t9);
    t5 = (~(t4));
    t6 = *((unsigned int *)t8);
    t14 = (t6 & t5);
    t15 = (t14 & 1U);
    if (t15 != 0)
        goto LAB27;

LAB28:    if (*((unsigned int *)t9) != 0)
        goto LAB29;

LAB30:    t11 = (t13 + 4);
    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t11);
    t18 = (t16 || t17);
    if (t18 > 0)
        goto LAB31;

LAB32:    t20 = *((unsigned int *)t13);
    t21 = (~(t20));
    t22 = *((unsigned int *)t11);
    t23 = (t21 || t22);
    if (t23 > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t11) > 0)
        goto LAB35;

LAB36:    if (*((unsigned int *)t13) > 0)
        goto LAB37;

LAB38:    memcpy(t12, t24, 8);

LAB39:    t25 = (t0 + 3312);
    xsi_vlogvar_assign_value(t25, t12, 0, 0, 1);
    xsi_set_current_line(102, ng0);
    t2 = (t0 + 4156);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB40;
    goto LAB1;

LAB27:    *((unsigned int *)t13) = 1;
    goto LAB30;

LAB29:    t10 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB30;

LAB31:    t19 = ((char*)((ng1)));
    goto LAB32;

LAB33:    t24 = ((char*)((ng2)));
    goto LAB34;

LAB35:    xsi_vlog_unsigned_bit_combine(t12, 32, t19, 32, t24, 32);
    goto LAB39;

LAB37:    memcpy(t12, t19, 8);
    goto LAB39;

LAB40:    xsi_set_current_line(103, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3312);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(104, ng0);
    t2 = (t0 + 4156);
    xsi_process_wait(t2, 50000LL);
    *((char **)t1) = &&LAB41;
    goto LAB1;

LAB41:    xsi_set_current_line(105, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3312);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(106, ng0);
    t2 = (t0 + 4156);
    xsi_process_wait(t2, 1000000LL);
    *((char **)t1) = &&LAB42;
    goto LAB1;

LAB42:    xsi_set_current_line(107, ng0);
    t2 = (t0 + 3588);
    t3 = (t2 + 36U);
    t8 = *((char **)t3);
    t9 = ((char*)((ng2)));
    memset(t12, 0, 8);
    xsi_vlog_unsigned_add(t12, 32, t8, 4, t9, 32);
    t10 = (t0 + 3588);
    xsi_vlogvar_assign_value(t10, t12, 0, 0, 4);
    xsi_set_current_line(108, ng0);
    t2 = (t0 + 3588);
    t3 = (t2 + 36U);
    t8 = *((char **)t3);
    t9 = ((char*)((ng4)));
    memset(t26, 0, 8);
    xsi_vlog_unsigned_mod(t26, 32, t8, 4, t9, 32);
    memset(t13, 0, 8);
    t10 = (t26 + 4);
    t4 = *((unsigned int *)t10);
    t5 = (~(t4));
    t6 = *((unsigned int *)t26);
    t14 = (t6 & t5);
    t15 = (t14 & 4294967295U);
    if (t15 != 0)
        goto LAB43;

LAB44:    if (*((unsigned int *)t10) != 0)
        goto LAB45;

LAB46:    t19 = (t13 + 4);
    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t19);
    t18 = (t16 || t17);
    if (t18 > 0)
        goto LAB47;

LAB48:    t20 = *((unsigned int *)t13);
    t21 = (~(t20));
    t22 = *((unsigned int *)t19);
    t23 = (t21 || t22);
    if (t23 > 0)
        goto LAB49;

LAB50:    if (*((unsigned int *)t19) > 0)
        goto LAB51;

LAB52:    if (*((unsigned int *)t13) > 0)
        goto LAB53;

LAB54:    memcpy(t12, t25, 8);

LAB55:    t27 = (t0 + 3404);
    xsi_vlogvar_assign_value(t27, t12, 0, 0, 1);
    xsi_set_current_line(109, ng0);
    t2 = (t0 + 3588);
    t3 = (t2 + 36U);
    t8 = *((char **)t3);
    t9 = ((char*)((ng5)));
    memset(t26, 0, 8);
    xsi_vlog_unsigned_mod(t26, 32, t8, 4, t9, 32);
    memset(t13, 0, 8);
    t10 = (t26 + 4);
    t4 = *((unsigned int *)t10);
    t5 = (~(t4));
    t6 = *((unsigned int *)t26);
    t14 = (t6 & t5);
    t15 = (t14 & 4294967295U);
    if (t15 != 0)
        goto LAB56;

LAB57:    if (*((unsigned int *)t10) != 0)
        goto LAB58;

LAB59:    t19 = (t13 + 4);
    t16 = *((unsigned int *)t13);
    t17 = *((unsigned int *)t19);
    t18 = (t16 || t17);
    if (t18 > 0)
        goto LAB60;

LAB61:    t20 = *((unsigned int *)t13);
    t21 = (~(t20));
    t22 = *((unsigned int *)t19);
    t23 = (t21 || t22);
    if (t23 > 0)
        goto LAB62;

LAB63:    if (*((unsigned int *)t19) > 0)
        goto LAB64;

LAB65:    if (*((unsigned int *)t13) > 0)
        goto LAB66;

LAB67:    memcpy(t12, t25, 8);

LAB68:    t27 = (t0 + 3496);
    xsi_vlogvar_assign_value(t27, t12, 0, 0, 1);
    t2 = (t0 + 6260);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB7;

LAB43:    *((unsigned int *)t13) = 1;
    goto LAB46;

LAB45:    t11 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB46;

LAB47:    t24 = ((char*)((ng1)));
    goto LAB48;

LAB49:    t25 = ((char*)((ng2)));
    goto LAB50;

LAB51:    xsi_vlog_unsigned_bit_combine(t12, 32, t24, 32, t25, 32);
    goto LAB55;

LAB53:    memcpy(t12, t24, 8);
    goto LAB55;

LAB56:    *((unsigned int *)t13) = 1;
    goto LAB59;

LAB58:    t11 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB59;

LAB60:    t24 = ((char*)((ng1)));
    goto LAB61;

LAB62:    t25 = ((char*)((ng2)));
    goto LAB63;

LAB64:    xsi_vlog_unsigned_bit_combine(t12, 32, t24, 32, t25, 32);
    goto LAB68;

LAB66:    memcpy(t12, t24, 8);
    goto LAB68;

}


extern void work_m_00000000004231219020_3718976702_init()
{
	static char *pe[] = {(void *)Always_78_0,(void *)Initial_80_1};
	xsi_register_didat("work_m_00000000004231219020_3718976702", "isim/ReceiverTestbench_isim_beh.exe.sim/work/m_00000000004231219020_3718976702.didat");
	xsi_register_executes(pe);
}
