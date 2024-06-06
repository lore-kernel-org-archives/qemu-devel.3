Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82628C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDiF-0003gv-Vv; Thu, 06 Jun 2024 10:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sFDiB-0003cr-W2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:03:28 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sFDi8-0003L8-Cx
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:03:27 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-795186ae3e9so56924985a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1717682601; x=1718287401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxN9qpvPGsKbtPRmGWpguyLi6SlUkX8Wype7csRQ8AI=;
 b=AXfAoZVH7qJQl31YUMYNY8wVZI/qU4zU/ta2wW2m1TOSapIEvyselJxocNWL+lPtIn
 sOykzSMtyn7Sb8nI5DzwjkMAsoO7i6xJR3x89UPS80sJcavNJxqYZeFcXscR9SJxIsWY
 b9wH54iYoVF7cJPr1H8ta9DR4ST7+7IQqeB62/wcNqxlqGK3vzJhOTVVT9YDPhlCsKgy
 vugCXIPyDBYvXpZ2GyEkIdUTIXyleJi8yu0RvrFu0C4hDlZ23ayOoNuYAaCNruerprfk
 QE+iHkPjOqMhEK/tSYKi/GjSsY8WR9L/GOPsi3iAgri6mEQoFipGhp1+lzXnNLLZbDKJ
 YerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717682601; x=1718287401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxN9qpvPGsKbtPRmGWpguyLi6SlUkX8Wype7csRQ8AI=;
 b=c/QTeeU8Re4SW3RvX6dHa81MafpLgOUFTACR9AtJhFgwF7W/+pCSs7bx1ucCn07kEI
 u1Qms12VUEYRvoR1j05mPyNzqfSkRRHCFLJOWQR66CLGNzuzPV7cmSJF5VqOkdMjd7sP
 SKyV+/42fUezfbtjebqNfXBYdHUAp2SBkn/CfdfQJQWYx/fJXMRs5sm3Vmi45AWzA+Iw
 thgat8mCWFuSVurzNgqwLJ7P86RZPBIfPoJBh3Qhe/cj943/EZtVrUbz6jLwpHYAK8Xu
 gYmFPlScGi0TLm1hCCumik4OUnV7kiq/7C+OWp25MpC/eDGjs8Qm/yVNWS6UHasO7Pl2
 rtmQ==
X-Gm-Message-State: AOJu0YyL2h/ey7j+h/KVWeJgWOGAoJSz6ZGUzkyHqOlrLDLX6KizMh93
 83vOIIncag9+ZRoCNUEUXSuHyasJvvTyNADgS57Ldu+4mgmPZbkYk7xpKoHqrJP/0y68zME+DIC
 b6vCAkuwA6UlzZrOaX07U5gct+Yi6c6svwJPbkpNSvn1nWlptEtrImNU3gygzonR3vV6I1woGmu
 YIbPkgFEhM47tNWolQmHFVy/RCYr9R
X-Google-Smtp-Source: AGHT+IHemDzSNwtQ1uX9/SJWO99dK/qbboh7GY524Kovd8O9cf0BJVesUXOuFtOl6kvd303z2jwLEg==
X-Received: by 2002:a05:620a:2453:b0:792:c243:3270 with SMTP id
 af79cd13be357-79523d263f1mr748321885a.7.1717682600734; 
 Thu, 06 Jun 2024 07:03:20 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-795330b2305sm62935685a.88.2024.06.06.07.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:03:19 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v3 4/6] Convert x86_cpu_get_memory_mapping() to use generic
 iterators
Date: Thu,  6 Jun 2024 10:02:51 -0400
Message-Id: <20240606140253.2277760-5-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606140253.2277760-1-porter@cs.unc.edu>
References: <20240606140253.2277760-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x733.google.com
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
 target/i386/arch_memory_mapping.c | 320 ++++--------------------------
 1 file changed, 43 insertions(+), 277 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index 562a00b5a7..b52e98133c 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -19,6 +19,7 @@
  ************** code hook implementations for x86 ***********
  */
 
