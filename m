Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C1AC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKi0-0003Ln-EH; Thu, 21 Mar 2024 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKhX-0001ep-Vf
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:51:32 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKhT-0002GQ-LJ
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:51:30 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a468226e135so139422066b.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036278; x=1711641078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEjVeypd0HsLhHx5I6xlQvUNDrlh1OFz+E3SoDVtuhE=;
 b=NmZkXEncfPpTqDjB2tOcVtpg183Dh5+IAGmXqzPJg1fXEqkzsEc19g/aJFF36sx1lR
 nJny4steUB+wcYfYpsxsVLDqvIyj1aOVKyOZpjR0YsrTiOE4qWG6i8iaxSJsomEPxeO+
 12ogRM9UEmFn5VhhqaSBIpbIy5W/dBd1xWVQmGCZj9EbafNU23k5LBVFgmH46J56+FD2
 dbcRueyceq82Zgv0XwEV+wjZuO8yXSgVlhLwMCs3xEu5jHw5CyGOabHZDTWPFhdrsrd5
 +u1UhjghO3fzs4uw4lgoq/iNSd2WiOdosL6ofMGb+crq39iDnSBtgOLX+JljMT9VL39p
 JWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036278; x=1711641078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rEjVeypd0HsLhHx5I6xlQvUNDrlh1OFz+E3SoDVtuhE=;
 b=IvnyXmHpFoHrCgfPeftfVAZRkh8cgpmdUsIfJjNBt+P3LEQeMd2+O3iV8g86i5Qg/W
 9qk/tcrXz0jzwOjMqEHnuy5x0fK85zaeZ7Z16uSx7ISvGjre6/Zphq6SC7pISrbrjctq
 sUC4SMKFWOWG0qozvbyLj1QrQbD3VCTcjBHl9fVnEiRCyWbVDSkBR53VkYyGkOyLNQIN
 of5N4nFyexlzDILeepBOrqKv3roW1HzV9QHEcPO8m42JKTxPCcaevmfiAYVLd/yJ//Q8
 2PLtA1yme+ynmheBqIVflmEeHKgAoc5yD2CAGLiV7Jnl5SvWDptFDTDW+RFwhF14nsCZ
 6YNw==
X-Gm-Message-State: AOJu0Yx5ARsJCGrKqk8dcEo+0GD/1Xgg7LXKjJTvYAQeLu8Cv2+8h4WI
 H4cvRepCHAJw5iHPnvuA6WmZ+7/Oi+USzdmksRDvvRiWYpMT7GVdlGK7v0nfFSyXRey81za9zPZ
 drYY=
X-Google-Smtp-Source: AGHT+IH+u8dh6Dd3IoTEkLrunbmBXAcoyeNE0+4XZ8t2uEGI/1Fk6JyfZva3OYGVZRcd8mLZe7oLuQ==
X-Received: by 2002:a17:906:2dd1:b0:a46:ddba:56ee with SMTP id
 h17-20020a1709062dd100b00a46ddba56eemr6252093eji.4.1711036277914; 
 Thu, 21 Mar 2024 08:51:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 la8-20020a170906ad8800b00a46e92e583bsm48071ejb.149.2024.03.21.08.51.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:51:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 21/21] target/xtensa: Replace qemu_printf() by
 monitor_printf() in monitor
Date: Thu, 21 Mar 2024 16:48:37 +0100
Message-ID: <20240321154838.95771-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace qemu_printf() by monitor_printf() / monitor_puts() in monitor.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/mmu.h     |   2 +-
 target/xtensa/monitor.c | 117 ++++++++++++++++++++--------------------
 2 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/target/xtensa/mmu.h b/target/xtensa/mmu.h
index 3e1d2c03ea..ef7504e16e 100644
--- a/target/xtensa/mmu.h
+++ b/target/xtensa/mmu.h
@@ -90,6 +90,6 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
                              unsigned *access);
 
 void xtensa_reset_mmu(CPUXtensaState *env);
-void xtensa_dump_mmu(CPUXtensaState *env);
+void xtensa_dump_mmu(Monitor *mon, CPUXtensaState *env);
 
 #endif
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index 9ba068d624..1c3dc85ea1 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu/qemu-print.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
@@ -31,7 +30,7 @@
 #include "mmu.h"
 
 
