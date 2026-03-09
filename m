Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0AAF417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv7-0001eQ-Di; Mon, 09 Mar 2026 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv3-0001TV-IY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv1-0005JW-58
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629DpP0M4086940
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BjOwtISkSznIkGFggrt4iZcpPbtGpp3lhAskrbSBHZg=; b=FQ96PhDCoWdjMmd4
 q6r2K5bIC9XCTVSGCmCnRWiM93+7IujiR+kZ7DkKpDarsQPu0n8CaOscQfk8BCpv
 E9PIZRN/k32RlQaNlYu1q2NIgdyZzHrDcOS6HwlqQ8YP72xIbYXKfbncc3A3tEXC
 qydkUpiqnu9m3m0KlCrbCWHrBJP4JYzCmCpa8A3rooNtKoOAMxxj1dWHrg1OPYm8
 c5sQFgEd7+p9T/a1kdltV9Cjfa7QmArK3phLPDzLSSEGPWHL9oY0rHM0lnI6jcLU
 dld/q9ikaqBUtqke4qEyrk22GEboOfKJm1mhDQov4aM2gNw5MRFwpVW3lj/95vxZ
 ZxFqAA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crd6fdr8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:03 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2be232ef3d3so70734377eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067743; x=1773672543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjOwtISkSznIkGFggrt4iZcpPbtGpp3lhAskrbSBHZg=;
 b=JIN3R1jxQiycfh+YAQIHPMXyqGLtkz0Q0I7artTwyDNw9FDtk+ueMh8B3FxDMaqr+c
 xPhBsOxoypfNgjciFGBgWS5Cq4LoSPokwEcBEzkKnEmw0BVIqW0GGYIeY71r46veHWXF
 ppXLgUX5w2j1+wmW+VFa/I4ZO+WcOTX8tU4qytEVDV6cpBAvAYr/XimZ8KP/gjX3YJAe
 5BHsaElW+G8gQLYTWZeJSOgqjrrhGfrTeGAt+kGGj6Qn5dkuPtVdd7UFg3WdVjmlTziv
 gmc7JfqTZ/mvXSnF6elIGOiLjIH0W2ox3WE/qVMJYMlOxoY6CUk1ynRo2rIESfBw1nFt
 445Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067743; x=1773672543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BjOwtISkSznIkGFggrt4iZcpPbtGpp3lhAskrbSBHZg=;
 b=cMYP558O/SwW5TTp0K2xfz7jJfz/Z8uFXQRbASZZJVGH08e/IkmaTj7RYOapmcSx4O
 fzfbyEjfa4TUntI+wEOMSPyNZBs5NW2ZzjpGT4rquOFsSXZ+kpysDFusufTVpDlMg76P
 TxVPFzIn+STKoR+V/Zrj4nIi0yqEQS0HqdWnRSNjumetxb+iJl5V8LcoO4wh6k80W2wU
 IRfRL83RsIAiBcabjZLOnPOvKGNiZ2nx/z5TEmnpFQs0G2V1Kau3ajndMOK468Oj0487
 bnXY3bXLjC0c+3coLT9ako7pRhZ0TutbuoDJAv5UprN7d60fqM0lSMBSb1vejQH8bbLu
 UlTw==
X-Gm-Message-State: AOJu0YxZRDhW+r1Z30htRgF1Y3W8FjCbus1dteaWnR7C+r7UOdMHH4/S
 wMdqdlyi2QoM8qkWccrWYtmCerZaI1ZwgF2w1PfpURUnQU+800aLoC3zinptV2B+PQEn0jdcB6s
 eHLu/apNUytlerfe+EpT+x776OB8AW689OknCgLWvnQkVFDtxn4FPVi98ZJBXz1v2UQ==
