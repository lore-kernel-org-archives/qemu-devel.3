Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6E606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j4/PpTVl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PR2eSRla
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpj-0005qz-De; Tue, 20 Oct 2026 23:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMnt-0003Iv-VP
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:15:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMnn-0002gK-Vo
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:15:49 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2ExcM2562800
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eM11e5ZliPQWh5X7FYojwl2XSBT/xIrvqwUdAV/Mepc=; b=j4/PpTVloVsroJNp
 1oJptMlWFU5YoNx6D4uIxWGfRC9CzVrA/VbIDFW+tBYNJ6TvLE295oBlXxlsNu36
 7TIlwWBd+4a4A40Ny9QovfDcTQSfSfM/kPcUc6Oo3htJYhGHK190rYVdRXP5//2N
 8BSvrbWUoFVPuN8yLx0+rm/zE5Iboui3z2R4HPzMCkfEKaDNr8bM2tC1HuOUBvUE
 /f4Z4j6NBm8mZ5hptbrSbVo4X00JprEQMpia/lsx5KdXcqAt4gHtkRtAVo4qpd+Z
 0E/9bZeHasRuHSNPHFSBXb5vWXhPfu2+XhdplapFoOqnxDFAi/57T7MwqiATT4Zb
 ZQhxDA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd23qa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c0f73807eso5564136d6.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552521; x=1793157321; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eM11e5ZliPQWh5X7FYojwl2XSBT/xIrvqwUdAV/Mepc=;
 b=PR2eSRlaR4GC03Z53r/EaQw/W77GiY9DbN5J2GnTfJTnP1XgQEzjIvS27k6hcrFmdg
 UHAeAbymQukBRb31c0d4N+UWApDyAb9oBHK41CGQc/bQnnut+2V+DVE+bEbnrXPqikFd
 7BMjTZZPyGxnYY4LKpo6MNR+APh7uRuO4Syj4kpi3JOeo3CF/WLhOKUAm+eHiFSt9ylt
 HsyT9cyunhdrwq+FZpSsaIv5EFw/wUt6RCeWESWo3QHG4SzL2f6pq0M1gBhvKeCg2/df
 NfbFezIm/O4i51gFUgLAFI2eOQimXmZs1XYSOHIKl0JbLwxxOfq6h1yaEadI49ujeKQ/
 bCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552521; x=1793157321;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eM11e5ZliPQWh5X7FYojwl2XSBT/xIrvqwUdAV/Mepc=;
 b=iSJrzS6vIhmEfONLnrFA8XKjqGYmfMBUmEhXvkrfyesHqVYqRfw1Nms4/GvdjgtPOk
 pqVCXxKDIRceQlMJvPhB9i/xaFWLN/Z6+Zkpd6glb2AyS+TQiY8RqEXJUmoGnNauqD8l
 6Uuz8WnL49XomvsN9Bsa5LKM1K4iNQiv4ZErEHwL+snLmhQ+PRYhcZhzLRPx1mCyNSZ0
 V48ed3Lsn+2BRDD/GHPlMbkyYLDLbQPQarYp0H9Ka/Zpd9PtTYzy1J768l28DuBc/W7S
 qyTaEC0TctTnsgSmYSpLu0HrH+cGPE0+Xg9rCNOtsNN66iUiBy8mZtjtPIvfefrt0OjK
 4Ewg==
X-Gm-Message-State: AFq9FYI2TPMw4dMO47SMf2ViqcfY6ue/rxQgLgQqr+Ub54WzdQkL3R0/
 nXj52FbzYj0y10TLMOPwHLl1ap3TvHVoZVIXlpZ1rwRnwlKKhCzhyq0srzIcxW0uEGi+pHJ89qZ
 jMseQHDk7qhS41r5XW0Fr0l1veJh4Q5VB024Y5yAcP8gg7NFXx07H7+D7Ei19Ulq6Pdxo
X-Gm-Gg: AYBFou3JgLxoY1/QsCHz63FGcVI31XK0UcQ+keetgdPMoW6y01+9P1qSsDne5JCmH0r
 UupyxTaJYJc6yK0gKfwM4x3EoB775F1Tm/ZGY4S9lyJblmehn4cbmsfS1l3X77rHvCiVHfuUT60
 NLToCyUNwSot92DUYljvE6Ft0h3yyncVUNGGuRxQWLAlopl/v4zLxrhTZdAEAiYgDYn2RSleRzx
 AdckbUj1fYzNiFoV+f7aAXEd1SMANYzuxHDy918UJ9yMZfWYyCs7h2nk30z+9/7kZ5ZdjP8A9hh
 zwAPiSRXAjEsHqz7M9jLKJ9lN2YpS0dI8gCmcQk8DNv5D5TCQbFQx2Mn4RNgWMfug2fan0N9vSc
 bVNguvuPrP3P4Hg8xyxjLhyY6MbkuFkrqQbEhQ4P1
