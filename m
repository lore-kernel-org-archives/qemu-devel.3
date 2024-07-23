Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A85FC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3yk-0002EA-SY; Mon, 22 Jul 2024 21:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yi-00026D-Sd
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:08 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yf-0008QF-CW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:08 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-79f17d6be18so301940985a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1721696763; x=1722301563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmrfwWInRb+J4QwsonGZ8qptunQS8YEDUwaLiBZ/2Sk=;
 b=Yfgy9FSYxOqOBhmzJYAqdpM0yIOFFa+O0nn4ekmBMypudFJHPngOGG6gmeZW5kA5/C
 UNc7wBkScXflbiy14LQPjjMVVh5I0iofUoV+Nc0/doJ8TERBgigQEEfD//tlxtx5U4y2
 WhWi7W39WhLv9sp8hi9+7Cpm4nTiUMvWG2Y1N9Ko7IJvUsl8tGwvEohrmm8Ti1Wh36sd
 pziQ0KMzRRjoValr3sdjkqjKTJ6RM4WwD+aB8uTBeN9hfVL72FaPcTTRAbHMENuKM8GM
 WSqYI2MmCDC0CuIPx1FCaZ+cdwgU8XQwwlWC85HZPAAN8C2ExfFOqlfDTk3PPhyDmKAR
 fyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721696763; x=1722301563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmrfwWInRb+J4QwsonGZ8qptunQS8YEDUwaLiBZ/2Sk=;
 b=vTiZr5hFP/b6JcuMoUdGiKBt1empcMwnQcbhic1kofinTBkV2USHXCB3xxhxNTQ6F5
 xNwCREV+RMerWiK1oUBqqM3u7Tse+xyToo+eUpaLmJcHsW9rl79xlLpm55hLrO2gNIgq
 GMoc/Qq1Ea/vtJ9pXDAn/KzGGRPFtIjSu24g40R5Ya4edyjoJvv66pyboiRygmlGOZKl
 Qi+cno1DSKmu/AYxX3fOIa472X//Im3vQwLzOHZROHLK5tdPUVSvlE0zRSFred2rRkFj
 jjl8MkZ777bx1JgeWDmJm1kgBfwwqetwJEPC4zLKPxlcCjy209Kwb964wET5hg29KYn9
 p8YQ==
X-Gm-Message-State: AOJu0Yz1kMvkfSoAYf14cB17V+D2bTJyKA+NSIFCPFx1mqOzbkja1Vmt
 SfaDJwOMPPGkiUuXxEJTg8d9HMDS/QVjTGhPUfjV6bXSDtczGcUQaKj/35qfYZtHi5kexSnSTrD
 /68mM/2z7s0gvBehzoUtd65pkf3It6riPZzr/gke8LMnJ1cBE0Wg9s5oPEhXKKRRsp2LK1drAgK
 kBYcJgEik8xMh8dM7zHZm+RfGwtqDw
X-Google-Smtp-Source: AGHT+IFsR8LpA1/fxaN6Rf+TOkN41uoP9UAxQID1tIlbhL+UjCQY5/rLYU72gJbtzo33leUTREWT9g==
X-Received: by 2002:a05:620a:45a6:b0:7a1:c431:357b with SMTP id
 af79cd13be357-7a1c4313826mr22601085a.33.1721696763318; 
 Mon, 22 Jul 2024 18:06:03 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cdc0cbdsm37953601cf.92.2024.07.22.18.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:06:02 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org, berrange@redhat.com,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v4 5/7] Convert 'info mem' to use generic iterator
Date: Mon, 22 Jul 2024 21:05:43 -0400
Message-Id: <20240723010545.3648706-6-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723010545.3648706-1-porter@cs.unc.edu>
References: <20240723010545.3648706-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x731.google.com
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

In the case of nested paging, change the output slightly
to show both the guest's and host's view.

For example:

(qemu) info mem
Info guest mem (guest virtual to guest physical mappings):
0000008000800000-000000800085c000 000000000005c000 ur-
0000008000a00000-0000008000a10000 0000000000010000 ur-
0000008003fa8000-0000008003fb8000 0000000000010000 -rw
0000008003fc0000-0000008003fd0000 0000000000010000 -rw
0000008003fd8000-0000008003fe8000 0000000000010000 -rw
0000008003ff0000-0000008005000000 0000000001010000 -rw
Info host mem (guest physical to host physical mappings):
0000000000001000-000000000000f000 000000000000e000 -xwr
00000000000b8000-00000000000b9000 0000000000001000 -xwr
0000000000100000-0000000000108000 0000000000008000 -xwr
0000000000200000-00000000007c6000 00000000005c6000 -xwr

Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 include/hw/core/sysemu-cpu-ops.h |   6 +
 target/i386/cpu.c                |   1 +
 target/i386/cpu.h                |   1 +
 target/i386/monitor.c            | 387 +++++++------------------------
 4 files changed, 95 insertions(+), 300 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 083df4717c..f8b71fb60d 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -232,6 +232,12 @@ typedef struct SysemuCPUOps {
     void (*mon_print_pte) (CPUState *cs, GString *buf, hwaddr addr,
                            hwaddr pte, uint64_t prot, int mmu_idx);
 
+    /**
+     * @mon_print_mem: Hook called by the monitor to print a range
+     * of memory mappings in 'info mem'
+     */
+    bool (*mon_print_mem)(CPUState *cs, struct mem_print_state *state);
+
 } SysemuCPUOps;
 
 int compressing_iterator(CPUState *cs, void *data, DecodedPTE *pte,
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 030198497a..f9ca2cddd3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8389,6 +8389,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .mon_info_pg_print_header = &x86_mon_info_pg_print_header,
     .mon_flush_page_print_state = &x86_mon_flush_print_pg_state,
     .mon_print_pte = &x86_mon_print_pte,
+    .mon_print_mem = &x86_mon_print_mem,
 };
 #endif
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 413c743c1a..da565bb7da 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2266,6 +2266,7 @@ void x86_mon_info_pg_print_header(struct mem_print_state *state);
 bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state);
 void x86_mon_print_pte(CPUState *cs, GString *out_buf, hwaddr addr,
                        hwaddr child, uint64_t prot, int mmu_idx);
