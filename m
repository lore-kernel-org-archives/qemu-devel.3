Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F7DC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDiE-0003fV-VS; Thu, 06 Jun 2024 10:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sFDi8-0003bt-Kl
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:03:25 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sFDi4-0003Kn-OT
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:03:23 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-79525719d8dso150465785a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1717682598; x=1718287398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEccv8mK64p3z2evfJ17YOEYtBAeDr+NQk/nnQ9WN4s=;
 b=Smr0XmmjeU9Z0xGOjGariBAZtEPrw0Gzqy69UqV9oZpUucoTFcPE27jxPivQxfQ/zS
 BqMzEKikQpVwMXGk7hVtyj1wB0kj2qOq34V34PS6Ncm4ucIZQ6omGGuo8Fld104r+L74
 IsFhXcJMBo1JKFx4rImUeCw4jN2/13eBTBMMVJUzbMqsqNe5ZAhR8DExUlKUJBBoroNd
 UTysr7zAv5D98/uP/GVg7ocEO1GxyBMpM5YajfG59XL4hOVfnKUQb3sRuC3etvXxnJzO
 CtcA+6xfBGSEtDuvFnYwRGxgUM4mDA97psdmCK7fHNwUvEGnkqMylTitN3uiicblaZct
 DKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717682598; x=1718287398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEccv8mK64p3z2evfJ17YOEYtBAeDr+NQk/nnQ9WN4s=;
 b=TsdxfP6ig6kSG+M4venawx0zBtYw0A1/yW6lh2baaNpeCoApE57HmejykevJmyIFtF
 v1XgNFGUMmLl1p79kImTWCXhBliXn6tXDOrNiwkT4HLLPoBhCi5Yg355CoV3IUDWVn/3
 DTon7s9fRldjQF0itXsitQKK7YOCEpQ0hHwFYKPspRsVfrAtBXzm3BqB8hVgeAzA5iqW
 e28mVjLNmaw24DRtvbvybPlGq/DLNAWRPIfr3GeY7xtMkLUG6X7qRmQhiaATJoIVq7Q3
 AvRjdz27GyxmHSAS9O7Q9Fjcy6F2HSS43pO6FFhFND6ODFoyKySLUe6RlAm/TEXrNsBk
 e/RQ==
X-Gm-Message-State: AOJu0YyVM+1dgREroMA/Q/B4ffwlHU8ZUePsxn/Ie9FfGk+/bfM/kSdn
 oy7g5tKEyrBSJ5Tl/+w8Yd2xIgKOVMMBaoqfim+dnxc1glmHiwlTdas+7gqk9jb9MLkD7LHSdFu
 aCYnDTbBIrGiVK2oF6PoIRwwYIGHi9ki3/LxRrgehKRPXSnlNJLhoel8/yOPX5ws1TJJO2hAmnu
 v3TYLFlADgVPUkNW19fo5jZz4xrIrq
X-Google-Smtp-Source: AGHT+IFmbQzwRh679OPGUgV9Nh1aW6tDoKnaas+hH2eGn7yMmItWo72LpgG82cddm9EbYGcWrMn0Mg==
X-Received: by 2002:a05:620a:211b:b0:792:9d7c:d2b0 with SMTP id
 af79cd13be357-7952f0df307mr469222385a.15.1717682597953; 
 Thu, 06 Jun 2024 07:03:17 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-795330b2305sm62935685a.88.2024.06.06.07.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:03:17 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v3 2/6] Convert 'info tlb' to use generic iterator