+/* PAE Paging or IA-32e Paging */
 #define PML4_ADDR_MASK 0xffffffffff000ULL /* selects bits 51:12 */
 
 /**
@@ -365,301 +366,66 @@ x86_pte_child(CPUState *cs, PTE_t *pte, int height)
     return -1;
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
+/**
+ * Back to x86 hooks
+ */
+struct memory_mapping_data {
+    MemoryMappingList *list;
+};
 
-static void walk_pde(MemoryMappingList *list, AddressSpace *as,
-                     hwaddr pde_start_addr,
-                     int32_t a20_mask, target_ulong start_line_addr)
+static int add_memory_mapping_to_list(CPUState *cs, void *data, PTE_t *pte,
+                                      vaddr vaddr_in, int height,
+                                      int offset)
 {
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
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
 
-        pte_start_addr = (pde & PLM4_ADDR_MASK) & a20_mask;
-        walk_pte(list, as, pte_start_addr, a20_mask, line_addr);
-    }
-}
+    struct memory_mapping_data *mm_data = (struct memory_mapping_data *) data;
 
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
+    hwaddr start_paddr = 0;
+    size_t pg_size = x86_pte_leaf_page_size(cs, height);
+    switch (height) {
+    case 1:
+        start_paddr = pte->pte64_t & ~0xfff;
+        if (env->cr[4] & CR4_PAE_MASK) {
+            start_paddr &= ~(0x1ULL << 63);
         }
-
-        line_addr = (((unsigned int)i & 0x3ff) << 22);
-        if ((pde & PG_PSE_MASK) && pse) {
+        break;
+    case 2:
+        if (env->cr[4] & CR4_PAE_MASK) {
+            start_paddr = (pte->pte64_t & ~0x1fffff) & ~(0x1ULL << 63);
+        } else {
+            assert(!!(env->cr[4] & CR4_PSE_MASK));
             /*
              * 4 MB page:
              * bits 39:32 are bits 20:13 of the PDE
              * bit3 31:22 are bits 31:22 of the PDE
              */
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
-
-#ifdef TARGET_X86_64
-/* IA-32e Paging */
-static void walk_pdpe(MemoryMappingList *list, AddressSpace *as,
-                      hwaddr pdpe_start_addr, int32_t a20_mask,
-                      target_ulong start_line_addr)
-{
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
+            hwaddr high_paddr = ((hwaddr)(pte->pte64_t & 0x1fe000) << 19);
+            start_paddr = (pte->pte64_t & ~0x3fffff) | high_paddr;
         }
-
-        pde_start_addr = (pdpe & PLM4_ADDR_MASK) & a20_mask;
-        walk_pde(list, as, pde_start_addr, a20_mask, line_addr);
+        break;
+    case 3:
+        /* Select bits 30--51 */
+        start_paddr = (pte->pte64_t & 0xfffffc0000000);
+        break;
+    default:
+        g_assert_not_reached();
     }
-}
-
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
 
-        line_addr = start_line_addr | ((i & 0x1ffULL) << 39);
-        pdpe_start_addr = (pml4e & PLM4_ADDR_MASK) & a20_mask;
-        walk_pdpe(list, as, pdpe_start_addr, a20_mask, line_addr);
+    /* This hook skips mappings for the I/O region */
+    if (cpu_physical_memory_is_io(start_paddr)) {
+        /* I/O region */
+        return 0;
     }
-}
 
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
-
-        line_addr = (0x7fULL << 57) | ((i & 0x1ffULL) << 48);
-        pml4e_start_addr = (pml5e & PLM4_ADDR_MASK) & a20_mask;
-        walk_pml4e(list, as, pml4e_start_addr, a20_mask, line_addr);
-    }
+    memory_mapping_list_add_merge_sorted(mm_data->list, start_paddr,
+                                         vaddr_in, pg_size);
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
-    if (!cpu_paging_enabled(cs)) {
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
+    return for_each_pte(cs, &add_memory_mapping_to_list, list, false, false);
 }
-- 
2.34.1


