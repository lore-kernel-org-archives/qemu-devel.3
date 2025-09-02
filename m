Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0CBCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0X-0007MC-Mk; Mon, 01 Sep 2025 23:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0N-00079v-Od
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0J-0004XO-5K
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RtdH012437
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3h6pGkmm/F0Vxjpevb4qVDHV/8snO/hu8HNA/KvSJCQ=; b=H4UaY7FLyJ/GtnA3
 Z/w/mPgqQfMPYLPVTAtrFTMlwr+QDuEkhma/hqXBjQvH97+hWoqUnU4C1OePN7Hz
 JGYq4DkbXkTcyrzbszWkayZlifO/I5hN4+0VwLn4B6rJ3kFDO8eTi0pr9ryEf7jz
 lbH2a1RRcvs4eOjEE8PwpGIjC1hfoziIzibYE+I6KemZ9ebMjsSmkJTS4ZPV9mNA
 tqQJSBF1/p1PTEfktYfwENGkjBXQrOZ6cH4nX5eLCLQvx3GsPqpr0vLDnV3MVg7d
 Tcg/7XOMNTN3EF1utOgm6J+x6IPhamivKrtHxX5NXQIMrYwffjhUOVh2RxsGECXe
 3NS71g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-324e41e946eso8953305a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784887; x=1757389687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3h6pGkmm/F0Vxjpevb4qVDHV/8snO/hu8HNA/KvSJCQ=;
 b=HKZVpxML11PT/04SFgUICvH1Aa2/iP+r/hUQ8yqcOcy66zi+8NtJFwAVcu6aplm1Ru
 6NRJbVvONzVSLcY3sY1TjQupL9BpUy5w1dN0UpKeDFNAKrul7CEMQy5HFGwlmSgIWlY+
 BZWl7scVRcjB/HCiWeZCRuhWJhyGtxoCFB4IiGbAvhYTCoppT7U8Tmf1xQSWsCh44RsT
 s0egJXRPlU0XAXhe4LQI9MSEEX+ZE6KSAjUU8KQ20WZQgiKj/bF4E0R7MG4quOs9gyOp
 y07g7YLQ9zBb0TYH0gk2+uwIq/dsLF4s9E+J0ibO4eiG+/jKqt/SYSmU/F30+AEldBuz
 mCIA==
X-Gm-Message-State: AOJu0YxKtX/27af2PPI8jxp/CyznKPDHi6jHrOUlKfs4WgaO3htyIQ8Y
 zoQqQkrS+YhXLgmzOXuA++GOTqxbgSXBQVNNzoHWujEUihg8WErXEqbbT9dd5kzpWEHTxMsNWDS
 Yri7MZ7JfIyFumtehHOxPgx9YyJt0Av3ZPffEguaTemUEDXLDbXSAzqHDMdRVqLV31VoG
X-Gm-Gg: ASbGncu8UP6Js15Q5jrqVnQkozhOICz49yigPSvoXs15/0y0cs8GmL87Kb1Mg4PG3rc
 Tm3gaaf1+EmdbzZPpxYOQ8Sr2i2vPDYCZEf0CgMX6Ot8dCox4BjNo/lcP8rDm7EmeoL3uetTLKG
 VTIEbk/jLZkJTdzu+GqzfuBYeXTVE04JAZ2Ns65iVVdrxMclvS2Rr0535jzR7mrnNo8skF8wSyp
 i0P9z01hE2dmRxhk0OFcrPmHw2sYNJd1htxFf2njAsGxcI9byF+0xZ4UdkjvlZYrLiBMQYQStCu
 TuG2hufwHAl9HW21B8x8H27hsUXVtYXJ4wLifgrC7/vNsitWuy1HYKvArLG4p33OYHNlZLQdSXH
 +ZrUmku/z+9Wh
X-Received: by 2002:a17:90b:38c2:b0:327:e67d:6595 with SMTP id
 98e67ed59e1d1-328156cc9c0mr13136398a91.25.1756784886117; 
 Mon, 01 Sep 2025 20:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9tRp2lNB5mm+ULG56iQAjBcLCW+YnBWyo1Tn4v2D0gMirPF0XHAzF09Ok8hihns38zMTJ0w==
X-Received: by 2002:a17:90b:38c2:b0:327:e67d:6595 with SMTP id
 98e67ed59e1d1-328156cc9c0mr13136349a91.25.1756784885397; 
 Mon, 01 Sep 2025 20:48:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Michael Lambert <mlambert@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v2 37/40] target/hexagon: Add initial MMU model
