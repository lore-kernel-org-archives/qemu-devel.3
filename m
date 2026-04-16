Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E15F8A165
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL45-00056S-UU; Thu, 16 Apr 2026 07:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL44-00055t-4d
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL3y-00039y-Tr
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G90YD22979251
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Deo326n2qmw
 FTkLiBkqpjqgcq8M3rSAS5nM+pXYoWxY=; b=NRreBNDXiUH/0MBBNFYzSvMC0l2
 eYOuX4Gt3F7C354/6F+siRNJyCcYusFr/k9EQEvEFVy6Fb2SHbwkiyH+XH62HJcP
 /VXGy+E4wsMeDY2kcPAb/b8iNJ9rn3C/MWr6X16rlgousEWKxBKKFnz3q/7lmptx
 nhJyUGDVYbzrLRi7x613pAUkdMRF4DXshRYO0voY8FUVepHzrviy46NImPWVnwwv
 0PVGT7EYNgXtAAks69gEuSafUrejum4nejG3chaoWtS7Da+nTk36zvNZvH33WX4w
 7gnzrgnUU3be5Z6nvKamLz5uUtfllBH/vcNxSxN2sUv+BKi5EWqkU6XO/Pw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djvru8hmn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so30180117eec.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339553; x=1776944353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Deo326n2qmwFTkLiBkqpjqgcq8M3rSAS5nM+pXYoWxY=;
 b=e7r13KwRwTs3YUaYBtMmg5oNuakoSqwPQCuVEbh+0hQjl9OXWH6AWfSio3GzapJzkL
 ghSGBqXXKbkfs1E6Hp/4r/UkfSyogFZI7IBwD6Wj4OH7seBDJcvqJwO1oDfqi3mAF/Gs
 DzY2HdyFpSEGvzrYWJgLIQBPHoHvQ9q+M0iBRPvHJ82zY062tdvwwXYdnoxtRbbnAngK
 RH6/DRRfzZ9ndtO2UHWeKPlL+sySwkyhvcGz0QP0SJvJDL9Os2ipWwTxI9drE7uUL+iL
 LHkLw4tszGzar5TR9jXcwZt0tybD1w10qrPM8poqqGLlyewjSVwjlLJKZ8aTG3vWZYeO
 mVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339553; x=1776944353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Deo326n2qmwFTkLiBkqpjqgcq8M3rSAS5nM+pXYoWxY=;
 b=iNXeMoSpEHFeB0ty0cN6IzYliO1QxITBnjDucYMEvc9ce9/VhbtLx/YKD87fZH+g56
 RvZDS6juZJ3tV0EZhzfymgGkFNnuBOx8XaXd42FEjyIfs7hpLnWBFMm75zq6RQS4mDEb
 CFUrL9olwyJ8DQTfvV0UNg3JVIMNsWYuzpi08M1+wWWc3pNfXXNFDh4N7cEsVXQ1yAV8
 AV09EaWUcCadC6Jio+DWwWNe1f0ZyFiM71+CQkEYZsgVMmfrbkzQ3b0SwyXVtRAqDnSQ
 m/yup8tZpAyyXQW5lEYSq5zTejotW6tHB2epNzDPgWDnXx8jpGMqJ3JkkxEVSVS1Gtnd
 gAbQ==
X-Gm-Message-State: AOJu0YzrpO5dlrbQ0JJJ8fZM9DNLF2cxE13A59BHQeVvc7uZS49LAfO/
 2R5b67vWYHOwOr6NczfmgfvgANekmK1nYs+qXXfK1snh4CCFqAavETcUWklfRo5HA8yy05nu/NA
 l9uMQZbWXIBz+Fwft972WWdhijyMgD6ZIJoEtaOsvLcGzDfMj/Q4nB72PVTbkunJH1nJl
X-Gm-Gg: AeBDiesZMCQbAIPgaY5oan7x9WRPalcwa+bE7MBweIFgGO4kSKEgp3TKe8QajLklXtt
 zJP41aqeG1/QuTg6aYPMfKOsI6PcjmJA7TpPtD/LXo5KuOGZ8T7HZYwxYu23R77wrUKy+B6/+UF
 fl+1tc7Eso9dXgo6dZnSK+P1dz+KaVh7NTNVD8+haQ2QgoMlVlDLKi/mdRSDXH/wPBZeX6jGRK9
 UsRL8Uh7UztcWoVf+StWe0ZppN0+2Ie3bMwttHwjKomCtdITzhbH+gyUYf4VXCcavSDyhaVO6vK
 4rgNwaK/6tXDDUOtwEZvwqcKNwvkbF0Wsi1nKQth/lNMrZYJmBHxZ1p6e7/sz6wR+/Uze8Hln0B
 XcHO38/akSajYDlemK9UUQMjocd1Gr6gZkJhnqdueaFD0wjZZCrLg4Q0Fn22eK+VLAG7oaP2h1t
 oLrxCqh47Nijhg08Jt3fE=
X-Received: by 2002:a05:7300:a284:b0:2da:4216:7ea3 with SMTP id
 5a478bee46e88-2da42169606mr8509845eec.14.1776339552640; 
 Thu, 16 Apr 2026 04:39:12 -0700 (PDT)
X-Received: by 2002:a05:7300:a284:b0:2da:4216:7ea3 with SMTP id
 5a478bee46e88-2da42169606mr8509824eec.14.1776339552104; 
 Thu, 16 Apr 2026 04:39:12 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:11 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 04/16] hexagon: group cpu configurations in their own struct
Date: Thu, 16 Apr 2026 04:38:53 -0700
Message-Id: <8f9a2e2ccfd2eeda73a63d1a6abbfd6e5458b44c.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX27yTu/YaTXpV
 nj6RWIgkKuNplm610I80sqK29d2cQq5dd9533yGjHdmzVg9lDR0DacETb6rK+7zKUuGCIPSQcD1
 bry1nYH+047OADH7rGiGMTrIOns+yNwqaXC4gFbQjvOAS7HNhbRnKPJ/TIKpSu2L0WRq30AgPFr
 w3aKKks+7ja4mfuRbgZK4L56BloJy8bujzO+G1kgGfijk5HXNYDSuCbcIOhe0cV5lZy2Tjstn+/
 8qHX/veBbqu29uhjFc0QVKKKhV5YTR+if+qJA0DO8b2H8/WXy6v/NMYJo8rgeGnPRLownuy5ztN
 MxwH5RSAJe5BssHArHluNX++9LybNyhSMAB+TbdYhHp6BgKdi0bImt/bp2KONgaiDIEG94t8gfQ
 xC8SwrQMyFtsIyjHFGzAQltj2EI76uMLEwhRw1BA26x4Jj2Ia0Be0gydzC6K6Ac5sn2r9Y6Glx0
 ncysHNufBenoMhZtlQw==
X-Proofpoint-GUID: 2mz1PFc3c2E69X2nPpsGjO1t7JimMrlS
X-Proofpoint-ORIG-GUID: 2mz1PFc3c2E69X2nPpsGjO1t7JimMrlS
X-Authority-Analysis: v=2.4 cv=GcInWwXL c=1 sm=1 tr=0 ts=69e0ca61 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=AHWWR7nXwgbOQO2z_T8A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
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


