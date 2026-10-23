Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0253606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mcvZWyjr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C0O/HYJa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwv-0000gJ-Ca; Fri, 23 Oct 2026 12:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwn-0008QU-28
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwl-0002TT-4e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG2vL03733906
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T7A7ndu0bW2A0mXuIdfncOEAr5b/vu5UnG44eQfU00g=; b=mcvZWyjrJ58AxpK8
 sQvjKfUOwMuzDUqyRKrOL3GLB2IIVawe54D1MGrwQTfi7ceYQJqUDPkuzx4CpZZ6
 oZdEoB/oxqWkLd8mGFKbEnPPah+1tF3HG4QggxnKjYHCLNgyFjJJspykGE9J8mjh
 fBVj4BOaxtHovdX895ghosCC00LWB7l2LnkKkfhndcGomLgHRn9bE0SjnCgHhFwj
 pSRxSuo1H27Axy8ILBmHkg5f9B2SUkmrpY8UgeJMYK2BSqyYw2NHUXlyXUIT+gtd
 fdER2T+izJcbA791Bt5f6N6aXJpelvfbWB/wbTNZHUVWgSYILdQ2Uoz/gtIBftwy
 JSdjPQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarug245-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f33438950so241787685a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772205; x=1793377005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T7A7ndu0bW2A0mXuIdfncOEAr5b/vu5UnG44eQfU00g=;
 b=C0O/HYJamlOXFXGGtU7THeZNkZuBwx1h/rKVUUSlkJFfimrkCrH8dAOtdM3K3+WLFt
 5zotNUheNRFTGeLnjvz1yiFzuO+a0QfGj24kl6dn5X727V3M4wbhluF89EYW64h1dByG
 JgqRCh5jxcwTKAEOWSDFqaDqRXphjnMe/ZWj+w9YfEXqUcEHb6cNqGk8cxNrUZ8Ne/Ym
 nE+ti1+LfckjwlvLR6KiQhQTM+oQbYWGXTMIx1lQQRqXnM6nRtrMCYwz9zON1faMEbNx
 7HewpGkJ7Twx7HfuWr0PKs7oz2xnui5mgr4gqQ8ZKzckxo7PHImnHmHSJBJTiHuRNGk9
 45ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772205; x=1793377005;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T7A7ndu0bW2A0mXuIdfncOEAr5b/vu5UnG44eQfU00g=;
 b=gYwn1J81+mu8IWXVCMm6/Gq7BbXjwTFOy+LQSUYaLaTXPLF+WuNEzO+uF+y3dK2z+W
 hPaXCZZIInvShkdcWik38PValJ3CqwUC5kGHSBucBDTC4D3VWBF/9KX2T5bu5cG0ifFs
 BwjZBEbO9gZTZ0Q3rWGH4ANA5Z7ifKYLKUmcuwgRLmsszUft7m0s7wwS2AQ34R1iTrZl
 WneGrslkFGP1GxP+i0jVrPOd4zgV35k+4uv3j09KZWKFnj4vUHB6ntLC0R+PnxLPftRS
 hzNUDbmhp84oruV5vKtljx1QqPuB1RGLqiCyTlrmZuNjYsI+El/TKsNiIc6isGRR5yrE
 UQKw==
X-Gm-Message-State: AFq9FYJfzvouF9jLkzsrhlLdcv67IRPelg+5rqBcHeZvfY3Tx0eM7okf
 B/i/TsmGLHsVobB4GoCRGYN7T3ahtahPdULnt+4Z78fMAagu4nBEV9O1jSMi8mYLoH32GMteYBm
 a3GFUhrBEQziPM7PwGCG9de/w+h9V82e/k5sLw1fLpW61NOnymYL17zxolloG0L1kEbCH
