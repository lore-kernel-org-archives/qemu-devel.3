Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA2DCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1B-0001Dk-FR; Mon, 01 Sep 2025 23:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI19-0001Ae-V0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI17-0004cE-J5
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RlRd012433
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m8oqFVnMH2IVmyeIFRru/rqdGObfY/30qKnuYmfKufk=; b=KaI1g2+3aLbRlj2O
 BHKVDHFAVfplx01rQCWKn6piiAK/OvZjc3zn/VEdba5SGBwOjKGi5yTu4wvO4Vvx
 Db94a4AyIfVv534JEJ5UjCEe6dcpU2uxRtzDuiAV921P6ZJjKdp+ZUgYyTIrurZZ
 EVbR1qloMrGbREFnIwwHQYhPJznV2QHBKoCxG8G0dlAnwhe0smZW+MnYEcyo1yim
 65sRsgI9Uq3m6isGu+tUQcTxYVaDnNhohO+Ny90RHeu5JEU33Zb/OX5oYdV46/L9
 EH+bLRyV9MNVdw8pdQPk87MMcCNWjBrmJI/vpDZeGWvusG0iu00m1GmHIy44cBWm
 E6u06Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eej8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-327b5e7f2f6so7154487a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784947; x=1757389747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8oqFVnMH2IVmyeIFRru/rqdGObfY/30qKnuYmfKufk=;
 b=HQIsIuhQopKvHCSRNVfLQu1J6ibRQ00sjoHFjICBcLQgAwKYplIczB3/mybqSXAhhv
 sU8VYBmYkh18hvtJV6UELuxqvzcA0ZO/ntPHO9Jo4exu3UcYTttm6LDKokY/DclZraD7
 /PCqmPQzwYGoGmMGDNFxRUO8JYHKjiYbtv5SdPUZbofaqOAIIXu9CftRVZY0as81yoLB
 AasoQS0attQN3/VeilGmoU1IhIWlGAe8QKJEm8BQzlmlK3bSPPSlbYD8SCHPKziR+Czw
 uaeZeKVPXGM30M0W1FA/mTFWuc+9zmKfgfcJBDyFzCOzeGmrqFj2QUXTaaqwTqO2g2JR
 l/rQ==
X-Gm-Message-State: AOJu0Yx7td2eVWeqXwRnGDrm0hPiDL4nrN9QVfC54+gKPs183UqourXl
 kMfLy/1t6Xfmc/HVc4tal1wSzMnaMLtErG2zeMBiH3lWWpQvTxWG+/cRYArgW3/KJtNRuqSSh/s
 b2vIVVJAJ6a8jANvGb5/SPSe99wRizaQNAfE60zKPfLtDtxmypUqYVQxurYQbZKzmNDoP
X-Gm-Gg: ASbGncsVebt05U30cwzDvNttclYxaQAffSLuS7yifIwX+LulT43IOdJW+VcIEIMV8g6
 60g18BDJxWDIJTx6Xa1tfqelXh938iwSG56v+bbIl+YLzvx+r4xloYmuCE31JIr2Liu4pnS1Gtz
 b/Cg1qpJ1BE/RoOHGSMuwmxPJ9Yiruq8MJ78Sjnlhl5dHcYcsig1vx20j9fd7rWrjrOhgX8T+3R
 nve9SYEdZXjecu15ewnGaH8yv051erz76VINXMNITz5Ab8LDEpMXkAZRsZwp2BkFu1LoaC1//jU
 ufRyDoQCJkclo7a/nIk1YCGYcQQ9ZbZpjYl5u+iAdlVQAx8lYJv/Lc7SzT1srC1xHXJ2LRsLqno
 PeeLFL0wPKjwv
X-Received: by 2002:a17:90b:3c0e:b0:327:c9a4:de71 with SMTP id
 98e67ed59e1d1-32815412248mr14757889a91.6.1756784946854; 
 Mon, 01 Sep 2025 20:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmzbQra0wuPhSl/0Tm7FUufO2GzxSXSmQD5F2vF/ZaNlBdqq1eexGbgnSkaZOPCLaCnvkotA==
X-Received: by 2002:a17:90b:3c0e:b0:327:c9a4:de71 with SMTP id
 98e67ed59e1d1-32815412248mr14757854a91.6.1756784946312; 
 Mon, 01 Sep 2025 20:49:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v2 12/39] target/hexagon: Add implementation of cycle counters
