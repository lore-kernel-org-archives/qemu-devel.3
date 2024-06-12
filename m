Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DF7C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJ80-00029M-88; Wed, 12 Jun 2024 04:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ7y-00026I-9o
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:14:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sHJ7v-0006HM-V5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:14:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f6fada63a6so29662205ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718180077; x=1718784877; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XwMwVBT0fP270rWsEHSo2631M0ztS9piF83iSzYOuzw=;
 b=N8bpuZp7gD6N3q70+D4kOG9fzrpjMjZT5hjOOWEXGHc4/lMrxDAfg9lokzwOR/Sbhi
 MxO/uAJVrfkSTaHtN6XVLBn3i7JcY2LO/ijoT6xNDwZm4Tiox79vPDyLaNq7hWamb3J4
 X9sJ3cQLkvk0fP44T6LKwxJ1T0obyMWdtg8fFKcBJTgMDAAcu3wbn9j5/emZWkW32b/+
 e6oN0sKMtJiIZ11rtlKjsSTDAHcwoCcefpK3Vo6brAvbG+WbBeOxgyAO3ZuQfA4cIzyN
 P5cEk5DhdsbdJF2/ZEVQ+rvf0cBjJ7XMyHLdEN6WdWr09HpjM6uCTFVkgYgbmfO2mGBp
 SGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180077; x=1718784877;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwMwVBT0fP270rWsEHSo2631M0ztS9piF83iSzYOuzw=;
 b=oVqRJvsJNBjGGD+RIOcAEPQckeH1r6Yh0ubA8+dqRKgqRklH77U4mNc55Bdd9AOW61
 seuLf1miMxfhfoORbOLKAr7sY2sUfx5FNshan1vABLiHih9jB85pMIdrDiEavsk9o37G
 GR19/pZ8hMxMA2E53UmUVeUIpY11+McgxwxRT1v79XO5WoG0Xo1+eoOknXS6nuiwhCi2
 9dBdC7xvp2Ld/nphrxmMlmri8YTkAT/JoooyhxbWimrCLXgVqEwMFBc9yupToBnEZBB+
 Si+5YFe6+JgV8CD9LflJ/ynFPLiKBH/NG1w/4uUCPdiOIszcafrFtm13t3MdZlCUcDia
 8N2A==
X-Gm-Message-State: AOJu0YxNQ9BvAfmVZkLm5D7EeLQh0MUScoEXauR1QqWw/b5q+K4ABAXj
 AuWqtSMXydXkF7SYbIzF/lKH5lcOc1TXzUlFS6pENQR3ijvSs3FQFr16t8WnQb9v1s6CEy2J5Vt
 oDn8+p4q1vgWIU2ihe7xtx8DNYkBFETecEmHPImM6Uq6UkI9ZWWtzwwpmQPIYRxdGTglL7MXwu8
 esf9jnenriciRlDOlevJqAfBJHKU7Oq1VgWDoWBTG4Eg==
X-Google-Smtp-Source: AGHT+IEo1bK99dcUiJWk+0Vs1vbfw/dSUmok49xRm+S/vMWu5IGnR7xF0K7Wa7r8B36J57d42xYrsw==
X-Received: by 2002:a17:902:dacf:b0:1f7:9fb:9d0c with SMTP id
 d9443c01a7336-1f83b74260emr11841995ad.56.1718180077162; 
 Wed, 12 Jun 2024 01:14:37 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f8393e8e53sm11363875ad.16.2024.06.12.01.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 01:14:36 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
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
 qemu-arm@nongnu.org (open list:ARM TCG CPUs),
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [RFC PATCH 01/16] accel/tcg: Store section pointer in CPUTLBEntryFull
Date: Wed, 12 Jun 2024 16:14:01 +0800
Message-Id: <20240612081416.29704-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240612081416.29704-1-jim.shu@sifive.com>
References: <20240612081416.29704-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index 117b516739..8cf124b760 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1169,6 +1169,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     desc->fulltlb[index] = *full;
     full = &desc->fulltlb[index];
     full->xlat_section = iotlb - addr_page;
+    full->section = section;
     full->phys_addr = paddr_page;
 
     /* Now calculate the new entry */
@@ -1248,14 +1249,14 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
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
@@ -1571,9 +1572,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
 
     /* We must have an iotlb entry for MMIO */
     if (tlb_addr & TLB_MMIO) {
-        MemoryRegionSection *section =
-            iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MASK,
-                             full->attrs);
+        MemoryRegionSection *section = full->section;
         data->is_io = true;
         data->mr = section->mr;
     } else {
@@ -1972,7 +1971,7 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -1993,7 +1992,7 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2513,7 +2512,7 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 0 && size <= 8);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
@@ -2533,7 +2532,7 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
     tcg_debug_assert(size > 8 && size <= 16);
 
     attrs = full->attrs;
-    section = io_prepare(&mr_offset, cpu, full->xlat_section, attrs, addr, ra);
+    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
     mr = section->mr;
 
     BQL_LOCK_GUARD();
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a2c8536943..3f6c10897b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -217,6 +217,9 @@ typedef struct CPUTLBEntryFull {
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