X-Gm-Gg: AYBFou1xs+8WBLzLz6HggN6pYuukasfBQouszvzlp3TaMAmEPnhSQmQls+E+rwC0VCR
 jYObZt5ypcGlJd+fjJHlGBUoLmLYaX3TtNhk2nTjSDyE+nKk8KrECAagLAULj0T9nSi5lTvi1D5
 PhmJ4Mm3j23gLSkTeWzn83nf6EVAVo7DJNJURHFmoZYjzqRVffmfOv9opKL8FQsQp4c1ew6gyES
 CWRcNswEY973sitXEjaGaqewCryyVj1gc7nuhEL8jmYmP2vbmC7rpCyIadaTfqAb2NyCYA4Iawe
 r1S1rwxDTdC4c+GmqcVaS6hmZnHDAEt0ox/PAmx0Nta5qmyPwPYgOhBPG3Y0fzHC3jSw6qXLHFJ
 lVyf6nhmR2/OlswKOp7dg21I32Wy59Ri4V16OoWGS
X-Received: by 2002:a05:620a:2688:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93f6f3cc32cmr501504185a.0.1792772205116; 
 Fri, 23 Oct 2026 09:16:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2688:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93f6f3cc32cmr501497685a.0.1792772204483; 
 Fri, 23 Oct 2026 09:16:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3ee6d8sm772307f8f.14.2026.10.23.09.16.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/83] target/arm: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:34 +0200
Message-ID: <20261023161332.60153-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX4Bu43RyLcBGj
 OFAEA3OdxlUlF2sWTKItRPRN3mhof9+eS6AEvo9JT2V/lfJ5ShpMgAl9KD3LxGvwYMRCnLJXswo
 bDLrFzy35omdJ8qQMVFxR6XNcKDyTR0=
X-Proofpoint-GUID: jVMPkmDYt1qy9wnrM2lbEq4viRZQEi9w
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adb886d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=QvePOBYGvqDf6_zMoJUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: jVMPkmDYt1qy9wnrM2lbEq4viRZQEi9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX6PFbWVZyCVRH
 Ixn5i404xXq8cCp0Pi3ZqAyCTGdRAPCvJAyWvRu0fijJD2D20bjbROt0JiMBoDQrECWJuURdhzo
 UUj4rkFn6qkLycdN6/8qb3HyiP87FmROw7XbosAjDzO4UCvCUK2NTVBzHspziEbuMRdWoQrHm7q
 h0apECeh+fSkP2pj4Z5j1RggDT7MhvJyBakwMO2J5sRV56g/dmk9/ndvExaHCANcBKC10PUF+eS
 xkDVJKWRnAWYv6JCYjt4spEgmreW2xfZEKe0lsXKpWFWIaz9QnYvY2NEX5DWGbHR42BD46dVWzw
 6xYwewwdeIZuHrOssW0PedJqHl03sUK9grjweY6yZ6uo3YPFhksnDWAIF0yVQYWIYjzE1Qfs4IS
 ymFtCbdWZR3dMfgdMm0AVDyhWJImTjAyE1EEI0DjVd0pKwwu+IDn1blRyw8HDcZqFvoW++ymmh0
 HFBVF1wN0VYoScWt13Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
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

Factor arm_exception_name() out of arm_log_exception() and
register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve ARM exception codes
to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-8-philmd@oss.qualcomm.com>
---
 target/arm/cpu.h    |  4 ++-
 target/arm/cpu.c    |  1 +
 target/arm/helper.c | 77 ++++++++++++++++++++++-----------------------
 3 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a0355ba9e1a..add993ef101 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -65,7 +65,9 @@
 #define EXCP_VINMI          27
 #define EXCP_VFNMI          28
 #define EXCP_MON_TRAP       29   /* AArch32 trap to Monitor mode */
-/* NB: add new EXCP_ defines to the array in arm_log_exception() too */
+/* NB: add new EXCP_ defines to the array in arm_exception_name() too */
+
+const char *arm_exception_name(int excp);
 
 #define ARMV7M_EXCP_RESET   1
 #define ARMV7M_EXCP_NMI     2
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 03a0ae02ebb..510fc9eeb3b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2645,6 +2645,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
+    cc->exception_name = arm_exception_name;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7ac21108d1c..b540705e638 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "trace.h"
 #include "cpu.h"
 #include "internals.h"
@@ -8841,46 +8842,8 @@ void arm_log_exception(CPUState *cs)
     int idx = cs->exception_index;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        const char *exc = NULL;