Date: Mon,  1 Sep 2025 20:47:12 -0700
Message-Id: <20250902034715.1947718-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX3m0YJYol8ee8
 hPgmz1QeVzP3Vg/kgzWrRluDN4AAxi6V/KUT8Kt4RQmrwrRxwPE5L6KBPx1WuTonnOvDsXz4kHs
 2vAAZVXPDJZvDPjAqhjbyH1BZiXYoVqxOlqyr8L70TSBt+GVtWys4Ke8bEi4T4zMMsvGkd4mtce
 /A8Lfnf5o0JdgMCH8kSXedrDa4EEMgnh07IKlRrsUpuVB3NUfJ/ou8DkVTu7MiAE8fzpUDY2WSX
 gWlVX6cWBZ9tvVu4C7r4fo8nGjEg96IrXk6RDQJ01UpxsbSA6w/+w12gup2DtZTw3Z4yjn/ZMR4
 1Sa8iWINm0p+5nAB8lF3z+xygu/rWylxFM7RAi/pXVWKkKe54+l80Y7xh1x/FbblJZSoWgMv72O
 PlqSXr8I
X-Proofpoint-ORIG-GUID: 1wHYQsFjHiSC8GM_Xs-Av3d-Vcs_C3jJ
X-Proofpoint-GUID: 1wHYQsFjHiSC8GM_Xs-Av3d-Vcs_C3jJ
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668f7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=XoBo4ihvdZbvXjo1iqsA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Co-authored-by: Michael Lambert <mlambert@quicinc.com>
Co-authored-by: Sid Manning <sidneym@quicinc.com>
Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu-param.h |   4 +
 target/hexagon/cpu.h       |   8 +
 target/hexagon/hex_mmu.h   |  30 +++
 target/hexagon/internal.h  |   8 +
 target/hexagon/cpu.c       |  42 +++
 target/hexagon/hex_mmu.c   | 525 +++++++++++++++++++++++++++++++++++++
 target/hexagon/machine.c   |  30 +++
 target/hexagon/translate.c |   2 +-
 8 files changed, 648 insertions(+), 1 deletion(-)
 create mode 100644 target/hexagon/hex_mmu.h
 create mode 100644 target/hexagon/hex_mmu.c

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 22bffa7881..38b463a780 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -18,7 +18,11 @@
 #ifndef HEXAGON_CPU_PARAM_H
 #define HEXAGON_CPU_PARAM_H
 
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 16     /* 64K pages */
+#else
+#define TARGET_PAGE_BITS 12     /* 4K pages */
+#endif
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 627748392f..f25b483188 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -36,6 +36,10 @@
 #error "Hexagon does not support system emulation"
 #endif
 
+#ifndef CONFIG_USER_ONLY
+typedef struct CPUHexagonTLBContext CPUHexagonTLBContext;
+#endif
+
 #define NUM_PREGS 4
 #define TOTAL_PER_THREAD_REGS 64
 
@@ -138,6 +142,7 @@ typedef struct CPUArchState {
     hex_lock_state_t k0_lock_state;
     target_ulong tlb_lock_count;
     target_ulong k0_lock_count;
+    CPUHexagonTLBContext *hex_tlb;
 #endif
     target_ulong next_PC;
     target_ulong new_value_usr;
@@ -185,12 +190,15 @@ struct ArchCPU {
     bool lldb_compat;
     target_ulong lldb_stack_adjust;
     bool short_circuit;
+#ifndef CONFIG_USER_ONLY
     uint32_t num_tlbs;
+#endif
 };
 
 #include "cpu_bits.h"
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
+FIELD(TB_FLAGS, MMU_INDEX, 1, 3)
 
 G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
new file mode 100644
index 0000000000..61a8056f08
--- /dev/null
+++ b/target/hexagon/hex_mmu.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_MMU_H
+#define HEXAGON_MMU_H
+
+#include "cpu.h"
+
+struct CPUHexagonTLBContext {
+    uint64_t entries[MAX_TLB_ENTRIES];
+};
+
+extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value);
+extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA);
+extern void hex_mmu_realize(CPUHexagonState *env);
+extern void hex_mmu_on(CPUHexagonState *env);
+extern void hex_mmu_off(CPUHexagonState *env);
+extern void hex_mmu_mode_change(CPUHexagonState *env);
+extern bool hex_tlb_find_match(CPUHexagonState *env, target_ulong VA,
+                               MMUAccessType access_type, hwaddr *PA, int *prot,
+                               int *size, int32_t *excp, int mmu_idx);
+extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
+                                 uint64_t index);
+extern void hex_tlb_lock(CPUHexagonState *env);
+extern void hex_tlb_unlock(CPUHexagonState *env);
+void dump_mmu(CPUHexagonState *env);
+#endif
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index c24c360921..94e5e502a9 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -40,6 +40,14 @@ void G_NORETURN do_raise_exception(CPUHexagonState *env,
         target_ulong PC,
         uintptr_t retaddr);
 
