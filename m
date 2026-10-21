Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9A606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bZ3EvuDb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QkWh/i4d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpu-0006Xd-Le; Tue, 20 Oct 2026 23:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMo7-0003uy-87
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMo3-0002ke-9n
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F2N72898065
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fUcHJFh/IdxFzNdGmkVOUtN+Hx71UUYFYuWgT/uaedQ=; b=bZ3EvuDbmNindqz6
 chzsAECgcfOHWwQPfI54tiUmcVtzimJGN/q8wX0m5z0EyOYEynsBIdjVNZyBvt7q
 jOm8hojOKmqOL8iWy0q58grw0wa4E68+bWJ7qTgbfuOO1ba5pQw3g47B80s3zSGZ
 Tc0p5UbB0Bwc0gBSwBzyI9j0R1T4PoGMdBWXJ5SeDLpmY9QjfWbX04M8bI2w8noz
 Ihz5V8AOw8vvK6sRRX4sSTUcs7yzRkITB4ApIUhbEo85FCcxWsoutt6/Ewjk/BlE
 Knt0l/7VNGfGu9drJOJfn4nmtpHNr4BXbq5UK0gNzHwkVgZP2XR0D1tyzpd/poqx
 n0O+TA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0hq98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf7856ffso75970185a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552546; x=1793157346; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fUcHJFh/IdxFzNdGmkVOUtN+Hx71UUYFYuWgT/uaedQ=;
 b=QkWh/i4djXnWHfIaVDoVSlJ9XklKiHZqf0PjS1Q1Owgd3NCfBrQ1qoZDjYOyHbcYTt
 +k0C7HigIYDBN69ef41ezxk2Xja3hUh3inD2l+xhwZViv4teTfh68NryoOzUv1DDBou1
 NahcZzF4rjXsqkGwHjmvxwXumLYwTYsWlrfJqh7sHnp/AS9Zk52mhziFSXK2iLpIBlEq
 L6TZ9IeXS8hXPKwzc5Hvnpww7WYM5DZWK+7yrwwcnkuPP9mXCerzfjI62H9oEadQhD7B
 CeMYRKsF5da0hYqaIgNF+IuTubxJvrJAtaxHzjYSVROfljpN+WOaYtsLi6btA2FKFnfD
 +Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552546; x=1793157346;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fUcHJFh/IdxFzNdGmkVOUtN+Hx71UUYFYuWgT/uaedQ=;
 b=ka11uYBLUy+6lC+hKUohqLZ8OkJ9FRU0Ojz6rtzE6jpmOOsGsG77f3wXsUrOeQQBzC
 gYp4e1pzEDdSwZ60vgQeoKBFBzeeLr4UOamTx8JAkznjCI+aE/p4XJ44M0xgFv2JanrR
 q+nn1sAU+xVbj9iKtwzGGTlCPEAxsP7JORYasQjgY5dNxwkHK+uF7m64NHtHN62izOs1
 HK7qbTFqmTMSJZxR0nB5LNdiFDJ0/bOMbXxIr19cAHpkvGqwRHd1si1669QtBgXYVr0s
 BpttR0r+H1wjAl7o8mKyZFFYubct7al0Mev7zoqTwuU4EycyO2OTFO6K85eqO3McqggS
 5jXA==
X-Gm-Message-State: AFq9FYKPXiJ1ZqX5S9heL640V1JCUFEaYZ7Gd2TlaSxo6WHBqWz4T8xo
 B9iXIpllGbOc8rBvcBqkLmMxr3FvuX0MLr+4d1LHAk/y8iBJ4k6k6TtSR4+f3pCoZNnVXTiWA1Q
 4bddF4jypM1wABB7xpwJZ8aMgqLbXEPZN+TBPaXT6uFa0/MZner1kXiGGRaMengaAu3fD