X-Gm-Gg: ATEYQzx6qj/nhkzZ5B0lTWPDz0cgYehvQT/uqqhIJjPNjq0cmT3Ud9bYLNHdTDKQ2zB
 0AZgI871Vsq7wYWzlxpPw4oU67lI++dzLiyCYOPcGU1XrkyQxoII19bXjJ9RbATkA+0zkm94rZm
 yBupUJNKtiLqshjJvU7x/+w1WE6vACmCb2+JY57kWilsAhBjzmUlyG1yfP4vKIw5MNaOCEAlyN9
 kr+NucnsT/FGUgcEdwI3bwMUaixT2NyhmKDPBjCobnK3Ox3L897TmKCrlmczS9DEWOQhvhbBkQx
 DhAif8v3u7jgk+TMIjq8X7ztwPyVB4kuy+OFuGmJNrCu5+FKn5mzHuw4/Nu46Vx2zJoLwDEkDJZ
 C/JROzANPMeAZe40VeVEdfO0YWSlRjG1TmBDDSRxQOtFu/Pydh9XG+iSWQm7948Q0RqFZ1g==
X-Received: by 2002:a05:7300:fd0e:b0:2be:2345:bec9 with SMTP id
 5a478bee46e88-2be4e05d213mr4911234eec.31.1773067742403; 
 Mon, 09 Mar 2026 07:49:02 -0700 (PDT)
X-Received: by 2002:a05:7300:fd0e:b0:2be:2345:bec9 with SMTP id
 5a478bee46e88-2be4e05d213mr4911211eec.31.1773067741865; 
 Mon, 09 Mar 2026 07:49:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:49:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v4 32/35] target/hexagon: Add stubs for modify_ssr/get_exe_mode
Date: Mon,  9 Mar 2026 07:48:19 -0700
Message-Id: <20260309144822.877695-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XbbsmJ3mPRJwqfgtrQ8rLEvJyoqW9jN4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX7T/1pczt5wVn
 rEa0iC+n34G0IVYu9q4VlkjPSD1B0SByKaDjj9Aqg11cxaYkuSIx4TkeRqgNzpenAwzgqvVE4u+
 JS9NzYS151fw3xrCisjv/i7y74XEtc2H+yQTcUwzQDf58dO631LMkAjCmzM90+rd7ex/qJfJllM
 JCHMtUmTGFXyKSsfdzEV6+4gOytb78ZGtJjrxxazWZKz1/7VKSm8cIYZJUDspZBP+2rLhvV39a+
 EJC4cyTygWVCSsSpEQGaRvAzofPbmFfeo3OhYD9XyaP+kQ6KZyV5KF0t1TDfabqYrfftF8G9+i9
 exH9mGnunEfd3ILJXi3A3p6s50fChptyo+7Y4r+Mb+yoRu2Yi7jv+VrpAmYkhY57rxY0DKdoOZp
 Qd41AlvfgRq8N8YzV4w5L1W8zhBWGeR44c8UNnuhGG8L5FZPzSpyuusrUIPZdZLatfPwag3UJmi
 /anlLCcoUuYEKjmRKuQ==
X-Proofpoint-GUID: XbbsmJ3mPRJwqfgtrQ8rLEvJyoqW9jN4
X-Authority-Analysis: v=2.4 cv=RP++3oi+ c=1 sm=1 tr=0 ts=69aedddf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1eS9DRoYkSOUxsN_X7IA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add hex_mmu.[ch], cpu mode helpers, and additional includes/stubs
that integrate the TLB device with the CPU model.

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu-param.h  |   4 +
 target/hexagon/cpu.h        |   5 +
 target/hexagon/cpu_helper.h |   2 +
 target/hexagon/hex_mmu.h    |  25 ++++
 target/hexagon/internal.h   |   9 ++
 target/hexagon/cpu.c        |  21 +++
 target/hexagon/cpu_helper.c |  10 ++
 target/hexagon/hex_mmu.c    | 277 ++++++++++++++++++++++++++++++++++++
 target/hexagon/translate.c  |   2 +-
 9 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 target/hexagon/hex_mmu.h
 create mode 100644 target/hexagon/hex_mmu.c

diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 1f0f22a7968..9eae7d2361c 100644
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
 
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 0c00feb0469..d8092cb6fe7 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -38,6 +38,9 @@
 #error "Hexagon does not support system emulation"
 #endif
 
+#ifndef CONFIG_USER_ONLY
+#endif
+
 #define NUM_PREGS 4
 #define TOTAL_PER_THREAD_REGS 64
 
@@ -189,12 +192,14 @@ struct ArchCPU {
     bool short_circuit;
 #ifndef CONFIG_USER_ONLY
     struct HexagonTLBState *tlb;
+    uint32_t htid;
 #endif
 };
 
 #include "cpu_bits.h"
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
+FIELD(TB_FLAGS, MMU_INDEX, 1, 3)
 
 G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index 1486a03c64a..18300657f3d 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -14,5 +14,7 @@ uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env);
 void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t);
 void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env, uint32_t);
 void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
+void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
+int get_exe_mode(CPUHexagonState *env);
 
 #endif
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
new file mode 100644
index 00000000000..99ddb3736a2
--- /dev/null
+++ b/target/hexagon/hex_mmu.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_MMU_H
+#define HEXAGON_MMU_H
+
+#include "cpu.h"
+
+extern void hex_tlbw(CPUHexagonState *env, uint32_t index, uint64_t value);
+extern uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA);
+extern void hex_mmu_on(CPUHexagonState *env);
+extern void hex_mmu_off(CPUHexagonState *env);
+extern void hex_mmu_mode_change(CPUHexagonState *env);
+extern bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
+                               MMUAccessType access_type, hwaddr *PA, int *prot,
+                               uint64_t *size, int32_t *excp, int mmu_idx);
+extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
+                                 uint64_t index);
+extern void hex_tlb_lock(CPUHexagonState *env);
+extern void hex_tlb_unlock(CPUHexagonState *env);
+void dump_mmu(CPUHexagonState *env);
+#endif
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 33d73ed18d1..4338914efb5 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -36,6 +36,15 @@ void G_NORETURN do_raise_exception(CPUHexagonState *env,
         uint32_t PC,
         uintptr_t retaddr);
 
+#define hexagon_cpu_mmu_enabled(env) ({ \
+    HexagonCPU *cpu = env_archcpu(env); \
+    cpu->globalregs ? \
+        GET_SYSCFG_FIELD(SYSCFG_MMUEN, \
+            hexagon_globalreg_read(cpu->globalregs, \
+                                   HEX_SREG_SYSCFG, (env)->threadId)) : \
+        0; \
+})
+
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_hexagon_cpu;
 #endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 640369329dc..5c937fa1cd1 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -27,6 +27,13 @@
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
 #include "accel/tcg/cpu-ops.h"
+#include "cpu_helper.h"
+#include "hex_mmu.h"
+
+#ifndef CONFIG_USER_ONLY
+#include "sys_macros.h"
+#include "accel/tcg/cpu-ldst.h"
+#endif
 
 static void hexagon_v66_cpu_init(Object *obj) { }
 static void hexagon_v67_cpu_init(Object *obj) { }
@@ -54,6 +61,7 @@ static const Property hexagon_cpu_properties[] = {
 #if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
                      HexagonTLBState *),
+    DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
 #endif
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
@@ -280,6 +288,13 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
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
 
@@ -297,6 +312,7 @@ static void hexagon_restore_state_to_opc(CPUState *cs,
     cpu_env(cs)->gpr[HEX_REG_PC] = data[0];
 }
 
+
 static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -320,6 +336,10 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     env->tlb_lock_count = 0;
     env->k0_lock_count = 0;
     env->next_PC = 0;
+
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    env->t_sreg[HEX_SREG_HTID] = cpu->htid;
+    env->threadId = cpu->htid;
 #endif
     env->cause_code = HEX_EVENT_NONE;
 }
@@ -348,6 +368,7 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
                              gdb_find_static_feature("hexagon-hvx.xml"), 0);
 
     qemu_init_vcpu(cs);
