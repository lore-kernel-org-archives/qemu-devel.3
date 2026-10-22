Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C44606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kZGaL9Ji;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MPcraIiA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0kr-0006EL-BZ; Thu, 22 Oct 2026 17:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kp-00066e-0B
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kn-0008H1-5V
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtCtX060317
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SppUsg6Y0BZjh1TQjO3glHmQMV8GzijVRJfGN5OYEH4=; b=kZGaL9JiZ8dzUj2h
 z5vqyLwDDXrEOlhSNhvAdbuBqB0+mXNfYAb60O2U3gQZSqBqRORKUDmZKtoh5OBq
 vsG5xM7rbGV+JkXMIw9QfupCw6B/awz71h3CzThAaZZbsHabC1cEQ6WV6ufm/hqi
 m3LFTk/wW/TlT2fbXsIxc5+lbELqC8bN0LuUF26IyK1Urb2eEhNYWsS+KKKRGIHm
 k8fPHKDWwTlBpEDDFOQSY/550bxoNTUJRCMb7QL9r+zgFcx5uS6eRq5ASgrY+Q2a
 ryo0C7L0Gw+ZbFyEpE9eN1EtNcWO6+FeYFsbYkVkSRBacVXMlmocmI2ngs9p3Cuf
 IIz3RQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahs48g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:55:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f20addba1so51005185a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706115; x=1793310915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SppUsg6Y0BZjh1TQjO3glHmQMV8GzijVRJfGN5OYEH4=;
 b=MPcraIiA7d3SQ43I9a30a06/Or7Uo65OHsH2SFNSRsGIjMPZnCkbuIrwD+3+MbsIVw
 AbfuDXmaUgKCkz2358ggGzCk0DyAnxrhHY3TUmqr5ra4XUyidzPYEojQcL93AiwQJ8kP
 4LxQHsCzUIWcLIcZdGuPNxazYjzqU8/0IzIKFj5TztJQkvWIR4LuXSxtVkGYctzMQ43A
 RkUacIjTv3NkeeiNzDJDTHQIc5itN8f1eWJ3iFX84fj8Kk/lOVZsJvWOUuth9nWS7QvE
 l8lkNGVz822q6e+NkvGWzMMlFax+9J6z7mXpfEJHyU9RURz5HQBDJA1bRWLozmooZHlL
 lNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706115; x=1793310915;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SppUsg6Y0BZjh1TQjO3glHmQMV8GzijVRJfGN5OYEH4=;
 b=sHUE9YwJ6LiDeHTF8ESn74xUCiqF1B7giJkuRQsymwZh9XgOcwRGIxMYQNlVU065sw
 u2phXpAwMLRZ2XyiYiJ5wDskKv8CuOzyA/BnUm9bD+AQp6ZoOSblAovMa7kBinxM76wc
 fyuyRZwA76aCO6ER4vyvFnIoNgmhZuFgpQKHUm41zz4P3UwJouE1UQs916J/2weogMpC
 ZOWG0D+rjLQ3vj25tivUVBCl3O19hQGGPBaN19L7t2+Fgb/tbwMxGMQ6HGmBVZyY61wX
 yJ6rw6ctensUg0QHQoxp4O7YX2bKzawCTmGpkAZMU9uvPnReSWNX0APlxqrHS1nehDAY
 3jsg==
X-Gm-Message-State: AFq9FYJTvC9zVpp2M/9W/QywQyEyjm5VuSErSQjVivDWblk8ivYMJ/fo
 1iMcovYs81xvaDNv3hpx8UcKD0TIj88ev1PhquaSccDFfKaKGT81HJe7V6s/a1HTC60zhAOto7O
 dml5OkiKQFMzbXWH6/2ymRWRnQCgosknE+deEX3SsFSsnnWSJS+IwyI5Fs0DzFub3AQ==
X-Gm-Gg: AYBFou1pCRGsad3nJAo6ZQwGCEiMJ2IUxPWpVaiKJ18uXgOkOOVev+FXHj/twD/vSo8
 RyNR8qzENfEG+bN6gOcz9V4RGZSHeNRxNmxFzrPu+JUCM64j2ngYQa/51kNePvYxRBaxMXCTqiz
 G+h82Bzt4OH4kr0D6+ApB5M+Qyp4xm6dZ1wd/UFNYe3+6bUMXVREMchcXI8Qjurkv696EQctXyL
 V3zROK9t324Sb6Z3du9WGjwTHQ7LnKeHILQ3DBhvubxP52wtTooLiPufWgvBtrzNs4/W6H1y8/E
 x3Oz/RKP7IOYuWTlzRkyiS6HXKadLh82tEWE4nmVDgRFm0H7DYkDJYb8HylfwOUnRD6dQZUEVVg
 lHR6qJJzC6kxODtzkYM0yOquuRAfA8Z/vllJpzRew
X-Received: by 2002:a05:620a:2b8e:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-93f6f8aed12mr138576385a.69.1792706115006; 
 Thu, 22 Oct 2026 14:55:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8e:b0:93e:c12c:4409 with SMTP id
 af79cd13be357-93f6f8aed12mr138574385a.69.1792706114451; 
 Thu, 22 Oct 2026 14:55:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38025d8dsm765755f8f.17.2026.10.22.14.55.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 32/33] target/sparc: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:51:12 +0200
