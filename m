Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D87BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDiF-0003gq-JF; Thu, 06 Jun 2024 10:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sFDiA-0003cE-87
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:03:26 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sFDi6-0003Kx-8a
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:03:25 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-79533d9fdb3so50265985a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1717682600; x=1718287400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNa4gOrXa0ai6KwAKlEBeHKsG2hf21dIDUXE5wzfxfA=;
 b=YzmrGtxGYuXF4LJ8NeJd/IhbGy7Ek4osNnKhyOATZ/Duh/jJlr++zw6EtLMV/DACYY
 syEqIAqpiBR4w9HwKKBYfUIp9l4SOBvG6F8DFC3MF1dk/N00FLU3wJmD6xqadv8BN1Ur
 eAX2OhtOalaWXtYzco6X535hraCgVzuiWsM2dbC+zyxLomD1147CUjqJ5t1NvU60P0ZS
 GCVl/DvF9frcyY+nXAYPjdNnu2PYtehwNK5TgzS/xlbs5loxgXS2BgRuEbZ9pGXSRcnI
 RmPtbic/FK4yhCJw/mcnt6NmdvcksrfYhyqmlYNrqlJBV1zAslsq1Mu2LUNa3ge8Iv5X
 5jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717682600; x=1718287400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNa4gOrXa0ai6KwAKlEBeHKsG2hf21dIDUXE5wzfxfA=;
 b=FIw3qp94P4z17fWTahLBgD+jbCJlB6E6ZhDzQCltBBkj9pGZv8hzu7tPiNE3pUlLVp
 88w1FKjjBhnUKMeuYInZUrVuHf3w3VzFRMHa9OV4DVQHjAOHpVI8V+CMA1/TrS9SfkF+
 3AejHFhAhaHHSO71Yd/7wNz8n3ZP+864ZmwC1vrPaUmrYyWrheic03QQPRX7cUh5hjc4
 GVclIxnhV9MwI51YjoNPJxesFGGsq/o9pZwAFCJAGOWciZT5VagWasj7FMjAJKqSm+ln
 zdhua8rn4avNCgpPH6rnXpcb1PqNRP9y4SpnqL/4iU2rbRjQ6LqRB+yL8x/0HbRnONap
 1bSw==
X-Gm-Message-State: AOJu0Yx5bhvSJkrnavz7rp9/U3Ve7CBfH1FaacM2YainnnyoG8RTAcfA
 NDNB16JNkeSySuK1TeFH7JJlyJsAE5Tuh/SOS/k/W37j1PXuPTWU8n+Yp/3DUGFO+IuAXA7PdZh
 GLL8rzuJ8c7a4akLtxkP0AktRZNlszwOcnejhzVZjEsqCEOmn+0L3bVMmsaxTyx7bPlj9LDIlOr
 ANr+16+PlINajVt/FPZ4fQCh9t+ax9
X-Google-Smtp-Source: AGHT+IFgZMd/QFSXBJl19iiymymrAfu+onLfKKAqiz8UMKE3Z4J9VAh8rMUME9F/rFVuyTLdh/wSTw==
X-Received: by 2002:a05:620a:17a8:b0:795:1fee:7209 with SMTP id
 af79cd13be357-7952f0d64famr467001985a.9.1717682599422; 
 Thu, 06 Jun 2024 07:03:19 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-795330b2305sm62935685a.88.2024.06.06.07.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:03:18 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v3 3/6] Convert 'info mem' to use generic iterator
Date: Thu,  6 Jun 2024 10:02:50 -0400
Message-Id: <20240606140253.2277760-4-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606140253.2277760-1-porter@cs.unc.edu>
References: <20240606140253.2277760-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x732.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 include/hw/core/sysemu-cpu-ops.h |   6 +
 include/monitor/monitor.h        |   4 +
 monitor/hmp-cmds-target.c        |   5 +-
 target/i386/cpu.c                |   1 +
 target/i386/cpu.h                |   1 +
 target/i386/monitor.c            | 354 ++++---------------------------
 6 files changed, 60 insertions(+), 311 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index bf3de3e004..3bef129460 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -250,6 +250,12 @@ typedef struct SysemuCPUOps {
     void (*mon_print_pte) (Monitor *mon, CPUArchState *env, hwaddr addr,
                            hwaddr pte);
 
+    /**
+     * @mon_print_mem: Hook called by the monitor to print a range
+     * of memory mappings in 'info mem'
+     */
+    bool (*mon_print_mem)(CPUState *cs, struct mem_print_state *state);
+
 } SysemuCPUOps;
 
 #endif /* SYSEMU_CPU_OPS_H */
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 965f5d5450..e954946ba0 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -5,6 +5,7 @@
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
 #include "exec/hwaddr.h"
