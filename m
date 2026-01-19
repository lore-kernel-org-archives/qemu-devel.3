Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC77CCF2DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 11:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhn4a-0000XQ-8l; Mon, 19 Jan 2026 06:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn4K-00008g-Fi
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:05:15 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhn4F-0006s3-O5
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 06:05:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so2501974f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768820706; x=1769425506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9fQffFhl/PW1gRIx+W9VUGAErfX3oCqnx4WCN0VxsM=;
 b=VwQUVPp8GsGzKREjKOD87F3rYJAzhPjAJXpGP9rZxzwD+haDHFVwJE6ZfIT+msH8pC
 1BeEHCidYWMm3w9BbCQOBSKS8VwwJw72lCw9SJo4EmNjqYuhFb4pcfev0/shfUafeHKy
 CF+fDCWnsiC6KpebC+YOQKlqkFAntaYiTCnkhoFQwq/THrsxPabRxeYlGiADlVHDLz/G
 QOqqWT9v6q/H4km0DNOJ5fUl/2V9R0Akx59QqcjZVRBHZFd7Gt3CIP+IIfiVMIkg/vaj
 CKfUhf7yhBX+LhvAfCoZ38p0BNcRZ6CoM8s9d1Sk6uwqpLmB8SiGEuv7cN97mF+ngq8y
 JnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768820706; x=1769425506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9fQffFhl/PW1gRIx+W9VUGAErfX3oCqnx4WCN0VxsM=;
 b=WwNE2TR77QJM9qSWUeKeC8cpIQBpBsHrKrX5+jHtMaWbcl2XIIfzOEygX8GYOQYMbI
 naCFesfTwbyg7/mgBAZl3i95XkuIaYrv6HoFP2W2UtHGw824rTeFw6oVu2ZjrWmmOw/s
 sXAOUqVpX8UUxyg4HkKC9L2tAFNqyb+tMAilAjJHDZ8CtcAwhUuLi0x1eQJLEWCWtRzj
 TPO5aXXpRyQTZDg58+QuFK42QXi5nwp92SKM0qzSk45i2n/O1EiUpcYCGPZ5+Qtc/jrD
 WzHPdU1CIUBpPfEnI2u/7ftfCA///B8DQgsBV/2pwe3NqootptIK91FA67fqs2Ho/gdC
 e5EQ==
X-Gm-Message-State: AOJu0YwsVgw1q1WZH2cqcBniUt4x54kwnk30PGFcmLMA+Me+X/K+dJwe
 fJrJtqTR0xRnWGSXaHbjAKpnWP6wfYI7E9CIuxmdg5wSEbN2HoqfhV3yU5edTv1ubsPunL25LEv
 cE9AAcOk=
X-Gm-Gg: AZuq6aLhG3dQDd5cbl4WyvHT9FFksslqKuCqx08lmgAHCt1pEkkeSMa0AJkFW6LLgoZ
 LSmMfkvR7m7c5Pm+V9rTMOc+aI2cdOPzYtVbzxE2iYDwyk1JtTINQ3cxe/DsZ7bkyMf4OgAdepj
 kN4I0D6p6N9XibR4QV3FVCChC7ukfro0S5zY/UJoqu2pMMQ5pU/PSrZIhxjCkwraJcW0u9rHa09
 Hqa1AmdFv4I2cl9XxNiSkXzILuDuqTSoTeifi6fh1rYAngZbCCUi2pp0DcjQ+2Vryr1J7uOfh7l
 ifR7Y+A5yH1PBluUhj4Zk7kxJc4Bsb8+KRSJ/PnKl5O/0SO3zuPa5iN7OUgryYwW+lrbR6PNSvA
 9fUgBpPO1liCIgRbhJGbUzOjekeD8fIuVyRdcmINiKew7IXRZ0W8oUuscL3TIxLVmRBYdo8FUu1
 iHNglOB6/YXqXnTZI/Zo/iLQZIGxnlWeuBylVFCejSt6j3ekgEsCeBASmewCCUba9wlL9SQsY=
X-Received: by 2002:a05:6000:1ac5:b0:432:a9db:f99b with SMTP id
 ffacd0b85a97d-43569919a6bmr11825492f8f.0.1768820705581; 
 Mon, 19 Jan 2026 03:05:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996dadbsm22348387f8f.21.2026.01.19.03.05.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jan 2026 03:05:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 8/8] monitor: Remove 'monitor/hmp-target.h' header
Date: Mon, 19 Jan 2026 12:03:58 +0100
Message-ID: <20260119110358.66821-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119110358.66821-1-philmd@linaro.org>
References: <20260119110358.66821-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The "monitor/hmp-target.h" header doesn't contain any
target-specific declarations anymore. Merge it with
"monitor/hmp.h", its target-agnostic counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 MAINTAINERS                   |  2 +-
 include/monitor/hmp-target.h  | 60 -----------------------------------
 include/monitor/hmp.h         | 31 ++++++++++++++++++
 hw/i386/sgx-stub.c            |  2 +-
 hw/i386/sgx.c                 |  1 -
 monitor/hmp-cmds.c            |  1 -
 monitor/hmp-target.c          |  1 -
 monitor/hmp.c                 |  1 -
 stubs/target-monitor-defs.c   |  2 +-
 target/i386/cpu-apic.c        |  2 +-
 target/i386/monitor.c         |  1 -
 target/i386/sev-system-stub.c |  2 +-
 target/i386/sev.c             |  1 -
 target/m68k/monitor.c         |  2 +-
 target/ppc/ppc-qmp-cmds.c     |  1 -
 target/riscv/monitor.c        |  2 +-
 target/riscv/riscv-qmp-cmds.c |  1 -
 target/sh4/monitor.c          |  1 -
 target/sparc/monitor.c        |  1 -
 target/xtensa/monitor.c       |  1 -
 20 files changed, 38 insertions(+), 78 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

