Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF1606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZlRkQsYv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iP6cLiDI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHxD-0001ob-CE; Fri, 23 Oct 2026 12:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHx7-0001aX-VI
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHx5-0002UT-Vq
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6NKF3000254
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HRrwXimDJD9w+GXxIMplwRZTr+lzMUXBvxyjmeWHINE=; b=ZlRkQsYvYprgCZsP
 MpXD18HELCrb8/C8KsL2/OPpa7OEzIfUAk5iUelBayG7/Q4B1JcraHSG+T/mbR2i
 ycu+ioXwHwbmJb5JbfRwQOMYGhZ0txyK9zGt6tgT9sXG5shSECQSnxmuq75se0si
 Yio8UsKFXHwVWMbBoHAgY+CmWI23MNnktUjf1M6Fhk7Fu4n+uc05goSH7yOSwfVg
 5w8jU7oXjlHqcWNAdNoSwNCflyplGKLG74r4Fg/UuKfnUfPjgBYROuwaKXx84cD6
 Bedn5exb59OrisSHEeX4llxsF1CnJ1mTl2y7lsJj9ooFUi+JopJ2lwqkEFYU11Zu
 4UXTkA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0vxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:07 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c02e1df088so244207137.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772226; x=1793377026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HRrwXimDJD9w+GXxIMplwRZTr+lzMUXBvxyjmeWHINE=;
 b=iP6cLiDIX4a0FaEZHLksGv+5UG0M7j2Isn6OhWriyNN9ff1H6bQ1ZdPod6YOTVbTBL
 vgr8rliyZgbYI90MtlT5mt3sRH8s/FKoK+QbQaCgpNlo+Dn7FnOMsYRm2DbFPTZUdqlw
 i92DXgh/r9rOTZB+jk/wyqUQFyuE/Ks8FmBMNt/AqPvu5Z1+urayVCNjoeNZbW/B4o3t
 Jml08fmQ5TmjcAevtdLVkZTSNxEkac3ryOa5U6hB/cyDr9GPB/M+MHRHNOuPgukTdBex
 2SCAo52eDYCl3l1ypWYapBNzykqiEZnyCWzUkofNkNPbjCvqoJRgeU0LGE7d8r1UcNW6
 ihFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772226; x=1793377026;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HRrwXimDJD9w+GXxIMplwRZTr+lzMUXBvxyjmeWHINE=;
 b=KcJnmlVmZfBeOnpw0N4kzVA/nngwnaYAzL5xb62kDZR1md26GIohUj5RArsUZpHeKy
 fRRl+8MCCONsUu1nIcD0kcOmFdGMph/x8NCuCOL+tP55sRkXZcIQivPkgBspkZFE4vv/
 UjyR0my7SObqDmCYT38C6nVeyIef//WfuKFNOekFrLVYQ+4d+O5L8F1VnJRE506VNcDa
 8SoYJXFvFQoJhC0zZJnqUghTW37HRBYD1l4ZAHoHb4kM/8YuSfDGWUOXkcsaPSSLMuyl
 W401V0349yJO81qwmIjRvB16GOtRaCHvqx1N+CMnue2X/7LbdabK8gETHM5kM5m0L2WX
 677A==
X-Gm-Message-State: AFq9FYIpZ/Nmw1J2hI7u1AnJ3gbqMvy26X3U/zeMIqChWCeaA57B/mba
 gQ1asBXGkkT4Nd1ebWo0ss7s8mqj46icn+ZTSZpfi45od+dA0uE5uH04WMt6KOXHyO/jbRkuQnz
 OLie96bVwfiiMSRa3yyxfWrXCCK/3ghD7tSSMjjb8Q/mY31Yw5RzLrW5sLJ8Ubs3v7jAs