-static void dump_tlb(CPUXtensaState *env, bool dtlb)
+static void dump_tlb(Monitor *mon, CPUXtensaState *env, bool dtlb)
 {
     unsigned wi, ei;
     const xtensa_tlb *conf =
@@ -40,7 +39,7 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
         xtensa_option_enabled(env->config, XTENSA_OPTION_MMU) ?
         mmu_attr_to_access : region_attr_to_access;
 
-    qemu_printf("%s:\n", dtlb ? "DTLB" : "IBLB");
+    monitor_puts(mon, dtlb ? "DTLB\n" : "IBLB\n");
     for (wi = 0; wi < conf->nways; ++wi) {
         uint32_t sz = ~xtensa_tlb_get_addr_mask(env, dtlb, wi) + 1;
         const char *sz_text;
@@ -71,35 +70,39 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
 
                 if (print_header) {
                     print_header = false;
-                    qemu_printf("Way %u (%d %s)\n", wi, sz, sz_text);
-                    qemu_printf("\tVaddr       Paddr       ASID  Attr RWX Cache\n"
-                                "\t----------  ----------  ----  ---- --- -------\n");
+                    monitor_printf(mon,
+                                   "Way %u (%d %s)\n", wi, sz, sz_text);
+                    monitor_puts(mon,
+                                 "\tVaddr       Paddr       ASID  Attr RWX Cache\n"
+                                 "\t----------  ----------  ----  ---- --- -------\n");
                 }
-                qemu_printf("\t0x%08x  0x%08x  0x%02x  0x%02x %c%c%c %s\n",
-                            entry->vaddr,
-                            entry->paddr,
-                            entry->asid,
-                            entry->attr,
-                            (access & PAGE_READ) ? 'R' : '-',
-                            (access & PAGE_WRITE) ? 'W' : '-',
-                            (access & PAGE_EXEC) ? 'X' : '-',
-                            cache_text[cache_idx] ?
-                            cache_text[cache_idx] : "Invalid");
+                monitor_printf(mon,
+                               "\t0x%08x  0x%08x  0x%02x  0x%02x %c%c%c %s\n",
+                               entry->vaddr,
+                               entry->paddr,
+                               entry->asid,
+                               entry->attr,
+                               (access & PAGE_READ) ? 'R' : '-',
+                               (access & PAGE_WRITE) ? 'W' : '-',
+                               (access & PAGE_EXEC) ? 'X' : '-',
+                               cache_text[cache_idx] ?
+                               cache_text[cache_idx] : "Invalid");
             }
         }
     }
 }
 