X-Received: by 2002:a05:620a:46a2:b0:93a:9ef5:d370 with SMTP id
 af79cd13be357-93f57ebdd8bmr230307385a.1.1792552520879; 
 Tue, 20 Oct 2026 20:15:20 -0700 (PDT)
X-Received: by 2002:a05:620a:46a2:b0:93a:9ef5:d370 with SMTP id
 af79cd13be357-93f57ebdd8bmr230304885a.1.1792552520358; 
 Tue, 20 Oct 2026 20:15:20 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb96bc7dsm44738385e9.15.2026.10.20.20.15.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:15:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 09/33] target/hppa: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:13:42 +0200
Message-ID: <20261021031407.24862-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX/AlNP69JFb+5
 BLrVe28v3xWjpSGpDbjf7XO5WYN/C/yb/IBn1X3zpLWiJNvCSH/6xw5YNMEx1k2n90DYuSrPgBB
 Aoi5VsStvPOkj2xrW819JLkQLDncimTE5Y3d8YAaWimR4EbK974ZnNvaW5TSy9uMuYGV0aMyHtu
 MVlJ2pavQPg0Fc8f8AhAc0jIAhYDQTBf66JxEsPx7W66m3XouMXjBItK6wYtPTI4EGCUCQDoJ9M
 w2X4eGKUfOBicrapoGT8PQLYgKgBTnMIymyfxZ+BQr6dtFSB7uXcjoY5F15WGvBptjdjmopMvDK
 SXKsjRCMdSGmxGgY3+9fneIl6OowjidKt3G656vrYlv9AItlsuzC8NVwQKaU7oLUkcsZ/z2FQKI
 mN5JNDwIVcHXigsMfm/jS5S1gMbNzy+hLwQQ7wahiDMQOoRcsa6XQb/HJ1TlKn7yKLVrYytaMvy
 //yGsKToDl4mcrdWvAg==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad82e4a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=TU1vJ8DaLJqu0uKs2-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: lPp6ZozmMqTZ1CWr5HDfWITW68Hdxy-V
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX4fTvBv2GE1Eu
 MzA2nln7d3DFy2NrYR+ZB3m+2u2RI+/EsKbKCPqUZ2HPvvdaZUEkHXZr4XsjX5E9itnGAkpzfCF
 46SQ4i4ODyyFXjClRklIADvnyAHyviA=
X-Proofpoint-GUID: lPp6ZozmMqTZ1CWr5HDfWITW68Hdxy-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
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

Factor hppa_exception_name() out of hppa_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve HPPA exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hppa/cpu.h        |  2 +
 target/hppa/cpu.c        |  1 +
 target/hppa/int_helper.c | 88 ++++++++++++++++++++--------------------
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f453444d7f9..3914b3285c5 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -98,6 +98,8 @@
 /* Emulated hardware TOC button */
 #define EXCP_TOC                 32 /* TOC = Transfer of control (NMI) */
 
+const char *hppa_exception_name(int excp);
+
 #define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3         /* TOC */
 
 /* Taken from Linux kernel: arch/parisc/include/asm/psw.h */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 07b49e51326..81eef6a2fc7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -305,6 +305,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, const void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
+    cc->exception_name = hppa_exception_name;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->get_pc = hppa_cpu_get_pc;
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 3e87b9a0011..e4297461d55 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -90,6 +90,46 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ulong val)
     bql_unlock();
 }
 
