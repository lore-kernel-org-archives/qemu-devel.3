Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11F9C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKhY-0001Z0-2W; Thu, 21 Mar 2024 11:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgt-0000wR-BH
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:52 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgp-000278-10
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:49 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a46dec5d00cso156135466b.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036243; x=1711641043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqft4MZU81mkCnglNplHbu0cFdrcwFTH3/wy+rtkBXE=;
 b=DlfN+nahn/vEBs4KpwZ654fRF4kZiWGzvaJlXAeYe9PkOQqLcVUwy0DRiINmfjkXNM
 xZozK4V2nYcmOpmF9LUDmouB/XoYklfTFC2+jGYiCZC8+msvxQFPF6C2m8MUXda+0jDE
 2k+K66jzqglvlxfIphRhUFieLMi6EMGoS1uPCHXAbfxSZU/wPW0Qkh+KPGl9ugSfHi9D
 zrC61cHZQV3XY+xTMoMVT/Ua48LMmgWNrceygVKZnbg/HK4b0Vaoo+yZGtUcYFWVswvy
 xkmXA9qziLe4jCkqYSA9QgVLgQhWrqqMDS0ZE6DC2mCd1IvllyMiURmYXRv/NHMrFQjD
 zCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036243; x=1711641043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqft4MZU81mkCnglNplHbu0cFdrcwFTH3/wy+rtkBXE=;
 b=Wyhck7enh8p536mWDLAEpuAH0I69Vh/32e0xBy3iKdmNbRxqa2xNuM+WEDr6rzVC9S
 0xTUvYjatOBVxcbNFAxbgm/G0WLoEPvhZaiKZAEm37BRX4knuxHVoXOEpkclcn3FD3Cc
 mUy58Ga4P1fJkyiAWFz9r6YXbmLTkQdcCXFW3B+/crSIGjfKs8TKh40ExPYV2sKxH/eO
 0JcgmY3RAaOyLkTzGXi0tfJosgQNmrZ5Nz0F0bBVAV1yWrOhsbdFjgiJMUzNMiXr09es
 WuQKecngPMAyIDMYKu46RyQUSB2iUN3VKgyV32pPmWsf7OBRM9XYy1OTXBI61llENXxO
 SiyQ==
X-Gm-Message-State: AOJu0Yzn4cDnc/yNqgwAZU/LgFrWFW6Garktofugd/wGevni0j0abOXh
 Hz5PH/RYW1H1ZzeO8vz114Zmt+n1XzTc+aGxxf5NS3qqoVstTDsVtwkcItpja338pXa6yrmLttR
 zZUM=
X-Google-Smtp-Source: AGHT+IFC+603+0zXjXAdG4HWaTIUS/dH/fvyFL+gcZp+Ho3JRr0cQ7lQy0en+QoMITehIBuIBHPe+w==
X-Received: by 2002:a17:906:cecc:b0:a46:1f6d:3047 with SMTP id
 si12-20020a170906cecc00b00a461f6d3047mr1899905ejb.4.1711036242798; 
 Thu, 21 Mar 2024 08:50:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 g27-20020a170906395b00b00a466fccbe96sm48234eje.122.2024.03.21.08.50.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:50:42 -0700 (PDT)
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
Subject: [PATCH-for-9.1 16/21] target/sparc: Replace qemu_printf() by
 monitor_printf() in monitor
Date: Thu, 21 Mar 2024 16:48:32 +0100
Message-ID: <20240321154838.95771-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Replace qemu_printf() by monitor_printf() in monitor.c.
Rename dump_mmu() as sparc_dump_mmu().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h         |   2 +-
 target/sparc/ldst_helper.c |  18 +++----
 target/sparc/mmu_helper.c  | 102 ++++++++++++++++++-------------------
 target/sparc/monitor.c     |   2 +-
 4 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f3cdd17c62..55589c8ae4 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -601,7 +601,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
-void dump_mmu(CPUSPARCState *env);
+void sparc_dump_mmu(Monitor *mon, CPUSPARCState *env);
 
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
 int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 064390d1d4..44f8b2bb7a 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -195,7 +195,7 @@ static void demap_tlb(SparcTLBEntry *tlb, target_ulong demap_addr,
             replace_tlb_entry(&tlb[i], 0, 0, env1);
 #ifdef DEBUG_MMU
             DPRINTF_MMU("%s demap invalidated entry [%02u]\n", strmmu, i);
-            dump_mmu(env1);
+            sparc_dump_mmu(env1);
 #endif
         }
     }
@@ -257,7 +257,7 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
             replace_tlb_entry(&tlb[i], tlb_tag, tlb_tte, env1);
 #ifdef DEBUG_MMU
             DPRINTF_MMU("%s lru replaced invalid entry [%i]\n", strmmu, i);
-            dump_mmu(env1);
+            sparc_dump_mmu(env1);
 #endif
             return;
         }
