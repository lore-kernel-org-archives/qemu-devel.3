Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB92D3F074
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7PL-000188-6R; Wed, 28 Jan 2026 10:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl7Oo-0000f1-JL
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:24:07 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl7Ol-0003UG-0j
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:24:04 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso644752b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 07:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769613840; x=1770218640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OxWCzPW0g/rN962XyMygE+kbGhHN7q/RykJMy+ty6Y=;
 b=aFEUJAoaBoZzjyNrMeFKRUIW7Zn9PaNh63rScR8bbam7a2b6C6i1dwcIfHFzV5o3W1
 QBra2+YOb/epsifpCDwb2oiMGAAFYS/8z1AKrMY7NhZYFnSsGDPQqKJ1Z/2oTJgRgG8Z
 qK/v6835lXvWBZEcnMgRPv18yjnxr1GhO67wNSqqZHcqbWMnUxijiG3I19SZgq2L5FYf
 tAIeNjiOtY++1mN+6OT/RQ4wEjAL3GYS4CUoYeP5eKtiBXhlhi0FrIvKiweTxdyXndWY
 glgi6DvJE/9fuKGYdedrnCTgVUz15Grj3KwWDr+LC5YwCSFJX23BOWwfzTegjqko7zKK
 ukSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769613840; x=1770218640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0OxWCzPW0g/rN962XyMygE+kbGhHN7q/RykJMy+ty6Y=;
 b=QpfcrF5MByus0C9xkx8drfvFHhqSBqkhLtw9rUE4hLUQ7ubqpt1CTK9it72QHZ9Gcw
 Pse/3M2e2LG8sRlsSJoCwcWSH/W1xRjZh1eWisx76VYJxcO94+t1aaIb3IuMOmgZZnfy
 yCIkJbfNtqS8yrY929w+Jvye2g/w+KsCqBcmfX+eUA+UkY711LLgQhcNxO4M8cdoRlKx
 sPMkqfdKMMr9IbgIFyjyKg1UcVmEw+zCsvPE07t6C97gyt4kkOZTDW/5ZmtxCQFBNVip
 Bqwh13XdPk9EQNi+Kop0W7ZO2FwhH1hbDUq2LsokqYy4BMfnPNHBoSmY0BO+KM7QiGCh
 gUFA==
X-Gm-Message-State: AOJu0YyXjTglegz2oo37EKQCLk9LSQ3m/uTK/VAuleeECUgvJwrrWb8A
 5pDuCVn0CAAALifzGk+3eqQVuBnF8fW25BM9c4GpEjdCOjuVHMt9mtFystWEVJs9fC4f3D/+/RM
 o40SnSjPw9HMApJgBG+Iqfu+y+7Y994GraqwLptV5wCFnJBFWfjVRALYiDC8yAdVFXykDev3wTH
 CM0ItYVTZVvDfdHiE9pSUeiE8/33Ehn8Uhf4S2Mw==
X-Gm-Gg: AZuq6aJyTWDFpAhOvbKgmdjacrtgLVdEqqsU0Fya8dcggzwzi0JnHLiy0tElkcBWJ3W
 pTFm6kILyjZQGN4hiqTK8wJqhAjKdkbjmS8zRGMmVI+2a9WratCVi9N+bFgPshILYpEExQZfx0y
 wPIOyOE3QHQRxY5pE66YzdOeWn+dBZ7T4x8dhdsA9E4K/Wetc4i6zkXVi7X5wCDIt9laRmk/ZQ9
 SDJ8I6I6Ukmjlq+ljjZIhnujLu16KL4GVEyfDZujtVA2bWm6kxZXbBdrG3OuPyhVdRmxrAYZQf9
 Bc73PlpcrRApeVgFjY+fhqkoW0pyJi/aRe1j8HbpWwP3pE+1laTHuU/o3fwH0rQv5lLWOCIrp82
 TQ7ZPOpME73NmjDoJoR3F4a/Q0M/yAlm5q2GBH/N52+8ryVX/HsOle9rOvZEAMUR94HX8NHRWa3
 MEazV/Ai7xA9Jbph9DzLmIZYi6RMT/Gu5w