Date: Thu,  6 Jun 2024 10:02:49 -0400
Message-Id: <20240606140253.2277760-3-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606140253.2277760-1-porter@cs.unc.edu>
References: <20240606140253.2277760-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x72d.google.com
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
 include/hw/core/sysemu-cpu-ops.h |   7 +
 monitor/hmp-cmds-target.c        |   1 +
 target/i386/cpu.h                |   2 +
 target/i386/monitor.c            | 217 ++++++-------------------------
 4 files changed, 53 insertions(+), 174 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index eb16a1c3e2..bf3de3e004 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -243,6 +243,13 @@ typedef struct SysemuCPUOps {
     bool (*mon_flush_page_print_state)(CPUState *cs,
                                        struct mem_print_state *state);
 
+    /**
+     * @mon_print_pte: Hook called by the monitor to print a page
+     * table entry at address addr, with contents pte.
+     */
+    void (*mon_print_pte) (Monitor *mon, CPUArchState *env, hwaddr addr,
+                           hwaddr pte);
+
 } SysemuCPUOps;
 
 #endif /* SYSEMU_CPU_OPS_H */
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 60a8bd0c37..3393e5ad0b 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -318,6 +318,7 @@ void hmp_info_pg(Monitor *mon, const QDict *qdict)
     /* Print last entry, if one present */
     cc->sysemu_ops->mon_flush_page_print_state(cs, &state);
 }
+
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
                         hwaddr addr, int is_physical)
 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cbb6f6fc4d..1346ec0033 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2167,6 +2167,8 @@ bool x86_mon_init_page_table_iterator(Monitor *mon,
                                       struct mem_print_state *state);
 void x86_mon_info_pg_print_header(Monitor *mon, struct mem_print_state *state);
 bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state);
+void x86_mon_print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
+                       hwaddr pte);
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 65e82e73e8..ecde164857 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -214,202 +214,71 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
     return addr;
 }
 
-static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
-                      hwaddr pte, hwaddr mask)
+void x86_mon_print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
+                       hwaddr pte)
 {
+    char buf[128];
+    char *pos = buf, *end = buf + sizeof(buf);
+
     addr = addr_canonical(env, addr);
 
-    monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
-                   " %c%c%c%c%c%c%c%c%c\n",
-                   addr,
-                   pte & mask,
-                   pte & PG_NX_MASK ? 'X' : '-',
-                   pte & PG_GLOBAL_MASK ? 'G' : '-',
-                   pte & PG_PSE_MASK ? 'P' : '-',
-                   pte & PG_DIRTY_MASK ? 'D' : '-',
-                   pte & PG_ACCESSED_MASK ? 'A' : '-',
-                   pte & PG_PCD_MASK ? 'C' : '-',
-                   pte & PG_PWT_MASK ? 'T' : '-',
-                   pte & PG_USER_MASK ? 'U' : '-',
-                   pte & PG_RW_MASK ? 'W' : '-');
-}
+    pos += snprintf(pos, end - pos, HWADDR_FMT_plx ": " HWADDR_FMT_plx " ",
+                    addr, (hwaddr) (pte & PG_ADDRESS_MASK));
 
-static void tlb_info_32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2;
-    uint32_t pgd, pde, pte;
+    pos += snprintf(pos, end - pos, " %s", pg_bits(pte));
 
-    pgd = env->cr[3] & ~0xfff;
-    for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
-        pde = le32_to_cpu(pde);
-        if (pde & PG_PRESENT_MASK) {
-            if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
-                /* 4M pages */
-                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
-            } else {
-                for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
-                    pte = le32_to_cpu(pte);
-                    if (pte & PG_PRESENT_MASK) {
-                        print_pte(mon, env, (l1 << 22) + (l2 << 12),
-                                  pte & ~PG_PSE_MASK,
-                                  ~0xfff);
-                    }
-                }
-            }
-        }
+    /* Trim line to fit screen */
+    if (pos - buf > 79) {
+        strcpy(buf + 77, "..");
     }
-}
 
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2, l3;
-    uint64_t pdpe, pde, pte;
-    uint64_t pdp_addr, pd_addr, pt_addr;
-
-    pdp_addr = env->cr[3] & ~0x1f;
-    for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
-        pdpe = le64_to_cpu(pdpe);
-        if (pdpe & PG_PRESENT_MASK) {
-            pd_addr = pdpe & 0x3fffffffff000ULL;
-            for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
-                pde = le64_to_cpu(pde);
-                if (pde & PG_PRESENT_MASK) {
-                    if (pde & PG_PSE_MASK) {
-                        /* 2M pages with PAE, CR4.PSE is ignored */
-                        print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
-                                  ~((hwaddr)(1 << 20) - 1));
-                    } else {
-                        pt_addr = pde & 0x3fffffffff000ULL;
-                        for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
-                            pte = le64_to_cpu(pte);
-                            if (pte & PG_PRESENT_MASK) {
-                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
-                                          + (l3 << 12),
-                                          pte & ~PG_PSE_MASK,
-                                          ~(hwaddr)0xfff);
-                            }
-                        }
-                    }
-                }
-            }
-        }
-    }
+    monitor_printf(mon, "%s\n", buf);
 }
 