-        static const char * const excnames[] = {
-            [EXCP_UDEF] = "Undefined Instruction",
-            [EXCP_SWI] = "SVC",
-            [EXCP_PREFETCH_ABORT] = "Prefetch Abort",
-            [EXCP_DATA_ABORT] = "Data Abort",
-            [EXCP_IRQ] = "IRQ",
-            [EXCP_FIQ] = "FIQ",
-            [EXCP_BKPT] = "Breakpoint",
-            [EXCP_EXCEPTION_EXIT] = "QEMU v7M exception exit",
-            [EXCP_KERNEL_TRAP] = "QEMU intercept of kernel commpage",
-            [EXCP_HVC] = "Hypervisor Call",
-            [EXCP_HYP_TRAP] = "Hypervisor Trap",
-            [EXCP_SMC] = "Secure Monitor Call",
-            [EXCP_VIRQ] = "Virtual IRQ",
-            [EXCP_VFIQ] = "Virtual FIQ",
-            [EXCP_SEMIHOST] = "Semihosting call",
-            [EXCP_NOCP] = "v7M NOCP UsageFault",
-            [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
-            [EXCP_STKOF] = "v8M STKOF UsageFault",
-            [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
-            [EXCP_LSERR] = "v8M LSERR UsageFault",
-            [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
-            [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
-            [EXCP_VSERR] = "Virtual SERR",
-            [EXCP_GPC] = "Granule Protection Check",
-            [EXCP_NMI] = "NMI",
-            [EXCP_VINMI] = "Virtual IRQ NMI",
-            [EXCP_VFNMI] = "Virtual FIQ NMI",
-            [EXCP_MON_TRAP] = "Monitor Trap",
-        };
-
-        if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
-            exc = excnames[idx];
-        }
-        if (!exc) {
-            exc = "unknown";
-        }
         qemu_log_mask(CPU_LOG_INT, "Taking exception %d [%s] on CPU %d\n",
-                      idx, exc, cs->cpu_index);
+                      idx, arm_exception_name(idx), cs->cpu_index);
     }
 }
 
@@ -9967,6 +9930,42 @@ void arm_cpu_do_interrupt(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
+const char *arm_exception_name(int excp)
+{
+    static const char * const excnames[] = {
+        [EXCP_UDEF] = "Undefined Instruction",
+        [EXCP_SWI] = "SVC",
+        [EXCP_PREFETCH_ABORT] = "Prefetch Abort",
+        [EXCP_DATA_ABORT] = "Data Abort",
+        [EXCP_IRQ] = "IRQ",
+        [EXCP_FIQ] = "FIQ",
+        [EXCP_BKPT] = "Breakpoint",
+        [EXCP_EXCEPTION_EXIT] = "QEMU v7M exception exit",
+        [EXCP_KERNEL_TRAP] = "QEMU intercept of kernel commpage",
+        [EXCP_HVC] = "Hypervisor Call",
+        [EXCP_HYP_TRAP] = "Hypervisor Trap",
+        [EXCP_SMC] = "Secure Monitor Call",
+        [EXCP_VIRQ] = "Virtual IRQ",
+        [EXCP_VFIQ] = "Virtual FIQ",
+        [EXCP_SEMIHOST] = "Semihosting call",
+        [EXCP_NOCP] = "v7M NOCP UsageFault",
+        [EXCP_INVSTATE] = "v7M INVSTATE UsageFault",
+        [EXCP_STKOF] = "v8M STKOF UsageFault",
+        [EXCP_LAZYFP] = "v7M exception during lazy FP stacking",
+        [EXCP_LSERR] = "v8M LSERR UsageFault",
+        [EXCP_UNALIGNED] = "v7M UNALIGNED UsageFault",
+        [EXCP_DIVBYZERO] = "v7M DIVBYZERO UsageFault",
+        [EXCP_VSERR] = "Virtual SERR",
+        [EXCP_GPC] = "Granule Protection Check",
+        [EXCP_NMI] = "NMI",
+        [EXCP_VINMI] = "Virtual IRQ NMI",
+        [EXCP_VFNMI] = "Virtual FIQ NMI",
+        [EXCP_MON_TRAP] = "Monitor Trap",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excnames, excp) ?: "unknown";
+}
+
 uint64_t arm_sctlr(CPUARMState *env, int el)
 {
     /* Only EL0 needs to be adjusted for EL1&0 or EL2&0 or EL3&0 */
-- 
2.55.0


