Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E42C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3yl-0002Fs-BF; Mon, 22 Jul 2024 21:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yj-00028w-HI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:09 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yh-0008QO-Bu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:09 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-26106ec9336so1840097fac.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1721696765; x=1722301565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJ8HWFv9ihWOF+E22RR1hIhCiKb1NCoJ/EAF7Qw8N2w=;
 b=JH/gdf5vLxE2C/xGE/WxYi2tzZOVXezxM0pgjfaGzjbNYUDiJsiWs14qVL/lFBhYcv
 p5NpsjF9m2QlaoS9Dstm3jU2wfo5gOHq5deHIFDuWm2+AQSVgIBmsJ8ODqHBBR6TFbTE
 Ai2wxSuf0XyDbNW4hqubdFM4ytY1HqwlK374ONbf4jMqM4kXUChy9Gd3u2FYLg0o6mgw
 j0xR4qHJSLqJjeJn4QYtWL6vUwP5uARf0oauOf2yRiUGma5m0q7LTxKwGpKTbOXpapde
 z7XVUNxm51RU0RI1sbXkXhIcS5iAHypDP/54Ty8hn11semN6YIEENMMI5c4CLHPAT3/J
 vh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721696765; x=1722301565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJ8HWFv9ihWOF+E22RR1hIhCiKb1NCoJ/EAF7Qw8N2w=;
 b=brChgUkIWBmP720at3X4lw/MXPXUKCAUMv5U+Nn0JrFcpD4oYjM/tf76udWbz7iFwh
 TdSFW0l62Hca+s6E1vjGPU4I4qrV8/ygGSXjr5G3aILoOZNjxMoipzJigYgi+uikzLjf
 qK8g6rkIkEMVLgFZLzZgZOxBcojpaopXI7HBPBMiTTpQ/VVQmw32rs+Aq2Wtmtkjai1J
 7RX1FA5+DZovyRc69xxC4x1d9nQswCIqKS47MNLM7ur+WPIiLi8ixiT5vycyAQBKxsyE
 3MynHalx1eMYBk5e2Us9d9mnRi2AFwyowQAIBG0jpe1Nx/nKJnU9A0UNDmWdNzOaQ8tK
 Czjg==
X-Gm-Message-State: AOJu0YwjhPNu+GuHmxK4GQpxqr/LC8XxaBT5kjM1aTCVbkwv8FrKcxlr
 jWxX8G9SpA1BPHNq1k6vcPpDUG+nRGZukR+tkxq4YDvxpNrRrHJehyIKgcQsaDMCuyLbjC1Mpf4
 iD0Z8TkG5G1KpeEWHS2Eb7rImaR4NdTLUQwxFtZTIk7MhOr/caoR+F740qwqK3OT1epRjltW3BD
 r2U8lzE3tk4gQyvleH6Saz7lUdAvhm
X-Google-Smtp-Source: AGHT+IG3tQdAsCXld+axsJc6tuV9o09i+qPwtsqsIcdpk3J9dv22JjttraF7iwSPsGMwvU31ByGN2w==
X-Received: by 2002:a05:6870:ac25:b0:261:88b:36fe with SMTP id
 586e51a60fabf-263ab315e4emr4668266fac.15.1721696764905; 
 Mon, 22 Jul 2024 18:06:04 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cdc0cbdsm37953601cf.92.2024.07.22.18.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:06:04 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org, berrange@redhat.com,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v4 6/7] Convert x86_cpu_get_memory_mapping() to use generic
 iterators
Date: Mon, 22 Jul 2024 21:05:44 -0400
Message-Id: <20240723010545.3648706-7-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723010545.3648706-1-porter@cs.unc.edu>
References: <20240723010545.3648706-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=porter@cs.unc.edu; helo=mail-oa1-x2b.google.com
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
 target/i386/arch_memory_mapping.c | 305 ++----------------------------
 1 file changed, 19 insertions(+), 286 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index ef29e4b42f..bb97443f0f 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -1006,301 +1006,34 @@ bool x86_ptw_translate(CPUState *cs, vaddr vaddress, hwaddr *hpa,
 
 }
 
