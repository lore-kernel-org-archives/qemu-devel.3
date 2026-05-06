Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BAACD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrF-0000fb-EY; Wed, 06 May 2026 10:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqR-00088R-As
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:27 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqL-00010d-8n
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so32530405e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076194; x=1778680994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1MUF+JGVoH0IQ7xVChxpoSkYG7Gzm4cBynDqRT/Hre4=;
 b=ahjIl7kYi5b0P/5MRJW58Ei6yCBNYpB2d8YpjIQwxqPOwx/E0cjmi3ua4w5ZFsNQAg
 y2imukNoI5GCei3omWG0drvpFQyZYd+X2rGp2sAvlgmNtu66VUOo+KT/4ywY0fT6mMk/
 rv8GK1DEK4JTgYTABuyu2scLiSq02nUg0nttX0pMPEs39XNy/BI+CC+9Kxvcdy43unAI
 JsZv9qkbx8EYMxOjGLU2WlpPGtZkN7aXB5Ca0HQrc8N9FaGkWanPlF0k6rC6O5Obmxf6
 quBhG6YH4LRtcc5OiI3uCLfbPFtbnO+t0Hoj1Mty30YrNzvxXHMqZRIboghfZwtRYv5P
 VBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076194; x=1778680994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1MUF+JGVoH0IQ7xVChxpoSkYG7Gzm4cBynDqRT/Hre4=;
 b=Qc4oxomY61kwVZW3+RiQ8cNQXPNSyxA0K3zMLUMxnku+QYIAIVxoHaZZAjZvQ0BJWC
 9FI7RioXtw7Zeqx6AwLDZY37XgVBuHVKC8QInAs4Sl1RtUDLfGndb4GfRVTS7cfCCYEZ
 rVqAknlg6SC2gLuKerOs/y3BXlaHKd4udbLoknQ1x1AlxkZKesy0Soei09Cl+fD9bjLl
 YmGvta14Z39D7BuIEpE/sOnbPUCx+aMLxknkRGVN0o0XFtkUA+vdMK3SIb2SyS14vyZP
 3Nphxh+zJwvqr4o38/cwK2wP+gCj5s55XQoycT05vcuWwF1VX5bj5HVKpG1ASJNXCU8u
 Pblg==
X-Gm-Message-State: AOJu0YxaZu7Smn6YLc1EGDaQQtoZ2yrjY0qou6gHtvKnOYyMzpYjuH/m
 u6EIi+DEdvx1UmuS6oqbmeE6L6nFLaol4Q+kXzL5OsEJqFWfKmg15HEwPY3Uhau2JMf72EPLAPb
 +dfkJuok=
X-Gm-Gg: AeBDieupuH5Jikg4sR+xCqEzSFha60yZkqdEqlAe2sIbOd4emRBfzfZb5TVEHN9RJwf
 HmRDHIEIoBPbcHm9lnXAn+uthFWQ9iugucZYH2ekvwOgP7yRAOLphZ/rdeL243oqAArmdcdRjDs
 vo60mZes1XSj8vIuZvzLQZX62/K2tdbKwHBLFJR3XE1O8lE+o8PsStROFwy2V0V2M1LOAdvk0Cm
 1mSzdMvx/29NbPe0FFReAdfMg05HTKgxzeaFGZRgkhJEzjIBW9FbvY7xFDhs5WWL8kKyqZYfa2a
 ffACMsxvE2UaSM1jEUXyTkQtpnp32SjbnevX6hCBsGfBUy/YwRma7S4JV9Rtt6ZQY/MjWjux/of
 JENsDB3L5ptkV5gXB0tDPXGDwX6q+beiIdpdTUQKv85JpWQVGN9yutXzt1gaXTmLRRiEMJxJUs8
 3aX649BdSWMdN3m3a4y/vELPcXWWPwXLLJhcf48Z9QDV72TaIYGUrnUFr1xrlbk1PHhZW2ZhBac
 lTnXYHyBBg=
