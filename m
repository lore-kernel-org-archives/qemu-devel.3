Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BEAF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5b-0006oO-Py; Fri, 10 Apr 2026 13:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5Y-0006mX-I5
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5V-0001YG-LM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:16 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AB1QqD1322636
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Deo326n2qmw
 FTkLiBkqpjqgcq8M3rSAS5nM+pXYoWxY=; b=hsB2mEdkGoP9clcksHN4hyd+zWf
 U3lm3YRXhhCUDS/JD72WVMHnF4tyCX54rbxGN8Wu0lITYhpHWwAd1LXqeTVhoih8
 sYBWgYNw0j1Mcwk38aPs5eGjG/Iuu0HHG1vrev/fK29Zv5iLZ7hXdJz3IF0d47Ql
 KglH+N6wQ0pEt9hVQldchMPq+DuSLM2OF0tX9ZQP26X28yBOzBPDNp3+4ttM9OQL
 ZJxc6OG/Oj4/ypi3OEqh/hrTLajBLI0WP7669UVSr3pWIZ4aqRsFf9zoVP0oGNfM
 h1VSbYwNnWnNP6LfZlRWP/svWiqsW5uqlm3TIX6fg+KU+lnLeoWdqMZfQEA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deyyh98ga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:12 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12711ec96fbso3874340c88.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843771; x=1776448571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Deo326n2qmwFTkLiBkqpjqgcq8M3rSAS5nM+pXYoWxY=;
 b=VGR/dt1G3oq3paHz0KB4EjvhtnDep7x7SABY3y23MwO+aeloDzB5Z7wNesjiRWvZWh
 d+UDJu1tyVj9e2iPVLYyMasgxsLmJuQJ3wlNb4IFOyF6+H9nJcwAN8hQhK2Gp4gCDbOW
 hnKkVf/nKM5bHWnfYiYGZ2DhkwE6wVuQqzn+t/VDoBREthmCHgrdRz0DDnXRydYMrwA7
 pm20gFFF1cJPqxL1fieJcTelyRY3rZSFHQs03fQzsDxmLAhCUYhZ0kLwZaeLuyjIu0b7
 rmSTsmAt/ktXjjLzh/bQWXnq9ZFG4wNbMxNxYmGZQMdGmLmws6uA2/lqkOt3/nvTuZnv
 tBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843771; x=1776448571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Deo326n2qmwFTkLiBkqpjqgcq8M3rSAS5nM+pXYoWxY=;
 b=GBYOINC6VEvd7NkMSilR9NkKVLwNpgcNqcYJ8JcqJ8zmY/IvraB27zaDfNFzd9Gi6s
 g0QZCFfl0tLjhIUg1OL/XPD585Y97AEFIEgxjqAHcsxnFc16cECDp3I7hIT+eSLkV3mo
 TVF3c0sSk1fz7vsD7zTZ8vuklWX/CJJu1qwwlkKjIcMS3Fj6J5sIgkzx+qSReQ+cKpAF
 Cp22kyprttxytal78ydquxD+WmOyw+vNuceEnjm1+fFKFje3yfq3z73SIq8upbCZHGUa
 kLWDtx0a9Oz1z6DrTaX2tr1ZOAPeKeV04mQl1AOITcK27d/CFcD6jKT7YSAF/qKNLks/
 uZBg==
X-Gm-Message-State: AOJu0YwCE0tVjJtT4ZsHkvO0kM8i16wCQuhPMC9t8ZsKwpOOJEaN1yMJ
 SkW4TYqWFqo4I9exE0A9qRi6cQp1GHqrrNCec1PAAzlcLUbfLc56joGiblLIMRgZE1GjGT48RMZ
 KIJojQ/Uf4otJK1hQYxY4RlAQvhlALjF+pBTKiK1M1CfB/VjZvMXWSXT5+mIzO50m4yaO
X-Gm-Gg: AeBDieuthnq+RS2cX3HJAcG+kNr3Bud56HrgqHaaXmyufzfbzVjTMWPTX0K1xnnGal2
 ZYNGYuMcUtV3f78IOD26zXmUyZNhWPNvgd/TIsffFyMFyuqzTXOhLL4Yk8j0LHMxlSIdbrVo11m
 XEr1JOhdXAX3P2nRVaHiue1x025yT7s4YGCocJQuCH88tyxUKxIdAXWyQMshAWFLFHwd88n5gsb
 Z+0EKVMSQ9ZmvoSx5T6W5r4quI+xVy2yZayySsErpzk+FzXTy9g+s4B7x4Za3XWIC4NjfLbvogn
 hp0gYdAubvCrBnMhXBv2/9OoYIa8GTt/ISKJh04Rb2jYzBTkHfLr6gQpxurMykDrsXAlZCoBpJa
 KKzFbS/phl6gaiDyXzRHhqoCUjc+kDR3t4vfGsaOYFQyki6bDc8DwKOTXt0XpGyU+y7F9DwsKQN
 dR/Y8VLoiy
X-Received: by 2002:a05:7022:321:b0:12b:f616:1a35 with SMTP id
 a92af1059eb24-12c34ea90e7mr2456173c88.8.1775843771279; 
 Fri, 10 Apr 2026 10:56:11 -0700 (PDT)
X-Received: by 2002:a05:7022:321:b0:12b:f616:1a35 with SMTP id
 a92af1059eb24-12c34ea90e7mr2456156c88.8.1775843770652; 
 Fri, 10 Apr 2026 10:56:10 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:10 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v4 04/16] hexagon: group cpu configurations in their own struct
Date: Fri, 10 Apr 2026 10:55:52 -0700
Message-Id: <ac72a36fd8483a7b30e09a99026a557c5bb80b02.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX2Z1+rajOIF7v
 Zj9SVO78ZoDFybJZOtZcJ3WtEfZ2dOhTIUzOEkv06b4Le2npy3MS3Btslwsc+hm3qMlOikli0gE
 eRx2Z+z98opQAhujVwnEFI0Xix+HOdMAR6fLTQpmtd//l/CDXBa467MBXfm5GIl7rsQLrHue2n9
 AbwmixH0c8yHStV492pzY2F44v6cwpvfjWw6UpQwhh3fqVuSe6GgwIpofziJDIf8ne/zS5MedbQ
 AqqePPRa+4ZaKYtQHS3hG3RJV7R5RsqUDYJIQagxKg3zjqj+jBP8hIqpDLEwLW0WbmVNXHc8hN1
 iJo0tjNWyNxnTP+ZFmOV6lR1Gb4y2LGg0sLL8Df6YayVuZEkYwKgXUuq8V2ujLS+7+KqxXMEq4M
 9aYhHfZnwWkSiHtlht3/1BjJjZe7GGwYe7JdceUWOoJJ/pOKVr0srHHpErt83oUASsR1/hwgbbn
 30VZ2vz7TmVyQmo271w==
X-Proofpoint-GUID: X6YTbxkQuSTof6k4ir3MV-HG1fXsbeY_
X-Proofpoint-ORIG-GUID: X6YTbxkQuSTof6k4ir3MV-HG1fXsbeY_
X-Authority-Analysis: v=2.4 cv=Wv8b99fv c=1 sm=1 tr=0 ts=69d939bc cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=AHWWR7nXwgbOQO2z_T8A:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100168
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