-/* PAE Paging or IA-32e Paging */
-static void walk_pte(MemoryMappingList *list, AddressSpace *as,
-                     hwaddr pte_start_addr,
-                     int32_t a20_mask, target_ulong start_line_addr)
-{
-    hwaddr pte_addr, start_paddr;
-    uint64_t pte;
-    target_ulong start_vaddr;
-    int i;
-
-    for (i = 0; i < 512; i++) {
-        pte_addr = (pte_start_addr + i * 8) & a20_mask;
-        pte = address_space_ldq(as, pte_addr, MEMTXATTRS_UNSPECIFIED, NULL);
-        if (!(pte & PG_PRESENT_MASK)) {
-            /* not present */
-            continue;
-        }
-
-        start_paddr = (pte & ~0xfff) & ~(0x1ULL << 63);
-        if (cpu_physical_memory_is_io(start_paddr)) {
-            /* I/O region */
-            continue;
-        }
-
-        start_vaddr = start_line_addr | ((i & 0x1ff) << 12);
-        memory_mapping_list_add_merge_sorted(list, start_paddr,
-                                             start_vaddr, 1 << 12);
-    }
-}
-
-/* 32-bit Paging */
-static void walk_pte2(MemoryMappingList *list, AddressSpace *as,
-                      hwaddr pte_start_addr, int32_t a20_mask,
-                      target_ulong start_line_addr)
-{
-    hwaddr pte_addr, start_paddr;
-    uint32_t pte;
-    target_ulong start_vaddr;
-    int i;
-
-    for (i = 0; i < 1024; i++) {
-        pte_addr = (pte_start_addr + i * 4) & a20_mask;
-        pte = address_space_ldl(as, pte_addr, MEMTXATTRS_UNSPECIFIED, NULL);
-        if (!(pte & PG_PRESENT_MASK)) {
-            /* not present */
-            continue;
-        }
-
-        start_paddr = pte & ~0xfff;
-        if (cpu_physical_memory_is_io(start_paddr)) {
-            /* I/O region */
-            continue;
-        }
-
-        start_vaddr = start_line_addr | ((i & 0x3ff) << 12);
-        memory_mapping_list_add_merge_sorted(list, start_paddr,
-                                             start_vaddr, 1 << 12);
-    }
-}
-
-/* PAE Paging or IA-32e Paging */
-#define PLM4_ADDR_MASK 0xffffffffff000ULL /* selects bits 51:12 */
-
-static void walk_pde(MemoryMappingList *list, AddressSpace *as,
-                     hwaddr pde_start_addr,
-                     int32_t a20_mask, target_ulong start_line_addr)
-{
-    hwaddr pde_addr, pte_start_addr, start_paddr;
-    uint64_t pde;
-    target_ulong line_addr, start_vaddr;
-    int i;
-
-    for (i = 0; i < 512; i++) {
-        pde_addr = (pde_start_addr + i * 8) & a20_mask;
-        pde = address_space_ldq(as, pde_addr, MEMTXATTRS_UNSPECIFIED, NULL);
-        if (!(pde & PG_PRESENT_MASK)) {
-            /* not present */
-            continue;
-        }
-
-        line_addr = start_line_addr | ((i & 0x1ff) << 21);
-        if (pde & PG_PSE_MASK) {
-            /* 2 MB page */
-            start_paddr = (pde & ~0x1fffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
-                /* I/O region */
-                continue;
-            }
-            start_vaddr = line_addr;
-            memory_mapping_list_add_merge_sorted(list, start_paddr,
-                                                 start_vaddr, 1 << 21);
-            continue;
-        }
-
-        pte_start_addr = (pde & PLM4_ADDR_MASK) & a20_mask;
-        walk_pte(list, as, pte_start_addr, a20_mask, line_addr);
-    }
-}
-
-/* 32-bit Paging */
-static void walk_pde2(MemoryMappingList *list, AddressSpace *as,
-                      hwaddr pde_start_addr, int32_t a20_mask,
-                      bool pse)
-{
-    hwaddr pde_addr, pte_start_addr, start_paddr, high_paddr;
-    uint32_t pde;
-    target_ulong line_addr, start_vaddr;
-    int i;
-
-    for (i = 0; i < 1024; i++) {
-        pde_addr = (pde_start_addr + i * 4) & a20_mask;
-        pde = address_space_ldl(as, pde_addr, MEMTXATTRS_UNSPECIFIED, NULL);
-        if (!(pde & PG_PRESENT_MASK)) {
-            /* not present */
-            continue;
-        }
-
-        line_addr = (((unsigned int)i & 0x3ff) << 22);
-        if ((pde & PG_PSE_MASK) && pse) {
-            /*
-             * 4 MB page:
-             * bits 39:32 are bits 20:13 of the PDE
-             * bit3 31:22 are bits 31:22 of the PDE
-             */
-            high_paddr = ((hwaddr)(pde & 0x1fe000) << 19);
-            start_paddr = (pde & ~0x3fffff) | high_paddr;
-            if (cpu_physical_memory_is_io(start_paddr)) {
-                /* I/O region */
-                continue;
-            }
-            start_vaddr = line_addr;
-            memory_mapping_list_add_merge_sorted(list, start_paddr,
-                                                 start_vaddr, 1 << 22);
-            continue;
-        }
-
-        pte_start_addr = (pde & ~0xfff) & a20_mask;
-        walk_pte2(list, as, pte_start_addr, a20_mask, line_addr);
-    }
-}
-
-/* PAE Paging */
-static void walk_pdpe2(MemoryMappingList *list, AddressSpace *as,
-                       hwaddr pdpe_start_addr, int32_t a20_mask)
-{
-    hwaddr pdpe_addr, pde_start_addr;
-    uint64_t pdpe;
-    target_ulong line_addr;
-    int i;
-
-    for (i = 0; i < 4; i++) {
-        pdpe_addr = (pdpe_start_addr + i * 8) & a20_mask;
-        pdpe = address_space_ldq(as, pdpe_addr, MEMTXATTRS_UNSPECIFIED, NULL);
-        if (!(pdpe & PG_PRESENT_MASK)) {
-            /* not present */
-            continue;
-        }
-
-        line_addr = (((unsigned int)i & 0x3) << 30);
-        pde_start_addr = (pdpe & ~0xfff) & a20_mask;
-        walk_pde(list, as, pde_start_addr, a20_mask, line_addr);
-    }
-}
+struct memory_mapping_data {
+    MemoryMappingList *list;
+};
 