+bool x86_mon_print_mem(CPUState *cs, struct mem_print_state *state);
 bool x86_ptw_translate(CPUState *cs, vaddr vaddress, hwaddr *hpa,
                        bool debug, int mmu_idx, bool user_access,
                        const MMUAccessType access_type, uint64_t *page_size,
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index d88347684b..318f9b7ca2 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -319,331 +319,118 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     }
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
+    hwaddr vstart = state->vstart[i];
+    hwaddr end = state->vend[i] + state->pg_size[i];
+    int prot = state->prot[i];
+
+    if (state->mmu_idx == 0
+        || (state->mmu_idx == 1 && env->vm_state_valid
+            && env->nested_pg_format == 1)){
+
+        g_string_append_printf(state->buf, HWADDR_FMT_plx "-" HWADDR_FMT_plx " "
+                               HWADDR_FMT_plx " %c%c%c\n",
+                               addr_canonical(env, vstart),
+                               addr_canonical(env, end),
+                               addr_canonical(env, end - vstart),
+                               prot & PG_USER_MASK ? 'u' : '-',
+                               'r',
+                               prot & PG_RW_MASK ? 'w' : '-');
+        return true;
+    } else if (state->mmu_idx == 1) {
+        g_string_append_printf(state->buf, HWADDR_FMT_plx "-" HWADDR_FMT_plx " "
+                               HWADDR_FMT_plx " %c%c%c%c\n",
+                               addr_canonical(env, vstart),
+                               addr_canonical(env, end),
+                               addr_canonical(env, end - vstart),
+                               prot & PG_EPT_X_USER_MASK ? 'u' : '-',
+                               prot & PG_EPT_X_SUPER_MASK ? 'x' : '-',
+                               prot & PG_EPT_W_MASK ? 'w' : '-',
+                               prot & PG_EPT_R_MASK ? 'r' : '-');
+
+        return true;
+    } else {
+        return false;
     }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
-}
 
 
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
 }
 
-static void mem_info_la57(Monitor *mon, CPUArchState *env)
+static
+void helper_hmp_info_mem(CPUState *cs, Monitor *mon, int mmu_idx)
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
+    struct mem_print_state state;
+    g_autoptr(GString) buf = g_string_new("");
 
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
+    CPUClass *cc = CPU_GET_CLASS(cs);
 
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
+    if (!cc->sysemu_ops->mon_init_page_table_iterator(cs, buf, mmu_idx,
+                                                      &state)) {
+        monitor_printf(mon, "Unable to initialize page table iterator\n");
+        return;
     }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 57, 0);
+
+    state.flusher = cc->sysemu_ops->mon_print_mem;
+
+    /**
+     * We must visit interior entries to update prot
+     */
+    for_each_pte(cs, &compressing_iterator, &state, true, false, false,
+                 mmu_idx);
+
+    /* Flush the last entry, if needed */
+    cc->sysemu_ops->mon_print_mem(cs, &state);
+
+    monitor_printf(mon, "%s", buf->str);
 }
-#endif /* TARGET_X86_64 */
 
 void hmp_info_mem(Monitor *mon, const QDict *qdict)
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
+
+    CPUClass *cc = CPU_GET_CLASS(cs);
+
+    if (!cc->sysemu_ops->mon_print_mem
+        || !cc->sysemu_ops->mon_init_page_table_iterator) {
+        monitor_printf(mon, "Info tlb unsupported on this ISA\n");
+    }
+
+    nested = cpu_paging_enabled(cs, 1);
+
+    if (nested) {
+        monitor_printf(mon,
+                       "Info guest mem (guest virtual to guest physical mappings):\n");
+    }
+
+    helper_hmp_info_mem(cs, mon, 0);
+
+    if (nested) {
+        monitor_printf(mon,
+                       "Info host mem (guest physical to host physical mappings):\n");
+
+        helper_hmp_info_mem(cs, mon, 1);
     }
 }
 
-- 
2.34.1


