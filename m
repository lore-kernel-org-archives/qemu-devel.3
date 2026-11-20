Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35145606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SFgCs+lM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFWE-0006ZT-Om; Thu, 19 Nov 2026 22:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joaoanandalima@gmail.com>)
 id 1xUEgv-0007g1-Al
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 21:49:33 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joaoanandalima@gmail.com>)
 id 1xUEgt-0004fj-5p
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 21:49:33 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-33fb4680717so979854eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 18:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795142969; x=1795747769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IfKF3ZdirmHj+IwjmRdhDue//Y8CR2vWIrReF05FiAs=;
 b=SFgCs+lMpA/66Mo6yWui4MCAoYYdNTp5pxUlPSSz2XjJz+CGdxrF7UfHbq3MR/GHW9
 ewwUzZiSOFP04V+PKuXw2M5JhexuB7ADR2S7DQda0tdAfRvqqHF7bI/g2kYkAYg5XpsV
 Ze3CzDYUT415pHHOSFDYtpb2Y/ldpuyMuuyvWtNucxKF2LpGvqZT1fMQY6fFtSAKB3n8
 YIL0NBHC1lDKwDV/ejTBKhvjQYUSVycvU+iNRJaw0XPUAv6DsVJhyNs5quPlO19haSbu
 3P0AjZtnWmi2oWLMCx3gz3DPNHluwFH+p80+wnAXSKfYvr1kjlC7bXjfjDrk6bKGYr6k
 RghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795142969; x=1795747769;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IfKF3ZdirmHj+IwjmRdhDue//Y8CR2vWIrReF05FiAs=;
 b=NwnAcznrq6DP/DPC7ZC7g8TLv6qCmrPSyAWjnYfBL/7FG4yASokPMr1S8iYdjLNJh1
 b0dVEEftw/w/hrm8C86U5+v4cHLVca4FwSAeyq5SXOTW4YkJoG+cvwkd2gEgVSK50k/b
 B8b3Iipaz9Z7oVNpyrnEhUvVKEa/2H2BflphA/WiUpKqozfNvsSRDhrwH1czuyAWdBiO
 EGZjILZmwg/StamZYUU4np50fM3kvozm/w4a3VkGG3tAUchyNhuWAcoCJ8aRlLESm4qz
 9OQfNcUeDPDcrMmL9nbjStuPTmpi0hCflxBmtv2kPfug7IXJrZWzZt41J0m2V7TlYVZQ
 wccQ==
X-Gm-Message-State: APuU4Z8xmhreqqyVnIZTXk1Qjz0goHje86P820f0dPvCCWv6pfdbW0J+
 HjjmpFAqwuexoKRxPKEBYDxfv0pqycNG6LxyKMV0CrpnRekxUWKxnkUtDEsN3REG
X-Gm-Gg: AYBFou3vBRPV/Sgtd1dnpPPQEAmK/yDTe/ppLE2490+7UFrSx142MeJihWWkjwJ6Aiq
 Z/kRjJuCHAa3+QgRuYzdmu/c3skLUURg8S6uWxJjbfKjPsOg8r+f35d+a+orVol6NUNjSLuGoX1
 Lrdr1SVvCNIrYB2jn2VmN39KCCZINBcvvtOEg3kXeMGMUVURh8pJJcDn6troo/i2m7m4XX/UoTf
 a1Uchn9bK8JGBciHt7Q6j19b/nBKz83A282RNN5I13sHnqDv1cZaFDPRdQOVUDAhbjJg6D0L/6J
 ErOmJTEep0ecATTgFXMl6X5+Y5g03OuwoTHnDrJzw7X2TdQw3sKEIBUU59LjUWw2yAn7DzGlSlQ
 YqN5BEedjJ8YYVhVJqK7JOpP/NhOZrQdYrWF/1SRztqqnIKngORU6esZdPq+W1JDx4d/jIV/MuK
 k6+5HQnLSChDgzcF7covQIvHk5llUl3Lwxq8T08LAT+UUFB/yqtler8K0k4fmaogI9XDq5EdnwA
 bh9/F1ILQj7WUle7SKa5disryMiAMbrLNFekMCtWJcTqmKdpR03G4QnVXjhvqKTVJOhakqqISf1
 /lEzbfKaIm2li9J0bE5XDwWE2aXK+WKBwBIKhTlaqZoqGwImJe1fHA==