-static void dump_mpu(CPUXtensaState *env, const char *map_desc,
+static void dump_mpu(Monitor *mon, CPUXtensaState *env, const char *map_desc,
                      const xtensa_mpu_entry *entry, unsigned n)
 {
     unsigned i;
 
-    qemu_printf("%s map:\n", map_desc);
-    qemu_printf("\t%s  Vaddr       Attr        Ring0  Ring1  System Type    CPU cache\n"
-                "\t%s  ----------  ----------  -----  -----  -------------  ---------\n",
-                env ? "En" : "  ",
-                env ? "--" : "  ");
+    monitor_printf(mon, "%s map:\n", map_desc);
+    monitor_printf(mon,
+                   "\t%s  Vaddr       Attr        Ring0  Ring1  System Type    CPU cache\n"
+                   "\t%s  ----------  ----------  -----  -----  -------------  ---------\n",
+                   env ? "En" : "  ",
+                   env ? "--" : "  ");
 
     for (i = 0; i < n; ++i) {
         uint32_t attr = entry[i].attr;
@@ -108,64 +111,64 @@ static void dump_mpu(CPUXtensaState *env, const char *map_desc,
         unsigned type = mpu_attr_to_type(attr);
         char cpu_cache = (type & XTENSA_MPU_TYPE_CPU_CACHE) ? '-' : ' ';
 
-        qemu_printf("\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   ",
-                    env ?
-                    ((env->sregs[MPUENB] & (1u << i)) ? '+' : '-') : ' ',
-                    entry[i].vaddr, attr,
-                    (access0 & PAGE_READ) ? 'R' : '-',
-                    (access0 & PAGE_WRITE) ? 'W' : '-',
-                    (access0 & PAGE_EXEC) ? 'X' : '-',
-                    (access1 & PAGE_READ) ? 'R' : '-',
-                    (access1 & PAGE_WRITE) ? 'W' : '-',
-                    (access1 & PAGE_EXEC) ? 'X' : '-');
+        monitor_printf(mon, "\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   ",
+                       env ?
+                       ((env->sregs[MPUENB] & (1u << i)) ? '+' : '-') : ' ',
+                       entry[i].vaddr, attr,
+                       (access0 & PAGE_READ) ? 'R' : '-',
+                       (access0 & PAGE_WRITE) ? 'W' : '-',
+                       (access0 & PAGE_EXEC) ? 'X' : '-',
+                       (access1 & PAGE_READ) ? 'R' : '-',
+                       (access1 & PAGE_WRITE) ? 'W' : '-',
+                       (access1 & PAGE_EXEC) ? 'X' : '-');
 
         switch (type & XTENSA_MPU_SYSTEM_TYPE_MASK) {
         case XTENSA_MPU_SYSTEM_TYPE_DEVICE:
-            qemu_printf("Device %cB %3s\n",
-                        (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
-                        (type & XTENSA_MPU_TYPE_INT) ? "int" : "");
+            monitor_printf(mon, "Device %cB %3s\n",
+                           (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
+                           (type & XTENSA_MPU_TYPE_INT) ? "int" : "");
             break;
         case XTENSA_MPU_SYSTEM_TYPE_NC:
-            qemu_printf("Sys NC %cB      %c%c%c\n",
-                        (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
-                        (type & XTENSA_MPU_TYPE_CPU_R) ? 'r' : cpu_cache,
-                        (type & XTENSA_MPU_TYPE_CPU_W) ? 'w' : cpu_cache,
-                        (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache);
+            monitor_printf(mon, "Sys NC %cB      %c%c%c\n",
+                           (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
+                           (type & XTENSA_MPU_TYPE_CPU_R) ? 'r' : cpu_cache,
+                           (type & XTENSA_MPU_TYPE_CPU_W) ? 'w' : cpu_cache,
+                           (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache);
             break;
         case XTENSA_MPU_SYSTEM_TYPE_C:
-            qemu_printf("Sys  C %c%c%c     %c%c%c\n",
-                        (type & XTENSA_MPU_TYPE_SYS_R) ? 'R' : '-',
-                        (type & XTENSA_MPU_TYPE_SYS_W) ? 'W' : '-',
-                        (type & XTENSA_MPU_TYPE_SYS_C) ? 'C' : '-',
-                        (type & XTENSA_MPU_TYPE_CPU_R) ? 'r' : cpu_cache,
-                        (type & XTENSA_MPU_TYPE_CPU_W) ? 'w' : cpu_cache,
-                        (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache);
+            monitor_printf(mon, "Sys  C %c%c%c     %c%c%c\n",
+                           (type & XTENSA_MPU_TYPE_SYS_R) ? 'R' : '-',
+                           (type & XTENSA_MPU_TYPE_SYS_W) ? 'W' : '-',
+                           (type & XTENSA_MPU_TYPE_SYS_C) ? 'C' : '-',
+                           (type & XTENSA_MPU_TYPE_CPU_R) ? 'r' : cpu_cache,
+                           (type & XTENSA_MPU_TYPE_CPU_W) ? 'w' : cpu_cache,
+                           (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache);
             break;
         default:
-            qemu_printf("Unknown\n");
+            monitor_puts(mon, "Unknown\n");
             break;
         }
     }
 }
 
-void xtensa_dump_mmu(CPUXtensaState *env)
+void xtensa_dump_mmu(Monitor *mon, CPUXtensaState *env)
 {
     if (xtensa_option_bits_enabled(env->config,
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_MMU))) {
 
-        dump_tlb(env, false);
-        qemu_printf("\n");
-        dump_tlb(env, true);
+        dump_tlb(mon, env, false);
+        monitor_puts(mon, "\n");
+        dump_tlb(mon, env, true);
     } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
-        dump_mpu(env, "Foreground",
+        dump_mpu(mon, env, "Foreground",
                  env->mpu_fg, env->config->n_mpu_fg_segments);
-        qemu_printf("\n");
-        dump_mpu(NULL, "Background",
+        monitor_puts(mon, "\n");
+        dump_mpu(mon, NULL, "Background",
                  env->config->mpu_bg, env->config->n_mpu_bg_segments);
     } else {
-        qemu_printf("No TLB for this CPU core\n");
+        monitor_puts(mon, "No TLB for this CPU core\n");
     }
 }
 
@@ -177,5 +180,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    xtensa_dump_mmu(env1);
+    xtensa_dump_mmu(mon, env1);
 }
-- 
2.41.0


