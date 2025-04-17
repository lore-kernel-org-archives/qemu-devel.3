Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906C0C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Ms3-0007Ko-Qu; Thu, 17 Apr 2025 06:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mrv-0007Hl-7D
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Mrn-0003HB-F2
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224100e9a5cso6839445ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887190; x=1745491990; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1OzcF3/O35O63aAFZJRPLEZk5T/555tjIU+685rxziI=;
 b=So5Z2/cGy9UoiI0fEVC9EDDUk991Iz5oMY1VJdDr+swhyEkpChR8W7u9qwvAKOWNaW
 JLxKwc9EpEeIeZOca+OplIUPqaaLoo2FBrjJi/rD5zWGGn76eg710NrmG7LZw5vneHQv
 L5d1VuKhW0Yyq2lpmE0DNk8hFv8FTf0mu7ROaehjbPbFvpyON00lG4QYbzLNbvrnM4Hk
 lWOP9RNgdqpfY3qH9UEATUn3d/Ix0OhMyGwJQyyQHw2RSJFUa54bOXom39Wdzt6lC2Pc
 wVA3HjMI/vrZDpav3pj8A/Rg5eK3NQBfdcQ2oMmQiovqzNbKB9U3yGRiO9HWWgNSIi15
 XUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887190; x=1745491990;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1OzcF3/O35O63aAFZJRPLEZk5T/555tjIU+685rxziI=;
 b=NqSVawyOjL89l7TuKBJUHVZt8OBz+FVXoKXTPzud2G9ETraSwJ/Gx4BryHwYYm/wLk
 kpdk8Zpvbpnt846Wx9MIzVzqzVgXF9tTcU/JOv/EhcSVaJxIbrUW1xGaJyXM91fJYs65
 U/sqgBc0nB+dy0zfUHV8uy5SpNRiRybfpZyaoOpyN/HN3a/YcJioNu85/O7NUQXqJvPw
 Bj7udQPEVQkR0LsWEO8bN96Me9jWnjddJYaE1Yf7TaB5DDSEdhwoWF7R19cg3tSibU4t
 etZGwYP7nwazy6wfVIge46BnOEebZpnNd1zkviuq+jN7UNgc7jhhysinClO8KfqaijcN
 K4HQ==
X-Gm-Message-State: AOJu0YwmPZcp3HT5Ke485hpvzeLgKHC1jPMkIwHkVE7phgE/+1++iKKg
 KevjqkXkTpm4gdZjgNY3KHlRsFIddC3+oUFzSXe3omXT1tS7bYKPTRG9XqK2lhkzeMhpKPekvoS
 CqLH/E3ILBkX0kuVF5447jm8FVU66JGGO0JaAlkXYK3aXxyb5Nn+ZgS/IzYMwGpki8usnF+hJh5
 VjGkB2XxNUue3cScaUbj6r+tBzTFzqjUqGBQ==
X-Gm-Gg: ASbGncs+vPCpr5GunZ0Yl7pJwJwKizXX5b5h9SMeHE+5zwF8kr5pj1C3LlvISNvPH4X
 Af2P3Akh2goiDP87XK8CdHvNCpT3uHV7ntgytmmUDYvxKd3lDSjemmiFme5b62D9P8zqxuLefc5
 EOcI233pucqHx3MAvRAqGcAbcRUulEv9F9mI3N0FhumD5nMuI5c7tdLtfu2ciJ4EiRdBjEML1oH
 hWXdLfaZ1g60MZnsKTq3iKibEopzt8+uPmhz2BubgJ04YnNDcCfLgZDo/NFSmX5U1pLtVE3by1U
 NF26wvu4ZvSlep1/bDC7p2paSJEARJ6QwM0xmkyA/D60OYDxJ/8zpCHDPFopn7Q=
X-Google-Smtp-Source: AGHT+IFB/VVpLc+3fkHQfajBQ7jQxp0K8fblft9XqyOnAuEWmcwRwAPFM/93cv/unN9ImTu7vLiK/g==
X-Received: by 2002:a17:902:ef08:b0:220:bcc5:2845 with SMTP id
 d9443c01a7336-22c358bb4acmr75104785ad.7.1744887189383; 
 Thu, 17 Apr 2025 03:53:09 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:53:08 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 01/18] accel/tcg: Store section pointer in CPUTLBEntryFull
Date: Thu, 17 Apr 2025 18:52:32 +0800
Message-Id: <20250417105249.18232-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To fix the bug of iotlb_to_section(), store complete MemoryRegionSection
pointer in CPUTLBEntryFull to replace the section_index in xlat_section.
Rename 'xlat_section' to 'xlat' as we remove last 12 bits section_index
inside. Remove iotlb_to_section() as we directly use section pointer in
the CPUTLBEntryFull (full->section).

iotlb_to_section() bug description:
'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
find the correct section when CPU access the IO region over the IOTLB.
However, section_index is only unique inside single AddressSpace. If
address space translation is over IOMMUMemoryRegion, it could return
section from other AddressSpace. 'iotlb_to_section()' API only finds the
sections from CPU's AddressSpace so that it couldn't find section in
other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
wrong section and QEMU will have wrong load/store access.

