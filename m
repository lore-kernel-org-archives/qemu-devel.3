Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22001098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aFS-0004jz-Sj; Fri, 20 Mar 2026 09:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3aFR-0004jn-GJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:50:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3aFP-0000zO-MC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:50:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso11784665e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774014642; x=1774619442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SU/wZb8JqLZRE/EuWEF+pAe98INuzvzERUZxV0x1Rng=;
 b=sGZtjU3YDuGT8Wrd3B08AJU17d7uJpQBLzIhG2f3Ie4wXGo/hZIZDw3130303hTTjO
 v1nGgtnkY+fY8K+Pr4i2kGHfX8vaCKiXs5AnIKiQJ99VSiiGwpO502YzAf7FIatsgzue
 YnI0gtQdcCg5+SFoeG3DW0l3m8BRom+oCWKOsyO9HCOC7n820yj07N+8F6LvPyKeq4q3
 um+0tTGmy2iZ8Vgo7urZlhQm2Vm3BzPRll94ZTMcMmoWTBeM/nIblmJQGMEztlD4IKsl
 tXA3mras6lIMRymEEXMpTtRDBkMi6KxN6sBtte1ska2hSAhMcIhEY+1Qlc6gu7GoDyJ3
 nhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774014642; x=1774619442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU/wZb8JqLZRE/EuWEF+pAe98INuzvzERUZxV0x1Rng=;
 b=N+q9GKSDGGZlOD9a2w5Egs5JG8xVZukrFaRHO4VJ87KaqRpANX2xfg4s+ixe5YMRpN
 kbimzYRV26wGRaJ7OYmF5gPjEZu0+paBejZAbSEuop+xIbkBr8bTaYjq2iT/Ip+SLoJV
 /6ZSw6Y8dWMx9ioVwn0a7/HGX1YkYRJiRzF0RYJK2ABy5ODV72Y7pVY9jaj50L0e4UoX
 YTeoGw79/Nm3kWnC2KU4Him4Ov3Q7GvoQCQn1DeyXDMPmHyCPf21E8Sb1XA2FLDIU2lp
 XytlmzoGKsbKsH/9yBOWOnvnBYvVkK7VVdwYbyGUP5htR08FwxdZ2tHuhQ57VzMzhDsQ
 cp3g==
X-Gm-Message-State: AOJu0YxsSPh7t3O2933bSkWx55CQuF6EtNwivfn6ipftyEOOe0GP80Ax
 PHav73yFgQMCIum+HYu5Y78JMWOszU4pDGFiqrp5HZBApIoxnDOuIje3T0DNjRZmxbZjBhUJAxQ
 etEtcorU=
X-Gm-Gg: ATEYQzyKPydnokRQVSbJCsnUb+AeTlu4E6GFBXeFzOvk44A/x8u1M4Osqu6dcmLXp3D
 jEh9nWegTbLBfedeAUCbTEjhNG7QMHZSBOGNsVDNFFCsziljtyMFH3R6i0Ucs+oa72bxfHgpShC
 vr4OjmuxM5TsDKc99GFpedzdUn22rzTfdb8NpDzGeyBkwWLFq0VgGVcO45/9UvyoFIcNzc/J9+7
 +GLdeyFnZ8IgmhuYG32VooBIfQBqszGPs5V3nV087UdUcToLZ0KKgzTDInIqfo3KNMa1xU36SNd
 nUSm+5SIoWDf6M3zPXgU4cHsw46UMzZ8m5JixxQqUYwCC6bx8sTUJOgeCwuHa/cFXEcicOUs2DH
 5LcS05zx0TENJYutBEBs9j5st7+J6HG615Paw5b0GS9lkxFxmqGV4Ey0+U8lRq72Xi6C32LgnHq
 9xDIUQLf9DK2Q1AcKDBHXXW1+CNAkIQ8rOndw99UNX0PW+CF7jo+zV+I3HpO9YLV2ZVvna5bwE
X-Received: by 2002:a05:600c:35c4:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-486fee31e63mr53716515e9.28.1774014641462; 
 Fri, 20 Mar 2026 06:50:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fa35b147sm121198045e9.15.2026.03.20.06.50.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 06:50:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1] target/xtensa: Have 'info tlb' dump MMU information
 on monitor
Date: Fri, 20 Mar 2026 14:50:39 +0100
Message-ID: <20260320135039.26546-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Currently 'info tlb' dumps the MMU information on stdout.
Propagate the @Monitor argument and replace qemu_printf()
by monitor_printf() to dump information over the monitor
(which is not always stdout).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.h        |  2 +-
 target/xtensa/mmu_helper.c | 44 ++++++++++++++++++--------------------
 target/xtensa/monitor.c    |  2 +-
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 22192924841..2e56e337022 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -694,7 +694,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
         uint32_t vaddr, int is_write, int mmu_idx,
         uint32_t *paddr, uint32_t *page_size, unsigned *access);
 void reset_mmu(CPUXtensaState *env);
-void dump_mmu(CPUXtensaState *env);
+void xtensa_monitor_dump_mmu(Monitor *mon, CPUXtensaState *env);
 
 static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 71330fc84b9..766fe60e2eb 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -27,7 +27,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/qemu-print.h"
 #include "qemu/units.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
@@ -38,6 +37,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
+#include "monitor/monitor.h"
 
 #define XTENSA_MPU_SEGMENT_MASK 0x0000001f
 #define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
@@ -1082,7 +1082,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
     }
 }
 
