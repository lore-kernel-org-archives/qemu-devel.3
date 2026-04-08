Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449DD10F9976
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYRl-0000a4-Ia; Wed, 08 Apr 2026 15:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAY2n-0005jf-0V
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:54:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wAVu0-0006o9-8l
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:37:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638GCDdF1073261
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 16:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Xz1CmgTtPGx
 O7CCCYjV3Yce2C/RGGhA/FnEMzJwczJA=; b=NJVmEoc9CfN6PWNfO0fgvnnR8j3
 Nsa8haSNBS1sMwcoORibkJgUBLD+plZ9+85G1V2+pEztvdXfDKlOg7e+uK6SYDCs
 Q0/c1moP8dD6t5098fpfkbLFrRgJEGdstCOgVT86xogArxB+kw4/r1/WUz+qYvtB
 tQCP1VZnQnuyQm6BhPLCt0DGnU3kMixxKYTzQQp+N2rVOHLpZJtxiukL/lkQUzrA
 wGSmoS3YnSzh9911cOpw9uEV2A6Tahymx6I42Y9yiH/m+Pu5AbPg3YS09BCP3IGc
 Ve/jm7d+cagSjuQh6Hb/vf4UbqhN7p6FwjVzPbeh9/AbqcAheobGXLqDPAA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddtb382bf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:37:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7424d91b2dso39073a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775666234; x=1776271034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xz1CmgTtPGxO7CCCYjV3Yce2C/RGGhA/FnEMzJwczJA=;
 b=K3Z+cXPVHWSCVAOmNm0uqRWp8QhINqgsWxGhQJ5zUx1A3nQzBc5V/5ZmvGm6LT/ZId
 Jvnu7G0syJm5yJ1nedARZsWYywbKA2ZSNP+lintfROokKaYVyxTabmGIh7iJ/9zkXhAF
 h0N2TZGU1iz0L1jlXeSAq92tdGhiij+yDUfy3CMX/FANmMrbaxeBkDhTieDOJBU8xrVB
 IfzyLkRPShU0mdyNF/nwIcCB6tF/cMZLTga5Z9ksl05MBLdIN5vxUCGM/j/706AkT3Dd
 C3m3iANoxma7W/sF50Ntrc5eYwGd3L105MJSKHNOaLRsBzjN4l4pkUmhSXO1k0p6NoiU
 arSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775666234; x=1776271034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xz1CmgTtPGxO7CCCYjV3Yce2C/RGGhA/FnEMzJwczJA=;
 b=plJh1S7jKAybt1dLn4dSVe+K49PuLNWMMr9fw9lZPfSzK7klXpGAvO9cX/o3x39gSO
 6GSlr2Ej43QgfVYlbl6Sh6bUpyutOfEZK8s3dsOg/YMk+AkfGZeyEi/KnZ090vU53z5V
 hlqNcRhJjoSkLwxtLoKSe8j7EqWyr/NwzgT7BVUpbu650dq343bcrNM31Lawz4ds35yR
 ysBm4yXFRvWyh97XW1RMfomqpnRVfDOQrKU0WSGQpw6H57KwrfmTiEMQZTx+XTpWpt8G
 +dXV6eBGNQ4ODeOKyDlIPfTcntJyobt3e8fD6r6nNmWVg1MJKvw6Ysf+CJqAb7fxdu+1
 QwKw==
X-Gm-Message-State: AOJu0Yz7+UbzqPeDgYYEs96oYEXgBLBPZKdwGkL/c3v3x2xvuHhEsL6D
 NeL/PGdMYWDo3T3/5v8SrG6vO0r4qpwbyf1SchsoTviTr6r3JhYchzN+ynurnunTagab7nDB/2O
 VTTd/cPSe7NGkTJ+NTi8S3606EqBDuHA9z6jWDiWjmnw1GaYUMAOb3TBch2cr0BokH0ik
X-Gm-Gg: AeBDieusKKdy+oBlqSg0EM+duwimEk7QDZCoM3k8d71aSP1DHt6GH2dRYTTpTGhIqvg
 bo72QUcwZXW5vX4n1uNySadglgECR184V13Lbgh956pauNuZIe3/8ErEMrKjoxL3/XDCEWcOlIO
 3w8P8O8byfJh8uGMF4Mr2arWXl5u5wyM1WkEm5sghlrSBJH8T6wqi4rMNkAx91XaHNgbgQUC2I5
 +ysVkUJEAH39siEnJqVD342qYlhlfrARRnykuyCp4x3C3yd+7CjFWKc/qIE9OjLSSMniJZAB+uT
 n0gdoM7ngcKZrrEGlhpKKoXqpr+6kywtnuoe7Bl2Xaqw8t0A2i2aFsAS+senDm8E/aXRWZ5y5LY
 mtPAWnT3+aD8jSoEhJjSyXU/CbRdW4CSGttnoQp+pHNdKA50Q1w9E6akPMh4P16byUj2N4xH0bV
 18zjY5gO4j
X-Received: by 2002:a05:7022:6881:b0:128:dedf:f56d with SMTP id
 a92af1059eb24-12bfb74419bmr11038051c88.24.1775666233641; 
 Wed, 08 Apr 2026 09:37:13 -0700 (PDT)
X-Received: by 2002:a05:7022:6881:b0:128:dedf:f56d with SMTP id
 a92af1059eb24-12bfb74419bmr11038024c88.24.1775666233062; 
 Wed, 08 Apr 2026 09:37:13 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c1ff43d04sm4082006c88.4.2026.04.08.09.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:37:12 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v3 04/16] hexagon: group cpu configurations in their own struct
Date: Wed,  8 Apr 2026 09:36:55 -0700
Message-Id: <d7cc954b233ff2a1d7424eb48338473556bac78c.1775665981.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NCBTYWx0ZWRfX+8glG7gmmDL1
 5RqBU9ACSp8eg6nIncNWwF5jndCVQkBGfBo6xAUBEn5Jqf1EEm56HLh5pwo6mQhhPtaSGPDNHwu
 Ge5wLtphJP2z+FwP4iYaDvT6FiKx6y9ws+KLKZZFSN1RTBcDSOunucy9XgtsZw5prlmg+rQMOTj
 8dAGcGm+26VlKmsL0N/H7UXKwk2P4+rtHKfW4BwM970bFAoe33vyI6Zny6/NNVsLH1EESMG99G4
 LjESmQB+x0xbA0UV+IEBr+FRaltYk8Ox2fSEtbPDfptoHTUCTA4mY9WLcpuovnrt0czh+t4/oaA
 PREiBMS1hdRgsUvt4Tr3TrO1DSmYwl4S7sPibQXl1d1mKB0csl26Llvnby0TrgGBVKEOn5Y/vEY
 kpQheWxKv/xONTLRwZnSuspWZFpLRWAzND0VG1JNy8RseS3UjoFcTV0gBofdPia1rtloeMWQ6zq
 hwpcjP7gfBNIElmx7KA==
X-Authority-Analysis: v=2.4 cv=eKIjSnp1 c=1 sm=1 tr=0 ts=69d6843b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=AHWWR7nXwgbOQO2z_T8A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 3K7r7gASpZIozAkPxZE9mJ-Cno8dAVPA
X-Proofpoint-ORIG-GUID: 3K7r7gASpZIozAkPxZE9mJ-Cno8dAVPA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080154
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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