+#define hexagon_cpu_mmu_enabled(env) ({ \
+    HexagonCPU *cpu = env_archcpu(env); \
+    cpu->globalregs ? \
+        GET_SYSCFG_FIELD(SYSCFG_MMUEN, \
+                          arch_get_system_reg(env, HEX_SREG_SYSCFG)) : \
+        0; \
+})
+
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_hexagon_cpu;
 #endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 2ee379121e..eb3adebb60 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -26,9 +26,12 @@
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
 #include "accel/tcg/cpu-ops.h"
+#include "cpu_helper.h"
+#include "hex_mmu.h"
 
 #ifndef CONFIG_USER_ONLY
 #include "sys_macros.h"
+#include "accel/tcg/cpu-ldst.h"
 #endif
 
 static void hexagon_v66_cpu_init(Object *obj) { }
@@ -274,6 +277,13 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
         hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
     }
 
+#ifndef CONFIG_USER_ONLY
+    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
+                           cpu_mmu_index(env_cpu(env), false));
+#else
+    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX, MMU_USER_IDX);
+#endif
+
     return (TCGTBCPUState){ .pc = pc, .flags = hex_flags };
 }
 
@@ -291,6 +301,18 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
 }
 
+
+#ifndef CONFIG_USER_ONLY
+static void mmu_reset(CPUHexagonState *env)
+{
+    CPUState *cs = env_cpu(env);
+    if (cs->cpu_index == 0) {
+        memset(env->hex_tlb, 0, sizeof(*env->hex_tlb));
+    }
+}
+#endif
+
+
 static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -306,6 +328,13 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     /* Default NaN value: sign bit set, all frac bits set */
     set_float_default_nan_pattern(0b11111111, &env->fp_status);
 #ifndef CONFIG_USER_ONLY
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+
+    memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
+    memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
+
+    mmu_reset(env);
+    arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index);
     memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
     memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
     env->threadId = cs->cpu_index;
@@ -338,6 +367,14 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    if (cpu->num_tlbs > MAX_TLB_ENTRIES) {
+        error_setg(errp, "Number of TLBs selected is invalid");
+        return;
+    }
+#endif
+
     gdb_register_coprocessor(cs, hexagon_hvx_gdb_read_register,
                              hexagon_hvx_gdb_write_register,
                              gdb_find_static_feature("hexagon-hvx.xml"), 0);
@@ -349,6 +386,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
 #endif
 
     qemu_init_vcpu(cs);