X-Received: by 2002:a05:600c:3b17:b0:48a:5970:2003 with SMTP id
 5b1f17b1804b1-48e51f18594mr61951915e9.3.1778076193558; 
 Wed, 06 May 2026 07:03:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53141f0dsm18026445e9.25.2026.05.06.07.03.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:03:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 060/110] monitor: Remove 'monitor/hmp-target.h' header
Date: Wed,  6 May 2026 15:54:32 +0200
Message-ID: <20260506135524.20617-61-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260427080738.77138-25-philmd@linaro.org>
---
 MAINTAINERS                   |  1 -
 include/monitor/hmp-target.h  | 41 -----------------------------------
 include/monitor/hmp.h         | 11 ++++++++++
 hw/i386/sgx-stub.c            |  1 -
 hw/i386/sgx.c                 |  1 -
 monitor/hmp-cmds.c            |  1 -
 monitor/hmp-target.c          |  1 -
 monitor/hmp.c                 |  1 -
 stubs/target-monitor-defs.c   |  2 +-
 target/i386/cpu-apic.c        |  1 -
 target/i386/monitor.c         |  1 -
 target/i386/sev-system-stub.c |  1 -
 target/i386/sev.c             |  1 -
 target/m68k/monitor.c         |  1 -
 target/ppc/monitor.c          |  2 --
 target/riscv/monitor.c        |  1 -
 target/sh4/monitor.c          |  1 -
 target/sparc/monitor.c        |  1 -
 target/xtensa/monitor.c       |  1 -
 19 files changed, 12 insertions(+), 59 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1eb7903268b..c4f78ac07f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3415,7 +3415,6 @@ F: hmp.h
 F: hmp-commands*.hx
 F: include/monitor/hmp.h
 F: include/monitor/hmp-completion.h
-F: include/monitor/hmp-target.h
 F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
 F: util/qemu-print.c
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
deleted file mode 100644
index ae34ca65ded..00000000000
--- a/include/monitor/hmp-target.h
+++ /dev/null
@@ -1,41 +0,0 @@
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
-    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
-};
-
-const MonitorDef *target_monitor_defs(void);
-
-CPUArchState *mon_get_cpu_env(Monitor *mon);
-CPUState *mon_get_cpu(Monitor *mon);
-
-#endif /* MONITOR_HMP_TARGET_H */
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 930ffa31aba..357fc972885 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -24,6 +24,17 @@
         g_assert_not_reached(); \
     }
 
+typedef struct MonitorDef {
+    const char *name;
+    int offset;
+    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
+} MonitorDef;
+
+const MonitorDef *target_monitor_defs(void);
+
+CPUArchState *mon_get_cpu_env(Monitor *mon);
+CPUState *mon_get_cpu(Monitor *mon);
+
 bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
 strList *hmp_split_at_comma(const char *str);
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 2b083c77bc1..59d58926311 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 5e792e8e6e9..7e4c509f5a4 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -17,7 +17,6 @@
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 1b44d07c18d..682bb62e91b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -22,7 +22,6 @@
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 550a7178052..2739383607d 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -28,7 +28,6 @@
 #include "monitor/qdev.h"
 #include "net/slirp.h"
 #include "system/device_tree.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
 #include "block/block-hmp-cmds.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index fe2f5560013..02e9d72e672 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -28,7 +28,6 @@
 #include "hw/core/sysemu-cpu-ops.h"
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
index eaa10ad2a3d..5599a4675c5 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -11,7 +11,6 @@
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/xen.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 98df5c7fd12..1befb8ea824 100644
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
index 2ea85597cf9..d97536cca1c 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "sev.h"
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 261b6aaa37b..b44b5a1c2b9 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -40,7 +40,6 @@
 #include "qom/object.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/qapi-commands-misc-i386.h"
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 94bb12833af..be7411edca6 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -8,7 +8,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "monitor/monitor.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 776a76602ea..7c88e0e2bda 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -7,9 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "cpu.h"
 
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3898595a3cb..63806002417 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -25,7 +25,6 @@
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/memory.h"
 #include "internals.h"
 
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
index a60671a60a4..99abddbf1e0 100644
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
2.53.0