X-Gm-Gg: AYBFou3f4GOVx8apnR8ISW6tncmos8O1EKK2YZ6+sFOxdkGAs8CBAg0rRkuwkkIlcye
 oKkrZkNYc4kP/X2PkpFzuM05R8B0bMxd3cDOuN1Ub7AoBOi4GmJWF8wzZQurOAEfeV3ovdipjkF
 pMXmZD7894uawzzZILpm+QOMNN0GHC5qr343BUizRpY5qdpR7Pl3oxX5XULJlM33tM+xyS4naWq
 zbj1Ji9JDClKmLpcGY13r41RTi6MNtFnWgermmvhg03Dzy4RAhNG3G0Nh5+TO5hi6Ypt2xYKgxf
 wV4D8rEbF7fO0neiappQ3QVrnbndM7LYdxgZNKGiolzAvZq6ZhuelHBy5c1+Krah/Eg8AjYMXy+
 qtrGgLqw9ae4yOik80dbEUibsBROOOk7x5Yj7diqa
X-Received: by 2002:a05:6102:548a:b0:7c2:5692:1917 with SMTP id
 ada2fe7eead31-7ccc32f3378mr958776137.10.1792772226125; 
 Fri, 23 Oct 2026 09:17:06 -0700 (PDT)
X-Received: by 2002:a05:6102:548a:b0:7c2:5692:1917 with SMTP id
 ada2fe7eead31-7ccc32f3378mr958767137.10.1792772225573; 
 Fri, 23 Oct 2026 09:17:05 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cdc74b7sm24467105e9.14.2026.10.23.09.17.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:17:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/83] target/hppa: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:37 +0200
Message-ID: <20261023161332.60153-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX6y9MO9t9Q3ZO
 sbGmL25IhNxcbVh9nHOfFAJGxnqIZto7M0u/TB7dDLT57yIXr75wWJ3aBl0xBDbHoXAJDnQVnao
 gI7GOunLF4VpH74C5p+ttA4VMx1PC0MRFq+lWWkok3MCxYVn5BXfQ2gD4wWIk6sLouiSrRHDxfN
 dD2AZhCj6wtUnB7aceye8oY/lsl4C2l9gQ31PGbSF5yA6wucLlJ9G1EzbvPAJuQdHI3rnsaLc8i
 KkRTI/IZTYPm9MFrLowB5+cwF63UuUhTqSMm2aqgklZs39hXIy1vnNBPWygnFTsKk4wUbre5JvB
 lfgRGueIEaL+TLT1OWArcgNcclkHlEhUhs4pQKsUo27+cC/nYxhhQbOilV4jMrIqcFe1+uwe8+M
 O10QX0nMM6d5gNG3ZXeHr+MvYrxQG/C/iC591C3CFmk975hx6Rc4mYEqM60224pY9vQMEmY7WY4
 BYl/YQ/qZV56mXYBRog==
X-Proofpoint-GUID: 6S3LI9wEmLY5BDW0e9KWMIUtfVt0hVBe
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb8883 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=sCbknPHGl6sa5x2yAD0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: 6S3LI9wEmLY5BDW0e9KWMIUtfVt0hVBe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXzoc8cxvp26tV
 dv31KF/z1Zj2LXlcEe7Sxdtooi7CZa70tRs7eQhvLyTjcxfh1epjLWpq0PbLhF0l3Sb289wVn5E
 hH6oeN89r3fze5EYlHdNChaz1r3wE7Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Factor hppa_exception_name() out of hppa_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve HPPA exception
codes to names.

With '-d int', hppa_cpu_do_interrupt() now logs
"INT: cpu N excp I (NAME)", NAME being "unknown" for unlisted
codes, instead of "INT: cpu N NAME" or "INT: cpu N unknown I".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-11-philmd@oss.qualcomm.com>
---
 target/hppa/cpu.h        |  2 ++
 target/hppa/cpu.c        | 42 +++++++++++++++++++++++++++++++++++
 target/hppa/int_helper.c | 48 +++-------------------------------------
 3 files changed, 47 insertions(+), 45 deletions(-)

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
index 7b1309a7c38..dbf86941cf0 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 #include "qemu/qemu-print.h"
 #include "qemu/timer.h"
 #include "cpu.h"
@@ -290,6 +291,46 @@ static void hppa_cpu_class_base_init(ObjectClass *oc, const void *data)
     g_assert(acc->def->phys_addr_bits <= 54);
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
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 static void hppa_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -304,6 +345,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, const void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
+    cc->exception_name = hppa_exception_name;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->get_pc = hppa_cpu_get_pc;
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 3e87b9a0011..598d1c6cefe 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -235,53 +235,11 @@ void hppa_cpu_do_interrupt(CPUState *cs)
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


