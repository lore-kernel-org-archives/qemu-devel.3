Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC03C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3yj-00027P-6R; Mon, 22 Jul 2024 21:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yg-0001yM-Qa
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:07 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yd-0008Pz-Kx
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:06 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3daf0e73a62so1239823b6e.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1721696762; x=1722301562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1vAWukA7skXvo38uXnn+rRVz1qXPJidwroYA3B/VcE=;
 b=NdxLX70oVFXTMZXASMkxXddfqEBTQLHYAGLFcgdppxyqt5oIl3UjrzjvHmNKltRMpm
 gWhtCMzA3V7Zyrr+fOAlU1mHBdLWP2ft1EZ9R8SO/kT45xm0qJQLc6RDkk8UhlSsS/TE
 QRhtuzWEbP311Ukz1QCdsfsHJ9IXsX6cMTg16cdbRJ0EfScwT7Pz8TIM8sMejTA3MbZ2
 Acy/rE32dsvSnUyLluxaII9WJIY4oXAXbJ4y1KyHiHijD6ruEe3CbT4Tclc0PmjgtU/Q
 laRSBZ7ehkDQx9FOOwjDGVXMQn0/l5cVRa5oN4azalIGpY5P+35rvelUQhP+5Wae3XEW
 Y2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721696762; x=1722301562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1vAWukA7skXvo38uXnn+rRVz1qXPJidwroYA3B/VcE=;
 b=QVHxpsMrypr06P4/ifJEY4nzAnQkPNnA/tb2Ok/Z+yZmRbwzEtwDgDksINSiXAcOZp
 OSMa1jlQcft2x+CMknnlzQtW1CTbs+QxIT6Czoxvv9L8aL+rZ1VfBK3YBhGQDHVHWmjY
 jV8TVmcuggj0g3T2SejuvXXVCX1NUXUbV3INhCkaw1NLRg9CFJKyXQoR/JbqyiqkWq2f
 9ES1uWmjuVRbzbA/hS4RPCzmReC+jNMoyEMNDO7AsGdjNTvBIEEDA7J5/MKrfqcub2pN
 3XrDXi5omZeTBy0TlVK2q8NqjnW1P5myt6Xeh8uKr2CgqDzAyjipxRhGJgmGdmJNLagH
 nMtw==
X-Gm-Message-State: AOJu0Yz4CDhHUcFh5C94qxTwFH6v52dDCHuy77F9UZ/1667BTyR6unKP
 YTrEwlml/VKLiCV41aFriTxTA2ZGoOreM6t0lmogdnr8hh39n6a1g5x99PuRqPzD3JrIPdJr5u8
 K8p176UdPRIDEwR4kXbqo1+pvRx1Qf45NGdoBoe9qDVpFxpt8c2cKZhFFUvifexD9cfQod4eRs1
 /CknPMH0Wkol8gMKWyzzrwQPWHCmXm
X-Google-Smtp-Source: AGHT+IFZjplj2BlS0CUke0Xi6NgQdzK8CxyQafZOIjSnguJ6OD0QAEFgeKTdGA3pumBnq++PxS+bew==
X-Received: by 2002:a05:6871:54e:b0:260:e611:c09 with SMTP id
 586e51a60fabf-2646932e43cmr1229980fac.47.1721696761536; 
 Mon, 22 Jul 2024 18:06:01 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cdc0cbdsm37953601cf.92.2024.07.22.18.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:06:01 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org, berrange@redhat.com,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v4 4/7] Convert 'info tlb' to use generic iterator.
Date: Mon, 22 Jul 2024 21:05:42 -0400
Message-Id: <20240723010545.3648706-5-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723010545.3648706-1-porter@cs.unc.edu>
References: <20240723010545.3648706-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=porter@cs.unc.edu; helo=mail-oi1-x235.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If the the guest is using nested page tables, change the output format
slightly, to first show guest virtual to guest physical, then guest
physical to host physical, as below:

(qemu) info tlb
Info guest TLB (guest virtual to guest physical):
0000008000800000: 000000000076a000  -------U-P
0000008000801000: 000000000076b000  -------U-P
0000008000802000: 000000000076c000  -------U-P
0000008000803000: 000000000076d000  -------U-P
[...]
0000008004ffd000: 0000000000ffd000  --------WP
0000008004ffe000: 0000000000ffe000  --------WP
0000008004fff000: 0000000000fff000  --------WP
Info host TLB, (guest physical to host physical):
0000000000001000: 0000000001b20000  ----XWR
0000000000002000: 0000000001b21000  ----XWR
0000000000003000: 0000000001b22000  ----XWR
0000000000004000: 0000000001b23000  ----XWR
0000000000005000: 0000000001b24000  ----XWR
[...]

Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 include/hw/core/sysemu-cpu-ops.h |   7 +
 target/i386/cpu.c                |   1 +
 target/i386/cpu.h                |   2 +
 target/i386/monitor.c            | 233 +++++++++----------------------
 4 files changed, 75 insertions(+), 168 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index d0e939def8..083df4717c 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -225,6 +225,13 @@ typedef struct SysemuCPUOps {
     bool (*mon_flush_page_print_state)(CPUState *cs,
                                        struct mem_print_state *state);
 
+    /**
+     * @mon_print_pte: Hook called by the monitor to print a page
+     * table entry at address addr, with contents pte.
+     */
+    void (*mon_print_pte) (CPUState *cs, GString *buf, hwaddr addr,
+                           hwaddr pte, uint64_t prot, int mmu_idx);
+
 } SysemuCPUOps;
 
 int compressing_iterator(CPUState *cs, void *data, DecodedPTE *pte,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ec419e0ef0..030198497a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8388,6 +8388,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .mon_init_page_table_iterator = &x86_mon_init_page_table_iterator,
     .mon_info_pg_print_header = &x86_mon_info_pg_print_header,
     .mon_flush_page_print_state = &x86_mon_flush_print_pg_state,
+    .mon_print_pte = &x86_mon_print_pte,
 };
 #endif
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4e5877f41d..413c743c1a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2264,6 +2264,8 @@ bool x86_mon_init_page_table_iterator(CPUState *cpu, GString *buf, int mmu_idx,
                                       struct mem_print_state *state);
 void x86_mon_info_pg_print_header(struct mem_print_state *state);
 bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state);