X-Received: by 2002:a05:6a00:6088:b0:81f:804f:af26 with SMTP id
 d2e1a72fcca58-8236a38cb0emr4926649b3a.19.1769613840056; 
 Wed, 28 Jan 2026 07:24:00 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c1eeebsm3021304b3a.45.2026.01.28.07.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 07:23:59 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 2/3] accel/tcg: Fix iotlb_to_section() for different
 AddressSpace
Date: Wed, 28 Jan 2026 23:23:47 +0800
Message-ID: <20260128152348.2095427-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128152348.2095427-1-jim.shu@sifive.com>
References: <20260128152348.2095427-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
find the correct section when CPU access the IO region over the IOTLB.
However, section_index is only unique inside single AddressSpace. If
address space translation is over IOMMUMemoryRegion, it could return
section from other AddressSpace. 'iotlb_to_section()' API only finds the
sections from CPU's AddressSpace so that it couldn't find section in
other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
wrong section and QEMU will have wrong load/store access.

To fix this bug of iotlb_to_section(), store complete MemoryRegionSection
pointer in CPUTLBEntryFull to replace the section_index in xlat_section.
Rename 'xlat_section' to 'xlat' as we remove last 12 bits section_index
inside. Also, since we directly use section pointer in the
CPUTLBEntryFull (full->section), we can remove the unused functions:
iotlb_to_section(), memory_region_section_get_iotlb().

This bug occurs only when
(1) IOMMUMemoryRegion is in the path of CPU access.
(2) IOMMUMemoryRegion returns different target_as and the section is in
the IO region.

Common IOMMU devices don't have this issue since they are only in the
path of DMA access. Currently, the bug only occurs when ARM MPC device
(hw/misc/tz-mpc.c) returns 'blocked_io_as' to emulate blocked access
handling. Upcoming RISC-V wgChecker [1] and IOPMP [2] devices are also
affected by this bug.

[1] RISC-V WG:
https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
[2] RISC-V IOPMP:
https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cputlb.c        | 22 ++++++++++------------
 include/accel/tcg/iommu.h | 15 ---------------
 include/exec/cputlb.h     |  4 ++--
 include/hw/core/cpu.h     | 17 +++++++++--------
 system/physmem.c          | 25 -------------------------
 5 files changed, 21 insertions(+), 62 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 82c9b6389dc..76546c66515 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1090,7 +1090,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         }
     } else {
         /* I/O or ROMD */
-        iotlb = memory_region_section_get_iotlb(cpu, section) + xlat;
+        iotlb = xlat;
         /*
          * Writes to romd devices must go through MMIO to enable write.
          * Reads to romd devices go through the ram_ptr found above,
@@ -1141,10 +1141,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     /*
      * When memory region is ram, iotlb contains a TARGET_PAGE_BITS
      * aligned ram_addr_t of the page base of the target RAM.
-     * Otherwise, iotlb contains
-     *  - a physical section number in the lower TARGET_PAGE_BITS
-     *  - the offset within section->mr of the page base (I/O, ROMD) with the
-     *    TARGET_PAGE_BITS masked off.
+     * Otherwise, iotlb contains a TARGET_PAGE_BITS aligned
+     * offset within section->mr of the page base (I/O, ROMD)
+     *
      * We subtract addr_page (which is page aligned and thus won't
      * disturb the low bits) to give an offset which can be added to the
      * (non-page-aligned) vaddr of the eventual memory access to get
@@ -1154,7 +1153,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      */
     desc->fulltlb[index] = *full;
     full = &desc->fulltlb[index];
-    full->xlat_section = iotlb - addr_page;
+    full->xlat_offset = iotlb - addr_page;
+    full->section = section;
     full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
@@ -1276,8 +1276,8 @@ io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
     MemoryRegionSection *section;
     hwaddr mr_offset;
 
-    section = iotlb_to_section(cpu, full->xlat_section, attrs);
-    mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
+    section = full->section;
+    mr_offset = full->xlat_offset + addr;
     cpu->mem_io_pc = retaddr;
     if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
@@ -1336,7 +1336,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
 static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
                            CPUTLBEntryFull *full, uintptr_t retaddr)
 {
-    ram_addr_t ram_addr = mem_vaddr + full->xlat_section;
+    ram_addr_t ram_addr = mem_vaddr + full->xlat_offset;
 
     trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
 
@@ -1593,9 +1593,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
 
     /* We must have an iotlb entry for MMIO */
     if (tlb_addr & TLB_MMIO) {
-        MemoryRegionSection *section =
-            iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MASK,
-                             full->attrs);
+        MemoryRegionSection *section = full->section;
         data->is_io = true;
         data->mr = section->mr;
     } else {
diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
index 90cfd6c0ed1..547f8ea0ef0 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -14,18 +14,6 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 
-/**
- * iotlb_to_section:
- * @cpu: CPU performing the access
- * @index: TCG CPU IOTLB entry
- *
- * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
- * it refers to. @index will have been initially created and returned
- * by memory_region_section_get_iotlb().
- */
-MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                      hwaddr index, MemTxAttrs attrs);
-
 MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
                                                        int asidx,
                                                        hwaddr addr,
