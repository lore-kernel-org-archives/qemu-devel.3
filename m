Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA2010987B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3d3W-0005nt-Ch; Fri, 20 Mar 2026 12:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3T-0005nK-0H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3R-0001N8-3q
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439fe4985efso669071f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025431; x=1774630231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpNfpAudaHSn6E46oY3mv5zJptnJn91JySmHe16VZmw=;
 b=VSg4dt+AYIJIDw/Y2m8aWC7unkX8pTGtT7rnateDl8lkNxHywCLS9eJNYVARQ6uDsK
 jo9KoBiykD5Ir/2bJ0gnnCFs4l3pHHcgwuawKQiXuIYtnwUwwtN5ERGfk5DCrbkDiJyT
 /Y13WQm7etUNMn9m1FdbCyZmHWho7cBZ0QBngMdYRjSXlfzjl/rvpWPW1UVvvN6Xuu3Z
 VFhKTGzjxQWLnFMpCOxfP0KENJXFNND7tBRfCeP/ZJZXgWlhiR5mL7t0PV32/8iMeve5
 5UmIVBFKIYcanCeonT030KmTKZqSblUk8S6HA6MHY9pIHtwr783y7okXvy3t0cxkJijL
 HgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025431; x=1774630231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LpNfpAudaHSn6E46oY3mv5zJptnJn91JySmHe16VZmw=;
 b=NpcQoX6waKT1vL2fhKhrSo0X2L3X+Kpj0vhgeM8HNJUWx7CucoePjMp9YKRaYjiyIz
 1R260+RXHUA5KB969gNlbc0Ikdd+HhZbM0y2ctXJpRSwHMZeRzdtyeynv+an2mquBrIU
 j+2ZO4ZLxZXVDZBwPhMXThWSYiGYNBFRy9OogaTN4jQ9LRe60hpwMc7Qki10upa7hi42
 MxHU3rz8p75R3/z9ccGFfQu/bGI1J7XCLo+dPZ1VHyeU8r5YiH3fBEIyiICF9i2BbKDM
 /CNOAjSTxMMKn49JWFyv7jj9jiFLnfZCh6ikujCEt50B4yP8r7iyLlIV4ksGpTKBwEL3
 IiFA==
X-Gm-Message-State: AOJu0Yw0iWZJ+CTgzUAzIiXcv2fGc+TN6C623aip8p++lmwwrqORogtJ
 OUdu9Ds2LrNM/8CLTK4QKXPN0NNBwa554Di/JUT5RJ8lvL/cUl8TTBAX+z69kfgb0CUwJXxnmWt
 5MUY4ovk=
X-Gm-Gg: ATEYQzwA+bx+BtzqDxITc046Bq1PMOXMxrGcU9a5AN6aRmyefiQlehxFJdS/M8kIogg
 ATdGvkZSvPmPm60BZ2ywdBpGsChl0fesgskqx1Uev2gI42Crga3N6j8ZlLS81kU2VrROiRVrARC
 I6vIPwy/DNUMzHoaW4iMTOSeF1AZmfqsH8ogdzqBNwpoUzUhoamectO4p8jln7Q+rv3bHvdcc8b
 VYExlAEMXHOBpys4oA2fG340LDDo579w/r99MWiRHP54RZulrgi0GICveJ/WjEclkxaT44MrSM5
 Oqb7RXw3YpblOSmoxHiskqDegVs5tvh6/hM6RzdU4o/mzcj00jqz0NSwx+YFd7ecRVhSEoDRv4V
 Z0WTpRjAZrIJ2RGvbZDzYwNcdEq7wYCQZ4gIF570VSPgod+610zcmGuEK7zNRr2qtJaO7k6y/lQ
 7C/q19oriGSaFXa5D5W/5e+7nC2Bq0LBnhnIolA7FQKYbnNUpcLuVBIduK/XZpYPHlTa4RtI+PS
 qvHNq7Q0jI=
X-Received: by 2002:a05:6000:430e:b0:43b:5356:a7fb with SMTP id
 ffacd0b85a97d-43b6427d152mr6207010f8f.49.1774025430704; 
 Fri, 20 Mar 2026 09:50:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644acb52sm8330572f8f.7.2026.03.20.09.50.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:50:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 1/7] target/m68k: Have 'info tlb' dump MMU
 information on monitor
Date: Fri, 20 Mar 2026 17:50:14 +0100
Message-ID: <20260320165021.39521-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320165021.39521-1-philmd@linaro.org>
References: <20260320165021.39521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently 'info tlb' dumps the MMU information on stdout.
Propagate the @Monitor argument and replace qemu_printf() by
monitor_printf() -- or monitor_puts when no formatting -- to
dump information over the monitor (which is not always stdout).

Fixes: 2097dca6d3a ("target/m68k: add HMP command "info tlb"")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.h     |   2 +-
 target/m68k/helper.c  | 116 +++++++++++++++++++++---------------------
 target/m68k/monitor.c |   2 +-
 3 files changed, 61 insertions(+), 59 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index d7f508a9e80..84ffebe3890 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -606,6 +606,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
