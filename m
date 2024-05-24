Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E26C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 17:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAYPD-00089s-Qr; Fri, 24 May 2024 13:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYP9-00089B-12
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:31 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYOt-0007Yu-Ef
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:29 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-792d65cd7a8so380449285a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1716570494; x=1717175294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRwvTY+4XhYfL9PJXxknJUGay/i87It9LQZF1nGxs/4=;
 b=Hg80qQqG67dsyRBxV/lf7GsXMQwykBP0qTxRPW/cHkf9DNg9rOBmsmbmv4ewLS47ND
 +3QH0PqH7clsgtLxJZw+GnZHZf6NOdNhO7N/wYYcW43QNegBiarD0WMnYhOp7zhofnTl
 S8iCKgFGBfRFME0BBdU4Vmnxoxqsn+pPUQmVb9E7+iiFAxOC3eTLtwB42oRFNRCfrLSe
 86HtMTx4EuCx8+IYz+q1Hys+vkmUsNr7FZFqdRZYCvDdBcPnRsfeE220KIOD+GW5pdc2
 lUATNXskiXvFrUvFaBQevaY+lMO2sJvvR9lS81mMa/JXtWC4Z5BU/IGjEaRhAhHKenge
 Hilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716570494; x=1717175294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QRwvTY+4XhYfL9PJXxknJUGay/i87It9LQZF1nGxs/4=;
 b=w1kIStM7FPZk621DpIfALxNaTJ5WEOB76sRzCHEAISYXI/UFUtm6fBPSRcMRvJXe56
 xBqzTQRXVSDyFeGe4986SzfY53QAx+K+5pP3bk9KZ9i/UVKEIGum38krPkeZyeIyy4pB
 BcQeGGkwlOknUvjSghCM9eQlus8Hz70hazsJ+f7jss947N3fvaFeW2uYeI5n/tplD5DT
 ZkVJK0dcVyJUSbK1WraGjBxqNMcdUnKZCeVbblmLqN4NtAE+eDGNsAMg/QyYWpVVBBJn
 xaIjTio3ju+KZuiDl5MFLijRUdaisT2f/ViBDm3UIoFzM3pqFpIB7eEqjAChHUsgdIjv
 oIXQ==
X-Gm-Message-State: AOJu0Yz1s4/uo1YUsQWYD2EBegR7adq6FDf37kA0UnE0xEysMQlHNCDU
 /fqyd3oy56z2dCoCRaTRSznBFy6BilDZBFmHAUJGBsvHgTo/Sx3O3zqHlLfbQi6c85b8WMNyLXu
 KJkhbtb6qc76LFOXCDjmP3uLJ3qSHEiSuBVgOtamOwgdywqs9WmM4m0tWny/RHpvoXY/qcQfK8/
 bRjdgiVAXKRRxLDb7dooUwh+ZgFzOC
X-Google-Smtp-Source: AGHT+IFY6hIDYWYldWjie0/4Tks4TyE+9UgFA29j6DigoUyS9kq5piLySzanGCRQDH0icKdsLVAmQw==
X-Received: by 2002:a05:620a:460e:b0:790:f696:2eb0 with SMTP id
 af79cd13be357-794ab1125ccmr339374285a.75.1716570493738; 
 Fri, 24 May 2024 10:08:13 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc0f0fsm79816585a.38.2024.05.24.10.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 10:08:13 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, Don Porter <porter@cs.unc.edu>
Subject: [PATCH v2 2/6] Convert 'info tlb' to use generic iterator
Date: Fri, 24 May 2024 13:07:44 -0400
Message-Id: <20240524170748.1842030-3-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524170748.1842030-1-porter@cs.unc.edu>
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x735.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/monitor.c | 203 ++++++------------------------------------
 1 file changed, 28 insertions(+), 175 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index d7aae99c73..adf95edfb4 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -430,201 +430,54 @@ void hmp_info_pg(Monitor *mon, const QDict *qdict)
 }
 
 static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
-                      hwaddr pte, hwaddr mask)
+                      hwaddr pte)
 {
-    addr = addr_canonical(env, addr);
-
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
+    char buf[128];
+    char *pos = buf;
 
-static void tlb_info_32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2;
-    uint32_t pgd, pde, pte;
+    addr = addr_canonical(env, addr);
 
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
+    pos += sprintf(pos, HWADDR_FMT_plx ": " HWADDR_FMT_plx " ", addr,
+                   (hwaddr) (pte & PG_ADDRESS_MASK));
 
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
-{
-    unsigned int l1, l2, l3;
-    uint64_t pdpe, pde, pte;
-    uint64_t pdp_addr, pd_addr, pt_addr;
+    pos += sprintf(pos, " %s", pg_bits(pte));
 
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
+    /* Trim line to fit screen */
+    if (pos - buf > 79) {
+        strcpy(buf + 77, "..");
     }
-}
 
-#ifdef TARGET_X86_64
-static void tlb_info_la48(Monitor *mon, CPUArchState *env,
-        uint64_t l0, uint64_t pml4_addr)
-{
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
+    monitor_printf(mon, "%s\n", buf);
 }
 
-static void tlb_info_la57(Monitor *mon, CPUArchState *env)
+static
+int mem_print_tlb(CPUState *cs, void *data, PTE_t *pte,
+                  target_ulong vaddr, int height, int offset)
 {
-    uint64_t l0;
-    uint64_t pml5e;
-    uint64_t pml5_addr;
-
-    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
-    for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
-        pml5e = le64_to_cpu(pml5e);
-        if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
-        }
-    }
+    struct mem_print_state *state = (struct mem_print_state *) data;
+    print_pte(state->mon, state->env, vaddr, pte->pte64_t);
+    return 0;
 }
-#endif /* TARGET_X86_64 */
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
-    CPUArchState *env;
+    struct mem_print_state state;
 
-    env = mon_get_cpu_env(mon);
-    if (!env) {
-        monitor_printf(mon, "No CPU available\n");
+    CPUState *cs = mon_get_cpu(mon);
+    if (!cs) {
+        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
         return;
     }
 
-    if (!(env->cr[0] & CR0_PG_MASK)) {
-        monitor_printf(mon, "PG disabled\n");
+    if (!init_iterator(mon, &state)) {
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