+
     cpu_reset(cs);
     mcc->parent_realize(dev, errp);
 }
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index b8e0625e3f8..b6a8bd35309 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -58,3 +58,13 @@ void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
 {
     g_assert_not_reached();
 }
+
+void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old)
+{
+    g_assert_not_reached();
+}
+
+int get_exe_mode(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
new file mode 100644
index 00000000000..1cdc92fdc31
--- /dev/null
+++ b/target/hexagon/hex_mmu.c
@@ -0,0 +1,277 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
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
+#include "hw/hexagon/hexagon_tlb.h"
+#include "hw/hexagon/hexagon_globalreg.h"
+
+static inline void hex_log_tlbw(uint32_t index, uint64_t entry)
+{
+    if (qemu_loglevel_mask(CPU_LOG_MMU)) {
+        if (qemu_log_enabled()) {
+            FILE *logfile = qemu_log_trylock();
+            if (logfile) {
+                fprintf(logfile, "tlbw[%03d]: ", index);
+                if (!hexagon_tlb_dump_entry(logfile, entry)) {
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
+    HexagonTLBState *tlb = env_archcpu(env)->tlb;
+    uint64_t old_entry = hexagon_tlb_read(tlb, myidx);
+
+    bool old_entry_valid = extract64(old_entry, 63, 1);
+    if (old_entry_valid && hexagon_cpu_mmu_enabled(env)) {
+        CPUState *cs = env_cpu(env);
+        tlb_flush(cs);
+    }
+    hexagon_tlb_write(tlb, myidx, value);
+    hex_log_tlbw(myidx, value);
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
+bool hex_tlb_find_match(CPUHexagonState *env, uint32_t VA,
+                        MMUAccessType access_type, hwaddr *PA, int *prot,
+                        uint64_t *size, int32_t *excp, int mmu_idx)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
+    uint8_t asid = GET_SSR_FIELD(SSR_ASID, ssr);
+    int cause_code = 0;
+
+    bool found = hexagon_tlb_find_match(cpu->tlb, asid, VA, access_type,
+                                        PA, prot, size, excp, &cause_code,
+                                        mmu_idx);
+    if (cause_code) {
+        env->cause_code = cause_code;
+    }
+    return found;
+}
+
+/* Called from tlbp instruction */
+uint32_t hex_tlb_lookup(CPUHexagonState *env, uint32_t ssr, uint32_t VA)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint8_t asid = GET_SSR_FIELD(SSR_ASID, ssr);
+    int cause_code = 0;
+
+    uint32_t result = hexagon_tlb_lookup(cpu->tlb, asid, VA, &cause_code);
+    if (cause_code) {
+        env->cause_code = cause_code;
+    }
+    return result;
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
+    HexagonCPU *cpu = env_archcpu(env);
+    return hexagon_tlb_check_overlap(cpu->tlb, entry, index);
+}
+
+void dump_mmu(CPUHexagonState *env)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    hexagon_tlb_dump(cpu->tlb);
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
+    qemu_log_mask(CPU_LOG_MMU, "hex_tlb_lock: " TARGET_FMT_ld "\n",
+                  env->threadId);
+    BQL_LOCK_GUARD();
+    g_assert((env->tlb_lock_count == 0) || (env->tlb_lock_count == 1));
+
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t syscfg = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
+                               env->threadId) : 0;
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
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t syscfg = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
+                               env->threadId) : 0;
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
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index cd6affa2f49..4df4226cbcb 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -987,7 +987,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs));
     uint32_t hex_flags = dcbase->tb->flags;
 
-    ctx->mem_idx = MMU_USER_IDX;
+    ctx->mem_idx = FIELD_EX32(hex_flags, TB_FLAGS, MMU_INDEX);
     ctx->num_packets = 0;
     ctx->num_insns = 0;
     ctx->num_hvx_insns = 0;
-- 
2.34.1