@@ -276,7 +276,7 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
 #ifdef DEBUG_MMU
                 DPRINTF_MMU("%s lru replaced unlocked %s entry [%i]\n",
                             strmmu, (replace_used ? "used" : "unused"), i);
-                dump_mmu(env1);
+                sparc_dump_mmu(env1);
 #endif
                 return;
             }
@@ -995,7 +995,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                 break;
             }
 #ifdef DEBUG_MMU
-            dump_mmu(env);
+            sparc_dump_mmu(env);
 #endif
         }
         break;
@@ -1050,7 +1050,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                             reg, oldreg, env->mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
-            dump_mmu(env);
+            sparc_dump_mmu(env);
 #endif
         }
         break;
@@ -1736,7 +1736,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                             PRIx64 "\n", reg, oldreg, env->immu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
-            dump_mmu(env);
+            sparc_dump_mmu(env);
 #endif
             return;
         }
@@ -1760,7 +1760,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             }
 #ifdef DEBUG_MMU
             DPRINTF_MMU("immu data access replaced entry [%i]\n", i);
-            dump_mmu(env);
+            sparc_dump_mmu(env);
 #endif
             return;
         }
@@ -1820,7 +1820,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                             PRIx64 "\n", reg, oldreg, env->dmmu.mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
-            dump_mmu(env);
+            sparc_dump_mmu(env);
 #endif
             return;
         }
@@ -1842,7 +1842,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             }
 #ifdef DEBUG_MMU
             DPRINTF_MMU("dmmu data access replaced entry [%i]\n", i);
-            dump_mmu(env);
+            sparc_dump_mmu(env);
 #endif
             return;
         }
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index ad1591d9fd..f325c9a4cc 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "qemu/qemu-print.h"
+#include "monitor/monitor.h"
 #include "trace.h"
 
 /* Sparc MMU emulation */
@@ -344,7 +344,7 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
     return 0;
 }
 