-void dump_mmu(CPUM68KState *env);
+void dump_mmu(Monitor *mon, CPUM68KState *env);
 
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bab1843892..2208b9a2ab9 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -28,7 +28,7 @@
 #include "system/memory.h"
 #include "gdbstub/helpers.h"
 #include "fpu/softfloat.h"
-#include "qemu/qemu-print.h"
+#include "monitor/monitor.h"
 
 #define SIGNBIT (1u << 31)
 
@@ -459,28 +459,30 @@ void m68k_switch_sp(CPUM68KState *env)
 #if !defined(CONFIG_USER_ONLY)
 /* MMU: 68040 only */
 
-static void print_address_zone(uint32_t logical, uint32_t physical,
+static void print_address_zone(Monitor *mon,
+                               uint32_t logical, uint32_t physical,
                                uint32_t size, int attr)
 {
-    qemu_printf("%08x - %08x -> %08x - %08x %c ",
+    monitor_printf(mon, "%08x - %08x -> %08x - %08x %c ",
                 logical, logical + size - 1,
                 physical, physical + size - 1,
                 attr & 4 ? 'W' : '-');
     size >>= 10;
     if (size < 1024) {
-        qemu_printf("(%d KiB)\n", size);
+        monitor_printf(mon, "(%d KiB)\n", size);
     } else {
         size >>= 10;
         if (size < 1024) {
-            qemu_printf("(%d MiB)\n", size);
+            monitor_printf(mon, "(%d MiB)\n", size);
         } else {
             size >>= 10;
-            qemu_printf("(%d GiB)\n", size);
+            monitor_printf(mon, "(%d GiB)\n", size);
         }
     }
 }
 
-static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
+static void dump_address_map(Monitor *mon, CPUM68KState *env,
+                             uint32_t root_pointer)
 {
     int tic_size, tic_shift;
     uint32_t tib_mask;
@@ -548,7 +550,7 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
                     if (first_logical != 0xffffffff) {
                         size = last_logical + (1 << tic_shift) -
                                first_logical;
-                        print_address_zone(first_logical,
+                        print_address_zone(mon, first_logical,
                                            first_physical, size, last_attr);
                     }
                     first_logical = logical;
@@ -559,125 +561,125 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
     }
     if (first_logical != logical || (attr & 4) != (last_attr & 4)) {
         size = logical + (1 << tic_shift) - first_logical;
-        print_address_zone(first_logical, first_physical, size, last_attr);
+        print_address_zone(mon, first_logical, first_physical, size, last_attr);
     }
 }
 
 #define DUMP_CACHEFLAGS(a) \
     switch (a & M68K_DESC_CACHEMODE) { \
     case M68K_DESC_CM_WRTHRU: /* cacheable, write-through */ \
-        qemu_printf("T"); \
+        monitor_puts(mon, "T"); \
         break; \
     case M68K_DESC_CM_COPYBK: /* cacheable, copyback */ \
-        qemu_printf("C"); \
+        monitor_puts(mon, "C"); \
         break; \
     case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
-        qemu_printf("S"); \
+        monitor_puts(mon, "S"); \
         break; \
     case M68K_DESC_CM_NCACHE: /* noncachable */ \
-        qemu_printf("N"); \
+        monitor_puts(mon, "N"); \
         break; \
     }
 
-static void dump_ttr(uint32_t ttr)
+static void dump_ttr(Monitor *mon, uint32_t ttr)
 {
     if ((ttr & M68K_TTR_ENABLED) == 0) {
-        qemu_printf("disabled\n");
+        monitor_puts(mon, "disabled\n");
         return;
     }
-    qemu_printf("Base: 0x%08x Mask: 0x%08x Control: ",
+    monitor_printf(mon, "Base: 0x%08x Mask: 0x%08x Control: ",
                 ttr & M68K_TTR_ADDR_BASE,
                 (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIFT);
     switch (ttr & M68K_TTR_SFIELD) {
     case M68K_TTR_SFIELD_USER:
-        qemu_printf("U");
+        monitor_puts(mon, "U");
         break;
     case M68K_TTR_SFIELD_SUPER:
-        qemu_printf("S");
+        monitor_puts(mon, "S");
         break;
     default:
-        qemu_printf("*");
+        monitor_puts(mon, "*");
         break;
     }
     DUMP_CACHEFLAGS(ttr);
     if (ttr & M68K_DESC_WRITEPROT) {
-        qemu_printf("R");
+        monitor_puts(mon, "R");
     } else {
-        qemu_printf("W");
+        monitor_puts(mon, "W");
     }
-    qemu_printf(" U: %d\n", (ttr & M68K_DESC_USERATTR) >>
+    monitor_printf(mon, " U: %d\n", (ttr & M68K_DESC_USERATTR) >>
                                M68K_DESC_USERATTR_SHIFT);
 }
 
-void dump_mmu(CPUM68KState *env)
+void dump_mmu(Monitor *mon, CPUM68KState *env)
 {
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
-        qemu_printf("Translation disabled\n");
+        monitor_puts(mon, "Translation disabled\n");
         return;
     }
-    qemu_printf("Page Size: ");
+    monitor_puts(mon, "Page Size: ");
     if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
-        qemu_printf("8kB\n");
+        monitor_puts(mon, "8kB\n");
     } else {
-        qemu_printf("4kB\n");
+        monitor_puts(mon, "4kB\n");
     }
 
-    qemu_printf("MMUSR: ");
+    monitor_puts(mon, "MMUSR: ");
     if (env->mmu.mmusr & M68K_MMU_B_040) {
-        qemu_printf("BUS ERROR\n");
+        monitor_puts(mon, "BUS ERROR\n");
     } else {
-        qemu_printf("Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
+        monitor_printf(mon, "Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
         /* flags found on the page descriptor */
         if (env->mmu.mmusr & M68K_MMU_G_040) {
-            qemu_printf("G"); /* Global */
+            monitor_puts(mon, "G"); /* Global */
         } else {
-            qemu_printf(".");
+            monitor_puts(mon, ".");
         }
         if (env->mmu.mmusr & M68K_MMU_S_040) {
-            qemu_printf("S"); /* Supervisor */
+            monitor_puts(mon, "S"); /* Supervisor */
         } else {
-            qemu_printf(".");
+            monitor_puts(mon, ".");
         }
         if (env->mmu.mmusr & M68K_MMU_M_040) {
-            qemu_printf("M"); /* Modified */
+            monitor_puts(mon, "M"); /* Modified */
         } else {
-            qemu_printf(".");
+            monitor_puts(mon, ".");
         }
         if (env->mmu.mmusr & M68K_MMU_WP_040) {
-            qemu_printf("W"); /* Write protect */
+            monitor_puts(mon, "W"); /* Write protect */
         } else {
-            qemu_printf(".");
+            monitor_puts(mon, ".");
         }
         if (env->mmu.mmusr & M68K_MMU_T_040) {
-            qemu_printf("T"); /* Transparent */
+            monitor_puts(mon, "T"); /* Transparent */
         } else {
-            qemu_printf(".");
+            monitor_puts(mon, ".");
         }
         if (env->mmu.mmusr & M68K_MMU_R_040) {
-            qemu_printf("R"); /* Resident */
+            monitor_puts(mon, "R"); /* Resident */
         } else {
-            qemu_printf(".");
+            monitor_puts(mon, ".");
         }
-        qemu_printf(" Cache: ");
+        monitor_puts(mon, " Cache: ");
         DUMP_CACHEFLAGS(env->mmu.mmusr);
-        qemu_printf(" U: %d\n", (env->mmu.mmusr >> 8) & 3);
-        qemu_printf("\n");
+        monitor_printf(mon, " U: %d\n", (env->mmu.mmusr >> 8) & 3);
+        monitor_puts(mon, "\n");
     }
 
-    qemu_printf("ITTR0: ");
-    dump_ttr(env->mmu.ttr[M68K_ITTR0]);
-    qemu_printf("ITTR1: ");
-    dump_ttr(env->mmu.ttr[M68K_ITTR1]);
-    qemu_printf("DTTR0: ");
-    dump_ttr(env->mmu.ttr[M68K_DTTR0]);
-    qemu_printf("DTTR1: ");
-    dump_ttr(env->mmu.ttr[M68K_DTTR1]);
+    monitor_puts(mon, "ITTR0: ");
+    dump_ttr(mon, env->mmu.ttr[M68K_ITTR0]);
+    monitor_puts(mon, "ITTR1: ");
+    dump_ttr(mon, env->mmu.ttr[M68K_ITTR1]);
+    monitor_puts(mon, "DTTR0: ");
+    dump_ttr(mon, env->mmu.ttr[M68K_DTTR0]);
+    monitor_puts(mon, "DTTR1: ");
+    dump_ttr(mon, env->mmu.ttr[M68K_DTTR1]);
 
-    qemu_printf("SRP: 0x%08x\n", env->mmu.srp);
-    dump_address_map(env, env->mmu.srp);
+    monitor_printf(mon, "SRP: 0x%08x\n", env->mmu.srp);
+    dump_address_map(mon, env, env->mmu.srp);
 
-    qemu_printf("URP: 0x%08x\n", env->mmu.urp);
-    dump_address_map(env, env->mmu.urp);
+    monitor_printf(mon, "URP: 0x%08x\n", env->mmu.urp);
+    dump_address_map(mon, env, env->mmu.urp);
 }
 
 static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index be7411edca6..38f925e5b16 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -19,7 +19,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    dump_mmu(env1);
+    dump_mmu(mon, env1);
 }
 
 static const MonitorDef monitor_defs[] = {
-- 
2.53.0