This bug occurs only when
(1) IOMMUMemoryRegion is in the path of CPU access.
(2) IOMMUMemoryRegion returns different target_as and the section is in
the IO region.

Common IOMMU devices don't have this issue since they are only in the
path of DMA access. Currently, the bug only occurs when ARM MPC device
(hw/misc/tz-mpc.c) returns 'blocked_io_as' to emulate blocked access
handling. Upcoming RISC-V wgChecker device is also affected by this bug.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 accel/tcg/cputlb.c      | 32 +++++++++++++++-----------------
 include/exec/cputlb.h   |  2 +-
 include/exec/exec-all.h | 15 ---------------
 include/hw/core/cpu.h   | 12 +++++++-----
 system/physmem.c        | 17 -----------------
 5 files changed, 23 insertions(+), 55 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876..d51bfc19c1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1085,7 +1085,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         }
     } else {
         /* I/O or ROMD */
-        iotlb = memory_region_section_get_iotlb(cpu, section) + xlat;
+        iotlb = xlat;
         /*
          * Writes to romd devices must go through MMIO to enable write.
          * Reads to romd devices go through the ram_ptr found above,
@@ -1136,10 +1136,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
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
@@ -1149,7 +1148,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
      */
     desc->fulltlb[index] = *full;
     full = &desc->fulltlb[index];
-    full->xlat_section = iotlb - addr_page;
+    full->xlat = iotlb - addr_page;
+    full->section = section;
     full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
@@ -1265,14 +1265,14 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
 }
 
 static MemoryRegionSection *
-io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
+io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
            MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
 {
     MemoryRegionSection *section;
     hwaddr mr_offset;
 
-    section = iotlb_to_section(cpu, xlat, attrs);
-    mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
+    section = full->section;
+    mr_offset = full->xlat + addr;
     cpu->mem_io_pc = retaddr;
     if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
@@ -1331,7 +1331,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
 static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
                            CPUTLBEntryFull *full, uintptr_t retaddr)
 {
-    ram_addr_t ram_addr = mem_vaddr + full->xlat_section;
+    ram_addr_t ram_addr = mem_vaddr + full->xlat;
 
     trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
 
@@ -1588,9 +1588,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
 
     /* We must have an iotlb entry for MMIO */
     if (tlb_addr & TLB_MMIO) {
-        MemoryRegionSection *section =
-            iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MASK,
-                             full->attrs);
+        MemoryRegionSection *section = full->section;
         data->is_io = true;
         data->mr = section->mr;
     } else {
@@ -1980,7 +1978,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2001,7 +1999,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2521,7 +2519,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2541,7 +2539,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 8125f6809c..fea0474cf6 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -43,7 +43,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
  * @full: the details of the tlb entry
  *
  * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
- * @full must be filled, except for xlat_section, and constitute
+ * @full must be filled, except for xlat, and constitute
  * the complete description of the translated page.
  *
  * This is generally called by the target tlb_fill function after
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index dd5c40f223..46be330d99 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -178,21 +178,6 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
-#if !defined(CONFIG_USER_ONLY)
-
-/**
- * iotlb_to_section:
- * @cpu: CPU performing the access
- * @index: TCG CPU IOTLB entry
- *
- * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
- * it refers to. @index will have been initially created and returned
- * by memory_region_section_get_iotlb().
- */
-struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                             hwaddr index, MemTxAttrs attrs);
-#endif
-
 /**
  * get_page_addr_code_hostp()
  * @env: CPUArchState
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index abd8764e83..da9011e2c5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -208,15 +208,17 @@ struct CPUClass {
  */
 struct CPUTLBEntryFull {
     /*
-     * @xlat_section contains:
-     *  - in the lower TARGET_PAGE_BITS, a physical section number
-     *  - with the lower TARGET_PAGE_BITS masked off, an offset which
-     *    must be added to the virtual address to obtain:
+     * @xlat contains:
+     *  - a TARGET_PAGE_BITS aligned offset which must be added to
+     *    the virtual address to obtain:
      *     + the ram_addr_t of the target RAM (if the physical section
      *       number is PHYS_SECTION_NOTDIRTY or PHYS_SECTION_ROM)
      *     + the offset within the target MemoryRegion (otherwise)
      */
-    hwaddr xlat_section;
+    hwaddr xlat;
+
+    /* @section contains physical section. */
+    MemoryRegionSection *section;
 
     /*
      * @phys_addr contains the physical address in the address space
diff --git a/system/physmem.c b/system/physmem.c
index 333a5eb94d..70a6dd1962 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2668,23 +2668,6 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
     return phys_section_add(map, &section);
 }
 
-MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                      hwaddr index, MemTxAttrs attrs)
-{
-    int asidx = cpu_asidx_from_attrs(cpu, attrs);
-    CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
-    AddressSpaceDispatch *d = cpuas->memory_dispatch;
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
 static void io_mem_init(void)
 {
     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
-- 
2.17.1