Date: Mon,  1 Sep 2025 20:48:20 -0700
Message-Id: <20250902034847.1948010-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mh_kfLRS4gDctVyyXtEUKwMqFKptaeBq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX8RzNmU54tGJ2
 +RVb3fDaZeOMWs70PqJwRYsHZJAfEH06/HbANVSa9gHwIXDeWW0ybLL+AInvXAzyn4L4+Vxsj+U
 YmbbLhT9TeOeIeaQdQhoroBiAce2DDcfrTHNCTQJ1obkSsqG5zc0ycuRY8Tjos8rh8W+Mu6YCZc
 yIlGOGYdlhT53TuEwdyxtNfZN7xhETufgm43ja3PBxPXUEwfLlRnJtC/iCsyOlhcFNgJG5v6b7D
 RdTaX0cZDGa/OURdK8xtKo6Xx4+EHKEDtcd9mfjui2iwNM/fMlirRDek48v4jNzu04EgexMmDUg
 mzf9BSjiZWv5vANmXE25W+0sCTy5SH1Cm4//GAjod26IIspEguuvQNpEXpMb3M3R276Jce1i3bp
 HnvDWIQq
X-Proofpoint-ORIG-GUID: mh_kfLRS4gDctVyyXtEUKwMqFKptaeBq
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b66934 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=6WCJHhgCVYwEtMrCBCEA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
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

The PCYCLE register is available in system mode, but only increments
when the SYSCFG.PCYCLEEN field is set.

The UPCYCLE register is available in user mode and we model it
unconditionally in linux-user emulation, as if the system had enabled
PCYCCLEEN.

For now, the model is very crudely counting the sum of instructions
executed among vCPUs, regardless of how the instructions were actually
scheduled.  This is sufficient for demonstrating a rough level of
activity but will be particularly misleading for benchmarks and performance
tuning.  We may decide to revisit this model in order to give more
a bit more fidelity, though without a cache model it would still be very far
from accurate.

Co-authored-by: Sid Manning <sidneym@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h        |  3 +++
 target/hexagon/translate.h  |  2 ++
 target/hexagon/cpu.c        | 11 +++++++++++
 target/hexagon/cpu_helper.c | 33 +++++++++++++++++++++++++++++----
 target/hexagon/translate.c  | 27 +++++++++++++++++++++++++++
 5 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 8046f7bff0..354e9e9cbf 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -28,6 +28,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
+#include "exec/cpu-common.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
 #include "hw/registerfields.h"
@@ -37,6 +38,7 @@
 #endif
 
 #ifndef CONFIG_USER_ONLY
+#include "reg_fields.h"
 typedef struct CPUHexagonTLBContext CPUHexagonTLBContext;
 #endif
 
@@ -200,6 +202,7 @@ struct ArchCPU {
 
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 FIELD(TB_FLAGS, MMU_INDEX, 1, 3)
+FIELD(TB_FLAGS, PCYCLE_ENABLED, 4, 1)
 
 G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index c3806fe068..0bdf526a9e 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -83,6 +83,8 @@ typedef struct DisasContext {
     TCGv new_pred_value[NUM_PREGS];
     TCGv branch_taken;
     TCGv dczero_addr;
+    bool pcycle_enabled;
+    uint32_t num_cycles;
 } DisasContext;
 
 bool is_gather_store_insn(DisasContext *ctx);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index e35ac92402..b7e21c913f 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -281,9 +281,20 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
     }
 
 #ifndef CONFIG_USER_ONLY
+    target_ulong syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
+
+    bool pcycle_enabled = extract32(syscfg,
+                                    reg_field_info[SYSCFG_PCYCLEEN].offset,
+                                    reg_field_info[SYSCFG_PCYCLEEN].width);
+
     hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
                            cpu_mmu_index(env_cpu(env), false));
+
+    if (pcycle_enabled) {
+        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, 1);
+    }
 #else
