Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB9FD39410
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8FaX-0004fx-Bn; Thu, 02 Apr 2026 06:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaV-0004ea-1I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w8FaS-0007nJ-Kn
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:47:46 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6326p30D4009504
 for <qemu-devel@nongnu.org>; Thu, 2 Apr 2026 10:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Xz1CmgTtPGx
 O7CCCYjV3Yce2C/RGGhA/FnEMzJwczJA=; b=OrlP/CFnYSvs87oJ/wfcAwKFXIa
 tWn7L5sjQX4LwP/ojJfuRvcFki4eR1I3pApICPsah/Dm+ltMxJh2Qh7fbdmdurO2
 kJREvZf1dPdphhNNuXM+DA5MI5TnCQFtNbmYr+QcAS2rBf8641G2M/KZVxmqidL2
 1rNhbvQE+FFWj2T5XjWjgoH9b6EavOQDUJXhEpHUu/hV+pelLNMZc6CMb8eYyd2I
 3lbBmAfQbedRoy8QDqbE28XFiB3nrLq9W3cOLVuX2gm1kSjTOmyGRNtVD1qOEv+s
 2BYNy7OM34e4vpEH455eqMr4glXtTQ/nOBrcpd2RRkJdNEflFMQ1s8q9/Pw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e03jxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:47:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c16233ee11so1114862eec.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775126860; x=1775731660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xz1CmgTtPGxO7CCCYjV3Yce2C/RGGhA/FnEMzJwczJA=;
 b=GfmHyBFipgYMLZA+IaNrYx5Ma5Q8oiTKRFXOb/fUHQrl5m5YCxXiWiPPMwnPnDyZL3
 4U1flTqfriPKbgRrAY0/v+R5SL6h0QN2+ywQvZ4Li6D+GEgmZ05npq9vmOzqnIMVlJEi
 CEsX87fDAQcPwGuYGo3BCvBV7DPE48Y/AOaOR60S4/swMnpljqWnzzxbzp7RigZmqnJo
 MZ1pngwUHFi9MNCtosnLJQE5CC1H47/NX56k721e7ehY4tVWBMmQDSBxdeGdfVUAdMo9
 3FcJoLkeL4gOYJJ6CteF19e6zhEknHCszkRcmuHbw1yaMG7gko7EUnJ9ESZ0UAdFnoyK
 10hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775126860; x=1775731660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xz1CmgTtPGxO7CCCYjV3Yce2C/RGGhA/FnEMzJwczJA=;
 b=baFJFYaNz4RCKzT0WiA+zCmpUMl6kmD/05qsuUCIjD8A1WmfSJGt2KBoqXQOTBC1tO
 q7U/asg2GfmH3c2RlctyTdzgJc9miPUpXb2L+zf0S5e9wQpCxMLsdkQvAMVvUkxzqKsl
 NcUTKoLHxQQTH6A/aX6m6QKg/hiAFRuqmLiP8OFLizG8572+0lBtj9+m4mox6vVCvOrZ
 lF4IfEPYf17E2jywgR90mcqWRXscyCFnBPhHkUWUrdCLzm+Lb56N92HCRxY2ndE+gzlx
 vRVUX0rvfBbv+L97zM041joHOOXRMAAeh//hH5XhqTi7TmoBZihzMBQXf/7MsPBNK9YH
 NVWQ==
X-Gm-Message-State: AOJu0YxHkB77GRbwu6D5R8kL9mbbM014lyaB+BlE+bx06DXBpyQJNk2T
 eC2EsBSfUXaj6uPOxm9BvucFv/+8JcVhEM7RxN6/6snW0dPv3ErqHEjB0ohOr+mjU0q7zPAr7CS
 bhjd8ESNj45R5I89ngkzn9/Pz2cbnPA7lPx3eGPPRRPz7UONRRSW4A5jOYrGfuvNAANp2
X-Gm-Gg: AeBDieuvxIsAagEkDskMNL8VPbi2uu5bi8EccnGCrGQ/YrBnsN1IN8/4cHm6heclLRL
 EkX8pgvZFNIIjnT24fDTWg2Dvj5iWf0LuBP8ev3AcFKAV+kWwVYCpksk5lybaPloaT79vjwIayQ
 at4Wn5uDPUKHDPCjtLhZO4GeCh0Qn/jQ8KLFIepuZHwcU9BK7K5xMYAIr3WMtHQYjKA3mx+793q
 BcokcJJIsYdsToDQ5bVc+5Un1jHKAgJXJpiNt+lnwbsrqx3uZ7O0nDvi5X2oxKAlX7cZ+Kx4CQc
 HZjOJaJRDyFiNBS9o2dPnjr+cHFAqr24wV9jSSo55x3y9QlAD1Ze6jElsZZqghJ3wKDKxMLGljC
 MoqMnaxrBn1Y86isx55eYrmZJsft16rzG939aff6nb8GBAgajALzLCZM+Z11jtfFtHX5zFd54ju
 aNCdl0mLQH
X-Received: by 2002:a05:7301:fa12:b0:2b7:2664:ae9f with SMTP id
 5a478bee46e88-2ca8d4889ffmr1569921eec.1.1775126859676; 
 Thu, 02 Apr 2026 03:47:39 -0700 (PDT)
X-Received: by 2002:a05:7301:fa12:b0:2b7:2664:ae9f with SMTP id
 5a478bee46e88-2ca8d4889ffmr1569901eec.1.1775126859169; 
 Thu, 02 Apr 2026 03:47:39 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7d00f5easm2004783eec.29.2026.04.02.03.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 03:47:38 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v2 04/16] hexagon: group cpu configurations in their own struct