+#include "hw/core/cpu.h"
 
 typedef struct MonitorHMP MonitorHMP;
 typedef struct MonitorOptions MonitorOptions;
@@ -63,4 +64,7 @@ void monitor_register_hmp_info_hrt(const char *name,
 int error_vprintf_unless_qmp(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 int error_printf_unless_qmp(const char *fmt, ...) G_GNUC_PRINTF(1, 2);
 
+int compressing_iterator(CPUState *cs, void *data, PTE_t *pte, vaddr vaddr_in,
+                         int height, int offset);
+
 #endif /* MONITOR_H */
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 3393e5ad0b..8ce37d3187 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -122,9 +122,8 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 /* Assume only called on present entries */
-static
-int compressing_iterator(CPUState *cs, void *data, PTE_t *pte,
-                         vaddr vaddr_in, int height, int offset)
+int compressing_iterator(CPUState *cs, void *data, PTE_t *pte, vaddr vaddr_in,
+                         int height, int offset)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
     struct mem_print_state *state = (struct mem_print_state *) data;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8bd6164b68..046d75f6bb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8316,6 +8316,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .mon_init_page_table_iterator = &x86_mon_init_page_table_iterator,
     .mon_info_pg_print_header = &x86_mon_info_pg_print_header,
     .mon_flush_page_print_state = &x86_mon_flush_print_pg_state,
+    .mon_print_mem = &x86_mon_print_mem,
 };
 #endif
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1346ec0033..1e463cc556 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2169,6 +2169,7 @@ void x86_mon_info_pg_print_header(Monitor *mon, struct mem_print_state *state);
 bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state);
 void x86_mon_print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
                        hwaddr pte);
+bool x86_mon_print_mem(CPUState *cs, struct mem_print_state *state);
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index ecde164857..215c018d1f 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -281,332 +281,70 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     for_each_pte(cs, &mem_print_tlb, &state, false, false);
 }
 
-static void mem_print(Monitor *mon, CPUArchState *env,
-                      hwaddr *pstart, int *plast_prot,
-                      hwaddr end, int prot)
+bool x86_mon_print_mem(CPUState *cs, struct mem_print_state *state)
 {
-    int prot1;
-    prot1 = *plast_prot;
-    if (prot != prot1) {
-        if (*pstart != -1) {
-            monitor_printf(mon, HWADDR_FMT_plx "-" HWADDR_FMT_plx " "
-                           HWADDR_FMT_plx " %c%c%c\n",
-                           addr_canonical(env, *pstart),
-                           addr_canonical(env, end),
-                           addr_canonical(env, end - *pstart),
-                           prot1 & PG_USER_MASK ? 'u' : '-',
-                           'r',
-                           prot1 & PG_RW_MASK ? 'w' : '-');
-        }
-        if (prot != 0)
-            *pstart = end;
-        else
-            *pstart = -1;
-        *plast_prot = prot;
-    }
-}
+    CPUArchState *env = state->env;
+    int i = 0;
 