-void dump_mmu(CPUSPARCState *env)
+void sparc_dump_mmu(Monitor *mon, CPUSPARCState *env)
 {
     CPUState *cs = env_cpu(env);
     target_ulong va, va1, va2;
@@ -352,29 +352,29 @@ void dump_mmu(CPUSPARCState *env)
     hwaddr pa;
     uint32_t pde;
 
-    qemu_printf("Root ptr: " HWADDR_FMT_plx ", ctx: %d\n",
-                (hwaddr)env->mmuregs[1] << 4, env->mmuregs[2]);
+    monitor_printf(mon, "Root ptr: " HWADDR_FMT_plx ", ctx: %d\n",
+                   (hwaddr)env->mmuregs[1] << 4, env->mmuregs[2]);
     for (n = 0, va = 0; n < 256; n++, va += 16 * 1024 * 1024) {
         pde = mmu_probe(env, va, 2);
         if (pde) {
             pa = cpu_get_phys_page_debug(cs, va);
-            qemu_printf("VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
-                        " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
+            monitor_printf(mon, "VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
+                           " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
             for (m = 0, va1 = va; m < 64; m++, va1 += 256 * 1024) {
                 pde = mmu_probe(env, va1, 1);
                 if (pde) {
                     pa = cpu_get_phys_page_debug(cs, va1);
-                    qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
-                                HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\n",
-                                va1, pa, pde);
+                    monitor_printf(mon, " VA: " TARGET_FMT_lx ", PA: "
+                                   HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\n",
+                                   va1, pa, pde);
                     for (o = 0, va2 = va1; o < 64; o++, va2 += 4 * 1024) {
                         pde = mmu_probe(env, va2, 0);
                         if (pde) {
                             pa = cpu_get_phys_page_debug(cs, va2);
-                            qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
-                                        HWADDR_FMT_plx " PTE: "
-                                        TARGET_FMT_lx "\n",
-                                        va2, pa, pde);
+                            monitor_printf(mon, "  VA: " TARGET_FMT_lx ", PA: "
+                                           HWADDR_FMT_plx " PTE: "
+                                           TARGET_FMT_lx "\n",
+                                           va2, pa, pde);
                         }
                     }
                 }
@@ -777,21 +777,21 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void dump_mmu(CPUSPARCState *env)
+void sparc_dump_mmu(Monitor *mon, CPUSPARCState *env)
 {
     unsigned int i;
     const char *mask;
 
-    qemu_printf("MMU contexts: Primary: %" PRId64 ", Secondary: %"
-                PRId64 "\n",
-                env->dmmu.mmu_primary_context,
-                env->dmmu.mmu_secondary_context);
-    qemu_printf("DMMU Tag Access: %" PRIx64 ", TSB Tag Target: %" PRIx64
-                "\n", env->dmmu.tag_access, env->dmmu.tsb_tag_target);
+    monitor_printf(mon, "MMU contexts: Primary: %" PRId64 ", Secondary: %"
+                   PRId64 "\n",
+                   env->dmmu.mmu_primary_context,
+                   env->dmmu.mmu_secondary_context);
+    monitor_printf(mon, "DMMU Tag Access: %" PRIx64 ", TSB Tag Target: %" PRIx64
+                   "\n", env->dmmu.tag_access, env->dmmu.tsb_tag_target);
     if ((env->lsu & DMMU_E) == 0) {
-        qemu_printf("DMMU disabled\n");
+        monitor_printf(mon, "DMMU disabled\n");
     } else {
-        qemu_printf("DMMU dump\n");
+        monitor_printf(mon, "DMMU dump\n");
         for (i = 0; i < 64; i++) {
             switch (TTE_PGSIZE(env->dtlb[i].tte)) {
             default:
@@ -809,28 +809,28 @@ void dump_mmu(CPUSPARCState *env)
                 break;
             }
             if (TTE_IS_VALID(env->dtlb[i].tte)) {
-                qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
-                            ", %s, %s, %s, %s, ie %s, ctx %" PRId64 " %s\n",
-                            i,
-                            env->dtlb[i].tag & (uint64_t)~0x1fffULL,
-                            TTE_PA(env->dtlb[i].tte),
-                            mask,
-                            TTE_IS_PRIV(env->dtlb[i].tte) ? "priv" : "user",
-                            TTE_IS_W_OK(env->dtlb[i].tte) ? "RW" : "RO",
-                            TTE_IS_LOCKED(env->dtlb[i].tte) ?
-                            "locked" : "unlocked",
-                            TTE_IS_IE(env->dtlb[i].tte) ?
-                            "yes" : "no",
-                            env->dtlb[i].tag & (uint64_t)0x1fffULL,
-                            TTE_IS_GLOBAL(env->dtlb[i].tte) ?
-                            "global" : "local");
+                monitor_printf(mon, "[%02u] VA: %" PRIx64 ", PA: %llx"
+                               ", %s, %s, %s, %s, ie %s, ctx %" PRId64 " %s\n",
+                               i,
+                               env->dtlb[i].tag & (uint64_t)~0x1fffULL,
+                               TTE_PA(env->dtlb[i].tte),
+                               mask,
+                               TTE_IS_PRIV(env->dtlb[i].tte) ? "priv" : "user",
+                               TTE_IS_W_OK(env->dtlb[i].tte) ? "RW" : "RO",
+                               TTE_IS_LOCKED(env->dtlb[i].tte) ?
+                               "locked" : "unlocked",
+                               TTE_IS_IE(env->dtlb[i].tte) ?
+                               "yes" : "no",
+                               env->dtlb[i].tag & (uint64_t)0x1fffULL,
+                               TTE_IS_GLOBAL(env->dtlb[i].tte) ?
+                               "global" : "local");
             }
         }
     }
     if ((env->lsu & IMMU_E) == 0) {
-        qemu_printf("IMMU disabled\n");
+        monitor_printf(mon, "IMMU disabled\n");
     } else {
-        qemu_printf("IMMU dump\n");
+        monitor_printf(mon, "IMMU dump\n");
         for (i = 0; i < 64; i++) {
             switch (TTE_PGSIZE(env->itlb[i].tte)) {
             default:
@@ -848,18 +848,18 @@ void dump_mmu(CPUSPARCState *env)
                 break;
             }
             if (TTE_IS_VALID(env->itlb[i].tte)) {
-                qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
-                            ", %s, %s, %s, ctx %" PRId64 " %s\n",
-                            i,
-                            env->itlb[i].tag & (uint64_t)~0x1fffULL,
-                            TTE_PA(env->itlb[i].tte),
-                            mask,
-                            TTE_IS_PRIV(env->itlb[i].tte) ? "priv" : "user",
-                            TTE_IS_LOCKED(env->itlb[i].tte) ?
-                            "locked" : "unlocked",
-                            env->itlb[i].tag & (uint64_t)0x1fffULL,
-                            TTE_IS_GLOBAL(env->itlb[i].tte) ?
-                            "global" : "local");
+                monitor_printf(mon, "[%02u] VA: %" PRIx64 ", PA: %llx"
+                               ", %s, %s, %s, ctx %" PRId64 " %s\n",
+                               i,
+                               env->itlb[i].tag & (uint64_t)~0x1fffULL,
+                               TTE_PA(env->itlb[i].tte),
+                               mask,
+                               TTE_IS_PRIV(env->itlb[i].tte) ? "priv" : "user",
+                               TTE_IS_LOCKED(env->itlb[i].tte) ?
+                               "locked" : "unlocked",
+                               env->itlb[i].tag & (uint64_t)0x1fffULL,
+                               TTE_IS_GLOBAL(env->itlb[i].tte) ?
+                               "global" : "local");
             }
         }
     }
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 73f15aa272..4fcdf75932 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -36,7 +36,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu(env1);
+    sparc_dump_mmu(mon, env1);
 }
 
 #ifndef TARGET_SPARC64
-- 
2.41.0


