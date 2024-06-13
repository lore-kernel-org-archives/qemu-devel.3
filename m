Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85AAC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo8u-0000i2-Rx; Thu, 13 Jun 2024 13:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8s-0000h3-F1
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8p-0005qw-M5
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:42 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b594deeso12640745ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299298; x=1718904098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqV+FTdks629tRLYY2/KOwi0BH2MUvvBEyqzi/F68NU=;
 b=Lg4alNEumLU/Cvk9bGSce9I30DV+hc8CgtHmOH4UReTjsueh+5fLIDfV9f+GGn/zlv
 SHQi9i/R51VrnYqkWvCzTCIVwZxicfsuh1xpWk25murNv6gvLJbM9AgzVlif4SuvianC
 aGBL4zZPW/T1Fr2VZmqn7S7m5JeFizHrqlIAcMn5lB2fWz+Rv4LxWvjc2Ex3YVmSfrBw
 nINxC3c4Sk46PnFu0vs7/eZdeFkWIzTzOJLhWgj4oEm4k0bJKm9MrQVEhlgXIGjpWIoU
 g+uba2gcVw3te04kEO0gz8+7Jwa/rp4OIAwPn0/ZFRuf5a8g72RNWNiYt4IyWAFZUnO7
 PV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299298; x=1718904098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqV+FTdks629tRLYY2/KOwi0BH2MUvvBEyqzi/F68NU=;
 b=iypnqJs3n2gKki4St36nirPQv4uH0/hEEJ0o/Up204gQhCb3K32CdJnelwmkzFDP/1
 hjBVNAoDweQO82mGmahOUnuAOrQOgTQO45c3IW/2P6t48i1Vpq8KpoIbONVPa/9OBkiq
 j9PjxDzQlOKDaPegzo3KNxK3qhoTbaUBs/qCbZalV9RW3v06s6I1OkWw+3Wmi9rUSVDV
 jchidP2vzSRiaJJOzYP/UUmrq5JJbcS/mPhBwszu/Du1/rCREX8aUjMvubZsjeautAOP
 fYkwdPrZ6DIQaXmTzcvBVBCv4RVujvq405oz6Mn86nBSW4+lhx6BKGV9o3z4exnTMk+2
 doeg==
X-Gm-Message-State: AOJu0YxWIFSUc2kPqq+mCWh0UHRSNOaz/QXB160LkiV42kblAIQfxckf
 dw5gF99GThO28yBD6worqKAdace1PtGsG3X+LM8fm6Ytxuvx0+LWXm6GsOVylSgpqeS6JzZhF3A
 S
X-Google-Smtp-Source: AGHT+IHOJSAJueuBWfIfVgpTObAJpS+vtwEE8VcOhWPvgMZdnZX9T362Qcuxf+bg0UlZbyBw6Mh/zg==
X-Received: by 2002:a17:902:ec8a:b0:1f6:fcd9:5b86 with SMTP id
 d9443c01a7336-1f8625c35a8mr3951595ad.12.1718299297257; 
 Thu, 13 Jun 2024 10:21:37 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5b85bsm16443885ad.32.2024.06.13.10.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:21:36 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 5/9] target/arm: Make some MTE helpers widely available
Date: Thu, 13 Jun 2024 17:20:59 +0000
Message-Id: <20240613172103.2987519-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613172103.2987519-1-gustavo.romero@linaro.org>
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
available to other subsystems by moving them from mte_helper.c to a new
header file, mte_helper.h.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/tcg/mte_helper.c | 184 +------------------------------
 target/arm/tcg/mte_helper.h | 211 ++++++++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+), 183 deletions(-)
 create mode 100644 target/arm/tcg/mte_helper.h

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a50d576294..da639282e6 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -29,6 +29,7 @@
 #include "hw/core/tcg-cpu-ops.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