+    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, true);
     hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX, MMU_USER_IDX);
 #endif
 
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index fc49fe7883..f540eadef4 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -91,17 +91,30 @@ void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
 
 uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    uint64_t cycles = 0;
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        CPUHexagonState *thread_env = cpu_env(cs);
+        cycles += thread_env->t_cycle_count;
+    }
+#ifndef CONFIG_USER_ONLY
+    HexagonCPU *cpu = env_archcpu(env);
+    return (cpu->globalregs ? hexagon_globalreg_get_pcycle_base(cpu) : 0) +
+           cycles;
+#else
+    return cycles;
+#endif
 }
 
 uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env)
 {
-    g_assert_not_reached();
+    return hexagon_get_sys_pcycle_count(env) >> 32;
 }
 
 uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)
 {
-    g_assert_not_reached();
+    return extract64(hexagon_get_sys_pcycle_count(env), 0, 32);
 }
 
 void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env,
@@ -118,7 +131,19 @@ void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env,
 
 void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+#ifndef CONFIG_USER_ONLY
+    HexagonCPU *cpu = env_archcpu(env);
+    if (cpu->globalregs) {
+        hexagon_globalreg_set_pcycle_base(cpu, cycles);
+    }
+#endif
+
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        CPUHexagonState *thread_env = cpu_env(cs);
+        thread_env->t_cycle_count = 0;
+    }
 }
 
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index b74ddc2acb..a71fa33ccf 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -57,6 +57,7 @@ TCGv_i64 hex_store_val64[STORES_MAX];
 TCGv hex_llsc_addr;
 TCGv hex_llsc_val;
 TCGv_i64 hex_llsc_val_i64;
+TCGv_i64 hex_cycle_count;
 TCGv hex_vstore_addr[VSTORES_MAX];
 TCGv hex_vstore_size[VSTORES_MAX];
 TCGv hex_vstore_pending[VSTORES_MAX];
@@ -124,6 +125,22 @@ static void gen_exception_raw(int excp)
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
 }
 
+#ifndef CONFIG_USER_ONLY
+static inline void gen_precise_exception(int excp, target_ulong PC)
+{
+    tcg_gen_movi_tl(hex_cause_code, excp);
+    gen_exception(HEX_EVENT_PRECISE, PC);
+}
+
+static inline void gen_pcycle_counters(DisasContext *ctx)
+{
+    if (ctx->pcycle_enabled) {
+        tcg_gen_addi_i64(hex_cycle_count, hex_cycle_count, ctx->num_cycles);
+        ctx->num_cycles = 0;
+    }
+}
+#endif
+
 static void gen_exec_counters(DisasContext *ctx)
 {
     tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],
@@ -132,6 +149,10 @@ static void gen_exec_counters(DisasContext *ctx)
                     hex_gpr[HEX_REG_QEMU_INSN_CNT], ctx->num_insns);
     tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_HVX_CNT],
                     hex_gpr[HEX_REG_QEMU_HVX_CNT], ctx->num_hvx_insns);
+
+#ifndef CONFIG_USER_ONLY
+   gen_pcycle_counters(ctx);
+#endif
 }
 
 static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
@@ -784,6 +805,7 @@ static void gen_commit_hvx(DisasContext *ctx)
     }
 }
 
+static const int PCYCLES_PER_PACKET = 3;
 static void update_exec_counters(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
@@ -803,6 +825,7 @@ static void update_exec_counters(DisasContext *ctx)
     }
 
     ctx->num_packets++;
+    ctx->num_cycles += PCYCLES_PER_PACKET;
     ctx->num_insns += num_real_insns;
     ctx->num_hvx_insns += num_hvx_insns;
 }
@@ -945,11 +968,13 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
 
     ctx->mem_idx = FIELD_EX32(hex_flags, TB_FLAGS, MMU_INDEX);
     ctx->num_packets = 0;
+    ctx->num_cycles = 0;
     ctx->num_insns = 0;
     ctx->num_hvx_insns = 0;
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
     ctx->short_circuit = hex_cpu->short_circuit;
+    ctx->pcycle_enabled = FIELD_EX32(hex_flags, TB_FLAGS, PCYCLE_ENABLED);
 }
 
 static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
@@ -1076,6 +1101,8 @@ void hexagon_translate_init(void)
         offsetof(CPUHexagonState, llsc_val), "llsc_val");
     hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
         offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
+    hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
+            offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
     for (i = 0; i < STORES_MAX; i++) {
         snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
         hex_store_addr[i] = tcg_global_mem_new(tcg_env,
-- 
2.34.1