+void x86_mon_print_pte(CPUState *cs, GString *out_buf, hwaddr addr,
+                       hwaddr child, uint64_t prot, int mmu_idx);
 bool x86_ptw_translate(CPUState *cs, vaddr vaddress, hwaddr *hpa,
                        bool debug, int mmu_idx, bool user_access,
                        const MMUAccessType access_type, uint64_t *page_size,
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 8ef92e7c42..d88347684b 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -224,201 +224,98 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
     return addr;
 }
 
-static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
-                      hwaddr pte, hwaddr mask)
+void x86_mon_print_pte(CPUState *cs, GString *out_buf, hwaddr addr,
+                       hwaddr child, uint64_t prot, int mmu_idx)
 {
+    CPUX86State *env = cpu_env(cs);
+    g_autoptr(GString) buf = g_string_new("");
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
+    g_string_append_printf(buf, HWADDR_FMT_plx ": " HWADDR_FMT_plx " ",
+                           addr, child);
 
-static void tlb_info_32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2;
-    uint32_t pgd, pde, pte;
+    g_string_append_printf(buf, " %s", pg_bits(cs, prot, mmu_idx));
 
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
-    }
-}
-
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2, l3;
-    uint64_t pdpe, pde, pte;
-    uint64_t pdp_addr, pd_addr, pt_addr;
+    /* Trim line to fit screen */
+    g_string_truncate(buf, 79);
 
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
+    g_string_append_printf(out_buf, "%s\n", buf->str);
 }
 
-#ifdef TARGET_X86_64
-static void tlb_info_la48(Monitor *mon, CPUArchState *env,
-        uint64_t l0, uint64_t pml4_addr)
+static
+int mem_print_tlb(CPUState *cs, void *data, DecodedPTE *pte, int height,
+                  int offset, int mmu_idx, const PageTableLayout *layout)
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
-
-        pdp_addr = pml4e & 0x3fffffffff000ULL;
-        for (l2 = 0; l2 < 512; l2++) {
-            cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
-            pdpe = le64_to_cpu(pdpe);
-            if (!(pdpe & PG_PRESENT_MASK)) {
-                continue;
-            }
+    struct mem_print_state *state = (struct mem_print_state *) data;
+    CPUClass *cc = CPU_GET_CLASS(cs);
 
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
+    cc->sysemu_ops->mon_print_pte(cs, state->buf, pte->bits_translated,
+                                  pte->child, pte->prot, mmu_idx);
 
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
+    return 0;
 }
 
-static void tlb_info_la57(Monitor *mon, CPUArchState *env)
+static
+void helper_hmp_info_tlb(CPUState *cs, Monitor *mon, int mmu_idx)
 {
-    uint64_t l0;
-    uint64_t pml5e;
-    uint64_t pml5_addr;
+    struct mem_print_state state;
+    g_autoptr(GString) buf = g_string_new("");
+    CPUClass *cc = CPU_GET_CLASS(cs);
 
-    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
-    for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
-        pml5e = le64_to_cpu(pml5e);
-        if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
-        }
+    if (!cc->sysemu_ops->mon_init_page_table_iterator(cs, buf, mmu_idx,
+                                                      &state)) {
+        monitor_printf(mon, "Unable to initialize page table iterator\n");
+        return;
     }
+
+    /**
+     * 'info tlb' visits only leaf PTEs marked present.
+     * It does not check other protection bits.
+     */
+    for_each_pte(cs, &mem_print_tlb, &state, false, false, false,  mmu_idx);
+
+    monitor_printf(mon, "%s", buf->str);
 }
-#endif /* TARGET_X86_64 */
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
-    CPUArchState *env;
+    CPUState *cs = mon_get_cpu(mon);
+    bool nested;
 
-    env = mon_get_cpu_env(mon);
-    if (!env) {
-        monitor_printf(mon, "No CPU available\n");
+    if (!cs) {
+        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
         return;
     }
 
-    if (!(env->cr[0] & CR0_PG_MASK)) {
+    if (!cpu_paging_enabled(cs, 0)) {
         monitor_printf(mon, "PG disabled\n");
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
+
+    CPUClass *cc = CPU_GET_CLASS(cs);
+
+    if (!cc->sysemu_ops->mon_print_pte
+        || !cc->sysemu_ops->mon_init_page_table_iterator) {
+        monitor_printf(mon, "Info tlb unsupported on this ISA\n");
+        return;
+    }
+
+    nested = cpu_paging_enabled(cs, 1);
+
+    if (nested) {
+        monitor_printf(mon,
+                       "Info guest TLB (guest virtual to guest physical):\n");
+    }
+
+    helper_hmp_info_tlb(cs, mon, 0);
+
+    if (nested) {
+        monitor_printf(mon,
+                       "Info host TLB, (guest physical to host physical):\n");
+
+        helper_hmp_info_tlb(cs, mon, 1);
+
     }
 }
 
-- 
2.34.1


