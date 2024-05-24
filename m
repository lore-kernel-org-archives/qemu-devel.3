Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074E3C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 17:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAYP1-00086S-3G; Fri, 24 May 2024 13:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYOz-00086C-QI
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:21 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sAYOw-0007Z3-4U
 for qemu-devel@nongnu.org; Fri, 24 May 2024 13:08:20 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5b2a2ef4e4cso4826788eaf.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1716570496; x=1717175296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAABzHvK46FYs1GzXkwiwwoFqpPX7zi34euYwr4q6m0=;
 b=mNSBbqhy6V/K0uaCsAMNYIr/E1lvcAC86jnAoV7e4+yMrROdlyhYmtS9UzeOGzDj7+
 jFABZQfqSd4Yxwinj5M/IBNJC6Bvye8GhoTZJoaoRVhLhlUTmNP6oSn9BXxNsqJ2zV8e
 zfvt7GBSNQLsjk9KyOwf2/qDCnywMW/oyASmW1HlXnwa0L/RMwJHS2OD0Gw2KFerGqDQ
 yOjUZQ/ZS+cKSBZtGJ8OHR77q+UiZJDKo55jQz1ejVhwLt6a6QOtwyJ/xSFAnP5QLxk2
 YdMVtmnwPVtFCFfPybH8h7ibrRfBd7RvKWoitZgPeLsb40/lKbnZ5lGiHcu5O7ktfDRd
 SRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716570496; x=1717175296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAABzHvK46FYs1GzXkwiwwoFqpPX7zi34euYwr4q6m0=;
 b=V5U1fEq4d9RcLb+suivWfvjP4lepr/AcVMw1yn678vfi/Tuj0GEmJukvUwqx8QKbvp
 2pATwnxv5aKtsVx9jLSu96KJVSFDxCI4JjTkLiLcQTZXHIqA2zKkWs8As/X9utmOYioH
 s+khVHt4rQTDmVgcvd6CDkpEHHrxrcAk6dJ00o/3AokN9jPSS5ntJ/lsw9q3W/KZio7o
 hmfbdVSvKV99eZTok95BvT8RVw8M/AaOGmmWYnQg2FgZAlhdYwPtW73fUda+braKwaXH
 C/Ma6SP5oyMuvDgHqKyh/jez5j+CbkyDJ8/wiAFxPDkTZHkBfdqBwyy3/DxhxH+ApVjE
 yaKQ==
X-Gm-Message-State: AOJu0YzQgtXG9SWsT/gxQa6aOzRNsj0cYGUTQHrfR4rrv6fHkst3i/8t
 gerLP+Adi1s6VIRa6wtViV71B5LvPlJ+aBf39y/V9G9Yp/8z0r6dQeeF5VJj9KtgkaBgSJaeho5
 RBPw1Wc0LDiPCn1C0+ZAhH+Zd0eV99M3rmmi5IPVCZAmKcia/KU4G2Z3EwgP+CakM3XHUcRb9X+
 zvQv/Xb4CsstCB0ZvC1UobI23MHFlF
X-Google-Smtp-Source: AGHT+IF82b90CUA9aSZH7RNh5p58p/P8iyNpAhjK+HRb6ErKhnIQtrsV/7s56wUl9P3xBhj0NsaV2Q==
X-Received: by 2002:a05:6359:c29:b0:18d:8cdc:13ce with SMTP id
 e5c5f4694b2df-197e50c8c88mr299929755d.2.1716570495455; 
 Fri, 24 May 2024 10:08:15 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc0f0fsm79816585a.38.2024.05.24.10.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 10:08:14 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, Don Porter <porter@cs.unc.edu>
Subject: [PATCH v2 3/6] Convert 'info mem' to use generic iterator
Date: Fri, 24 May 2024 13:07:45 -0400
Message-Id: <20240524170748.1842030-4-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524170748.1842030-1-porter@cs.unc.edu>
References: <ZiKkWCjreGOMFX5p@gallifrey>
 <20240524170748.1842030-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=porter@cs.unc.edu; helo=mail-oo1-xc34.google.com
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

Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 target/i386/monitor.c | 344 +++++-------------------------------------
 1 file changed, 35 insertions(+), 309 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index adf95edfb4..147743392d 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -480,332 +480,58 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     for_each_pte(cs, &mem_print_tlb, &state, false, false);
 }
 
-static void mem_print(Monitor *mon, CPUArchState *env,
-                      hwaddr *pstart, int *plast_prot,
-                      hwaddr end, int prot)
-{
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
-
-static void mem_info_32(Monitor *mon, CPUArchState *env)
+static
+bool mem_print(CPUState *cs, struct mem_print_state *state)
 {
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
-        }
-    }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
-}
+    CPUArchState *env = state->env;
+    int i = 0;
 
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
-
-
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
+    /* We need to figure out the lowest populated level */
+    for ( ; i < state->max_height; i++) {
+        if (state->vstart[i] != -1) {
+            break;
         }
     }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 48, 0);
-}
 
-static void mem_info_la57(Monitor *mon, CPUArchState *env)
-{
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
+    hwaddr vstart = state->vstart[i];
+    hwaddr end = state->vend[i] + mmu_pte_leaf_page_size(cs, i);
+    int prot = ent2prot(state->ent[i]);
 
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
-
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
-    }
-    /* Flush last range */
-    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 57, 0);
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
-#endif /* TARGET_X86_64 */
 
 void hmp_info_mem(Monitor *mon, const QDict *qdict)
 {
-    CPUArchState *env;
+    CPUState *cs;
+    struct mem_print_state state;
 
-    env = mon_get_cpu_env(mon);
-    if (!env) {
-        monitor_printf(mon, "No CPU available\n");
+    if (!init_iterator(mon, &state)) {
         return;
     }
+    state.flusher = mem_print;
 
-    if (!(env->cr[0] & CR0_PG_MASK)) {
-        monitor_printf(mon, "PG disabled\n");
+    cs = mon_get_cpu(mon);
+    if (!cs) {
+        monitor_printf(mon, "Unable to get CPUState.  Internal error\n");
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
+    /**
+     * We must visit interior entries to update prot
+     */
+    for_each_pte(cs, &compressing_iterator, &state, true, false);
+
+    /* Flush the last entry, if needed */
+    mem_print(cs, &state);
 }
 
 void hmp_mce(Monitor *mon, const QDict *qdict)
-- 
2.34.1


