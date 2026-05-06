Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CABCD3440
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKT4z-00023V-KF; Tue, 05 May 2026 23:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4o-0001y0-AX
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4l-0006WD-Ab
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:33 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2addb31945aso34709375ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 20:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778038650; x=1778643450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCE1rmUyv2obu5/xMHQbs2caqICn55jp/cPYxrAOFH4=;
 b=L1hXQnAg6HDOaFmb9iQe6A/Y7s3GrMzT07UYmt2lKkzgSj8cAgyL41CgTUpKaAF42B
 KE9ONkUKCaJpGFWqf66WMmy2NVRNJ27V2t4FNASIK7/PrxMrV7/BQF7IH2UD1gbuDtWo
 r9Yb3OmPr7LMEzzyw9y8oB+I8KtuHqqwoG2zEXfIvQiJyIvdn4OVCBNCQ1TN2Jvw8cFH
 rc31+nwmi0mhFo3MjHOAWCszYMX3u6a5/8mW62EBDr0stz6O0tJ/3HxGxMtMrg4un/XW
 Cgcyz2XQJ69ibGqDmoZnkUXsDLXUbyMBcx2pn3vIX+yyxntCf3osx6yta8CAWt9lNwvI
 EaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038650; x=1778643450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qCE1rmUyv2obu5/xMHQbs2caqICn55jp/cPYxrAOFH4=;
 b=SuRKdyisQ5zddx9NYrSnmzh9HIWjgNmLbNCDEuzdfbvaTDqKjCIzv6mw/pxX4G8C6t
 rxpgcEHj3BdrEzsnVnoVNtFKrguxh66HCy2xo6n2cI9fEeNdZWQ77eSmt6vDHGLD8uIt
 eDvFXPb+mkbXXvFeqZm3aFh686/TFgQeRHN8iCqu2HHN7PoUsMUWjGxO8590dip1SD6P
 Ba85Ei1h24g4zDvU2wFKl90gIXURLzyxgvfsqswqt2GuzfNy1/ujPermxVWwsQm0WEky
 rW9kcsBfMSpD1l1HDYDLyZk9VU6Gl/yOJdMH09zM95SdkUraWY2OCG+x6Sz+3+3ZLSik
 Q2zg==
X-Gm-Message-State: AOJu0YzsTjJZfo5xOgS/C4Ag7oHEe6Dvgu43lyh8fokNLqsI9WVlFAAv
 a3K6YR3ChINmiJHkv8+Dh3jRY3eVHAOgHayzDcm084kRbH0DHHS3K71VScxaHaFpcACf0tU7sku
 zI0OwhrcoelxbEgT37bBQECMAUHqvSVbcNbfHg8ZwMWEGML3FdPgV1ezhxmvh9bMebpAGmuqlpb
 evvqGuGwNZrBrElIpDkIKT/OxPSCYBHsvOULDhCNeN
X-Gm-Gg: AeBDietJq98EVp7IEHlfQjT1WeaiQBHZBbaa1H1z31suRnS/Vw9ln5+pdOGzev6J8WA
 AC1IhVVkzZf3FEDixkWleD8IsznvM9/3uobGgUlqcQanhZm1Z7xYglHifm+KZ7yzRDmbtDXTebI
 W4n5tCqgNqFogSJf3ms70eMhYT9zEgZ2O2tOKMZfRBmliL2wjt3tmRyps1Q3oagS35JUI02l8CA
 //Q1uUAFBnYsOaMzeu3OClocVqOP7/+0sjAgAqQD4FFv17LGPKVNiA1u7KYg00k5GlyYECFNDUT
 Qr2Fpr/65i+GlLmCyiOgyBsTvRayEbuLRUc5NzI7F4YrQuGe3fz8RWGl8m1DqZYRTT+OiUW//Pg
 ytvxLJ6YU3Jt55h556x4tM+ViF6EPShgjQ99Jcsimfrul17jd2X5+Gwp+pB5Ds6fhAsrRPCOtu0
 PwmunEJsPHycRx+Q12ghSaKDiKNTaeQ9LmJ1kC4Frzvahq8GY5qCQNI5c=
X-Received: by 2002:a17:903:4304:b0:2b2:6b58:9317 with SMTP id
 d9443c01a7336-2ba799d6c69mr9284815ad.39.1778038649428; 
 Tue, 05 May 2026 20:37:29 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca34cfdsm7666265ad.79.2026.05.05.20.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:37:28 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 5/5] accel/tcg: Support IOMMU lazy translation in CPU TLB
Date: Wed,  6 May 2026 11:36:42 +0800
Message-ID: <20260506033642.3641390-6-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506033642.3641390-1-jim.shu@sifive.com>
References: <20260506033642.3641390-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62e.google.com
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

tlb_set_page_full() no longer translates IOMMU region, but only stores
untranslated IOMMU region in the CPUTLBEntryFull. Then, when CPU uses
CPUTLBEntryFull in the slow path. it should perform the lazy translation
via tlb_translate_iommu().

The untranslated IOMMU region in TLB always requires to run in the slow
path to trigger the lazy translation, so the IOMMU region will contain a
new TLB flag, TLB_IOMMU, to force the slow path. Lazy translation will
overwrite the TLB flags to the flags of the translated region. The host
memory region from IOMMU region can still run in the fast path to
accelerate the performance.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/tcg/cputlb.c       | 66 ++++++++++++++++++++++++++++++++++------
 include/exec/tlb-flags.h |  4 ++-
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5735f632896..7a44ae8238b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1034,7 +1034,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     hwaddr iotlb, xlat, sz, paddr_page;
     vaddr addr_page;
     int asidx, wp_flags, prot;
