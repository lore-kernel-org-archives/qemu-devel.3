Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D3A10987A9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3d3w-0005yJ-4y; Fri, 20 Mar 2026 12:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3l-0005qf-0B
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3g-0001Ul-8s
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:50:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43b467dcf0bso2120963f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025445; x=1774630245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMP6P39GtUY9QKw5KFD9byXsM6LV5ZDKVvl9cJpnkZg=;
 b=sYL7udV+fTuMGZR1NhWyvryAd+WAPT5s/GZySbbHYPHtVe/bseRJVdp5Ho8WrQqqba
 UPNeQne/ylpHHAc6FzChrgXd5zzqdp2ezMkLjP1dc22DBUJr9yrqRkbw15k9Jv2ZEwh8
 i7zu+ASnODBLykMw+8/85LuvyE7d+tt/cYh1k0lI2fEkuMk3wA1HXY3WWM2uG9GErPZr
 99oXLlFhp0MfEYhcao/kfsTsNDwMtH+dusA5CwpxCkzeGE7Q47vSYsVgB9jTwmsqZQp0
 yVC6lF3dwr0PoUuNBJlr/5tRDQEgEPgToUV0qH/aVq4+BPgGXIf2OprqO6fr/eacm/yt
 OtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025445; x=1774630245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMP6P39GtUY9QKw5KFD9byXsM6LV5ZDKVvl9cJpnkZg=;
 b=FdX13prvfNJ4Uv72UIbb+wq6dvLRANVtxBRk1Skl20f5g2EJy0snc3xpKNZ4jo3GaV
 wvoexqSzRlp9bcfklEIbs3U1Df+AQIYGSa9XiVSrKL2a/tsBI1D8I2m524Q4wZMme+bo
 vDu5p1S7cf3oEM6Pbg/B4wsQonVUzlZRPyVUkdEFmRHjawIPAYOPYQKu8Wpt7PJH/pd+
 UFttLWCOeZl5OotQPvEhDyD9uyuPujHtQhkmBvOERPI70dV7Z1vdmE/K2LDwF8Y+rmiF
 Ro8tNg6p6LLAD/3OcLey2X2R+gISQV1XUTQiih6Ly0xLO/22lkToByj+0CKR5bTcfl2C
 8LqA==
X-Gm-Message-State: AOJu0Yz7xMd41n6P8+Ck4P2VJb2dl0FN94Uk0sJWV3Ok9sm9TLIpw64+
 vU7aW636TJ36FWRo0rhEhbHaRgUMEqnaH42TeUuZXDki2q2BeWu7u7A7t6G1NIgkm3RxZV3POb9
 Oi0QjV2E=
X-Gm-Gg: ATEYQzxksGIBex/kKvPh1K4bRcCqKx/vr1AdsxdMiLFrn/vfmynHMl1Fn5Shc+9o0le
 ieaT63MzOqVw6zbibx+9HToFk/yvZ1ULkNeMslVOfFa7iYtYcToWJBh7uI9Udg903tRezuRjhAm
 28KL7s6bv7O5xvWhWfa+iridjVWl76nMhlNaRJuT0YaAdeFuUO5wjH1QZBG5bO23yEiP9WUmSGx
 PCdyKbpNUBwUnNHbpnvIiBXetW8TRxcqNdReKLT4Iz+pDIThowXCw0tVpncOMPjSqpsYz4WNhq8
 r9KLnRrt90OvA9TRK/u88UM+uu2d/Izcd5kiftVxsiHQ2lvQncNulKg4TN4tGjpqrLCRxNGXcim
 hYwfipigaoQwHbEvzc13IvB2uBH/lV+TdeVyTmvRCiPJRsfpCsS5Cg9+gUseEcYIqNURGyoBMQC
 NplC4FGf7ZoJv8uTt3t7KWepFMW5PgUj+0E5qDBu6o2y+Hp8ns/3Pkr3MTlaCahmegN9SqfZ0y
X-Received: by 2002:a05:600c:1383:b0:486:fbc4:8fe2 with SMTP id
 5b1f17b1804b1-486fe8fb2b2mr63111185e9.15.1774025444675; 
 Fri, 20 Mar 2026 09:50:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7e3a94sm82408645e9.7.2026.03.20.09.50.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:50:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 3/7] target/xtensa: Have 'info tlb' dump MMU
 information on monitor
Date: Fri, 20 Mar 2026 17:50:16 +0100
Message-ID: <20260320165021.39521-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320165021.39521-1-philmd@linaro.org>
References: <20260320165021.39521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Fixes: d41160a3e64 ("Sparc: implement monitor command 'info tlb'")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/cpu.h        |  2 +-
 target/xtensa/mmu_helper.c | 44 +++++++++++++++++++-------------------
 target/xtensa/monitor.c    |  2 +-
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index dfd2ceab7cf..caec22bb742 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -693,7 +693,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
         uint32_t vaddr, int is_write, int mmu_idx,
         uint32_t *paddr, uint32_t *page_size, unsigned *access);
 void reset_mmu(CPUXtensaState *env);
-void dump_mmu(CPUXtensaState *env);
+void dump_mmu(Monitor *mon, CPUXtensaState *env);
 
 static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 71330fc84b9..9dbf671228b 100644
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
@@ -1121,11 +1121,11 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
 
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
@@ -1140,12 +1140,12 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
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
@@ -1157,7 +1157,7 @@ static void dump_mpu(CPUXtensaState *env,
         unsigned type = mpu_attr_to_type(attr);
         char cpu_cache = (type & XTENSA_MPU_TYPE_CPU_CACHE) ? '-' : ' ';
 
-        qemu_printf("\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   ",
+        monitor_printf(mon, "\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   ",
                     env ?
                     ((env->sregs[MPUENB] & (1u << i)) ? '+' : '-') : ' ',
                     entry[i].vaddr, attr,
@@ -1170,19 +1170,19 @@ static void dump_mpu(CPUXtensaState *env,
 
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
@@ -1191,29 +1191,29 @@ static void dump_mpu(CPUXtensaState *env,
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
+void dump_mmu(Monitor *mon, CPUXtensaState *env)
 {
     if (xtensa_option_bits_enabled(env->config,
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_MMU))) {
 
-        qemu_printf("ITLB:\n");
-        dump_tlb(env, false);
-        qemu_printf("\nDTLB:\n");
-        dump_tlb(env, true);
+        monitor_puts(mon, "ITLB:\n");
+        dump_tlb(mon, env, false);
+        monitor_puts(mon, "\nDTLB:\n");
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
index 2af84934f83..2761735f112 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -34,5 +34,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu(env1);
+    dump_mmu(mon, env1);
 }
-- 
2.53.0


