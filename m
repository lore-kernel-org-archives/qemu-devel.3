Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9AD606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=exPd1/mA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LUKAMXK1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0ic-0008B1-67; Thu, 22 Oct 2026 17:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0ia-00085d-07
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0iX-0007aQ-OH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIH9Kt1494703
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PiwT8lJoO3+STnETLTMXGfkBAKvJYEsCLsfoTJ+ab2Y=; b=exPd1/mAH+KAgQUz
 vTiYFV3/ygRUFgQfzEqPzS4SuMtnXvT42ef/S2NkUeVWf3NMO2ql30jKd19G0doS
 vEHZqt2Iqf25WRnCKFiS1B7kHa3Tery0XDqOsK86nhQRI2prd/Twd9QU00j1+fxi
 JQHjuRJR3ZhpJE332/h4vpxgXrEwzYXwn39hSGHRQ3W7U8xxPuSMs0T77emj25m3
 ggvAmnSUkJk4ObnEx6MlowdDWDNxfN9eIkhgWuUDm5E87TbE2HshcrGoVwR3prGK
 WyFwt3VcgwT53K8CVbvQOvV34UtZG9FxF+cUISpcRxfsJH+Qi+rBV0KHN865bE5q
 8s5ekA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmr8ph1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f13c143c8so46810085a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705975; x=1793310775; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PiwT8lJoO3+STnETLTMXGfkBAKvJYEsCLsfoTJ+ab2Y=;
 b=LUKAMXK1VtnpC1rXSIu4Pl8c1/OFzexd7sFL/eTPT87BcObZRE415x8/PyjKbki5a9
 n9XbK/6+xvckfFvtZf7jcA08pQgQUmQxFgeXW+OF5B//fWssZNSE8Ysprem4WtgbuS7G
 zHXOEp83Y1NByBuAE4LQjTorp3pWWa7eJBTHyRz78Hg9U534Ph+j0i3soA7MIn9Z//+r
 2FcnyzdZRJ1pFGuDxn167R5lMKJ6pO3kF3W9L597sd/vb3Q2DzsC/7vmdvgNM45usicD
 S8wFqom5UsBO3aAVYu98kEdLybYa5/F0K44DGujVlmSLbUb30UKJtMVOpZ+5KG+SwZRS
 9bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705975; x=1793310775;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PiwT8lJoO3+STnETLTMXGfkBAKvJYEsCLsfoTJ+ab2Y=;
 b=kO9fiyonruH2LNRfkGaSIbSO3qIsMo1Ts80c/azD8gHQ4BMfogAgLag/vukChq2JFh
 bIckRc2fb2hfcPXoG0F4gKSn/H53xXR8eULHMZetJv80hRRZLuEAXocGKfOkfdYShvox
 kvdIyumM83ttjTBg7Yt5kQwLaDbBBRkBvz1yMTxRtYBi0RmcopcZAUGG/ujLZFeI+C9A
 JVF2rj9ymlKl4hZIW5AHZQAdb7kruc2Pb6clhM+pekz8kTJ3X09MNMXZON/ifOpoV+QO
 RV+NXR14XRTeI4dcGQMo/dxRUFV1hmPfUI5xBiCzciPXTZaBohqhuLuzm19hcVKw+ZSw
 so/Q==
X-Gm-Message-State: AFq9FYKKFP9vseBlXVQt4F1fnDjh9CDSPzvZHzwiC7Jt2RXkmw+DFL2O
 dI+axhQBcvdTvU5r4Twi/AWJXGcp4+/GyuFCfXgBhAI9dHTHVnOIN70iSwUzDJqxh5dMKe/aA77
 wPw40/xdiBQ9cUli4wZKYWrifLdZmjoNgsVGO0oVEmsJJNR5nq/8MgkSDlmoEniLKrw==
