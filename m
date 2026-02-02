Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAA2E7FDD8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1N1-00057U-MX; Mon, 02 Feb 2026 16:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Mi-00053j-KG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Me-0007Ps-U2
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso41294445e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067298; x=1770672098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WuWggxfl7YWGc0iIVpyLoNSrAHblpQuEzJfAm/Kjzwc=;
 b=DjNfFtzRkAT5Oi9cZMsQuACeLKLEwHX97ZdaWB/8FNv2HO3Y83AAwKHj3vAma3HgU2
 FoVlVO8bV1T6EoMLEpSntgSAjJTcE01HB7hWkM6UaGzACbEwJJtN7WbpnUCcccuKS6h1
 tREq9iHCesYiD2E6cpITqozgdPc7lyI7uV6GWxZsYGjZbK+Murt1qP8f2N0Pn/mBxnDn
 20z1f/RNDQof53g+JokNwOF/F4XYfSkKsBfZhfmbLPzBz++XgnWb8sCQ3R0T+5glriBA
 IssSVLlekDV+3Vt8udooqIRmjjNioFhP2+35XpmRTIbvGLuoN9EPtymiqf/CXMjK/TAT
 cJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067298; x=1770672098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WuWggxfl7YWGc0iIVpyLoNSrAHblpQuEzJfAm/Kjzwc=;
 b=VH9XkXoKlOmUhiFRrRv7kY8x4qM0UNeLj0vWWyuh7aYQH9Lr51SduUI065BFDZYpUP
 DntIaRl3qXz4acbx3xyapT5S8T+bvLlSSn2Mg3jobwX0WHcQerpVf0VUCTjR2l3nLeKP
 hsi9my+f4HNQMJ12ePwfzqJRaKKeWLiBOH5w5DeFfzPuUrQQVXFGXpd7GyIKY+itII/E
 06LzPtDRN3htAQbGiSZACDRgddGhF8Nh8QZ5Gj2bVHb6kKwnG+e06RzWaI4DTSzEZHDr
 mA3I6xpiv1JDLkoSj0UnH0p9WynGwCFfGk2qoUTFJV+Npm2cKeK2yi0rzlKNg/2y7ABH
 iqAA==
X-Gm-Message-State: AOJu0YyN9V+p4jHjX4j3UlcNvhAczzu36+nXMuLj7e6gfDP3TSCDsjwJ
 nUhLwOQSRVMlDnCbLERYDM7RaMB4+6N0/ocIDW9Fm7aqnAqqKlA8iyJ9GWHsMTBZxzP7M9+C7h5
 6orwjaDE=
X-Gm-Gg: AZuq6aLnW2WRLXCkrv/pSHl10UotIRxDEvjSyO7hSIGUKCxCFodDnY2OFVUow30YZCe
 Hez/u0gpEKeMkf29t2amp+ukWIR2oqHwC4osJlwmMjLZpzhXtJTfZ/edLiyG44I8D9991cX6oRq
 s5YDekOKEhaQDEqi3JqZfPwE1rWUMMtFRDZvWCXFhJJVZlSivOKkbLlTcfgUwlE1ba2j69CcQvx
 ZfDP4jKE6AeDhwuD/TKdbH/bnT11ZwPLCOu3TFrKKNORlmsndLv/r5IGW5FG+D2XVLwS/JxN0r2
 NDbC4pXCiRkABpaq3M4rg6ioR5C2lmJZkNSshsV9vYVCLWAEBJpqxU1duE+IoZ3/7CSy27eKiQt
 XRtLrYtpFBYEVf3aSdYbAYDx5NMOIp2RnIRlqu2M6qqviNjoqZ/TyoeezOYs2uU5RkxKGugxs7k
 G4U79i0QlvkS7WDTlrK7hbfS9cXV8iPhSvtT+1sjZw/wUFcVUuveS0DzkXXc2r
X-Received: by 2002:a05:600c:a00a:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-482db47d460mr168420295e9.20.1770067298426; 
 Mon, 02 Feb 2026 13:21:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfd4sm44575192f8f.25.2026.02.02.13.21.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:21:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] accel/tcg: Fix iotlb_to_section() for different
 AddressSpace
Date: Mon,  2 Feb 2026 22:20:14 +0100
Message-ID: <20260202212019.94205-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Jim Shu <jim.shu@sifive.com>

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
Tested-by: Mark Burton <mburton@qti.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260128152348.2095427-3-jim.shu@sifive.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/iommu.h | 15 ---------------
 include/exec/cputlb.h     |  4 ++--
 include/hw/core/cpu.h     | 17 +++++++++--------
 accel/tcg/cputlb.c        | 22 ++++++++++------------
 system/physmem.c          | 25 -------------------------
 5 files changed, 21 insertions(+), 62 deletions(-)

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
2.52.0