Date: Thu,  2 Apr 2026 03:47:21 -0700
Message-Id: <c257371d4d0bdc12ed4c0319ddcbc1b6d8954f80.1775122853.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69ce494c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=AHWWR7nXwgbOQO2z_T8A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: sRQn15xrTJeeXm5wexdmRVSwkj5lCxEy
X-Proofpoint-GUID: sRQn15xrTJeeXm5wexdmRVSwkj5lCxEy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5NyBTYWx0ZWRfX3YBYdf47/CU9
 kmLNSR5Ar8A6BBmUyfWEippTFW47Pwu2vILiwrHwrb0iLk07hiZb31O8Q7ic5EdnoBKnH2QzPfU
 oqnsHXOfwYOHg+PzHwS/Hdwy2jucp0FRlgeD4D2p3oZMptnxzlCCgOCAnW43KcOQBgot9MtzEmj
 aRYL4G3x4M60Z29BbkqnenuXtE2ZRCXa5h2Z+VbGz18qVk9zMpwUPvNh43FV2DXad6+edDZ4u6T
 tyMKSbdfOUnsr422gxwtYaVRmQIO7EwGO2vwWkATa2D9HJnmMKG8KWIHDSTJI5Dd8JsbpGgzKWZ
 g+kOJYB32IRoDhMYMoZ8htfwRluxdN+OqJ8hOXwgIyLCXCdAMCOs2ojj8wbmsdnvBM+VL4PfIwO
 APYP59aiqXlAE+DVhBCfHoTMKOUea3XnqLDOB59Qh+kCX0zHSbMPDcSKTssaGjXSpU/6Brgl6DA
 hj8YlBVaGUYa5qFLu5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020097
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

This will be used in a follow up commit.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.h       | 10 +++-------
 target/hexagon/cpu_bits.h  |  7 +++++++
 target/hexagon/cpu.c       | 14 +++++++-------
 target/hexagon/translate.c |  6 +++---
 4 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 77822a48b6..d28beaa92f 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -119,19 +119,15 @@ typedef struct HexagonCPUClass {
     ResettablePhases parent_phases;
 } HexagonCPUClass;
 
+#include "cpu_bits.h"
+
 struct ArchCPU {
     CPUState parent_obj;
 
     CPUHexagonState env;
-
-    bool lldb_compat;
-    target_ulong lldb_stack_adjust;
-    bool short_circuit;
-    bool ieee_fp_extension;
+    HexagonCPUConfig cfg;
 };
 
-#include "cpu_bits.h"
-
 FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
 
 G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 19beca81c0..83d13de569 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -20,6 +20,13 @@
 
 #include "qemu/bitops.h"
 
+typedef struct HexagonCPUConfig {
+    bool lldb_compat;
+    uint32_t lldb_stack_adjust;
+    bool short_circuit;
+    bool ieee_fp_extension;
+} HexagonCPUConfig;
+
 #define PCALIGN 4
 #define PCALIGN_MASK (PCALIGN - 1)
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 8b72a5d3c8..5470d9c7ce 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -50,11 +50,11 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
 }
 
 static const Property hexagon_cpu_properties[] = {
-    DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
-    DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
-                         qdev_prop_uint32, target_ulong),
-    DEFINE_PROP_BOOL("short-circuit", HexagonCPU, short_circuit, true),
-    DEFINE_PROP_BOOL("ieee-fp", HexagonCPU, ieee_fp_extension, true),
+    DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, cfg.lldb_compat, false),
+    DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, cfg.lldb_stack_adjust,
+                         0, qdev_prop_uint32, target_ulong),
+    DEFINE_PROP_BOOL("short-circuit", HexagonCPU, cfg.short_circuit, true),
+    DEFINE_PROP_BOOL("ieee-fp", HexagonCPU, cfg.ieee_fp_extension, true),
 };
 
 const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS] = {
@@ -77,7 +77,7 @@ const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS] = {
 static target_ulong adjust_stack_ptrs(CPUHexagonState *env, target_ulong addr)
 {
     HexagonCPU *cpu = env_archcpu(env);
-    target_ulong stack_adjust = cpu->lldb_stack_adjust;
+    target_ulong stack_adjust = cpu->cfg.lldb_stack_adjust;
     target_ulong stack_start = env->stack_start;
     target_ulong stack_size = 0x10000;
 
@@ -181,7 +181,7 @@ static void hexagon_dump(CPUHexagonState *env, FILE *f, int flags)
 {
     HexagonCPU *cpu = env_archcpu(env);
 
-    if (cpu->lldb_compat) {
+    if (cpu->cfg.lldb_compat) {
         /*
          * When comparing with LLDB, it doesn't step through single-cycle
          * hardware loops the same way.  So, we just skip them here
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index fa8f615a9e..ce3af96675 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -987,8 +987,8 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
     ctx->num_hvx_insns = 0;
     ctx->branch_cond = TCG_COND_NEVER;
     ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
-    ctx->short_circuit = hex_cpu->short_circuit;
-    ctx->ieee_fp_extension = hex_cpu->ieee_fp_extension;
+    ctx->short_circuit = hex_cpu->cfg.short_circuit;
+    ctx->ieee_fp_extension = hex_cpu->cfg.ieee_fp_extension;
 }
 
 static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
@@ -1041,7 +1041,7 @@ static void hexagon_tr_translate_packet(DisasContextBase *dcbase, CPUState *cpu)
          * so end the TLB after every packet.
          */
         HexagonCPU *hex_cpu = env_archcpu(env);
-        if (hex_cpu->lldb_compat && qemu_loglevel_mask(CPU_LOG_TB_CPU)) {
+        if (hex_cpu->cfg.lldb_compat && qemu_loglevel_mask(CPU_LOG_TB_CPU)) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         }
     }
-- 
2.37.2