-#ifdef TARGET_X86_64
-static void tlb_info_la48(Monitor *mon, CPUArchState *env,
-        uint64_t l0, uint64_t pml4_addr)
+static
+int mem_print_tlb(CPUState *cs, void *data, PTE_t *pte,
+                  vaddr vaddr_in, int height, int offset)
 {
-    uint64_t l1, l2, l3, l4;
-    uint64_t pml4e, pdpe, pde, pte;
-    uint64_t pdp_addr, pd_addr, pt_addr;
-
-    for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
-        pml4e = le64_to_cpu(pml4e);
-        if (!(pml4e & PG_PRESENT_MASK)) {
-            continue;
-        }
+    struct mem_print_state *state = (struct mem_print_state *) data;
+    CPUClass *cc = CPU_GET_CLASS(cs);
 
-        pdp_addr = pml4e & 0x3fffffffff000ULL;
-        for (l2 = 0; l2 < 512; l2++) {
-            cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
-            pdpe = le64_to_cpu(pdpe);
-            if (!(pdpe & PG_PRESENT_MASK)) {
-                continue;
-            }
-
-            if (pdpe & PG_PSE_MASK) {
-                /* 1G pages, CR4.PSE is ignored */
-                print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
-                        pdpe, 0x3ffffc0000000ULL);
-                continue;
-            }
-
-            pd_addr = pdpe & 0x3fffffffff000ULL;
-            for (l3 = 0; l3 < 512; l3++) {
-                cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
-                pde = le64_to_cpu(pde);
-                if (!(pde & PG_PRESENT_MASK)) {
-                    continue;
-                }
-
-                if (pde & PG_PSE_MASK) {
-                    /* 2M pages, CR4.PSE is ignored */
-                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
-                            (l3 << 21), pde, 0x3ffffffe00000ULL);
-                    continue;
-                }
-
-                pt_addr = pde & 0x3fffffffff000ULL;
-                for (l4 = 0; l4 < 512; l4++) {
-                    cpu_physical_memory_read(pt_addr
-                            + l4 * 8,
-                            &pte, 8);
-                    pte = le64_to_cpu(pte);
-                    if (pte & PG_PRESENT_MASK) {
-                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
-                                (l2 << 30) + (l3 << 21) + (l4 << 12),
-                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
-                    }
-                }
-            }
-        }
-    }
+    cc->sysemu_ops->mon_print_pte(state->mon, state->env, vaddr_in,
+                                  pte->pte64_t);
+    return 0;
 }
 
-static void tlb_info_la57(Monitor *mon, CPUArchState *env)
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
-    uint64_t l0;
-    uint64_t pml5e;
-    uint64_t pml5_addr;
+    struct mem_print_state state;
 
-    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
-    for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
-        pml5e = le64_to_cpu(pml5e);
-        if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
-        }
+    CPUState *cs = mon_get_cpu(mon);
+    if (!cs) {
+        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
+        return;
     }
-}
-#endif /* TARGET_X86_64 */
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
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
+        || (!cc->sysemu_ops->mon_print_pte)
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
-                tlb_info_la57(mon, env);
-            } else {
-                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL);
-            }
-        } else
-#endif
-        {
-            tlb_info_pae32(mon, env);
-        }
-    } else {
-        tlb_info_32(mon, env);
-    }
+
+    /**
+     * 'info tlb' visits only leaf PTEs marked present.
+     * It does not check other protection bits.
+     */
+    for_each_pte(cs, &mem_print_tlb, &state, false, false);
 }
 
 static void mem_print(Monitor *mon, CPUArchState *env,
-- 
2.34.1