X-Received: by 2002:a05:7300:3e93:b0:384:4d76:27a1 with SMTP id
 5a478bee46e88-3857015d41fmr1425812eec.36.1795142968820; 
 Thu, 19 Nov 2026 18:49:28 -0800 (PST)
Received: from DESKTOP-7QP7L26 ([45.190.211.142])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c371esm2805260eec.23.2026.11.19.18.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 18:49:28 -0800 (PST)
From: dev12124 <joaoanandalima@gmail.com>
To: qemu-devel@nongnu.org
Cc: dev12124 <joaoanandalima@gmail.com>
Subject: [RFC PATCH] target/ia64: Add initial CPU state and PC accessors
Date: Thu, 19 Nov 2026 23:49:18 -0300
Message-ID: <20261120024920.1064-1-joaoanandalima@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=joaoanandalima@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Nov 2026 22:42:34 -0500
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: dev12124 <joaoanandalima@gmail.com>
---
 target/ia64/cpu-qom.h | 43 ++++++++++++++++++++++
 target/ia64/cpu.c     | 54 ++++++++++++++++++++++++++++
 target/ia64/cpu.h     | 83 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+)
 create mode 100644 target/ia64/cpu-qom.h
 create mode 100644 target/ia64/cpu.c
 create mode 100644 target/ia64/cpu.h