+#include "mte_helper.h"
 
 
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
@@ -50,176 +51,6 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
-/**
- * allocation_tag_mem_probe:
- * @env: the cpu environment
- * @ptr_mmu_idx: the addressing regime to use for the virtual address
- * @ptr: the virtual address for which to look up tag memory
- * @ptr_access: the access to use for the virtual address
- * @ptr_size: the number of bytes in the normal memory access
- * @tag_access: the access to use for the tag memory
- * @probe: true to merely probe, never taking an exception
- * @ra: the return address for exception handling
- *
- * Our tag memory is formatted as a sequence of little-endian nibbles.
- * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
- * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
- * for the higher addr.
- *
- * Here, resolve the physical address from the virtual address, and return
- * a pointer to the corresponding tag byte.
- *
- * If there is no tag storage corresponding to @ptr, return NULL.
- *
- * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
- * three options:
- * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
- *     accessible, and do not take watchpoint traps. The calling code must
- *     handle those cases in the right priority compared to MTE traps.
- * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
- *     that the page is going to be accessible. We will take watchpoint traps.
- * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
- *     traps and watchpoint traps.
- * (probe = true, ra != 0 is invalid and will assert.)
- */
-static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
-                                         uint64_t ptr, MMUAccessType ptr_access,
-                                         int ptr_size, MMUAccessType tag_access,
-                                         bool probe, uintptr_t ra)
-{
-#ifdef CONFIG_USER_ONLY
-    uint64_t clean_ptr = useronly_clean_ptr(ptr);
-    int flags = page_get_flags(clean_ptr);
-    uint8_t *tags;
-    uintptr_t index;
-
-    assert(!(probe && ra));
-
-    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
-        if (probe) {
-            return NULL;
-        }
-        cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
-                              !(flags & PAGE_VALID), ra);
-    }
-
-    /* Require both MAP_ANON and PROT_MTE for the page. */
-    if (!(flags & PAGE_ANON) || !(flags & PAGE_MTE)) {
-        return NULL;
-    }
-
-    tags = page_get_target_data(clean_ptr);
-
-    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
-                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
-    return tags + index;
-#else
-    CPUTLBEntryFull *full;
-    MemTxAttrs attrs;
-    int in_page, flags;
-    hwaddr ptr_paddr, tag_paddr, xlat;
-    MemoryRegion *mr;
-    ARMASIdx tag_asi;
-    AddressSpace *tag_as;
-    void *host;
-
-    /*
-     * Probe the first byte of the virtual address.  This raises an
-     * exception for inaccessible pages, and resolves the virtual address
-     * into the softmmu tlb.
-     *
-     * When RA == 0, this is either a pure probe or a no-fault-expected probe.
-     * Indicate to probe_access_flags no-fault, then either return NULL
-     * for the pure probe, or assert that we received a valid page for the
-     * no-fault-expected probe.
-     */
-    flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
-                              ra == 0, &host, &full, ra);
-    if (probe && (flags & TLB_INVALID_MASK)) {
-        return NULL;
-    }
-    assert(!(flags & TLB_INVALID_MASK));
-
-    /* If the virtual page MemAttr != Tagged, access unchecked. */
-    if (full->extra.arm.pte_attrs != 0xf0) {
-        return NULL;
-    }
-
-    /*
-     * If not backed by host ram, there is no tag storage: access unchecked.
-     * This is probably a guest os bug though, so log it.
-     */
-    if (unlikely(flags & TLB_MMIO)) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
-                      "but is not backed by host ram\n", ptr);
-        return NULL;
-    }
-
-    /*
-     * Remember these values across the second lookup below,
-     * which may invalidate this pointer via tlb resize.
-     */
-    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
-    attrs = full->attrs;
-    full = NULL;
-
-    /*
-     * The Normal memory access can extend to the next page.  E.g. a single
-     * 8-byte access to the last byte of a page will check only the last
-     * tag on the first page.
-     * Any page access exception has priority over tag check exception.
-     */
-    in_page = -(ptr | TARGET_PAGE_MASK);
-    if (unlikely(ptr_size > in_page)) {
-        flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
-                                   ptr_mmu_idx, ra == 0, &host, &full, ra);
-        assert(!(flags & TLB_INVALID_MASK));
-    }
-
-    /* Any debug exception has priority over a tag check exception. */
-    if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
-        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
-        assert(ra != 0);
-        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
-    }
-
-    /* Convert to the physical address in tag space.  */
-    tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
-
-    /* Look up the address in tag space. */
-    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
-    tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
-    mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
-                                 tag_access == MMU_DATA_STORE, attrs);
-
-    /*
-     * Note that @mr will never be NULL.  If there is nothing in the address
-     * space at @tag_paddr, the translation will return the unallocated memory
-     * region.  For our purposes, the result must be ram.
-     */
-    if (unlikely(!memory_region_is_ram(mr))) {
-        /* ??? Failure is a board configuration error. */
-        qemu_log_mask(LOG_UNIMP,
-                      "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
-                      "Normal Memory @ 0x%" HWADDR_PRIx "\n",
-                      tag_paddr, ptr_paddr);
-        return NULL;
-    }
-
-    /*
-     * Ensure the tag memory is dirty on write, for migration.
-     * Tag memory can never contain code or display memory (vga).
-     */
-    if (tag_access == MMU_DATA_STORE) {
-        ram_addr_t tag_ra = memory_region_get_ram_addr(mr) + xlat;
-        cpu_physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
-    }
-
-    return memory_region_get_ram_ptr(mr) + xlat;
-#endif
-}
-
 static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uint64_t ptr, MMUAccessType ptr_access,
                                    int ptr_size, MMUAccessType tag_access,