-static void mem_info_32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2;
-    int prot, last_prot;
-    uint32_t pgd, pde, pte;
-    hwaddr start, end;
-
-    pgd = env->cr[3] & ~0xfff;
-    last_prot = 0;
-    start = -1;
-    for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
-        pde = le32_to_cpu(pde);
-        end = l1 << 22;
-        if (pde & PG_PRESENT_MASK) {
-            if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
-                prot = pde & (PG_USER_MASK | PG_RW_MASK | PG_PRESENT_MASK);
-                mem_print(mon, env, &start, &last_prot, end, prot);
-            } else {
-                for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
-                    pte = le32_to_cpu(pte);
-                    end = (l1 << 22) + (l2 << 12);
-                    if (pte & PG_PRESENT_MASK) {
-                        prot = pte & pde &
-                            (PG_USER_MASK | PG_RW_MASK | PG_PRESENT_MASK);
-                    } else {
-                        prot = 0;
-                    }
-                    mem_print(mon, env, &start, &last_prot, end, prot);
-                }
-            }
-        } else {
-            prot = 0;
-            mem_print(mon, env, &start, &last_prot, end, prot);
+    /* We need to figure out the lowest populated level */
+    for ( ; i < state->max_height; i++) {
+        if (state->vstart[i] != -1) {
+            break;
         }
     }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
-}
 
-static void mem_info_pae32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2, l3;
-    int prot, last_prot;
-    uint64_t pdpe, pde, pte;
-    uint64_t pdp_addr, pd_addr, pt_addr;
-    hwaddr start, end;
-
-    pdp_addr = env->cr[3] & ~0x1f;
-    last_prot = 0;
-    start = -1;
-    for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
-        pdpe = le64_to_cpu(pdpe);
-        end = l1 << 30;
-        if (pdpe & PG_PRESENT_MASK) {
-            pd_addr = pdpe & 0x3fffffffff000ULL;
-            for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
-                pde = le64_to_cpu(pde);
-                end = (l1 << 30) + (l2 << 21);
-                if (pde & PG_PRESENT_MASK) {
-                    if (pde & PG_PSE_MASK) {
-                        prot = pde & (PG_USER_MASK | PG_RW_MASK |
-                                      PG_PRESENT_MASK);
-                        mem_print(mon, env, &start, &last_prot, end, prot);
-                    } else {
-                        pt_addr = pde & 0x3fffffffff000ULL;
-                        for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
-                            pte = le64_to_cpu(pte);
-                            end = (l1 << 30) + (l2 << 21) + (l3 << 12);
-                            if (pte & PG_PRESENT_MASK) {
-                                prot = pte & pde & (PG_USER_MASK | PG_RW_MASK |
-                                                    PG_PRESENT_MASK);
-                            } else {
-                                prot = 0;
-                            }
-                            mem_print(mon, env, &start, &last_prot, end, prot);
-                        }
-                    }
-                } else {
-                    prot = 0;
-                    mem_print(mon, env, &start, &last_prot, end, prot);
-                }
-            }
-        } else {
-            prot = 0;
-            mem_print(mon, env, &start, &last_prot, end, prot);
-        }
-    }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
-}
+    hwaddr vstart = state->vstart[i];
+    hwaddr end = state->vend[i] + x86_pte_leaf_page_size(cs, i);
+    int prot = x86_pte_flags(state->ent[i]);
 
 
-#ifdef TARGET_X86_64
-static void mem_info_la48(Monitor *mon, CPUArchState *env)
-{
-    int prot, last_prot;
-    uint64_t l1, l2, l3, l4;
-    uint64_t pml4e, pdpe, pde, pte;
-    uint64_t pml4_addr, pdp_addr, pd_addr, pt_addr, start, end;
-
-    pml4_addr = env->cr[3] & 0x3fffffffff000ULL;
-    last_prot = 0;
-    start = -1;
-    for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
-        pml4e = le64_to_cpu(pml4e);
-        end = l1 << 39;
-        if (pml4e & PG_PRESENT_MASK) {
-            pdp_addr = pml4e & 0x3fffffffff000ULL;
-            for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
-                pdpe = le64_to_cpu(pdpe);
-                end = (l1 << 39) + (l2 << 30);
-                if (pdpe & PG_PRESENT_MASK) {
-                    if (pdpe & PG_PSE_MASK) {
-                        prot = pdpe & (PG_USER_MASK | PG_RW_MASK |
-                                       PG_PRESENT_MASK);
-                        prot &= pml4e;
-                        mem_print(mon, env, &start, &last_prot, end, prot);
-                    } else {
-                        pd_addr = pdpe & 0x3fffffffff000ULL;
-                        for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
-                            pde = le64_to_cpu(pde);
-                            end = (l1 << 39) + (l2 << 30) + (l3 << 21);
-                            if (pde & PG_PRESENT_MASK) {
-                                if (pde & PG_PSE_MASK) {
-                                    prot = pde & (PG_USER_MASK | PG_RW_MASK |
-                                                  PG_PRESENT_MASK);
-                                    prot &= pml4e & pdpe;
-                                    mem_print(mon, env, &start,
-                                              &last_prot, end, prot);
-                                } else {
-                                    pt_addr = pde & 0x3fffffffff000ULL;
-                                    for (l4 = 0; l4 < 512; l4++) {
-                                        cpu_physical_memory_read(pt_addr
-                                                                 + l4 * 8,
-                                                                 &pte, 8);
-                                        pte = le64_to_cpu(pte);
-                                        end = (l1 << 39) + (l2 << 30) +
-                                            (l3 << 21) + (l4 << 12);
-                                        if (pte & PG_PRESENT_MASK) {
-                                            prot = pte & (PG_USER_MASK | PG_RW_MASK |
-                                                          PG_PRESENT_MASK);
-                                            prot &= pml4e & pdpe & pde;
-                                        } else {
-                                            prot = 0;
-                                        }
-                                        mem_print(mon, env, &start,
-                                                  &last_prot, end, prot);
-                                    }
-                                }
-                            } else {
-                                prot = 0;
-                                mem_print(mon, env, &start,
-                                          &last_prot, end, prot);
-                            }
-                        }
-                    }
-                } else {
-                    prot = 0;
-                    mem_print(mon, env, &start, &last_prot, end, prot);
-                }
-            }
-        } else {
-            prot = 0;
-            mem_print(mon, env, &start, &last_prot, end, prot);
-        }
-    }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 48, 0);
+    monitor_printf(state->mon, HWADDR_FMT_plx "-" HWADDR_FMT_plx " "
+                   HWADDR_FMT_plx " %c%c%c\n",
+                   addr_canonical(env, vstart),
+                   addr_canonical(env, end),
+                   addr_canonical(env, end - vstart),
+                   prot & PG_USER_MASK ? 'u' : '-',
+                   'r',
+                   prot & PG_RW_MASK ? 'w' : '-');
+    return true;
 }
 
