Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC5BC369B9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bPh-0006Be-6k; Tue, 15 Apr 2025 04:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bPe-0005uE-8N
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:12:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bPb-0001tf-BA
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:12:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22928d629faso50533045ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704773; x=1745309573; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GR/8z++2aqI3yyfjoa8U9+bhg7JVoM1t0POSqDl+R9E=;
 b=WZGa/14odk++z1oyT4MLm1/+TBg1NCJDNJo7msXWcbo9ZIJpSc0+RZ20ZDUI+JSUW4
 PW8/7cdvwSUFJtCDgS5H1MMNz6c5vXcq91vpHSfVo++gDXlRAzsjCOnK+3UNirtN9c7s
 hvrmGYOxDtQTsi8vtXrTTLWNXtD7O542WoDOUrDFOy3JSHWwiF5pJ5VXxxiilJ7XfOMg
 R9VFVnA7O7HoA1wK4V5ncv/ScEh9lVXe3LlZnL36Hh2dt1Y+EHCMBgS2Tl9oJ49qKqKK
 w7at9pLVNql5uBLa1AipPZ6dZuSSQCjzxqcH6yrJng9SO5wMFr8n+n3RfyJCNBd8OiFA
 qBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704773; x=1745309573;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GR/8z++2aqI3yyfjoa8U9+bhg7JVoM1t0POSqDl+R9E=;
 b=m4rSp3eI31yOHje2+jv9/nSzBWgMn2Web7HZojSjTj2tmdPQ8bGhtwnNza3+nN/6uI
 B0vjX5XbYmV2hdEanwx4pkMe7egDpDGDXFI6QcnqXRRYbJB1sMI1U9iF27haak4qcJ0c
 B8N5jtnJhhiKRmRXZu+yNrcL1xfJ4XaGKPxSmh810RoK/slwpU2216zVr/ssJVgFHqOw
 8k/l+8hCB0Q6VFEWlLZaCvQjbdWeycIXDzBMPjOYRNn+Hh0B50b9DdAeOJhjFYBJ2cw9
 EQsvncI0/ZzTYfBumIkobjRqIVCLJCBFdv4cmYYwAegEIxA6Tugt/iWqyRweftHTsXgP
 Bxbg==
X-Gm-Message-State: AOJu0Yx7Q9FxiMCfAi20KObWHUcUzejx02oUEvT5PW0Qfh4cUDRUKewD
 9Lonsnr1sGtPI2Re32ka9IUZbvMgqdRHDvZWzIn08IirikUHMZP62c+rLOT5/X/Yt9o6GPbmUio
 tKzb/PSjX9g81jbHFvzmzv7cu4xEPv2fLAELu3W/gCWAZnGvz9l0rVE5LJyx9BKMvd7/Cwdj9Me
 Ot+E7Jroisxf0qi/SzfUXy1UI8iL92utR6/3Tb
X-Gm-Gg: ASbGncvokJ63H5Pqcy5au6/2YrpbIw61nU93aP20TU3186N7M90piHlnAI470DPNiDp
 kVlcdBCingyVBidgoFXwnHgERWh/4lwsWvcrwYhWJyN1ZO8XLWwjbtZwxRZaTP+NKwb/uQAqO7L
 aJzPb0WrOZdyJvt8oiQSAlejftankCnJEYNrVn59B1P4QSBQWTubBGGxaJWjje+XXxclNBj2f4k
 AaqxlRUM2wvlGRveA7ajuu0TyhCHoJJib+lq/ONHmX4Y0I4hpXsBOQSykdecXozkbxZOaVaQxlr
 pfkI7prn9aQb0vx/Mk4ms0TobMyUG4N8HHZIdF5VLo9hhvdP33gpZu7IPIXlTLM=
X-Google-Smtp-Source: AGHT+IEvywpEavvmyOduEwwU9z9a/qrP8uMTOrmGOQ25BCjKptwcRQBPtDLlsB4i+g1TFvGzFaNUAA==
X-Received: by 2002:a17:903:1a10:b0:220:c4e8:3b9d with SMTP id
 d9443c01a7336-22bea4efeefmr219540275ad.37.1744704772795; 
 Tue, 15 Apr 2025 01:12:52 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:12:52 -0700 (PDT)
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
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 01/17] accel/tcg: Store section pointer in CPUTLBEntryFull
Date: Tue, 15 Apr 2025 16:12:15 +0800
Message-Id: <20250415081231.21186-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x629.google.com
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

'CPUTLBEntryFull.xlat_section' stores section_index in last 12 bits to
find the correct section when CPU access the IO region over the IOTLB
(iotlb_to_section()).

However, section_index is only unique inside single AddressSpace. If
address space translation is over IOMMUMemoryRegion, it could return
section from other AddressSpace. 'iotlb_to_section()' API only finds the
sections from CPU's AddressSpace so that it couldn't find section in
other AddressSpace. Thus, using 'iotlb_to_section()' API will find the
wrong section and QEMU will have wrong load/store access.

To fix this bug, store complete MemoryRegionSection pointer in
CPUTLBEntryFull instead of section_index.

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
 accel/tcg/cputlb.c    | 19 +++++++++----------
 include/hw/core/cpu.h |  3 +++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876..581611d82d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1150,6 +1150,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     desc->fulltlb[index] = *full;
     full = &desc->fulltlb[index];
     full->xlat_section = iotlb - addr_page;
+    full->section = section;
     full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
@@ -1265,14 +1266,14 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
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
+    mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
     if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
@@ -1588,9 +1589,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
 
     /* We must have an iotlb entry for MMIO */
     if (tlb_addr & TLB_MMIO) {
-        MemoryRegionSection *section =
-            iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MASK,
-                             full->attrs);
+        MemoryRegionSection *section = full->section;
         data->is_io = true;
         data->mr = section->mr;
     } else {
@@ -1980,7 +1979,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2001,7 +2000,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2521,7 +2520,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2541,7 +2540,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index abd8764e83..8759e30fcc 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -218,6 +218,9 @@ struct CPUTLBEntryFull {
      */
     hwaddr xlat_section;
 
+    /* @section contains physical section. */
+    MemoryRegionSection *section;
+
     /*
      * @phys_addr contains the physical address in the address space
      * given by cpu_asidx_from_attrs(cpu, @attrs).
-- 
2.17.1


