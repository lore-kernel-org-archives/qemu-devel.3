Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3BDD35683
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 06:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkzDS-0004l7-Dr; Wed, 28 Jan 2026 01:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vkzD1-0004YB-0P
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 01:39:24 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vkzCy-0006Vl-Su
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 01:39:22 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8230f2140beso300503b3a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769582358; x=1770187158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1vX8Oa0zQbJhc6oo6JnHi5pnkeeCFy2kauj2VrGdfM=;
 b=EuiMv45or0ZoRY2AmAhYFeNPNwTGUm1FyoEiy/QNTuyK/14xGuluJ/WhkS2TgO2IdU
 Fhxg4+MOlOeijoJ8jadA+p7Y/VAYJQAUNerzKVVED0+X7f4jVot+n3H4xNwU2xYMo0OG
 WSTkKNraX4QzWO360dAJQMs1+E6CasrUvkj3A0qQx1LuSzRmh/tO/TZZt3J4fd9ttZfF
 RS9nhFPpINbQdbNm1O12WG+DjWNg342bOOjIy0m85Z+vVC1mepnxrTYmtzjFMk50e1qj
 txlT4Z5roVK7CFrefcLBh+FbuWxih5Umj13wdA53Qfnb+2eYDjt3TR/2vviUlx4+Kv6F
 POoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769582358; x=1770187158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C1vX8Oa0zQbJhc6oo6JnHi5pnkeeCFy2kauj2VrGdfM=;
 b=Xx+Ahi4LfUaI+aR3DE2E9BzRI+9hwJWlmrCJz1JrkNRTurGbsPTTXxcnrF0zBw00+9
 2GhRdAka3r7ddYvr2mDi3w5G1fjYB0/VieUNjnsM9qI6SUnQv09ay3epvo+2cJykm1i0
 yghVOeGlDORIh9SoDvMwIp1ik2XT7JzJCQZ+drQazv4QivNqNaA3mCb4wQrypPdZbj9w
 kZIUYcrztsXSXB0WRG1FRwpYbt0zQ3VwSWy1NrLyGZWoRfvH0VSqQEHGsNMVORco0o/w
 xjsuRSOZoCMb6g9CO+8Xh34pNUVqc91KXj7kqiWe/NSbrBEBET6QFN4eov0lxuDzLegD
 2kEQ==
X-Gm-Message-State: AOJu0Yz4Ow+gvAfPrE7BdKHDNmq+wH+/odFB4VczmCKjIx6dL2yZxCiJ
 x99RnePnibeYoG/xi3kb7ITwK91vix+Kpj9ldVFaRpc1qMNhy1ImEzDtI/Nf7KDO5kKoyJBEAYE
 yCHiqRlwPo6YGU0IzOonzRrLmYgwByxQBBB+TUJ3J4vmb9GxEU7PeNZyrIiub5FIlL33IUUiwwH
 rZHT4OIHDQ4OeW1iY+ImiUYayoTI+DrBBK2D+JSw==
X-Gm-Gg: AZuq6aKTJelHDsGS8ixrdHnred4WgU5YiwHKwsLvWzVxN+W6n9sbs2qbG/lQ02w+9UI
 CXAqwu3ojpjWQOrTZ/ARzvv34zeWEFO/RUsiK8Ny1RXDhAzzrgaxNFlACLsx6uSmlY9LEqhLlvY
 wlHdtbE6c8Vl1FfB8mlggplSWM94h6Qo+6dHUxzpWZH7qs8pOww/uG3qrPWR7PKInnLefVxxQUj
 XEYFG5I0uI6Lgk4TXO6fagCdOzWJ6w8JdPMJnfpnbMgCf7TI2BcXriaim31gMAQdnI3WxGLX7RI
 N5b45qxwkGifcvZ1G11b5vlGF8Cl/GaW/rRS6KrJ7Cpf4kkPCOMEB8K9jG9A5GcOWhy/bbfKREu
 OJ8kj8/iFDZIpodeKmvKkNOOMEhKufg+Ow6x4y3V5x8sasuY5/sIaB8A/bB1ZmWO6Z4Rugqh4V/
 GTDyXPundvifbkQuXFOg3+Fio+BG6uyhJ6
X-Received: by 2002:a05:6a20:918f:b0:38e:9ca2:7e65 with SMTP id
 adf61e73a8af0-38ec58ec696mr4560874637.0.1769582357982; 
 Tue, 27 Jan 2026 22:39:17 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642487f1f5sm1244736a12.0.2026.01.27.22.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 22:39:17 -0800 (PST)
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
Subject: [PATCH 1/2] accel/tcg: Fix iotlb_to_section() for different
 AddressSpace
Date: Wed, 28 Jan 2026 14:39:06 +0800
Message-ID: <20260128063907.2066100-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128063907.2066100-1-jim.shu@sifive.com>
References: <20260128063907.2066100-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42a.google.com
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
---
 accel/tcg/cputlb.c        | 32 +++++++++++++++-----------------
 include/accel/tcg/iommu.h | 15 ---------------
 include/exec/cputlb.h     |  2 +-
 include/hw/core/cpu.h     | 12 +++++++-----
 system/physmem.c          | 25 -------------------------
 5 files changed, 23 insertions(+), 63 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6900a126827..c61339d10a3 100644
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
+    full->xlat = iotlb - addr_page;
+    full->section = section;
     full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
@@ -1270,14 +1270,14 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
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
@@ -1336,7 +1336,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
 static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
                            CPUTLBEntryFull *full, uintptr_t retaddr)
 {
-    ram_addr_t ram_addr = mem_vaddr + full->xlat_section;
+    ram_addr_t ram_addr = mem_vaddr + full->xlat;
 
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
@@ -1981,7 +1979,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2002,7 +2000,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2499,7 +2497,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2519,7 +2517,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
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
index 0d1d46429c9..e599a0f7627 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -44,7 +44,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
  * @full: the details of the tlb entry
  *
  * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
- * @full must be filled, except for xlat_section, and constitute
+ * @full must be filled, except for xlat, and constitute
  * the complete description of the translated page.
  *
  * This is generally called by the target tlb_fill function after
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 61da2ea4331..7de576ab602 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -219,15 +219,17 @@ typedef uint32_t MMUIdxMap;
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