-static void mem_info_la57(Monitor *mon, CPUArchState *env)
+void hmp_info_mem(Monitor *mon, const QDict *qdict)
 {
-    int prot, last_prot;
-    uint64_t l0, l1, l2, l3, l4;
-    uint64_t pml5e, pml4e, pdpe, pde, pte;
-    uint64_t pml5_addr, pml4_addr, pdp_addr, pd_addr, pt_addr, start, end;
-
-    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
-    last_prot = 0;
-    start = -1;
-    for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
-        pml5e = le64_to_cpu(pml5e);
-        end = l0 << 48;
-        if (!(pml5e & PG_PRESENT_MASK)) {
-            prot = 0;
-            mem_print(mon, env, &start, &last_prot, end, prot);
-            continue;
-        }
-
-        pml4_addr = pml5e & 0x3fffffffff000ULL;
-        for (l1 = 0; l1 < 512; l1++) {
-            cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
-            pml4e = le64_to_cpu(pml4e);
-            end = (l0 << 48) + (l1 << 39);
-            if (!(pml4e & PG_PRESENT_MASK)) {
-                prot = 0;
-                mem_print(mon, env, &start, &last_prot, end, prot);
-                continue;
-            }
+    struct mem_print_state state;
+    CPUState *cs = mon_get_cpu(mon);
 
-            pdp_addr = pml4e & 0x3fffffffff000ULL;
-            for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
-                pdpe = le64_to_cpu(pdpe);
-                end = (l0 << 48) + (l1 << 39) + (l2 << 30);
-                if (pdpe & PG_PRESENT_MASK) {
-                    prot = 0;
-                    mem_print(mon, env, &start, &last_prot, end, prot);
-                    continue;
-                }
-
-                if (pdpe & PG_PSE_MASK) {
-                    prot = pdpe & (PG_USER_MASK | PG_RW_MASK |
-                            PG_PRESENT_MASK);
-                    prot &= pml5e & pml4e;
-                    mem_print(mon, env, &start, &last_prot, end, prot);
-                    continue;
-                }
-
-                pd_addr = pdpe & 0x3fffffffff000ULL;
-                for (l3 = 0; l3 < 512; l3++) {
-                    cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
-                    pde = le64_to_cpu(pde);
-                    end = (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21);
-                    if (pde & PG_PRESENT_MASK) {
-                        prot = 0;
-                        mem_print(mon, env, &start, &last_prot, end, prot);
-                        continue;
-                    }
-
-                    if (pde & PG_PSE_MASK) {
-                        prot = pde & (PG_USER_MASK | PG_RW_MASK |
-                                PG_PRESENT_MASK);
-                        prot &= pml5e & pml4e & pdpe;
-                        mem_print(mon, env, &start, &last_prot, end, prot);
-                        continue;
-                    }
-
-                    pt_addr = pde & 0x3fffffffff000ULL;
-                    for (l4 = 0; l4 < 512; l4++) {
-                        cpu_physical_memory_read(pt_addr + l4 * 8, &pte, 8);
-                        pte = le64_to_cpu(pte);
-                        end = (l0 << 48) + (l1 << 39) + (l2 << 30) +
-                            (l3 << 21) + (l4 << 12);
-                        if (pte & PG_PRESENT_MASK) {
-                            prot = pte & (PG_USER_MASK | PG_RW_MASK |
-                                    PG_PRESENT_MASK);
-                            prot &= pml5e & pml4e & pdpe & pde;
-                        } else {
-                            prot = 0;
-                        }
-                        mem_print(mon, env, &start, &last_prot, end, prot);
-                    }
-                }
-            }
-        }
+    if (!cs) {
+        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
+        return;
     }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 57, 0);