+const char *hppa_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_HPMC]          = "high priority machine check",
+        [EXCP_POWER_FAIL]    = "power fail interrupt",
+        [EXCP_RC]            = "recovery counter trap",
+        [EXCP_EXT_INTERRUPT] = "external interrupt",
+        [EXCP_LPMC]          = "low priority machine check",
+        [EXCP_ITLB_MISS]     = "instruction tlb miss fault",
+        [EXCP_IMP]           = "instruction memory protection trap",
+        [EXCP_ILL]           = "illegal instruction trap",
+        [EXCP_BREAK]         = "break instruction trap",
+        [EXCP_PRIV_OPR]      = "privileged operation trap",
+        [EXCP_PRIV_REG]      = "privileged register trap",
+        [EXCP_OVERFLOW]      = "overflow trap",
+        [EXCP_COND]          = "conditional trap",
+        [EXCP_ASSIST]        = "assist exception trap",
+        [EXCP_DTLB_MISS]     = "data tlb miss fault",
+        [EXCP_NA_ITLB_MISS]  = "non-access instruction tlb miss",
+        [EXCP_NA_DTLB_MISS]  = "non-access data tlb miss",
+        [EXCP_DMP]           = "data memory protection trap",
+        [EXCP_DMB]           = "data memory break trap",
+        [EXCP_TLB_DIRTY]     = "tlb dirty bit trap",
+        [EXCP_PAGE_REF]      = "page reference trap",
+        [EXCP_ASSIST_EMU]    = "assist emulation trap",
+        [EXCP_HPT]           = "high-privilege transfer trap",
+        [EXCP_LPT]           = "low-privilege transfer trap",
+        [EXCP_TB]            = "taken branch trap",
+        [EXCP_DMAR]          = "data memory access rights trap",
+        [EXCP_DMPI]          = "data memory protection id trap",
+        [EXCP_UNALIGN]       = "unaligned data reference trap",
+        [EXCP_PER_INTERRUPT] = "performance monitor interrupt",
+        [EXCP_SYSCALL]       = "syscall",
+        [EXCP_SYSCALL_LWS]   = "syscall-lws",
+        [EXCP_TOC]           = "TOC (transfer of control)",
+    };
+
+    return ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 void hppa_cpu_do_interrupt(CPUState *cs)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
@@ -235,53 +275,11 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     }
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        static const char * const names[] = {
-            [EXCP_HPMC]          = "high priority machine check",
-            [EXCP_POWER_FAIL]    = "power fail interrupt",
-            [EXCP_RC]            = "recovery counter trap",
-            [EXCP_EXT_INTERRUPT] = "external interrupt",
-            [EXCP_LPMC]          = "low priority machine check",
-            [EXCP_ITLB_MISS]     = "instruction tlb miss fault",
-            [EXCP_IMP]           = "instruction memory protection trap",
-            [EXCP_ILL]           = "illegal instruction trap",
-            [EXCP_BREAK]         = "break instruction trap",
-            [EXCP_PRIV_OPR]      = "privileged operation trap",
-            [EXCP_PRIV_REG]      = "privileged register trap",
-            [EXCP_OVERFLOW]      = "overflow trap",
-            [EXCP_COND]          = "conditional trap",
-            [EXCP_ASSIST]        = "assist exception trap",
-            [EXCP_DTLB_MISS]     = "data tlb miss fault",
-            [EXCP_NA_ITLB_MISS]  = "non-access instruction tlb miss",
-            [EXCP_NA_DTLB_MISS]  = "non-access data tlb miss",
-            [EXCP_DMP]           = "data memory protection trap",
-            [EXCP_DMB]           = "data memory break trap",
-            [EXCP_TLB_DIRTY]     = "tlb dirty bit trap",
-            [EXCP_PAGE_REF]      = "page reference trap",
-            [EXCP_ASSIST_EMU]    = "assist emulation trap",
-            [EXCP_HPT]           = "high-privilege transfer trap",
-            [EXCP_LPT]           = "low-privilege transfer trap",
-            [EXCP_TB]            = "taken branch trap",
-            [EXCP_DMAR]          = "data memory access rights trap",
-            [EXCP_DMPI]          = "data memory protection id trap",
-            [EXCP_UNALIGN]       = "unaligned data reference trap",
-            [EXCP_PER_INTERRUPT] = "performance monitor interrupt",
-            [EXCP_SYSCALL]       = "syscall",
-            [EXCP_SYSCALL_LWS]   = "syscall-lws",
-            [EXCP_TOC]           = "TOC (transfer of control)",
-        };
-
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
-            const char *name = NULL;
-
-            if (i >= 0 && i < ARRAY_SIZE(names)) {
-                name = names[i];
-            }
-            if (name) {
-                fprintf(logfile, "INT: cpu %d %s\n", cs->cpu_index, name);
-            } else {
-                fprintf(logfile, "INT: cpu %d unknown %d\n", cs->cpu_index, i);
-            }
+            const char *name = hppa_exception_name(i);
+            fprintf(logfile, "INT: cpu %d excp %d (%s)\n",
+                             cs->cpu_index, i, name);
             hppa_cpu_dump_state(cs, logfile, 0);
             qemu_log_unlock(logfile);
         }
-- 
2.55.0


