Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98570606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FqLJJ0Te;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FNnmUlPM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0N-00008s-5a; Fri, 23 Oct 2026 12:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzf-0007jS-GF
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzd-0002gc-8g
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG2ukA3733893
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8EKtigz2LT1tqKm9TjWDplrVbAa5p1aqsSCZ6D/y0yA=; b=FqLJJ0TeFWbY9GOw
 qgTRIc9LA4MGlNV5NjNeazRsmKGHUXVsRTMeexXmCiUASKCTVplZS6JuERJmoa8W
 mYebdTk1H4kkYFU2AmOU9kbkyI93qeDe/aktRytfE6ZjbQi61nj2beaiekfomrkV
 GaSxNNCoIiqyaNequ6ALFK/1McCNkyayAJR3EQ36I00SWTk/yFhbdJDsmeBqeSUJ
 4uR5a5QLYIIUJn9CyutitcqdqIukpbD1Gl5MKZLEMwbPe0DOeEcUyZ6qYE0wBs0v
 7L+1ykjuRUdLm6jiO1R8sORM3g2kZEmCh1I6612EXG+BYhmkF0N1gWhX3smOzSKA
 OWxWxQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarug2fu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f3969a2a7so177780085a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772384; x=1793377184; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8EKtigz2LT1tqKm9TjWDplrVbAa5p1aqsSCZ6D/y0yA=;
 b=FNnmUlPMIyZLFBBSssZca6khibXLnIvaBACMQjcCh1DXEAaN6WgRWeQeO06Ffrd6zs
 W6SPZ95omKLMZfkP31wutg4SRy/onU89lYbjPUY2aRNZRsxppRv8fD2TOa0bzoPpRpNs
 445fOZSRzOU3LFJuSVoe2ZJu+zffjowRkeq4icNLckAy9vM8GDLmuPBlTPw7xZ6jfSXA
 8aOD5JXF5trKVfnUegkzUxjVTgXC5+HR+Gtn/mOo4OjzG7iQugej72vQuYWqAiTnmBw+
 CNk05T5yNPRzdB3v1RyDhLWQ2adt826lgVvpGX72BDZ2o67cJgWOiUeLhPgiAxoYTB8Z
 R0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772384; x=1793377184;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8EKtigz2LT1tqKm9TjWDplrVbAa5p1aqsSCZ6D/y0yA=;
 b=CRzCeSUdP8ZLkE00ppPRv4Ahw9GIpN97WS0gybkIYaMX8g6TtMPKzLJVe0IDRJniu6
 WEUQqwcFlQ6OwiQ70QHkcHy54UxTRVlw1gGGil84oJesxbDDiaGYk+NFV33UduSRqVyS
 uWcCEfP1AMBUBH1aauRsiAj3XikCGiYuoBtS6G3d5wDWqDAlqZh0szjzBP3HGLdJ07n1
 LyOwvsmzWw5gthrkZKownfPvCFRjCgYnUnbkwqAg9ps2Tu/KbaGxuhwv6Tv0FHvC1u/u
 8KNGamS3P4n3stLh9rLeFFmDLf7P/zVB1Wp1kcF/o+U0H80Tu3swJOkVYYCxbMYKTAeW
 R0JA==
X-Gm-Message-State: AFq9FYK/bbI19e6oSzZzW93YyxlAreyKQz7wLZBe21kXznQL05cHbg0A
 u3sL7aAPiQaydPddDO4bwkJJnZHsa24te9E7jl6JbAUBPr9CLmo9NmVC+o69iNoJny82FcgdmYi
 guzS1R/Xg8wNp1YX6X6dViQ4NIoJJiBvYbGhqGAOLT5yACUodB+LNR3M2CAB9e6XR77o2
X-Gm-Gg: AYBFou1EZasuVzWrh70TMOSvgMKNaStndx0uc1JkdeJiexXBCjBK5nWniYCVOwOYxUy
 r0FDKHRlOfJ6SnnrPI4kZCK4t/3GfM9O4LUlq8AatJ8FXaxUqwcFtK8vCCZ/ZqIwhmh7NkbB3S0
 3v2JRIooec5OWChlStE/7mgEwGyhziighQJMYeBbT4qqJBEh+ejew+RDHgDnnF/G0X5Fi1DeCWb
 7HZEx8JwSxtW5LTZ11wTZwxXpxUKZYwPXfQfWfcMcwvIayBITcU/UDc0P2t2ma/Y6lWLXKBddlq
 88+xAmXgOQNQGt4+wXGqSLwR2ldVR+nJn+H/W3+4Rcp31Y9fMtC+WdO0i2jA8v/QY+P3unNAvCn
 IYoR4xjTZyesyUpnPcqywnl7Xjgz8ZYNItM65jZLx
X-Received: by 2002:a05:620a:470a:b0:93f:2d10:ea49 with SMTP id
 af79cd13be357-93f6f8151d0mr498381985a.45.1792772383660; 
 Fri, 23 Oct 2026 09:19:43 -0700 (PDT)
X-Received: by 2002:a05:620a:470a:b0:93f:2d10:ea49 with SMTP id
 af79cd13be357-93f6f8151d0mr498377285a.45.1792772383121; 
 Fri, 23 Oct 2026 09:19:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a92a4444sm16394465e9.5.2026.10.23.09.19.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:19:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/83] target/sparc: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:59 +0200
Message-ID: <20261023161332.60153-52-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX7Oh1nYDrWI0U
 58aUQBkxIu+GssXbldDbC21V6C2OyQURYzYlUVtFpiBUMzr6oIWqSZqN84ftQblIMe+TZcvnudz
 L3X75GzLmmgE1DDrRYENt+HIwFFzxWk=
X-Proofpoint-GUID: zeLVG3Lvg6wvtuz3YFWta-Gh9GBFqXZi
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adb8920 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=kEJbCHFcLIL5wbn19PYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: zeLVG3Lvg6wvtuz3YFWta-Gh9GBFqXZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX5lH10tW0P/p/
 GXjiyXcAojGuipGwVYwRMhc/mY4feEGfI/ZU9RUPgK+woUUKjvJPszRX4K5PgMyBg7IvJAc/W8V
 B9NcixHdwVavl+al/vneXUNFpXkxjhNOZPIYSNv+uV6iE/1ut55BAuYSIlHSaXOk3OXtqbO2ac8
 dFmbA5Li3aNLZqHga7zhQMATcvzDuemQbjp0stOOdI2cg5ZfHIsxbC46sXGs8wHdmfh1C6p+KUk
 bk3AoZf5lMAKx2dJpfdF9qksqVpokVd/mM78vF69rMLZN3fxGw5ZR4B8wA4R+ZtyKzyCYW8KyVF
 S9Bl3pFvluY5V+9ZS4xjP6G+gSOzRDXDEGdxhxKJhqpxF7YKbLgdr7Gz9MhcmmnIhy9y00T9AG7
 qNbqOoHpnhD5OPg/Sfq5ewxtq/TPCesc84cNt8FAyT3D/xdtg1XvGcbC9m6m40VK7lCULRabe81
 Zr7bFIO37Eg9zTzXMNg==
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
Message-ID: <20261022215115.19680-33-philmd@oss.qualcomm.com>
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
index 1529f9570da..3c71f60bb4f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1097,6 +1097,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
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