-    bool is_ram, is_romd;
+    bool is_ram, is_romd, is_iommu;
 
     assert_cpu_is_self(cpu);
 
@@ -1049,29 +1049,38 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     prot = full->prot;
     asidx = cpu_asidx_from_attrs(cpu, full->attrs);
-    section = address_space_translate_for_iotlb_late(cpu, asidx, paddr_page,
-                                                     &xlat, &sz, full->attrs,
-                                                     &prot);
+
+    /*
+     * Use the early translation to check if it is an IOMMU region.
+     * This function stops at IOMMU regions without translating through them.
+     */
+    section = address_space_translate_for_iotlb_early(cpu, asidx, paddr_page,
+                                                      &xlat, &sz, full->attrs,
+                                                      &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
     tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
               " prot=%x idx=%d\n",
               addr, full->phys_addr, prot, mmu_idx);
 
+    is_iommu = memory_region_is_iommu(section->mr);
+    is_ram = memory_region_is_ram(section->mr);
+    is_romd = memory_region_is_romd(section->mr);
+
+    full->is_iommu = is_iommu;
+    full->iommu_last_at = MMU_ACCESS_COUNT;
+
     read_flags = full->tlb_fill_flags;
     if (full->lg_page_size < TARGET_PAGE_BITS) {
         /* Repeat the MMU check and TLB fill on every access.  */
         read_flags |= TLB_INVALID_MASK;
     }
 
-    is_ram = memory_region_is_ram(section->mr);
-    is_romd = memory_region_is_romd(section->mr);
-
     if (is_ram || is_romd) {
         /* RAM and ROMD both have associated host memory. */
         addend = (uintptr_t)memory_region_get_ram_ptr(section->mr) + xlat;
     } else {
-        /* I/O does not; force the host address to NULL. */
+        /* I/O and IOMMU does not; force the host address to NULL. */
         addend = 0;
     }
 
@@ -1090,6 +1099,15 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
                 write_flags |= TLB_NOTDIRTY;
             }
         }
+    } else if (is_iommu) {
+        /* IOMMU */
+        iotlb = xlat;
+        /*
+         * If IOMMU region is not translated, any access will go to
+         * the slow path and do the lazy IOMMU translation.
+         */
+        read_flags |= TLB_IOMMU;
+        write_flags |= TLB_IOMMU;
     } else {
         /* I/O or ROMD */
         iotlb = xlat;
@@ -1568,6 +1586,11 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     flags &= tlb_addr;
 
     *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+
+    if (full->is_iommu) {
+        tlb_translate_iommu(cpu, mmu_idx, addr, access_type, full);
+    }
+
     flags |= full->slow_flags[access_type];
 
     /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
@@ -1760,6 +1783,11 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
     }
 
     full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+
+    if (full->is_iommu) {
+        tlb_translate_iommu(cpu, mmu_idx, addr, access_type, full);
+    }
+
     data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
     /* We must have an iotlb entry for MMIO */
@@ -1833,6 +1861,11 @@ static bool mmu_lookup1(CPUState *cpu, MMULookupPageData *data, MemOp memop,
     }
 
     full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+
+    if (full->is_iommu) {
+        tlb_translate_iommu(cpu, mmu_idx, addr, access_type, full);
+    }
+
     flags = tlb_addr & (TLB_FLAGS_MASK & ~TLB_FORCE_SLOW);
     flags |= full->slow_flags[access_type];
 
@@ -1944,6 +1977,11 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
             uintptr_t index = tlb_index(cpu, l->mmu_idx, addr);
             l->page[0].full = &cpu->neg.tlb.d[l->mmu_idx].fulltlb[index];
+
+            if (l->page[0].full->is_iommu) {
+                tlb_translate_iommu(cpu, l->mmu_idx, addr, type,
+                                    l->page[0].full);
+            }
         }
 
         flags = l->page[0].flags | l->page[1].flags;
@@ -2001,6 +2039,17 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
         tlb_addr = tlb_addr_write(tlbe) & ~TLB_INVALID_MASK;
     }
 
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+
+    if (full->is_iommu) {
+        /*
+         * Do IOMMU lazy translation before accessing addr_idx and TLB flags.
+         * Generate TLB flags for both read and write.
+         */
+        tlb_translate_iommu(cpu, mmu_idx, addr, MMU_DATA_LOAD, full);
+        tlb_translate_iommu(cpu, mmu_idx, addr, MMU_DATA_STORE, full);
+    }
+
     /*
      * Let the guest notice RMW on a write-only page.
      * We have just verified that the page is writable.
@@ -2035,7 +2084,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     }
 
     /* Finish collecting tlb flags for both read and write. */
-    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     tlb_addr |= tlbe->addr_read;
     tlb_addr &= TLB_FLAGS_MASK & ~TLB_FORCE_SLOW;
     tlb_addr |= full->slow_flags[MMU_DATA_STORE];
diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index 357e79095c9..d78f1c3dc64 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -52,10 +52,12 @@
 #define TLB_DISCARD_WRITE    (1 << 3)
 /* Set if TLB entry is an IO callback.  */
 #define TLB_MMIO             (1 << 4)
+/* Set if TLB entry is a IOMMU region which requires lazy translation. */
+#define TLB_IOMMU            (1 << 5)
 
 #define TLB_SLOW_FLAGS_MASK \
     (TLB_BSWAP | TLB_WATCHPOINT | TLB_CHECK_ALIGNED | \
-     TLB_DISCARD_WRITE | TLB_MMIO)
+     TLB_DISCARD_WRITE | TLB_MMIO | TLB_IOMMU)
 
 /*
  * Flags stored in CPUTLBEntry.addr_idx[x].
-- 
2.43.0