-#ifdef TARGET_X86_64
-/* IA-32e Paging */
-static void walk_pdpe(MemoryMappingList *list, AddressSpace *as,
-                      hwaddr pdpe_start_addr, int32_t a20_mask,
-                      target_ulong start_line_addr)
+static int add_memory_mapping_to_list(CPUState *cs, void *data, DecodedPTE *pte,
+                                      int height, int offset, int mmu_idx,
+                                      const PageTableLayout *layout)
 {
-    hwaddr pdpe_addr, pde_start_addr, start_paddr;
-    uint64_t pdpe;
-    target_ulong line_addr, start_vaddr;
-    int i;
-
-    for (i = 0; i < 512; i++) {
-        pdpe_addr = (pdpe_start_addr + i * 8) & a20_mask;
-        pdpe = address_space_ldq(as, pdpe_addr, MEMTXATTRS_UNSPECIFIED, NULL);
-        if (!(pdpe & PG_PRESENT_MASK)) {
-            /* not present */
-            continue;
-        }
-
-        line_addr = start_line_addr | ((i & 0x1ffULL) << 30);
-        if (pdpe & PG_PSE_MASK) {
-            /* 1 GB page */
-            start_paddr = (pdpe & ~0x3fffffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
-                /* I/O region */
-                continue;
-            }
-            start_vaddr = line_addr;
-            memory_mapping_list_add_merge_sorted(list, start_paddr,
-                                                 start_vaddr, 1 << 30);
-            continue;
-        }
-
-        pde_start_addr = (pdpe & PLM4_ADDR_MASK) & a20_mask;
-        walk_pde(list, as, pde_start_addr, a20_mask, line_addr);
-    }
-}
+    struct memory_mapping_data *mm_data = (struct memory_mapping_data *) data;
 