X-Gm-Gg: AYBFou3JMjznqdCBmiSIXomjYfx/XuU2EekxXCgGmJwHl0oyYnOVz4/5OS6xmN+dn4r
 ykx7BWW2D6UX9ku2Qci9RKTSBrtFwEIThZ3FIrnGsjj3bm6GR8pKjwP6EZSOHur1z6NocRROuA8
 meWdAQqcT00zomhEo04NsWUA8BfmQVOulTj67F0fEE4aZZw3ZhgrHzU3EwEps5XtP4VNCJ1Du/l
 eAgq4wNL0fId463YvRNj1YdHvHCbk59pzYv5723DKmrQoGhsea7sh2/ms1JOiXnCX9oTv2tU8E7
 YBHh+QFS31Itc0Xd49Ki6VGlP/U2R8sn4DGB0p1AIoQu0qC42fea15TQw5MkjlfgNX0hlOjkkWm
 NTYaeyUuvIHWuTzr3VPgYjijraunwSyGX4AjnPs/b
X-Received: by 2002:a05:620a:171e:b0:93b:e578:583d with SMTP id
 af79cd13be357-93f6f7dcab3mr170339585a.21.1792705975263; 
 Thu, 22 Oct 2026 14:52:55 -0700 (PDT)
X-Received: by 2002:a05:620a:171e:b0:93b:e578:583d with SMTP id
 af79cd13be357-93f6f7dcab3mr170336585a.21.1792705974823; 
 Thu, 22 Oct 2026 14:52:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38053b8asm620242f8f.42.2026.10.22.14.52.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:52:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v3 13/33] target/loongarch: Register
 CPUClass::exception_name() handler
Date: Thu, 22 Oct 2026 23:50:53 +0200
Message-ID: <20261022215115.19680-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TrPNE0UMIEwFuVxDt4MKhsxJbVnSKZqA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX4AuyMWA69Wj9
 rTR5PD2+fWAp0ydnhnJI1yti7QB0tG4Yo5j0JoL9JwCqUQZljnsyVpcbmWPyaLJKX+Jw7nuwO7T
 RI7SZYrgypbTQtMapVUYcdzx2O2kAV0=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6ada85b8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nrwLMCx1wy8-tITOK3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX18+qmEuHRV8H
 FuFAkmkDy3RoUnsJEg/w/5sBAA+931LzqrFiV2+H79+c9w6QAMcDJsdRLVY4FujuAmU8+me3oZq
 vsHFkSUo2EFaMmqgVGq01DTjoD6mxVczvSaXpUjaz+eQANNS+0eMnHg91M6elfZZcbiwzhzCx2q
 vrsPngkxaJ+L2QcY8wNZlZRXF7AHkNKL27EoJqtbENrUlN/CJ3BvZY9F2BvmIUr/+rVu93zgzgT
 FSD2dSQD6CWXfkRGvp1ItsGmDi7imjhXX8gBw7Bq53a3oEKkzSj41OQkUqjwd5YWkdlxWVrgyli
 0dtDzch2Z5ySosKpQTSXFzfLpnVPx2frsyn4VSK2U2YASaAwEG3Ya2OADXL3wA+Jd62I9ndejjq
 JywAwqZvrP6wGnvv8DbCJJ1UGPj7s6mw64pXn1iOPEfcLoEwTde0X6om1i1UiR0lPIDrJh4sfhh
 yOaUbAHQf9asvcB5tig==
X-Proofpoint-ORIG-GUID: TrPNE0UMIEwFuVxDt4MKhsxJbVnSKZqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move loongarch_exception_name() out of tcg_cpu.c and expose
the prototype so non-TCG code path can access it. Register
it as the CPUClass::exception_name() handler, so the common
exception logging can resolve LoongArch exception codes to
names.

With '-d int', unlisted codes are now logged as "unknown"
instead of "Unknown".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/internals.h   |  2 ++
 target/loongarch/cpu.c         | 38 +++++++++++++++++++++++++++++++
 target/loongarch/tcg/tcg_cpu.c | 41 ----------------------------------
 3 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index ff956823fd7..e7fed3afde5 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -42,6 +42,8 @@ bool loongarch_cpu_has_work(CPUState *cs);
 bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
 #endif /* !CONFIG_USER_ONLY */
 