Message-ID: <20261022215115.19680-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX0czI1eJwXFWl
 M+8Zr4PNWQ0JBEeO3V8sz+lay+Npmb9iQF/13y4VvARb5ogB6TYpJYrn7JGmwN9mLfJYBbqC3vE
 4Ky8fnrAVdiQ+9wbUPFg3yhh9VExeyM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzOSpgbyvHnAd
 i+6xO+n+rQKFAYtbrrRTCQUPvrHqKeGEcUhIoN7WUIU+Yf1vitbvQIjZy7g2t0kl4B8yJQiMKGp
 okhWmzksm2pry0wsWYQ/dn7bSRQYRwM8vdeOw9leOaqleUzE17oNPWkUfgRTw7qnvhlsZ6VSliR
 QJlRg3YOqNcg+OjQvBpHa7b5sPJrgpLk5b+fDAsbcwXnZkdzgcqKVXNha1QLnzvT9dLi+dx0Z7b
 5w8dq8qHjJGXff2Z2ycsr8akMIUKqc9jVvr3HNsQyH2kB6ITfniP9isMEhuff8KtTREz3Mt7P7J
 aGWqq4+gx2sRidiS84vkBAWnK1cKpcLmxGsAGGdO+Osfxl974tRjzClX9Z6oeXkUqkgNtPMVEAI
 5JF6I1X+CSKnhEiP2yrpW+wAt1DByRuYOytS/PmDv8ekIoRTA4OzNWp9hvnZplFdSsW0L//gbvX
 Z9QE5L6PEMd+gCVbusw==
X-Proofpoint-GUID: TJ5yazj8uoh2MkSqW4M0zcdqW00Nq34f
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6ada8644 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kEJbCHFcLIL5wbn19PYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: TJ5yazj8uoh2MkSqW4M0zcdqW00Nq34f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
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

For each SPARC / SPARC64 target:
factor sparc_exception_name() out of sparc_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler, so
the common exception logging can resolve SPARC exception codes
to names.

With '-d int', unlisted codes are now logged as "unknown" instead
of "Unknown". On SPARC, the "Error state" abort message now names
trap instructions (0x80-0xff) instead of calling them "Unknown".
On SPARC64, trap 0x1ff is now named "Hyperprivileged Trap
Instruction"; it was "Unknown" because of an off-by-one in the
former range check.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sparc/cpu.h          |  1 +
 target/sparc/cpu.c          |  1 +
 target/sparc/int32_helper.c | 22 ++++++++--------------
 target/sparc/int64_helper.c | 36 ++++++++++++++++++------------------
 4 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31a16c2af03..3c1ba223eb2 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -583,6 +583,7 @@ extern const VMStateDescription vmstate_sparc_cpu;
 hwaddr sparc_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #endif
 
+const char *sparc_exception_name(int excp);
 void sparc_cpu_do_interrupt(CPUState *cpu);
 int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df8..1f9a62a8c76 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1098,6 +1098,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = sparc_cpu_class_by_name;
+    cc->exception_name = sparc_exception_name;
     cc->list_cpus = sparc_cpu_list,
     cc->parse_features = sparc_cpu_parse_features;
     cc->dump_state = sparc_cpu_dump_state;
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index d6bb3fa1e54..03ed5dffc9d 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "trace.h"
 #include "accel/tcg/cpu-ldst.h"
@@ -58,12 +59,12 @@ static const char * const excp_names[0x80] = {
     [TT_NCP_INSN] = "Coprocessor Disabled",
 };
 
-static const char *excp_name_str(int32_t exception_index)
+const char *sparc_exception_name(int excp)
 {
-    if (exception_index < 0 || exception_index >= ARRAY_SIZE(excp_names)) {
-        return "Unknown";
+    if (excp >= 0x80 && excp < 0x100) {
+        return "Trap Instruction";
     }
-    return excp_names[exception_index];
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -107,15 +108,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
-        const char *name;
-
-        if (intno < 0 || intno >= 0x100) {
-            name = "Unknown";
-        } else if (intno >= 0x80) {
-            name = "Trap Instruction";
-        } else {
-            name = excp_name_str(intno);
-        }
+        const char *name = sparc_exception_name(intno);
 
         qemu_log("%6d: %s (v=%02x)\n", count, name, intno);
         log_cpu_state(cs, 0);
@@ -129,7 +122,8 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         } else {
             cpu_abort(cs, "Trap 0x%02x (%s) while interrupts disabled, "
                           "Error state",
-                      cs->exception_index, excp_name_str(cs->exception_index));
+                      cs->exception_index,
+                      sparc_exception_name(cs->exception_index));
         }
         return;
     }
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 10341e0c282..849b1a436b2 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/cpu-common.h"
@@ -60,6 +61,22 @@ static const char * const excp_names[0x80] = {
     [TT_EXTINT | 0xf] = "External Interrupt 15",
 };
 
+const char *sparc_exception_name(int excp)
+{
+    if (excp < 0 || excp >= 0x200) {
+        return "unknown";
+    } else if (excp >= 0x180) {
+        return "Hyperprivileged Trap Instruction";
+    } else if (excp >= 0x100) {
+        return "Trap Instruction";
+    } else if (excp >= 0xc0) {
+        return "Window Fill";
+    } else if (excp >= 0x80) {
+        return "Window Spill";
+    }
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
 {
@@ -136,24 +153,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
-        const char *name;
-
-        if (intno < 0 || intno >= 0x1ff) {
-            name = "Unknown";
-        } else if (intno >= 0x180) {
-            name = "Hyperprivileged Trap Instruction";
-        } else if (intno >= 0x100) {
-            name = "Trap Instruction";
-        } else if (intno >= 0xc0) {
-            name = "Window Fill";
-        } else if (intno >= 0x80) {
-            name = "Window Spill";
-        } else {
-            name = excp_names[intno];
-            if (!name) {
-                name = "Unknown";
-            }
-        }
+        const char *name = sparc_exception_name(intno);
 
         qemu_log("%6d: %s (v=%04x)\n", count, name, intno);
         log_cpu_state(cs, 0);
-- 
2.55.0