+
+#ifndef CONFIG_USER_ONLY
+    CPUHexagonState *env = cpu_env(cs);
+    hex_mmu_realize(env);
+#endif
     cpu_reset(cs);
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
new file mode 100644
index 0000000000..332e7f4029
--- /dev/null
+++ b/target/hexagon/hex_mmu.c
@@ -0,0 +1,525 @@
+/*
+ * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/qemu-print.h"
+#include "cpu.h"
+#include "system/cpus.h"
+#include "internal.h"
+#include "exec/cpu-interrupt.h"
+#include "cpu_helper.h"
+#include "exec/cputlb.h"
+#include "hex_mmu.h"
+#include "macros.h"
+#include "sys_macros.h"
+#include "reg_fields.h"
+
+#define GET_TLB_FIELD(ENTRY, FIELD)                               \
+    ((uint64_t)fEXTRACTU_BITS(ENTRY, reg_field_info[FIELD].width, \
+                              reg_field_info[FIELD].offset))
+
+/* PPD (physical page descriptor) */
+static inline uint64_t GET_PPD(uint64_t entry)
+{
+    return GET_TLB_FIELD(entry, PTE_PPD) |
+        (GET_TLB_FIELD(entry, PTE_PA35) << reg_field_info[PTE_PPD].width);
+}
+
+#define NO_ASID      (1 << 8)
+
+typedef enum {
+    PGSIZE_4K,
+    PGSIZE_16K,
+    PGSIZE_64K,
+    PGSIZE_256K,
+    PGSIZE_1M,
+    PGSIZE_4M,
+    PGSIZE_16M,
+    PGSIZE_64M,
+    PGSIZE_256M,
+    PGSIZE_1G,
+    NUM_PGSIZE_TYPES
+} tlb_pgsize_t;
+
+static const char *pgsize_str[NUM_PGSIZE_TYPES] = {
+    "4K",
+    "16K",
+    "64K",
+    "256K",
+    "1M",
+    "4M",
+    "16M",
+    "64M",
+    "256M",
+    "1G",
+};
+
+#define INVALID_MASK 0xffffffffLL
+
+static const uint64_t encmask_2_mask[] = {
+    0x0fffLL,                           /* 4k,   0000 */
+    0x3fffLL,                           /* 16k,  0001 */
+    0xffffLL,                           /* 64k,  0010 */
+    0x3ffffLL,                          /* 256k, 0011 */
+    0xfffffLL,                          /* 1m,   0100 */
+    0x3fffffLL,                         /* 4m,   0101 */
+    0xffffffLL,                         /* 16m,  0110 */
+    0x3ffffffLL,                        /* 64m,  0111 */
+    0xfffffffLL,                        /* 256m, 1000 */
+    0x3fffffffLL,                       /* 1g,   1001 */
+    INVALID_MASK,                      /* RSVD, 0111 */
+};
+
+/*
+ * @return the page size type from @a entry.
+ */
+static inline tlb_pgsize_t hex_tlb_pgsize_type(uint64_t entry)
+{
+    if (entry == 0) {
+        qemu_log_mask(CPU_LOG_MMU, "%s: Supplied TLB entry was 0!\n", __func__);
+        return 0;
+    }
+    tlb_pgsize_t size = ctz64(entry);
+    g_assert(size < NUM_PGSIZE_TYPES);
+    return size;
+}
+
+/*
+ * @return the page size of @a entry, in bytes.
+ */
+static inline uint64_t hex_tlb_page_size_bytes(uint64_t entry)
+{
+    return 1ull << (TARGET_PAGE_BITS + 2 * hex_tlb_pgsize_type(entry));
+}
+
+static inline uint64_t hex_tlb_phys_page_num(uint64_t entry)
+{
+    uint32_t ppd = GET_PPD(entry);
+    return ppd >> 1;
+}
+
+static inline uint64_t hex_tlb_phys_addr(uint64_t entry)
+{
+    uint64_t pagemask = encmask_2_mask[hex_tlb_pgsize_type(entry)];
+    uint64_t pagenum = hex_tlb_phys_page_num(entry);
+    uint64_t PA = (pagenum << TARGET_PAGE_BITS) & (~pagemask);
+    return PA;
+}
+
+static inline uint64_t hex_tlb_virt_addr(uint64_t entry)
+{
+    return (uint64_t)GET_TLB_FIELD(entry, PTE_VPN) << TARGET_PAGE_BITS;
+}
+
+static bool hex_dump_mmu_entry(FILE *f, uint64_t entry)
+{
+    if (GET_TLB_FIELD(entry, PTE_V)) {
+        fprintf(f, "0x%016" PRIx64 ": ", entry);
+        uint64_t PA = hex_tlb_phys_addr(entry);
+        uint64_t VA = hex_tlb_virt_addr(entry);
+        fprintf(f, "V:%" PRId64 " G:%" PRId64 " A1:%" PRId64 " A0:%" PRId64,
+                GET_TLB_FIELD(entry, PTE_V), GET_TLB_FIELD(entry, PTE_G),
+                GET_TLB_FIELD(entry, PTE_ATR1), GET_TLB_FIELD(entry, PTE_ATR0));
+        fprintf(f, " ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
+                GET_TLB_FIELD(entry, PTE_ASID), VA);
+        fprintf(f,
+                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64 " U:%" PRId64
+                " C:%" PRId64,
+                GET_TLB_FIELD(entry, PTE_X), GET_TLB_FIELD(entry, PTE_W),
+                GET_TLB_FIELD(entry, PTE_R), GET_TLB_FIELD(entry, PTE_U),
+                GET_TLB_FIELD(entry, PTE_C));
+        fprintf(f, " PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", PA,
+                pgsize_str[hex_tlb_pgsize_type(entry)],
+                hex_tlb_page_size_bytes(entry));
+        fprintf(f, "\n");
+        return true;
+    }
+
+    /* Not valid */
+    return false;
+}
+
+void dump_mmu(CPUHexagonState *env)
+{
+    int i;
+
+    HexagonCPU *cpu = env_archcpu(env);
+    for (i = 0; i < cpu->num_tlbs; i++) {
+        uint64_t entry = env->hex_tlb->entries[i];
+        if (GET_TLB_FIELD(entry, PTE_V)) {
+            qemu_printf("0x%016" PRIx64 ": ", entry);
+            uint64_t PA = hex_tlb_phys_addr(entry);
+            uint64_t VA = hex_tlb_virt_addr(entry);
+            qemu_printf(
+                "V:%" PRId64 " G:%" PRId64 " A1:%" PRId64 " A0:%" PRId64,
+                GET_TLB_FIELD(entry, PTE_V), GET_TLB_FIELD(entry, PTE_G),
+                GET_TLB_FIELD(entry, PTE_ATR1), GET_TLB_FIELD(entry, PTE_ATR0));
+            qemu_printf(" ASID:0x%02" PRIx64 " VA:0x%08" PRIx64,
+                        GET_TLB_FIELD(entry, PTE_ASID), VA);
+            qemu_printf(
+                " X:%" PRId64 " W:%" PRId64 " R:%" PRId64 " U:%" PRId64
+                " C:%" PRId64,
+                GET_TLB_FIELD(entry, PTE_X), GET_TLB_FIELD(entry, PTE_W),
+                GET_TLB_FIELD(entry, PTE_R), GET_TLB_FIELD(entry, PTE_U),
+                GET_TLB_FIELD(entry, PTE_C));
+            qemu_printf(" PA:0x%09" PRIx64 " SZ:%s (0x%" PRIx64 ")", PA,
+                        pgsize_str[hex_tlb_pgsize_type(entry)],
+                        hex_tlb_page_size_bytes(entry));
+            qemu_printf("\n");
+        }
+    }
+}
+
+static inline void hex_log_tlbw(uint32_t index, uint64_t entry)
+{
+    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+        if (qemu_log_enabled()) {
+            FILE *logfile = qemu_log_trylock();
+            if (logfile) {
+                fprintf(logfile, "tlbw[%03d]: ", index);
+                if (!hex_dump_mmu_entry(logfile, entry)) {
+                    fprintf(logfile, "invalid\n");
+                }
+                qemu_log_unlock(logfile);
+            }
+        }
+    }
+}
+
+void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value)
+{
+    uint32_t myidx = fTLB_NONPOW2WRAP(fTLB_IDXMASK(index));
+    bool old_entry_valid = GET_TLB_FIELD(env->hex_tlb->entries[myidx], PTE_V);
+    if (old_entry_valid && hexagon_cpu_mmu_enabled(env)) {
+        CPUState *cs = env_cpu(env);
+
+        tlb_flush(cs);
+    }
+    env->hex_tlb->entries[myidx] = (value);
+    hex_log_tlbw(myidx, value);
+}
+
+void hex_mmu_realize(CPUHexagonState *env)
+{
+    CPUState *cs = env_cpu(env);
+    if (cs->cpu_index == 0) {
+        env->hex_tlb = g_malloc0(sizeof(CPUHexagonTLBContext));
+    } else {
+        CPUState *cpu0 = qemu_get_cpu(0);
+        CPUHexagonState *env0 = cpu_env(cpu0);
+        env->hex_tlb = env0->hex_tlb;
+    }
+}
+
+void hex_mmu_on(CPUHexagonState *env)
+{
+    CPUState *cs = env_cpu(env);
+    qemu_log_mask(CPU_LOG_MMU, "Hexagon MMU turned on!\n");
+    tlb_flush(cs);
+}
+
+void hex_mmu_off(CPUHexagonState *env)
+{
+    CPUState *cs = env_cpu(env);
+    qemu_log_mask(CPU_LOG_MMU, "Hexagon MMU turned off!\n");
+    tlb_flush(cs);
+}
+
+void hex_mmu_mode_change(CPUHexagonState *env)
+{
+    qemu_log_mask(CPU_LOG_MMU, "Hexagon mode change!\n");
+    CPUState *cs = env_cpu(env);
+    tlb_flush(cs);
+}
+
+static inline bool hex_tlb_entry_match_noperm(uint64_t entry, uint32_t asid,
+                                              uint64_t VA)
+{
+    if (GET_TLB_FIELD(entry, PTE_V)) {
+        if (GET_TLB_FIELD(entry, PTE_G)) {
+            /* Global entry - ingnore ASID */
+        } else if (asid != NO_ASID) {
+            uint32_t tlb_asid = GET_TLB_FIELD(entry, PTE_ASID);
+            if (tlb_asid != asid) {
+                return false;
+            }
+        }
+
+        uint64_t page_size = hex_tlb_page_size_bytes(entry);
+        uint64_t page_start =
+            ROUND_DOWN(hex_tlb_virt_addr(entry), page_size);
+        if (page_start <= VA && VA < page_start + page_size) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline void hex_tlb_entry_get_perm(CPUHexagonState *env, uint64_t entry,
+                                          MMUAccessType access_type,
+                                          int mmu_idx, int *prot,
+                                          int32_t *excp)
+{
+    g_assert_not_reached();
+}
+
+static inline bool hex_tlb_entry_match(CPUHexagonState *env, uint64_t entry,
+                                       uint8_t asid, target_ulong VA,
+                                       MMUAccessType access_type, hwaddr *PA,
+                                       int *prot, int *size, int32_t *excp,
+                                       int mmu_idx)
+{
+    if (hex_tlb_entry_match_noperm(entry, asid, VA)) {
+        hex_tlb_entry_get_perm(env, entry, access_type, mmu_idx, prot, excp);
+        *PA = hex_tlb_phys_addr(entry);
+        *size = hex_tlb_page_size_bytes(entry);
+        return true;
+    }
+    return false;
+}
+
+bool hex_tlb_find_match(CPUHexagonState *env, target_ulong VA,
+                        MMUAccessType access_type, hwaddr *PA, int *prot,
+                        int *size, int32_t *excp, int mmu_idx)
+{
+    *PA = 0;
+    *prot = 0;
+    *size = 0;
+    *excp = 0;
+    uint32_t ssr = arch_get_system_reg(env, HEX_SREG_SSR);
+    uint8_t asid = GET_SSR_FIELD(SSR_ASID, ssr);
+    int i;
+    HexagonCPU *cpu = env_archcpu(env);
+    for (i = 0; i < cpu->num_tlbs; i++) {
+        uint64_t entry = env->hex_tlb->entries[i];
+        if (hex_tlb_entry_match(env, entry, asid, VA, access_type, PA, prot,
+                                size, excp, mmu_idx)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static uint32_t hex_tlb_lookup_by_asid(CPUHexagonState *env, uint32_t asid,
+                                       uint32_t VA)
+{
+    g_assert_not_reached();
+}
+
+/* Called from tlbp instruction */
+uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA)
+{
+    return hex_tlb_lookup_by_asid(env, GET_SSR_FIELD(SSR_ASID, ssr), VA);
+}
+
+static bool hex_tlb_is_match(CPUHexagonState *env,
+                             uint64_t entry1, uint64_t entry2,
+                             bool consider_gbit)
+{
+    bool valid1 = GET_TLB_FIELD(entry1, PTE_V);
+    bool valid2 = GET_TLB_FIELD(entry2, PTE_V);
+    uint64_t size1 = hex_tlb_page_size_bytes(entry1);
+    uint64_t vaddr1 = ROUND_DOWN(hex_tlb_virt_addr(entry1), size1);
+    uint64_t size2 = hex_tlb_page_size_bytes(entry2);
+    uint64_t vaddr2 = ROUND_DOWN(hex_tlb_virt_addr(entry2), size2);
+    int asid1 = GET_TLB_FIELD(entry1, PTE_ASID);
+    int asid2 = GET_TLB_FIELD(entry2, PTE_ASID);
+    bool gbit1 = GET_TLB_FIELD(entry1, PTE_G);
+    bool gbit2 = GET_TLB_FIELD(entry2, PTE_G);
+
+    if (!valid1 || !valid2) {
+        return false;
+    }
+
+    if (((vaddr1 <= vaddr2) && (vaddr2 < (vaddr1 + size1))) ||
+        ((vaddr2 <= vaddr1) && (vaddr1 < (vaddr2 + size2)))) {
+        if (asid1 == asid2) {
+            return true;
+        }
+        if ((consider_gbit && gbit1) || gbit2) {
+            return true;
+        }
+    }
+    return false;
+}
+
+/*
+ * Return codes:
+ * 0 or positive             index of match
+ * -1                        multiple matches
+ * -2                        no match
+ */
+int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
+{
+    int matches = 0;
+    int last_match = 0;
+    int i;
+
+    HexagonCPU *cpu = env_archcpu(env);
+    for (i = 0; i < cpu->num_tlbs; i++) {
+        if (hex_tlb_is_match(env, entry, env->hex_tlb->entries[i], false)) {
+            matches++;
+            last_match = i;
+        }
+    }
+
+    if (matches == 1) {
+        return last_match;
+    }
+    if (matches == 0) {
+        return -2;
+    }
+    return -1;
+}
+
+static inline void print_thread(const char *str, CPUState *cs)
+{
+    g_assert(bql_locked());
+    CPUHexagonState *thread = cpu_env(cs);
+    bool is_stopped = cpu_is_stopped(cs);
+    int exe_mode = get_exe_mode(thread);
+    hex_lock_state_t lock_state = thread->tlb_lock_state;
+    qemu_log_mask(CPU_LOG_MMU,
+           "%s: threadId = %d: %s, exe_mode = %s, tlb_lock_state = %s\n",
+           str,
+           thread->threadId,
+           is_stopped ? "stopped" : "running",
+           exe_mode == HEX_EXE_MODE_OFF ? "off" :
+           exe_mode == HEX_EXE_MODE_RUN ? "run" :
+           exe_mode == HEX_EXE_MODE_WAIT ? "wait" :
+           exe_mode == HEX_EXE_MODE_DEBUG ? "debug" :
+           "unknown",
+           lock_state == HEX_LOCK_UNLOCKED ? "unlocked" :
+           lock_state == HEX_LOCK_WAITING ? "waiting" :
+           lock_state == HEX_LOCK_OWNER ? "owner" :
+           "unknown");
+}
+
+static inline void print_thread_states(const char *str)
+{
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        print_thread(str, cs);
+    }
+}
+
+void hex_tlb_lock(CPUHexagonState *env)
+{
+    qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: %d\n", env->threadId);
+    BQL_LOCK_GUARD();
+    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));
+
+    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
+    uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
+    if (tlb_lock) {
+        if (env->tlb_lock_state == HEX_LOCK_QUEUED) {
+            env->next_PC += 4;
+            env->tlb_lock_count++;
+            env->tlb_lock_state = HEX_LOCK_OWNER;
+            SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
+            return;
+        }
+        if (env->tlb_lock_state == HEX_LOCK_OWNER) {
+            qemu_log_mask(CPU_LOG_MMU | LOG_GUEST_ERROR,
+                          "Double tlblock at PC: 0x%x, thread may hang\n",
+                          env->next_PC);
+            env->next_PC += 4;
+            CPUState *cs = env_cpu(env);
+            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+            return;
+        }
+        env->tlb_lock_state = HEX_LOCK_WAITING;
+        CPUState *cs = env_cpu(env);
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+    } else {
+        env->next_PC += 4;
+        env->tlb_lock_count++;
+        env->tlb_lock_state = HEX_LOCK_OWNER;
+        SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 1);
+    }
+
+    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+        qemu_log_mask(CPU_LOG_MMU, "Threads after hex_tlb_lock:\n");
+        print_thread_states("\tThread");
+    }
+}
+
+void hex_tlb_unlock(CPUHexagonState *env)
+{
+    BQL_LOCK_GUARD();
+    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));
+
+    /* Nothing to do if the TLB isn't locked by this thread */
+    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
+    uint8_t tlb_lock = GET_SYSCFG_FIELD(SYSCFG_TLBLOCK, syscfg);
+    if ((tlb_lock == 0) ||
+        (env->tlb_lock_state != HEX_LOCK_OWNER)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "thread %d attempted to tlbunlock without having the "
+                      "lock, tlb_lock state = %d\n",
+                      env->threadId, env->tlb_lock_state);
+        g_assert(env->tlb_lock_state != HEX_LOCK_WAITING);
+        return;
+    }
+
+    env->tlb_lock_count--;
+    env->tlb_lock_state = HEX_LOCK_UNLOCKED;
+    SET_SYSCFG_FIELD(env, SYSCFG_TLBLOCK, 0);
+
+    /* Look for a thread to unlock */
+    unsigned int this_threadId = env->threadId;
+    CPUHexagonState *unlock_thread = NULL;
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        CPUHexagonState *thread = cpu_env(cs);
+
+        /*
+         * The hardware implements round-robin fairness, so we look for threads
+         * starting at env->threadId + 1 and incrementing modulo the number of
+         * threads.
+         *
+         * To implement this, we check if thread is a earlier in the modulo
+         * sequence than unlock_thread.
+         *     if unlock thread is higher than this thread
+         *         thread must be between this thread and unlock_thread
+         *     else
+         *         thread higher than this thread is ahead of unlock_thread
+         *         thread must be lower then unlock thread
+         */
+        if (thread->tlb_lock_state == HEX_LOCK_WAITING) {
+            if (!unlock_thread) {
+                unlock_thread = thread;
+            } else if (unlock_thread->threadId > this_threadId) {
+                if (this_threadId < thread->threadId &&
+                    thread->threadId < unlock_thread->threadId) {
+                    unlock_thread = thread;
+                }
+            } else {
+                if (thread->threadId > this_threadId) {
+                    unlock_thread = thread;
+                }
+                if (thread->threadId < unlock_thread->threadId) {
+                    unlock_thread = thread;
+                }
+            }
+        }
+    }
+    if (unlock_thread) {
+        cs = env_cpu(unlock_thread);
+        print_thread("\tWaiting thread found", cs);
+        unlock_thread->tlb_lock_state = HEX_LOCK_QUEUED;
+        SET_SYSCFG_FIELD(unlock_thread, SYSCFG_TLBLOCK, 1);
+        cpu_interrupt(cs, CPU_INTERRUPT_TLB_UNLOCK);
+    }
+
+    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+        qemu_log_mask(CPU_LOG_MMU, "Threads after hex_tlb_unlock:\n");
+        print_thread_states("\tThread");
+    }
+
+}
+
diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
index 10e0fe9688..f3d2bdf41d 100644
--- a/target/hexagon/machine.c
+++ b/target/hexagon/machine.c
@@ -7,6 +7,33 @@
 #include "qemu/osdep.h"
 #include "migration/cpu.h"
 #include "cpu.h"
