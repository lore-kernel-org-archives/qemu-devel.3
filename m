Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3963606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T+nsj2TH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d4m7Z6Qm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0iE-0006ft-Ew; Thu, 22 Oct 2026 17:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0iB-0006S7-BD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0i9-0007Xs-42
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIGJYu3578645
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C/c5a5DkZyMreB36hQU3TBH5JEQEHuCKOfMcIxsWBVc=; b=T+nsj2THoaYM6+vM
 XTRZLPLT/PC0OucxUvi5eZ4PCISyDh9JKxrctcNRqq26JwN5KWxeNZHgj952dsKu
 nf57aCopQ/fAoKoiRxtdB/FMXgS7SJvTddIrp5h5EQ0mN9DRcUXJSdG/u/wi/4ot
 F1vIbx5zgw6KTw24Tgq2eIKAYj26pBRXnjVLisferY19OIPDRYipSOhNJ5hTq/Ic
 vesXkuTp9wLhah4qP8S3ig0zxDhEb3rC/UV0SXCD9CdkOYmyIkbBtpArvsojdj5m
 /89Avzpns74NbuKOtuGMlDuNb1KmJql9o6Vh7/KqCIgDxvoWXtRhIyxFE45yInpl
 hf9I2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmbgqd7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844cb60so50396285a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705951; x=1793310751; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C/c5a5DkZyMreB36hQU3TBH5JEQEHuCKOfMcIxsWBVc=;
 b=d4m7Z6QmonBShutWnMKYARlco+grHbkgnxOplpORrtWmSX3mSffAFcwdCIQTJSfrVx
 eLQxPvlY9Xw05mjdTRpHkYAhWkWO0va+4Q/n6F0AXQeNaWntdwsnl/ddFfOnkuuTc5JD
 4iqRv7wUlLItl9Ng8gwSlXqQVZClCdmnZVQk3f57LJhBLDUeMAvDb6JZbef/kesPAwxx
 Sa6aothHxcelmlmz/W8o/cOf9t5s30o+DfVdG2hxTgd5ZuDwn/SWdWLXoqS634nE8yJ7
 lNiQih7q7CWp+WzsWjN5SQjUUpco9VAJYgcOjUqkWiu8nYCWgFipmaLp5iEwD14qdITa
 b5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705951; x=1793310751;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C/c5a5DkZyMreB36hQU3TBH5JEQEHuCKOfMcIxsWBVc=;
 b=HJTV31WHVfZMxPTVn0bZHXWKkvY7rDaBRt9s811VQQVI/0qNp/6BWCEHhYwswSlioE
 xdppLFGlP7I9RlV/IwGFXyXPDt+YtZZMzkjMPXmNlHWhitYu80sS8u0EWSLm6mmANYXl
 fHFZagyXJndlaemfR0blO5CdrYLPwUs7VInQe6opVXRCzdWoJjcHAMGBDc7o63qE/ve7
 jzii8QCOmOBL1ijg/wUl8+L1VT1AaUAkGAUogBJ1Um7EVGO0mCTVfVhEYzrFq9cLZiFm
 ktcYotcPNu3kMxHFkqsGFHzBhqKzvMoM0PWIgeZR05MKdAn/sZHDsCniPabAicDLk138
 xrMQ==
X-Gm-Message-State: AFq9FYKtoYJJ9p8fiYB7L8jl8b9DKi1VO/EKKWQKj8sJlmtYkpRfn1aI
 IlszSG7SflI6Yi/akDHaw9G8x+GtveFDaft9AuwatUh84c2KdUyt321GWG/MyrYC7oax5gM3QT6
 V7NL+sqEGkhAVJpra1m18L8+5ITjCd9MnEc5vSwmfsf40no85m1M3YNoXnRwKbAUacg==
X-Gm-Gg: AYBFou0NbNZYfcm1q/Aiy8b0VsKHUsZR6r4XXUFCbNuCQvAcQsztIfGGE1tLwBopxbl
 0cGuYm5PGVk0R/srcsteVlCm59pSL5H0WNvQiEGaG+2PnRTVgpo0NeJTUsFK7SYFFsZoS3BbSDH
 +W0u05GDr7CVHvKQ2bWvy1BYlTJr01Y9fNwh6ELppvX4urXZKgmKbWsHXKKGj/IxBCGFW0EDTkN
 0WpAMgnaOFnzw45RdY8/KS3dZItJGGUnFluWcwhaIV11ebsq8tREm4i0zNsLQH+ubAqLjjm/pMn
 EXEAJHe1CSfJOVPLQ4tW3tHROfmKysXexzH3cIIWdFiSGnWejL13j8GhyaTLjxseTZoH8QY3dUI
 wa2oCE1+hyMGDpDstQFC6ohhZJdBplNjVN2UqvT8c
X-Received: by 2002:a05:620a:8082:b0:93f:4a02:ed99 with SMTP id
 af79cd13be357-93f6271feb8mr597671885a.20.1792705951276; 
 Thu, 22 Oct 2026 14:52:31 -0700 (PDT)
X-Received: by 2002:a05:620a:8082:b0:93f:4a02:ed99 with SMTP id
 af79cd13be357-93f6271feb8mr597668985a.20.1792705950814; 
 Thu, 22 Oct 2026 14:52:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21223d254sm4843955e9.3.2026.10.22.14.52.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:52:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 10/33] target/hppa: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:50:50 +0200
Message-ID: <20261022215115.19680-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX8MQn75mCESSF
 sL+kMvV0+GNO0jZInDFlHBoTNeT10ha3kaPD+dJUyjVOaU3KCGlOWsCbEt5gThUf8+QMtaxL10i
 4LeCIG8NmxV3B5MnqyQQLL/TlSS60ak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+Xy/N430/mnU
 iPosSYgWTFNkjR/YYLjwQ30YfcrW0xnVRC4iRG+wUcl/6Pv9QxTEI0a9lyG+b6SCXnKQFW1RFB3
 Bm5LBzCL3H2JI/mZcR2LmxBBkV1UALNrrAwluYx57enROnwELhKoeSlsYzMS3pqeEF8odWhh4Ky
 VsehrV9jmRY0b/WfemN0c9P0zf1QAW8RYN0u4EVzrq2svigJMiEwD7rNc/5TeriGNkLZed8inCq
 1uMvrAKDw+1PTacv0nmBrpXLAqXmmOXnJKeeIp/5QIfKywgW4VZGsea7qq5RjhoQdrTF7YynITZ
 GPDvR18j2adF0yAmn+w6OqPGyC6g739fvgaBtnfujJHa8SIASjk5bFCOJ1sWMy5QZzEBjpTN1+W
 2IQX/IKXVa6vemuks61St0MUN4TmeKjS4MQxGA0Wi0AdWuLlGB2shHgN3BY89oA5XRpzqy/rXH8
 QLFfSaCD/ZMZ9MFVWiQ==
X-Proofpoint-ORIG-GUID: n-PX6X31Ep1r2snnC2dNTdTf6tdKvg9h
X-Authority-Analysis: v=2.4 cv=Nt1E4MdJ c=1 sm=1 tr=0 ts=6ada85a0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=sCbknPHGl6sa5x2yAD0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: n-PX6X31Ep1r2snnC2dNTdTf6tdKvg9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
index 07b49e51326..70ea5b0c8be 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/cutils.h"
 #include "qemu/qemu-print.h"
 #include "qemu/timer.h"
 #include "cpu.h"
@@ -291,6 +292,46 @@ static void hppa_cpu_class_base_init(ObjectClass *oc, const void *data)
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
@@ -305,6 +346,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, const void *data)
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