diff --git a/MAINTAINERS b/MAINTAINERS
index de8246c3ffd..1e0d71c7bb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3377,7 +3377,7 @@ F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
 F: hmp-commands*.hx
-F: include/monitor/hmp-target.h
+F: include/monitor/hmp.h
 F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
 F: util/qemu-print.c
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
deleted file mode 100644
index c56f8df505c..00000000000
--- a/include/monitor/hmp-target.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * QEMU monitor
- *
- * Copyright (c) 2003-2004 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef MONITOR_HMP_TARGET_H
-#define MONITOR_HMP_TARGET_H
-
-typedef struct MonitorDef MonitorDef;
-
-struct MonitorDef {
-    const char *name;
-    int offset;
-    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
-    int type;
-};
-
-#define MD_TULONG 0
-#define MD_U32    1
-
-const MonitorDef *target_monitor_defs(void);
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
-CPUArchState *mon_get_cpu_env(Monitor *mon);
-CPUState *mon_get_cpu(Monitor *mon);
-
-void hmp_info_mem(Monitor *mon, const QDict *qdict);
-void hmp_info_tlb(Monitor *mon, const QDict *qdict);
-void hmp_mce(Monitor *mon, const QDict *qdict);
-void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
-void hmp_info_sev(Monitor *mon, const QDict *qdict);
-void hmp_info_sgx(Monitor *mon, const QDict *qdict);
-void hmp_info_via(Monitor *mon, const QDict *qdict);
-void hmp_memory_dump(Monitor *mon, const QDict *qdict);
-void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
-void hmp_info_registers(Monitor *mon, const QDict *qdict);
-void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
-void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
-void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
-
-#endif /* MONITOR_HMP_TARGET_H */
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 83721b5ffc6..9d70a7b78ad 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -17,6 +17,37 @@
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
 
+typedef struct MonitorDef {
+    const char *name;
+    int offset;
+    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
+    int type;
+} MonitorDef;
+
+#define MD_TULONG 0
+#define MD_U32    1
+
+const MonitorDef *target_monitor_defs(void);
+
+int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
+
+CPUArchState *mon_get_cpu_env(Monitor *mon);
+CPUState *mon_get_cpu(Monitor *mon);
+
+void hmp_info_mem(Monitor *mon, const QDict *qdict);
+void hmp_info_tlb(Monitor *mon, const QDict *qdict);
+void hmp_mce(Monitor *mon, const QDict *qdict);
+void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
+void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_info_sgx(Monitor *mon, const QDict *qdict);
+void hmp_info_via(Monitor *mon, const QDict *qdict);
+void hmp_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_info_registers(Monitor *mon, const QDict *qdict);
+void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
+void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
+void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
+
 bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
 strList *hmp_split_at_comma(const char *str);
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index d295e54d239..6e82773a86d 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index e2801546ad6..54d2cae36d8 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -16,7 +16,6 @@
 #include "hw/mem/memory-device.h"
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 5a673cddb2a..7c2b69dfa5b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -21,7 +21,6 @@
 #include "gdbstub/enums.h"
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
-#include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index a3306b69c93..2574c5d8b4b 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -27,7 +27,6 @@
 #include "monitor/qdev.h"
 #include "net/slirp.h"
 #include "system/device_tree.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "block/block-hmp-cmds.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 36e58c54670..2d9f870df26 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,7 +27,6 @@
 #include "hw/core/qdev.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
 #include "qemu/bswap.h"
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
index 35a0a342772..0dd4cdb34f6 100644
--- a/stubs/target-monitor-defs.c
+++ b/stubs/target-monitor-defs.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 
 const MonitorDef *target_monitor_defs(void)
 {
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index eeee62b52a2..3b73a04597f 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -10,7 +10,7 @@
 #include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/xen.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 427f1990399..1d04978c43b 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index 7c5c02a5657..f799a338d60 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "sev.h"
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1d70f96ec1f..31dbabe4b51 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -36,7 +36,6 @@
 #include "migration/blocker.h"
 #include "qom/object.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "qapi/qapi-commands-misc-i386.h"
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index fe289f6d5de..c148926d827 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "monitor/monitor.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 07938abb15f..08314e3c1cd 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -26,7 +26,6 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "qemu/ctype.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 8a77476db93..bc176dd8771 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 #include "system/memory.h"
 
 #ifdef TARGET_RISCV64
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d5e9bec0f86..79232d34005 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -34,7 +34,6 @@
 #include "qemu/ctype.h"
 #include "qemu/qemu-print.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "cpu-qom.h"
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 2da6a5426eb..50324d3600c 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 378967f8164..83257a18717 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index fbf60d55530..2af84934f83 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
-- 
2.52.0