diff --git a/target/ia64/cpu-qom.h b/target/ia64/cpu-qom.h
new file mode 100644
index 0000000000..4ed395df81
--- /dev/null
+++ b/target/ia64/cpu-qom.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: MIT */
+
+/*
+   * QEMU Project for Intel Itanium (IA-64) emulation by 'Software Developer'.
+   *
+   * Copyright (c) 2026-2028 João (@dev12124 GitHub, @dev GitLab).
+   *
+   * This file is the CPU Header sign QEMU Models.
+   * Author: João Guilherme da Silva Freitas Lima <joaoanandalima@gmail.com>.
+   *
+   * WARNINGS:
+   *
+   * Permission is hereby granted, free of charge, to any person obtaining a copy
+   * of this software and associated documentation files (the "Software"), to deal
+   * in the Software without restriction, including without limitation the rights
+   * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+   * copies of the Software, and to permit persons to whom the Software is
+   * furnished to do so, subject to the following conditions:
+   *
+   * The above copyright notice and this permission notice shall be included in
+   * all copies or substantial portions of the Software.
+   * 
+   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+   * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+   * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+   * THE SOFTWARE.
+   */
+
+#ifndef __CPu_CLASS_HID
+#define __CPu_CLASS_HID
+
+#include "hw/core/cpu.h"
+
+struct IA64CPUClass {
+    CPUClass parent_class;
+    DeviceRealize parent_realize; 
+    ResettablePhases parent_phases;
+} __attribute__((aligned(64))); /* Optimization in first local */
+
+#endif
\ No newline at end of file
diff --git a/target/ia64/cpu.c b/target/ia64/cpu.c
new file mode 100644
index 0000000000..731fd6b8bc
--- /dev/null
+++ b/target/ia64/cpu.c
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: MIT */
+
+/*
+   * QEMU Project for Intel Itanium (IA-64) emulation by 'Software Developer'.
+   *
+   * Copyright (c) 2026-2028 João (@dev12124 GitHub, @dev GitLab).
+   *
+   * This file is Implementation CPU Emulated of IA64 Arch.
+   * Author: João Guilherme da Silva Freitas Lima <joaoanandalima@gmail.com>.
+   *
+   * WARNINGS:
+   *
+   * Permission is hereby granted, free of charge, to any person obtaining a copy
+   * of this software and associated documentation files (the "Software"), to deal
+   * in the Software without restriction, including without limitation the rights
+   * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+   * copies of the Software, and to permit persons to whom the Software is
+   * furnished to do so, subject to the following conditions:
+   *
+   * The above copyright notice and this permission notice shall be included in
+   * all copies or substantial portions of the Software.
+   * 
+   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+   * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+   * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+   * THE SOFTWARE.
+   */
+
+#include "qemu/osdep.h" 
+#include "cpu-qom.h" /* target/ia64/ */
+#include "cpu.h" /* target/ia64/ */
+
+static void ia64_set_pc(CPUState *cs, vaddr value)
+{
+    if(unlikely(!cs)) /* Pure Optimizatiom */
+        return;
+
+    CPUIA64State *env = cpu_env(cs); /* Extract */
+    env->ip = env->ip | value & ~0xFULL;
+    env->slot = value & 0x3;
+}
+
+static vaddr ia64_get_pc(CPUState *cs)
+{
+    if(unlikely(!cs))
+        return 0;
+
+    CPUIA64State *env = cpu_env(cs);
+    vaddr result = env->ip | (env->slot & 0x3);
+    return result;
+}
\ No newline at end of file
diff --git a/target/ia64/cpu.h b/target/ia64/cpu.h
new file mode 100644
index 0000000000..f83f508c43
--- /dev/null
+++ b/target/ia64/cpu.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: MIT */
+
+/*
+   * QEMU Project for Intel Itanium (IA-64) emulation by 'Software Developer'.
+   *
+   * Copyright (c) 2026-2028 João (@dev12124 GitHub, @dev GitLab).
+   *
+   * This file is the CPU Header sign QEMU Models.
+   * Author: João Guilherme da Silva Freitas Lima <joaoanandalima@gmail.com>.
+   *
+   * WARNINGS:
+   *
+   * Permission is hereby granted, free of charge, to any person obtaining a copy
+   * of this software and associated documentation files (the "Software"), to deal
+   * in the Software without restriction, including without limitation the rights
+   * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+   * copies of the Software, and to permit persons to whom the Software is
+   * furnished to do so, subject to the following conditions:
+   *
+   * The above copyright notice and this permission notice shall be included in
+   * all copies or substantial portions of the Software.
+   * 
+   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+   * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+   * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+   * THE SOFTWARE.
+   */
+
+#ifndef __CPU_HEADER_MODEL__
+#define __CPU_HEADER_MODEL__
+
+#include "cpu-qom.h"
+#include "exec/cpu-defs.h"
+
+#ifndef unlikely
+#define unlikely(x) __builtin_expect(!!(x), 0)
+#endif
+
+typedef struct CPUArchState {
+      uint64_t gr[128];
+
+      uint64_t nat_lo;
+      uint64_t nat_hi;
+
+      uint64_t pr;
+
+      uint64_t br[8];
+
+      uint64_t ar[128];
+
+      uint64_t cr[128];
+
+      uint64_t ip;
+      uint64_t slot;
+
+      uint64_t cfm;
+
+      uint64_t psr;
+} __attribute__((aligned(64))) CPUIA64State; /* Aligned in a Cache Line (I love optimization) */
+
+struct ArchCPU {
+    CPUState parent_obj;
+    CPUIA64State env;
+} __attribute__((aligned(64)));
+
+#define TYPE_IA64_CPU "ia64-cpu"
+OBJECT_DECLARE_CPU_TYPE(IA64CPU, IA64CPUClass, IA64_CPU)
+
+static inline void cpu_get_tb_cpu_state(CPUIA64State *env, vaddr *pc,
+                                 uint64_t *cs_base, uint32_t *flags)
+{
+    if(unlikely(!env)||unlikely(!pc)||unlikely(!cs_base)||unlikely(!flags))
+        return;
+
+    *pc = env->ip | (env->slot & 0x3);
+    *cs_base = 0;
+    *flags = 0;
+}
+
+#endif
\ No newline at end of file
-- 
2.55.0.windows.3