+#include "hex_mmu.h"
+
+static int get_hex_tlb_ptr(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field)
+{
+    CPUHexagonTLBContext *tlb = pv;
+    for (int i = 0; i < ARRAY_SIZE(tlb->entries); i++) {
+        tlb->entries[i] = qemu_get_be64(f);
+    }
+    return 0;
+}
+
+static int put_hex_tlb_ptr(QEMUFile *f, void *pv, size_t size,
+                      const VMStateField *field, JSONWriter *vmdesc)
+{
+    CPUHexagonTLBContext *tlb = pv;
+    for (int i = 0; i < ARRAY_SIZE(tlb->entries); i++) {
+        qemu_put_be64(f,  tlb->entries[i]);
+    }
+    return 0;
+}
+
+const VMStateInfo vmstate_info_hex_tlb_ptr = {
+    .name = "hex_tlb_pointer",
+    .get  = get_hex_tlb_ptr,
+    .put  = put_hex_tlb_ptr,
+};
 
 
 const VMStateDescription vmstate_hexagon_cpu = {
@@ -27,6 +54,9 @@ const VMStateDescription vmstate_hexagon_cpu = {
         VMSTATE_UINTTL(env.threadId, HexagonCPU),
         VMSTATE_UINTTL(env.cause_code, HexagonCPU),
         VMSTATE_UINTTL(env.wait_next_pc, HexagonCPU),
+        VMSTATE_POINTER(env.hex_tlb, HexagonCPU, 0,
+                        vmstate_info_hex_tlb_ptr, CPUHexagonTLBContext *),
+
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index d788aa227c..b74ddc2acb 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -943,7 +943,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs));
     uint32_t hex_flags = dcbase->tb->flags;
 
-    ctx->mem_idx = MMU_USER_IDX;
+    ctx->mem_idx = FIELD_EX32(hex_flags, TB_FLAGS, MMU_INDEX);
     ctx->num_packets = 0;
     ctx->num_insns = 0;
     ctx->num_hvx_insns = 0;
-- 
2.34.1