+const char *loongarch_exception_name(int exception);
+
 uint64_t read_fcc(CPULoongArchState *env);
 void write_fcc(CPULoongArchState *env, uint64_t val);
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c26998979..f275fa1eda6 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -835,6 +835,43 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
+static const struct {
+    int32_t exccode;
+    const char * const name;
+} excp_names[] = {
+    {EXCCODE_INT, "Interrupt"},
+    {EXCCODE_PIL, "Page invalid exception for load"},
+    {EXCCODE_PIS, "Page invalid exception for store"},
+    {EXCCODE_PIF, "Page invalid exception for fetch"},
+    {EXCCODE_PME, "Page modified exception"},
+    {EXCCODE_PNR, "Page Not Readable exception"},
+    {EXCCODE_PNX, "Page Not Executable exception"},
+    {EXCCODE_PPI, "Page Privilege error"},
+    {EXCCODE_ADEF, "Address error for instruction fetch"},
+    {EXCCODE_ADEM, "Address error for Memory access"},
+    {EXCCODE_SYS, "Syscall"},
+    {EXCCODE_BRK, "Break"},
+    {EXCCODE_INE, "Instruction Non-Existent"},
+    {EXCCODE_IPE, "Instruction privilege error"},
+    {EXCCODE_FPD, "Floating Point Disabled"},
+    {EXCCODE_FPE, "Floating Point Exception"},
+    {EXCCODE_DBP, "Debug breakpoint"},
+    {EXCCODE_BCE, "Bound Check Exception"},
+    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
+    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
+    {EXCP_HLT, "EXCP_HLT"},
+};
+
+const char *loongarch_exception_name(int exception)
+{
+    for (size_t i = 0; i < ARRAY_SIZE(excp_names); i++) {
+        if (excp_names[i].exccode == exception) {
+            return excp_names[i].name;
+        }
+    }
+    return "unknown";
+}
+
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -875,6 +912,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, const void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
+    cc->exception_name = loongarch_exception_name;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a1644..dd3e2d7ce53 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -18,47 +18,6 @@
 #include "tcg_loongarch.h"
 #include "internals.h"
 
-struct TypeExcp {
-    int32_t exccode;
-    const char * const name;
-};
-
-static const struct TypeExcp excp_names[] = {
-    {EXCCODE_INT, "Interrupt"},
-    {EXCCODE_PIL, "Page invalid exception for load"},
-    {EXCCODE_PIS, "Page invalid exception for store"},
-    {EXCCODE_PIF, "Page invalid exception for fetch"},
-    {EXCCODE_PME, "Page modified exception"},
-    {EXCCODE_PNR, "Page Not Readable exception"},
-    {EXCCODE_PNX, "Page Not Executable exception"},
-    {EXCCODE_PPI, "Page Privilege error"},
-    {EXCCODE_ADEF, "Address error for instruction fetch"},
-    {EXCCODE_ADEM, "Address error for Memory access"},
-    {EXCCODE_SYS, "Syscall"},
-    {EXCCODE_BRK, "Break"},
-    {EXCCODE_INE, "Instruction Non-Existent"},
-    {EXCCODE_IPE, "Instruction privilege error"},
-    {EXCCODE_FPD, "Floating Point Disabled"},
-    {EXCCODE_FPE, "Floating Point Exception"},
-    {EXCCODE_DBP, "Debug breakpoint"},
-    {EXCCODE_BCE, "Bound Check Exception"},
-    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
-    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
-    {EXCP_HLT, "EXCP_HLT"},
-};
-
-static const char *loongarch_exception_name(int32_t exception)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
-        if (excp_names[i].exccode == exception) {
-            return excp_names[i].name;
-        }
-    }
-    return "Unknown";
-}
-
 void G_NORETURN do_raise_exception(CPULoongArchState *env,
                                    uint32_t exception,
                                    uintptr_t pc)
-- 
2.55.0


