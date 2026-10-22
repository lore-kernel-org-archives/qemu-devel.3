Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E2606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G6/pXANi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g7GwGtZ8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0i9-0006Gl-MA; Thu, 22 Oct 2026 17:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hq-0005b0-CS
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0ho-0007Vr-GS
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKWrLV3413424
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Hcg+jvPjDV9xmJwthUVkue7gc06kjeaCQ6EMvYlnJMw=; b=G6/pXANiXKf6or4Z
 XdOBfSYqk/xLdNzwQaTHt0BDR29OOjn7189VP/ir3QS/jc5h4kmI0J0fBlAd1cwb
 2fQHfV8xWJX+jN4onTXiBszNzcB98gC4QIAwVx8wh+8oQ6bWmLaxXyow1WAigZxU
 ysytDfOAfbXhldlgcYhu1uOlNsUwWNUsSIxdOZW4qK48aE4iKaGiDGQi38W63EUH
 OsMRTLyUjeUrmXMAgcs0kn75y7z4Xwl/CFgu4ZaLWxu+N01Xmi6cMurmJJqGDi9V
 K+dpN3I/kFovcv/YebEZJH/dTgegEVhQdcEJBSRJbD5QZ+46oncnd0fMkYHCFCHt
 azQNiQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmar7tn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93909014c85so48060785a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705930; x=1793310730; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hcg+jvPjDV9xmJwthUVkue7gc06kjeaCQ6EMvYlnJMw=;
 b=g7GwGtZ8gf+3xadQ+JQ7QPcWqj0eGw5Al2uwjAP3B5vJ7D4RJTVJ2SxjG/uULRoiez
 9//YRQBpC4Hw49KO/6mM/pijCj/TEJs0ybQa17ysVAGHygir7GsOolmiCfXzPH82i52W
 ofrbJ5wIrRAcU02FaewtPIqLmKM6VNfpmTj5ev3o81/fBazff8Ze1FHSlMKvONA0VNgb
 pIMdzfxtHr0PvjMJA6rd+umAkKDvTFbyvhUMI3xi5oMD+ymsI3laCrli0pngZXMtpcsi
 a/bJ55RTR7Sv3Xm1QqDGmW3lbFLTFaXJ0URDzpSnl1ehVlAsqdDHnDGExqTE7LjyUe+6
 LLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705930; x=1793310730;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hcg+jvPjDV9xmJwthUVkue7gc06kjeaCQ6EMvYlnJMw=;
 b=FlK7emfxEHfUlsR5BkfYwlHmPREMReug2LZwUNiD7pPBu04Pb3UfGOOQrtKn38VjNQ
 8ZQ6nd42nGmanE4pbv75VtPNyKV/6nrskPMhiD7kSzko70GEZ7Ya1F0c/TJVtXotCOw9
 CTZGsAe7q2Drv1x1b5XMv90qJziznZ76fo93CD0FwJyKsjtkVNCDQ5rFwp2ekFHyr33k
 REybkumt9s+wtG/LA0jCHfNWAjj7aJvYFywlj6DJOOumoAw7mmrPj6Wrw3BA7adykYjb
 rVHrFn5kwLC5p8FdQk7wVhYadIdGFmh6sfjTVz7yetkgzLFj8PKsMtEpXDuDtN/uVgdO
 96cA==
X-Gm-Message-State: AFq9FYLstQQiE/MKPhoLy86cnnUU+Mew3a3GBMdl8lMVc51PSlgWbKIL
 X6EJhWalv/6cEWNo87zOMCigt0n4vRxL8H2uznrMDOtGhpH12vfYiGeEbVveE3mHaTCZgiHE/1L
 3CUGZXwc9FYhHS3tCy7F0D4r9SJ5a++XSQVLZBeS4QWBiqnbeuYLaeB1KNwJf0fhAQg==
X-Gm-Gg: AYBFou1lLAv4PIaRqw0BEzi3wAgBjxBfHXfcT4wOVamnBXd+00fChhsUmp7wYsI16X4
 glKHsVaLvLCD3nUvJ19kjwzyEXfnr/8ou80Z+DzIYIF/653t4g5HtMTYA0KshrFaL0n1/75KWWb
 T8CyT6vsY2a3+0cSoHbDxOxsrk61RG7e0tjzwstD6Qy/M2dbP+y7p3N4rZBnzxmYww7Vdx4mzW1
 puJCxKCpO95JzksSPd13MlRgJ/vlzV82U7bIFSG4Miy9bUl0aAiEEDHl61Qb2vQi/RcW5zjynWW
 En7V2VyHlJ9FsVymsyKMQjLw18N6fJ+0JEikq0j4ooP63rN9rMSDN/eorFPwvEYrACVouq2Sc05
 Tr/loz9fMEDFZnrQYjD2LcWuf339vFwXPwjKnnkDO
X-Received: by 2002:a05:620a:390c:b0:93f:353c:6bee with SMTP id
 af79cd13be357-93f6f7d0d45mr141932385a.41.1792705929828; 
 Thu, 22 Oct 2026 14:52:09 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:93f:353c:6bee with SMTP id
 af79cd13be357-93f6f7d0d45mr141930485a.41.1792705929374; 
 Thu, 22 Oct 2026 14:52:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2123613easm4750465e9.5.2026.10.22.14.52.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:52:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 07/33] target/arm: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:50:47 +0200
Message-ID: <20261022215115.19680-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6ada858b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QvePOBYGvqDf6_zMoJUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX4rZwwNufWq2B
 bxhkCLhJr2i/Ko32U39WD3e4IO9J/miZkKtySJOkTMa+j6nMbdm1V1bZ/27f+RfsBgPmFPSH8G+
 sZn6IdP7oW9L2TwPnHh2bQgcUOwGjiA=
X-Proofpoint-GUID: hSmKQBk7c_pJkFJGISwuus7PbFJedawV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXx8Pgs4sfyNUP
 iGVoOJ0kuNE8jf4lnnyVbXzPOvg5HgpSzv91+2bcHqI8yt3Vl1m6vQisv4LEDzuQd9eCUPES8XU
 t986r4ojqC69bul0f9K3eSZj2zzn19nsdOvluRMm4dbXEjZ2BE0Xhqws794Xca/S5mnf66JgJmb
 F+F73EEcIrwxOh/6s1+UhwuWj4FTl+AHRnRpcJzEMck1GPaYqz4U8tYxS/l/6WGJew85nh8lB6b
 F5HrsA7UEIXDZRWkiRsb0EpK4iBFHGhfei2eY1iG/yh1+AkzJPuiM2zR5xDN+XwSomy94mQO6TD
 pG+62M6yMDtq30e7MrO+LOHWWRISMZ8rzqxLhwIcWldkH9ArJ8cGCXEEHbP+EeRtaM8eTL9oDwx
 u4ft8S14tZEDhIN050ZcuVw4SM59Qyn7P67DijAw64m99zRyV3EA9akXDvYzPACUSO4Owgz5lGI
 ZxQyc16Pqv9/JGGew/g==
X-Proofpoint-ORIG-GUID: hSmKQBk7c_pJkFJGISwuus7PbFJedawV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
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

Factor arm_exception_name() out of arm_log_exception() and
register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve ARM exception codes
to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
index 81ec1ce21c6..8efbf673a92 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2647,6 +2647,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
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