X-Gm-Gg: AYBFou3XdqbpPAs6FdMaST+jWtUSC9pgVQOu8235De1nrLQZV3wlwTvrn81ZVPdIaq/
 g2njv2junejVZxAfrnH64ttOLiysZ1KZg/9C57yafYA21Mpy4OvVS9zrcTcDBPk3yWyH+WgzV6v
 nMS0z+E7G8QHXKIvgqmPEkg4e3/ur1pzT59tDiMdQlvFQsrt/DYgtW1Wn4BlUdxqa0fCOtWImBr
 s23SlQMK4RP/scFpEyudP+x4pmV/3avNY6OAOgsJ6wBLkDIJSodJQZG6lL5xAHs894FcG+zvbUL
 CHkCM6ixQcbE9cP5nOtz3V0cGGzl5vTmrOFGAIQOw48pBOZwmh26hx3+OB4rJeaNlbW1WJ/jHCy
 52/XWko6iCfhkiq/CvOi7Ouc02bps5vM8gUIh3kpb
X-Received: by 2002:a05:620a:8390:b0:93f:3978:481a with SMTP id
 af79cd13be357-93f57f9d4acmr230277885a.51.1792552545993; 
 Tue, 20 Oct 2026 20:15:45 -0700 (PDT)
X-Received: by 2002:a05:620a:8390:b0:93f:3978:481a with SMTP id
 af79cd13be357-93f57f9d4acmr230275385a.51.1792552545534; 
 Tue, 20 Oct 2026 20:15:45 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828ca3sm2417731f8f.25.2026.10.20.20.15.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:15:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 12/33] target/loongarch: Register
 CPUClass::exception_name() handler
Date: Wed, 21 Oct 2026 05:13:45 +0200
Message-ID: <20261021031407.24862-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXy2zbXguvWsRT
 I1cSeHOklDV+c7VHjVgz+E0At7J58BBjQN7uo7bKNC8BquxLM/fplOezZ7AyGf8/Hg0B/wG0aYP
 qZ+JTqcdGglR9XVTrIvo87O5eCCRpFdpiZWpNMWzzqKVa+9CvYV7bytWd4gna9w3ErYGsltiCWs
 slwd/xIJ0Ey1QwpP8RXHjki1eqqfuteQ4NnYVRniOtaqppDRb0fyLllweobJH130l82sJ0q+pxm
 mYmRDIwkeXF4lrcpjrGMPujscx7cRU1g5Wjfwfup3XmkOFyGazHv0detvuIugwUtvdu8meOK2se
 i0qNf7V9B2e5r8joWs2eXUHRkwDTO8e5/L0EEJJ15Gj/aCwbXV8zDLM9JvLs8Q5rALDZW8Ah2VR
 L7CqIaaZ+j04khRNFkzfTQ4cg1+tpGOeI9nWhSum9gr6/PP35OBHh58mu4BA/jJgAZnhcx9lOXG
 obAWAxCtMRWk7Qeqeqg==
X-Proofpoint-ORIG-GUID: AnofWevqMegNtTyKqsKwEWxlYSTp9lLK
X-Proofpoint-GUID: AnofWevqMegNtTyKqsKwEWxlYSTp9lLK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX78mQXw/h7WGv
 EDKNWJo8ttpdNy1OUzX1n6HoqM0OChn39PwXe39KkNOtxfL22vRZ6XaDla3T6gRDXD2BlOPScZN
 xy5GaPlEUNJ6UfV+M22Qm/t6nOLNlMo=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad82e63 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=nrwLMCx1wy8-tITOK3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move loongarch_exception_name() out of tcg_cpu.c and expose
the prototype so non-TCG code path can access it. Register
it as the CPUClass::exception_name() handler, so the common
exception logging can resolve LoongArch exception codes to
names. Remove the qemu_log_mask() call in do_raise_exception()
because it would duplicate the one in log_raise_exception().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/internals.h   |  2 ++
 target/loongarch/cpu.c         | 38 ++++++++++++++++++++++++++++
 target/loongarch/tcg/tcg_cpu.c | 45 ----------------------------------
 3 files changed, 40 insertions(+), 45 deletions(-)

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
index 4b1d44a1644..933b9b2d221 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -18,57 +18,12 @@
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
 {
     CPUState *cs = env_cpu(env);
 
-    qemu_log_mask(CPU_LOG_INT, "%s: exception: %d (%s)\n",
-                  __func__,
-                  exception,
-                  loongarch_exception_name(exception));
     cs->exception_index = exception;
 
     cpu_loop_exit_restore(cs, pc);
-- 
2.55.0