@@ -287,12 +118,6 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
     return address_with_allocation_tag(ptr + offset, rtag);
 }
 
-static int load_tag1(uint64_t ptr, uint8_t *mem)
-{
-    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
-    return extract32(*mem, ofs, 4);
-}
-
 uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
 {
     int mmu_idx = arm_env_mmu_index(env);
@@ -320,13 +145,6 @@ static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
     }
 }
 
-/* For use in a non-parallel context, store to the given nibble.  */
-static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
-{
-    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
-    *mem = deposit32(*mem, ofs, 4, tag);
-}
-
 /* For use in a parallel context, atomically store to the given nibble.  */
 static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
 {
diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
new file mode 100644
index 0000000000..2d09345642
--- /dev/null
+++ b/target/arm/tcg/mte_helper.h
@@ -0,0 +1,211 @@
+/*
+ * ARM MemTag Operation Helpers
+ *
+ * Copyright (c) 2024 Linaro, Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARM_MTE_H
+#define TARGET_ARM_MTE_H
+
+#include "exec/exec-all.h"
+#include "exec/ram_addr.h"
+#include "hw/core/tcg-cpu-ops.h"
+#include "qemu/log.h"
+
+/**
+ * allocation_tag_mem_probe:
+ * @env: the cpu environment
+ * @ptr_mmu_idx: the addressing regime to use for the virtual address
+ * @ptr: the virtual address for which to look up tag memory
+ * @ptr_access: the access to use for the virtual address
+ * @ptr_size: the number of bytes in the normal memory access
+ * @tag_access: the access to use for the tag memory
+ * @probe: true to merely probe, never taking an exception
+ * @ra: the return address for exception handling
+ *
+ * Our tag memory is formatted as a sequence of little-endian nibbles.
+ * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
+ * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
+ * for the higher addr.
+ *
+ * Here, resolve the physical address from the virtual address, and return
+ * a pointer to the corresponding tag byte.
+ *
+ * If there is no tag storage corresponding to @ptr, return NULL.
+ *
+ * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
+ * three options:
+ * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
+ *     accessible, and do not take watchpoint traps. The calling code must
+ *     handle those cases in the right priority compared to MTE traps.
+ * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
+ *     that the page is going to be accessible. We will take watchpoint traps.
+ * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
+ *     traps and watchpoint traps.
+ * (probe = true, ra != 0 is invalid and will assert.)
+ */
+static inline uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                         uint64_t ptr, MMUAccessType ptr_access,
+                                         int ptr_size, MMUAccessType tag_access,
+                                         bool probe, uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    uint64_t clean_ptr = useronly_clean_ptr(ptr);
+    int flags = page_get_flags(clean_ptr);
+    uint8_t *tags;
+    uintptr_t index;
+
+    assert(!(probe && ra));
+
+    if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
+        if (probe) {
+            return NULL;
+        }
+        cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
+                              !(flags & PAGE_VALID), ra);
+    }
+
+    /* Require both MAP_ANON and PROT_MTE for the page. */
+    if (!(flags & PAGE_ANON) || !(flags & PAGE_MTE)) {
+        return NULL;
+    }
+
+    tags = page_get_target_data(clean_ptr);
+
+    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
+                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+    return tags + index;
+#else
+    CPUTLBEntryFull *full;
+    MemTxAttrs attrs;
+    int in_page, flags;
+    hwaddr ptr_paddr, tag_paddr, xlat;
+    MemoryRegion *mr;
+    ARMASIdx tag_asi;
+    AddressSpace *tag_as;
+    void *host;
+
+    /*
+     * Probe the first byte of the virtual address.  This raises an
+     * exception for inaccessible pages, and resolves the virtual address
+     * into the softmmu tlb.
+     *
+     * When RA == 0, this is either a pure probe or a no-fault-expected probe.
+     * Indicate to probe_access_flags no-fault, then either return NULL
+     * for the pure probe, or assert that we received a valid page for the
+     * no-fault-expected probe.
+     */
+    flags = probe_access_full(env, ptr, 0, ptr_access, ptr_mmu_idx,
+                              ra == 0, &host, &full, ra);
+    if (probe && (flags & TLB_INVALID_MASK)) {
+        return NULL;
+    }
+    assert(!(flags & TLB_INVALID_MASK));
+
+    /* If the virtual page MemAttr != Tagged, access unchecked. */
+    if (full->extra.arm.pte_attrs != 0xf0) {
+        return NULL;
+    }
+
+    /*
+     * If not backed by host ram, there is no tag storage: access unchecked.
+     * This is probably a guest os bug though, so log it.
+     */
+    if (unlikely(flags & TLB_MMIO)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
+                      "but is not backed by host ram\n", ptr);
+        return NULL;
+    }
+
+    /*
+     * Remember these values across the second lookup below,
+     * which may invalidate this pointer via tlb resize.
+     */
+    ptr_paddr = full->phys_addr | (ptr & ~TARGET_PAGE_MASK);
+    attrs = full->attrs;
+    full = NULL;
+
+    /*
+     * The Normal memory access can extend to the next page.  E.g. a single
+     * 8-byte access to the last byte of a page will check only the last
+     * tag on the first page.
+     * Any page access exception has priority over tag check exception.
+     */
+    in_page = -(ptr | TARGET_PAGE_MASK);
+    if (unlikely(ptr_size > in_page)) {
+        flags |= probe_access_full(env, ptr + in_page, 0, ptr_access,
+                                   ptr_mmu_idx, ra == 0, &host, &full, ra);
+        assert(!(flags & TLB_INVALID_MASK));
+    }
+
+    /* Any debug exception has priority over a tag check exception. */
+    if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
+        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
+        assert(ra != 0);
+        cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
+    }
+
+    /* Convert to the physical address in tag space.  */
+    tag_paddr = ptr_paddr >> (LOG2_TAG_GRANULE + 1);
+
+    /* Look up the address in tag space. */
+    tag_asi = attrs.secure ? ARMASIdx_TagS : ARMASIdx_TagNS;
+    tag_as = cpu_get_address_space(env_cpu(env), tag_asi);
+    mr = address_space_translate(tag_as, tag_paddr, &xlat, NULL,
+                                 tag_access == MMU_DATA_STORE, attrs);
+
+    /*
+     * Note that @mr will never be NULL.  If there is nothing in the address
+     * space at @tag_paddr, the translation will return the unallocated memory
+     * region.  For our purposes, the result must be ram.
+     */
+    if (unlikely(!memory_region_is_ram(mr))) {
+        /* ??? Failure is a board configuration error. */
+        qemu_log_mask(LOG_UNIMP,
+                      "Tag Memory @ 0x%" HWADDR_PRIx " not found for "
+                      "Normal Memory @ 0x%" HWADDR_PRIx "\n",
+                      tag_paddr, ptr_paddr);
+        return NULL;
+    }
+
+    /*
+     * Ensure the tag memory is dirty on write, for migration.
+     * Tag memory can never contain code or display memory (vga).
+     */
+    if (tag_access == MMU_DATA_STORE) {
+        ram_addr_t tag_ra = memory_region_get_ram_addr(mr) + xlat;
+        cpu_physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
+    }
+
+    return memory_region_get_ram_ptr(mr) + xlat;
+#endif
+}
+
+static inline int load_tag1(uint64_t ptr, uint8_t *mem)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    return extract32(*mem, ofs, 4);
+}
+
+/* For use in a non-parallel context, store to the given nibble.  */
+static inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    *mem = deposit32(*mem, ofs, 4, tag);
+}
+
+#endif /* TARGET_ARM_MTE_H */
-- 
2.34.1