-/* IA-32e Paging */
-static void walk_pml4e(MemoryMappingList *list, AddressSpace *as,
-                       hwaddr pml4e_start_addr, int32_t a20_mask,
-                       target_ulong start_line_addr)
-{
-    hwaddr pml4e_addr, pdpe_start_addr;
-    uint64_t pml4e;
-    target_ulong line_addr;
-    int i;
-
-    for (i = 0; i < 512; i++) {
-        pml4e_addr = (pml4e_start_addr + i * 8) & a20_mask;
-        pml4e = address_space_ldq(as, pml4e_addr, MEMTXATTRS_UNSPECIFIED,
-                                  NULL);
-        if (!(pml4e & PG_PRESENT_MASK)) {
-            /* not present */
-            continue;
-        }
+    /* In the case of nested paging, give the real, host-physical mapping. */
+    hwaddr start_paddr = pte->pte_host_addr;
+    size_t pg_size = pte->leaf_page_size;
 
-        line_addr = start_line_addr | ((i & 0x1ffULL) << 39);
-        pdpe_start_addr = (pml4e & PLM4_ADDR_MASK) & a20_mask;
-        walk_pdpe(list, as, pdpe_start_addr, a20_mask, line_addr);
+    /* This hook skips mappings for the I/O region */
+    if (cpu_physical_memory_is_io(start_paddr)) {
+        /* I/O region */
+        return 0;
     }
-}
-
-static void walk_pml5e(MemoryMappingList *list, AddressSpace *as,
-                       hwaddr pml5e_start_addr, int32_t a20_mask)
-{
-    hwaddr pml5e_addr, pml4e_start_addr;
-    uint64_t pml5e;
-    target_ulong line_addr;
-    int i;
-
-    for (i = 0; i < 512; i++) {
-        pml5e_addr = (pml5e_start_addr + i * 8) & a20_mask;
-        pml5e = address_space_ldq(as, pml5e_addr, MEMTXATTRS_UNSPECIFIED,
-                                  NULL);
-        if (!(pml5e & PG_PRESENT_MASK)) {
-            /* not present */
-            continue;
-        }
 
-        line_addr = (0x7fULL << 57) | ((i & 0x1ffULL) << 48);
-        pml4e_start_addr = (pml5e & PLM4_ADDR_MASK) & a20_mask;
-        walk_pml4e(list, as, pml4e_start_addr, a20_mask, line_addr);
-    }
+    memory_mapping_list_add_merge_sorted(mm_data->list, start_paddr,
+                                         pte->bits_translated, pg_size);
+    return 0;
 }
-#endif
 
 bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
                                 Error **errp)
 {
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
-    int32_t a20_mask;
-
-    if (!cpu_paging_enabled(cs, 0)) {
-        /* paging is disabled */
-        return true;
-    }
-
-    a20_mask = x86_get_a20_mask(env);
-    if (env->cr[4] & CR4_PAE_MASK) {
-#ifdef TARGET_X86_64
-        if (env->hflags & HF_LMA_MASK) {
-            if (env->cr[4] & CR4_LA57_MASK) {
-                hwaddr pml5e_addr;
-
-                pml5e_addr = (env->cr[3] & PLM4_ADDR_MASK) & a20_mask;
-                walk_pml5e(list, cs->as, pml5e_addr, a20_mask);
-            } else {
-                hwaddr pml4e_addr;
-
-                pml4e_addr = (env->cr[3] & PLM4_ADDR_MASK) & a20_mask;
-                walk_pml4e(list, cs->as, pml4e_addr, a20_mask,
-                        0xffffULL << 48);
-            }
-        } else
-#endif
-        {
-            hwaddr pdpe_addr;
-
-            pdpe_addr = (env->cr[3] & ~0x1f) & a20_mask;
-            walk_pdpe2(list, cs->as, pdpe_addr, a20_mask);
-        }
-    } else {
-        hwaddr pde_addr;
-        bool pse;
-
-        pde_addr = (env->cr[3] & ~0xfff) & a20_mask;
-        pse = !!(env->cr[4] & CR4_PSE_MASK);
-        walk_pde2(list, cs->as, pde_addr, a20_mask, pse);
-    }
-
-    return true;
+    return for_each_pte(cs, &add_memory_mapping_to_list, list, false, false,
+                        false, 0);
 }
-- 
2.34.1