@@ -34,8 +22,5 @@ MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
                                                        MemTxAttrs attrs,
                                                        int *prot);
 
-hwaddr memory_region_section_get_iotlb(CPUState *cpu,
-                                       MemoryRegionSection *section);
-
 #endif
 
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 0d1d46429c9..3a9603a6965 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -44,8 +44,8 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
  * @full: the details of the tlb entry
  *
  * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
- * @full must be filled, except for xlat_section, and constitute
- * the complete description of the translated page.
+ * @full must be filled, except for xlat_offset & section, and
+ * constitute the complete description of the translated page.
  *
  * This is generally called by the target tlb_fill function after
  * having performed a successful page table walk to find the physical
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 61da2ea4331..98678704a64 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -219,15 +219,16 @@ typedef uint32_t MMUIdxMap;
  */
 struct CPUTLBEntryFull {
     /*
-     * @xlat_section contains:
-     *  - in the lower TARGET_PAGE_BITS, a physical section number
-     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
-     *    must be added to the virtual address to obtain:
-     *     + the ram_addr_t of the target RAM (if the physical section
-     *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
-     *     + the offset within the target MemoryRegion (otherwise)
+     * @xlat_offset: TARGET_PAGE_BITS aligned offset which must be added to
+     * the virtual address to obtain:
+     *   + the ram_addr_t of the target RAM (if the physical section
+     *     number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
+     *   + the offset within the target MemoryRegion (otherwise)
      */
-    hwaddr xlat_section;
+    hwaddr xlat_offset;
+
+    /* @section contains physical section. */
+    MemoryRegionSection *section;
 
     /*
      * @phys_addr contains the physical address in the address space
diff --git a/system/physmem.c b/system/physmem.c
index b0311f45312..d17596a77fb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -747,31 +747,6 @@ translate_fail:
     return &d->map.sections[PHYS_SECTION_UNASSIGNED];
 }
 
-MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                      hwaddr index, MemTxAttrs attrs)
-{
-    int asidx = cpu_asidx_from_attrs(cpu, attrs);
-    CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
-    AddressSpaceDispatch *d = address_space_to_dispatch(cpuas->as);
-    int section_index = index & ~TARGET_PAGE_MASK;
-    MemoryRegionSection *ret;
-
-    assert(section_index < d->map.sections_nb);
-    ret = d->map.sections + section_index;
-    assert(ret->mr);
-    assert(ret->mr->ops);
-
-    return ret;
-}
-
-/* Called from RCU critical section */
-hwaddr memory_region_section_get_iotlb(CPUState *cpu,
-                                       MemoryRegionSection *section)
-{
-    AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
-    return section - d->map.sections;
-}
-
 #endif /* CONFIG_TCG */
 
 void cpu_address_space_init(CPUState *cpu, int asidx,
-- 
2.43.0