-static void dump_tlb(CPUXtensaState *env, bool dtlb)
+static void dump_tlb(Monitor *mon, CPUXtensaState *env, bool dtlb)
 {
     unsigned wi, ei;
     const xtensa_tlb *conf =
@@ -1091,6 +1091,7 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
         xtensa_option_enabled(env->config, XTENSA_OPTION_MMU) ?
         mmu_attr_to_access : region_attr_to_access;
 
+    monitor_printf(mon, "\n%cTLB:\n", dtlb ? 'D' : 'I');
     for (wi = 0; wi < conf->nways; ++wi) {
         uint32_t sz = ~xtensa_tlb_get_addr_mask(env, dtlb, wi) + 1;
         const char *sz_text;
@@ -1121,11 +1122,11 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
 
                 if (print_header) {
                     print_header = false;
-                    qemu_printf("Way %u (%d %s)\n", wi, sz, sz_text);
-                    qemu_printf("\tVaddr       Paddr       ASID  Attr RWX Cache\n"
+                    monitor_printf(mon, "Way %u (%d %s)\n", wi, sz, sz_text);
+                    monitor_puts(mon, "\tVaddr       Paddr       ASID  Attr RWX Cache\n"
                                 "\t----------  ----------  ----  ---- --- -------\n");
                 }
-                qemu_printf("\t0x%08x  0x%08x  0x%02x  0x%02x %c%c%c %s\n",
+                monitor_printf(mon, "\t0x%08x  0x%08x  0x%02x  0x%02x %c%c%c %s\n",
                             entry->vaddr,
                             entry->paddr,
                             entry->asid,
@@ -1140,12 +1141,12 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
     }
 }
 
-static void dump_mpu(CPUXtensaState *env,
+static void dump_mpu(Monitor *mon, CPUXtensaState *env,
                      const xtensa_mpu_entry *entry, unsigned n)
 {
     unsigned i;
 
-    qemu_printf("\t%s  Vaddr       Attr        Ring0  Ring1  System Type    CPU cache\n"
+    monitor_printf(mon, "\t%s  Vaddr       Attr        Ring0  Ring1  System Type    CPU cache\n"
                 "\t%s  ----------  ----------  -----  -----  -------------  ---------\n",
                 env ? "En" : "  ",
                 env ? "--" : "  ");
@@ -1157,7 +1158,7 @@ static void dump_mpu(CPUXtensaState *env,
         unsigned type = mpu_attr_to_type(attr);
         char cpu_cache = (type & XTENSA_MPU_TYPE_CPU_CACHE) ? '-' : ' ';
 
-        qemu_printf("\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   ",
+        monitor_printf(mon, "\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   ",
                     env ?
                     ((env->sregs[MPUENB] & (1u << i)) ? '+' : '-') : ' ',
                     entry[i].vaddr, attr,
@@ -1170,19 +1171,19 @@ static void dump_mpu(CPUXtensaState *env,
 
         switch (type & XTENSA_MPU_SYSTEM_TYPE_MASK) {
         case XTENSA_MPU_SYSTEM_TYPE_DEVICE:
-            qemu_printf("Device %cB %3s\n",
+            monitor_printf(mon, "Device %cB %3s\n",
                         (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
                         (type & XTENSA_MPU_TYPE_INT) ? "int" : "");
             break;
         case XTENSA_MPU_SYSTEM_TYPE_NC:
-            qemu_printf("Sys NC %cB      %c%c%c\n",
+            monitor_printf(mon, "Sys NC %cB      %c%c%c\n",
                         (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
                         (type & XTENSA_MPU_TYPE_CPU_R) ? 'r' : cpu_cache,
                         (type & XTENSA_MPU_TYPE_CPU_W) ? 'w' : cpu_cache,
                         (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache);
             break;
         case XTENSA_MPU_SYSTEM_TYPE_C:
-            qemu_printf("Sys  C %c%c%c     %c%c%c\n",
+            monitor_printf(mon, "Sys  C %c%c%c     %c%c%c\n",
                         (type & XTENSA_MPU_TYPE_SYS_R) ? 'R' : '-',
                         (type & XTENSA_MPU_TYPE_SYS_W) ? 'W' : '-',
                         (type & XTENSA_MPU_TYPE_SYS_C) ? 'C' : '-',
@@ -1191,29 +1192,26 @@ static void dump_mpu(CPUXtensaState *env,
                         (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache);
             break;
         default:
-            qemu_printf("Unknown\n");
+            monitor_puts(mon, "Unknown\n");
             break;
         }
     }
 }
 
-void dump_mmu(CPUXtensaState *env)
+void xtensa_monitor_dump_mmu(Monitor *mon, CPUXtensaState *env)
 {
     if (xtensa_option_bits_enabled(env->config,
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_MMU))) {
-
-        qemu_printf("ITLB:\n");
-        dump_tlb(env, false);
-        qemu_printf("\nDTLB:\n");
-        dump_tlb(env, true);
+        dump_tlb(mon, env, false);
+        dump_tlb(mon, env, true);
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
-        qemu_printf("Foreground map:\n");
-        dump_mpu(env, env->mpu_fg, env->config->n_mpu_fg_segments);
-        qemu_printf("\nBackground map:\n");
-        dump_mpu(NULL, env->config->mpu_bg, env->config->n_mpu_bg_segments);
+        monitor_puts(mon, "Foreground map:\n");
+        dump_mpu(mon, env, env->mpu_fg, env->config->n_mpu_fg_segments);
+        monitor_puts(mon, "\nBackground map:\n");
+        dump_mpu(mon, NULL, env->config->mpu_bg, env->config->n_mpu_bg_segments);
     } else {
-        qemu_printf("No TLB for this CPU core\n");
+        monitor_puts(mon, "No TLB for this CPU core\n");
     }
 }
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index fbf60d55530..2eb7997a011 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -35,5 +35,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu(env1);
+    xtensa_monitor_dump_mmu(mon, env1);
 }
-- 
2.53.0