-}
-#endif /* TARGET_X86_64 */
 
-void hmp_info_mem(Monitor *mon, const QDict *qdict)
-{
-    CPUArchState *env;
+    CPUClass *cc = CPU_GET_CLASS(cs);
 
-    env = mon_get_cpu_env(mon);
-    if (!env) {
-        monitor_printf(mon, "No CPU available\n");
-        return;
+    if ((!cc->sysemu_ops->pte_child)
+        || (!cc->sysemu_ops->pte_leaf)
+        || (!cc->sysemu_ops->pte_leaf_page_size)
+        || (!cc->sysemu_ops->page_table_entries_per_node)
+        || (!cc->sysemu_ops->pte_flags)
+        || (!cc->sysemu_ops->mon_print_mem)
+        || (!cc->sysemu_ops->mon_init_page_table_iterator)) {
+        monitor_printf(mon, "Info tlb unsupported on this ISA\n");
     }
 
-    if (!(env->cr[0] & CR0_PG_MASK)) {
-        monitor_printf(mon, "PG disabled\n");
+    if (!cc->sysemu_ops->mon_init_page_table_iterator(mon, &state)) {
+        monitor_printf(mon, "Unable to initialize page table iterator\n");
         return;
     }
-    if (env->cr[4] & CR4_PAE_MASK) {
-#ifdef TARGET_X86_64
-        if (env->hflags & HF_LMA_MASK) {
-            if (env->cr[4] & CR4_LA57_MASK) {
-                mem_info_la57(mon, env);
-            } else {
-                mem_info_la48(mon, env);
-            }
-        } else
-#endif
-        {
-            mem_info_pae32(mon, env);
-        }
-    } else {
-        mem_info_32(mon, env);
-    }
+
+    state.flusher = cc->sysemu_ops->mon_print_mem;
+
+    /**
+     * We must visit interior entries to update prot
+     */
+    for_each_pte(cs, &compressing_iterator, &state, true, false);
+
+    /* Flush the last entry, if needed */
+    cc->sysemu_ops->mon_print_mem(cs, &state);
 }
 
 void hmp_mce(Monitor *mon, const QDict *qdict)
-- 
2.34.1


